package scripts.luas;

import Type.ValueType;
import scripts.ScriptLua;
import haxe.DynamicAccess;

using Lambda;

/**
 * 孩子们，副本很好玩
 * @see https://github.com/MAJigsaw77/hxluajit-wrapper/blob/main/hxluajit/wrapper/LuaUtils.hx
 * @see https://github.com/MAJigsaw77/hxluajit-wrapper/blob/main/hxluajit/wrapper/LuaConverter.hx
 * 只借鉴了亿点点（确信
 */
@:access(scripts.luas.LuaCallbackManager)
class LuaUtil {
	public static function callFunctionWithoutName(byd:LuaState, args:Array<Dynamic>):Array<Dynamic>
	{
		#if ALLOW_LUASCRIPT
		//排除已经在栈顶的function
		final origin:Int = byd.gettop() - 1;
		for (arg in args)
			byd.convertToLua(arg);

		final status:Int = byd.pcall(args.length, Lua.MULTRET, 0);

		if (status != Lua.OK)
		{
			if(ScriptLua.focusOn != null) {
				final ret = ScriptLua.focusOn.parseErrorHandler(Std.string(byd.tostring(-1)));
				byd.pop(1);
				ScriptLua.focusOn.error(ret);
			} else byd.pop(1);
			return [];
		}

		final args:Array<Dynamic> = [];

		{
			final count:Int = byd.gettop();

			if(count > origin) {
				final xd:Int = Std.int(Math.abs(count - origin));
				for (i in 1...(xd + 1))
					args.push(byd.convertFromLua(-i));

					byd.pop(xd);
			}
		}

		return args;
		#end

		return null;
	}

	public static function convertFromLua(byd:LuaState, idx:Int):Dynamic {
		#if ALLOW_LUASCRIPT
		switch(byd.type(idx)) {
			case type if(type == Lua.TNIL):
				return null;
			case type if(type == Lua.TNUMBER):
				return byd.tonumber(idx);
			case type if(type == Lua.TSTRING):
				return Std.string(byd.tostring(idx));
			case type if(type == Lua.TBOOLEAN):
				return byd.toboolean(idx) == 1;
			case type if(type == Lua.TTABLE):
				return convertFromLuaTable(byd, idx);
			default:
				trace('Warning: Cannot Covert This Type "${byd.typename(idx)}" From Lua');
		}
		#end

		return null;
	}

	public static function convertToLua(byd:LuaState, value:Dynamic) {
		#if ALLOW_LUASCRIPT
		switch(Type.typeof(value)) {
			case TNull:
				byd.pushnil();
			case TFloat:
				byd.pushnumber(cast value);
			case TInt:
				byd.pushinteger(cast value);
			case TBool:
				byd.pushboolean(value == true ? 1 : 0);
			case TObject if(!value is Class):
				LuaUtil.convertObjectToLuaTable(byd, value);
			case TClass(String):
				byd.pushstring(Std.string(value));
			case TClass(Array):
				LuaUtil.convertArrayToLuaTable(byd, cast value);
			case TClass(haxe.ds.IntMap) | TClass(haxe.ds.StringMap):
				LuaUtil.convertMapToLuaTable(byd, cast value);
			default:
				byd.pushnil();
				trace('Warning: Cannot Covert This Type "${Std.string(value)}:${Std.string(Type.typeof(value))}" To Lua');
		}
		#end
	}

	/**
	 * 由于某些不可抗因素（SB_JIT只支持到lua5.1），只能现做当活阎王了（lua_absindex在5.2添加的）
	 * @param byd		  虚拟交互机
	 * @param idx		  栈数
	 * @return				  返回栈数的绝对值
	 */
	public inline static function absindex(byd:LuaState, idx:Int):Int {
		#if ALLOW_LUASCRIPT
		if(idx < 0) idx += byd.gettop() + 1;
		#end
		return idx;
	}

	/**
	 * 由于某些不可抗因素（SB_JIT只支持到lua5.1），只能现做当活阎王了（lua_isinteger在5.3添加的）
	 * @param byd		  虚拟交互机
	 * @param idx		  栈数
	 * @return				  返回1就是true，否则为false
	 */
	public inline static function isinteger(byd:LuaState, idx:Int):Int {
		#if ALLOW_LUASCRIPT
		if(byd.isnumber(idx) != 1) return 0;
		final origin = byd.tonumber(idx);
		return (origin == Std.int(origin) ? 1 : 0);
		#else
		return 0;
		#end
	}

	#if ALLOW_LUASCRIPT
	@:noUsing @:noCompletion static function convertMapToLuaTable(byd:LuaState, map:haxe.Constraints.IMap<Dynamic, Dynamic>) {
		byd.createtable(0, map.count());
		for(key=>value in map) {
			byd.convertToLua(key);
			byd.convertToLua(value);
			byd.settable(-3);
		}
	}

	@:noUsing @:noCompletion static function convertObjectToLuaTable(byd:LuaState, object:Dynamic) {
		final fields:Array<String> = Reflect.fields(object);

		if(fields.length > 0) {
			byd.createtable(0, fields.length);
			for(field in fields) {
				byd.pushstring(field);
				byd.convertToLua(Reflect.field(object, field));
				byd.settable(-3);
			}
		}
	}

	@:noUsing @:noCompletion static function convertArrayToLuaTable(byd:LuaState, array:Array<Dynamic>) {
		byd.createtable(0, array.length);
		for(key=>ar in array) {
			byd.pushinteger(cast (key + 1));
			byd.convertToLua(ar);
			byd.settable(-3);
		}
	}

	@:noUsing @:noCompletion static function convertFromLuaTable(byd:LuaState, idx:Int):Dynamic {
		if(sureConvertTableToArray(byd, idx)) {
			var arr:Array<Dynamic> = [];

			if(idx < 0) idx = byd.absindex(idx);
			byd.pushnil();
			while(byd.next(idx) != 0) {
				arr.push(byd.convertFromLua(-1));
				byd.pop(1);
			}

			return arr;
		} else {
			var table:DynamicAccess<Dynamic> = new DynamicAccess<Dynamic>();

			if(idx < 0) idx = byd.absindex(idx);
			byd.pushnil();
			while(byd.next(idx) != 0) {
				table.set(byd.convertFromLua(-2), byd.convertFromLua(-1));
				byd.pop(1);
			}

			return table;
		}

		return null;
	}

	@:noUsing @:noCompletion static inline function sureConvertTableToArray(byd:LuaState, idx:Int):Bool {
		var useArray:Bool = false;

		if(idx < 0) idx = byd.absindex(idx);
		byd.pushnil();
		var index:Int = 0;
		while(byd.istable(idx) != 0 && byd.next(idx) != 0) {
			useArray = false;
			if(byd.isinteger(-2) == 1) {
				index++;
				if(index != byd.tointeger(-2)) {
					byd.pop(2);
					break;
				}
			} else {
				byd.pop(2);
				break;
			}

			useArray = true;
			byd.pop(1);
		}

		return useArray;
	}
	#end
}