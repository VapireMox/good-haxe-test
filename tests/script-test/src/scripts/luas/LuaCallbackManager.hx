package scripts.luas;

import haxe.Constraints.Function;

/**
 * 你用个屁😂
 */
class LuaCallbackManager {
	private static final luaCallbacks:Map<String, Map<String, Function>> = [];

	/**
	 * 注册你的爷爷
	 * @param sl		  爷爷
	 */
	public static function registerCallback(sl:ScriptLua) {
		if(sl._closed) return;

		if(!luaCallbacks.exists(sl.path)) {
			luaCallbacks.set(sl.path, new Map<String, Function>());
		}
	}

	/**
	 * 添加你的爸爸
	 * @param sl				  爷爷
	 * @param name		  叔叔
	 * @param func		  爸爸
	 */
	public static function addCallback(sl:ScriptLua, name:String, func:Function) {
		if(sl._closed) return;
		#if ALLOW_LUASCRIPT
		final byd:LuaState = sl.heart;

		if(luaCallbacks.exists(sl.path)) {
			final funcMap = luaCallbacks.get(sl.path);

			funcMap.set(name, func);
			byd.pushstring('${sl.path}:$name');
			byd.pushcclosure(cpp.Function.fromStaticFunction(callbackHandler), 1);
			byd.setglobal(name);
		}
		#end
	}

	/**
	 * 父愁者联盟
	 * @param sl				  爷爷
	 * @param name		  叔叔
	 */
	public static function removeCallback(sl:ScriptLua, name:String) {
		if(sl._closed) return;
		#if ALLOW_LUASCRIPT
		final byd:LuaState = sl.heart;

		//注意：如果将name这个变量设置了其他值，可能会纯在误删的情况（
		if(luaCallbacks.exists(sl.path)) {
			final funcMap = luaCallbacks.get(sl.path);

			if(funcMap != null && funcMap.exists(name)) {
				var oldtop = byd.gettop();
				byd.getglobal(name);
				if(byd.isnil(-1) != 1) {
					byd.pushnil();
					byd.setglobal(name);
				}
				byd.pop(1);

				funcMap.remove(name);
			}
		}
		#end
	}

	/**
	 * 孩子你无敌了
	 * @param sl		  爷爷
	 */
	public static function clearCallback(sl:ScriptLua) {
		if(sl._closed) return;

		#if ALLOW_LUASCRIPT
		if(luaCallbacks.exists(sl.path)) {
			final funcMap = luaCallbacks.get(sl.path);
			if(funcMap != null) {
				for(sb in funcMap.keys()) {
					removeCallback(sl, sb);
				}
			}
		}
		#end
	}

	/**
	 * 谋权篡位家庭版
	 * @param sl		  爷爷
	 */
	public static function logOffCallback(sl:ScriptLua) {
		#if ALLOW_LUASCRIPT
		if(luaCallbacks.exists(sl.path)) {
			clearCallback(sl);
			luaCallbacks.remove(sl.path);
		}
		#end
	}

	#if ALLOW_LUASCRIPT
	@:noCompletion @:noUsing private static function callbackHandler(byd:LuaState) {
		final tag = LuaUtil.convertFromLua(byd, Lua.upvalueindex(1));
		if(tag != null && tag is String) {
			final funcMap = luaCallbacks.get(tag.substr(0, tag.lastIndexOf(":")));
			var name:String = tag.substring(tag.lastIndexOf(":") + 1);
			if(funcMap != null && funcMap.exists(name)) {
				final n = byd.gettop();
				var args:Array<Dynamic> = [];

				for(at in 1...n + 1) {
					args.push(LuaUtil.convertFromLua(byd, at));
				}

				var ret:Dynamic = null;
				switch(name) {
					case "print":
						ret = Reflect.callMethod(null, funcMap.get(name), [args]);
					default:
						ret = Reflect.callMethod(null, funcMap.get(name), args);
				}
				LuaUtil.convertToLua(byd, ret);
				return 1;
			}
		}

		return 0;
	}
	#end
}