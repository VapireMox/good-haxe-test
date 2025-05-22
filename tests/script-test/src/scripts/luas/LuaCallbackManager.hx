package scripts.luas;

#if ALLOW_LUASCRIPT
import cpp.Pointer;
#end
import haxe.Constraints.Function;

using StringTools;
using Lambda;

class LuaCallbackManager {
	@:noCompletion static var _pool:Map<String, LuaCallbackManager> = new Map();

	public static function registerNewCallback(byd:RawLuaState, tag:String):LuaCallbackManager {
		#if ALLOW_LUASCRIPT
		var lsp:Pointer<Lua_State> = Pointer.fromRaw(byd);
		#else
		var lsp = byd;
		#end
		var manager = new LuaCallbackManager(lsp, tag);
		_pool.set(tag, manager);
		return manager;
	}

	#if !ALLOW_LUASCRIPT
	public var tag:String;
	var lsp:RawLuaState;

	private function new(lsp:RawLuaState, tag:String) {
		this.lsp = lsp;
		this.tag = tag;
	}

	public function add(name:String, value:String, istable:Bool = false) {}

	public function remove(name:String, istable:Bool = false) {}

	public function clear() {}

	public function dispose() {}

	#else

	public var tag:String;
	var lsp:Pointer<Lua_State>;
	var callbackReferences:Map<String, Function>;

	private function new(lsp:Pointer<Lua_State>, tag:String) {
		this.tag = tag;
		this.lsp = lsp;
		callbackReferences = new Map<String, Function>();
	}

	public function add(name:String, func:Function, fromtable:Bool = false) {
		var byd:RawLuaState = lsp.raw;
		var split:Array<String> = name.split(".");

		if(split.length > 1 && fromtable) {
			for(index=>key in split) {
				if(index == 0) {
					byd.getglobal(key);
				} else if(index < split.length - 1) {
					byd.getfield(-1, key);
					//清除上一任表格
					byd.remove(-2);
				}
				if(index < split.length - 1) {
					if(byd.istable(-1) != 1) break;
				} else {
					callbackReferences.set(name, func);
					byd.pushstring(tag);
					byd.pushstring(name);
					byd.pushcclosure(cpp.Function.fromStaticFunction(callbackHandler), 2);
					byd.setfield(-2, key);
				}
			}
			byd.pop(1);
		} else {
			name = split[0];
			callbackReferences.set(name, func);
			byd.pushstring(tag);
			byd.pushstring(name);
			byd.pushcclosure(cpp.Function.fromStaticFunction(callbackHandler), 2);
			byd.setglobal(name);
		}
	}

	public function remove(name:String, fromtable:Bool = false) {
		var byd:RawLuaState = lsp.raw;
		var split:Array<String> = name.split(".");

		if(split.length > 1 && fromtable) {
			for(index=>key in split) {
				if(index == 0) {
					byd.getglobal(key);
				} else if(index < split.length - 1) {
					byd.getfield(-1, key);
					//清除上一任表格
					byd.remove(-2);
				}
				if(index < split.length - 1) {
					if(byd.istable(-1) != 1) break;
				} else {
					if(callbackReferences.exists(name)) {
						byd.getfield(-1, key);
						if(byd.isnil(-1) != 1 && byd.isfunction(-1) == 1) {
							byd.pushnil();
							byd.setfield(-3, name);
						}
						byd.pop(1);
						callbackReferences.remove(name);
					}
				}
			}
			byd.pop(1);
		} else {
			name = split[0];
			if(callbackReferences.exists(name)) {
				byd.getglobal(name);
				if(byd.isnil(-1) != 1 && byd.isfunction(-1) == 1) {
					byd.pushnil();
					byd.setglobal(name);
				}
				byd.pop(1);
				callbackReferences.remove(name);
			}
		}
	}

	public function dispose() {
		clear();
		if(_pool.exists(tag)) _pool.remove(tag);
	}

	public function clear() {
		for(key in callbackReferences.keys()) {
			remove(key, key.contains("."));
		}
	}

	public function toString():String {
		return Std.string(callbackReferences);
	}

	@:noCompletion @:noUsing private static function callbackHandler(byd:RawLuaState) {
		var prefix = byd.tostring(Lua.upvalueindex(1));
		if(prefix == null) return 0;

		var tag = byd.tostring(Lua.upvalueindex(2));
		if(tag != null) {
			var value = _pool.get(prefix);
			if(value != null) {
				final args:Array<Dynamic> = [];

				for(count in 1...(byd.gettop() + 1)) {
					args.push(byd.convertFromLua(count));
				}

				final func:Dynamic = value.callbackReferences.get(tag);
				if(func != null && Reflect.isFunction(func)) {
					byd.convertToLua(switch(Std.string(tag)) {
						case "print":
							Reflect.callMethod(null, func, [args]);
						default: Reflect.callMethod(null, func, args);
					});
					return 1;
				}
			}
		}
		return 0;
	}

	#end
}