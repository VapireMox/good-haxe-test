package scripts.luas;

#if ALLOW_LUASCRIPT
import cpp.Pointer;

class LuaGuiseFunction {
	var byd:Null<Pointer<Lua_State>>;
	var ref:Int;

	public function new(byd:Pointer<Lua_State>, ref:Int) {
		this.byd = byd;
		this.ref = ref;
	}

	public function call(?args:Array<Dynamic>):Dynamic {
		if(this.byd != null) {
			var ret:Dynamic = null;
			var byd:RawLuaState = this.byd.raw;
			byd.rawgeti(Lua.REGISTRYINDEX, ref);
			if(byd.isfunction(-1) != 0) {
				ret = byd.callFunctionWithoutName(args != null ? args : []);
				ret = {
					if(ret.length == 1) ret[0];
					else if(ret.length == 0) null;
					else ret;
				};
			} else byd.pop(1);

			return ret;
		}
		return null;
	}

	public function destroy() {
		if(this.byd != null) {
			var byd:RawLuaState = this.byd.raw;
			byd.unref(Lua.REGISTRYINDEX, ref);

			this.byd = null;
		}
	}
}
#else
class LuaGuiseFunction {
	var byd:RawLuaState;
	var ref:Int;

	public function new(byd:RawLuaState, ref:Int) {
		this.byd = byd;
		this.ref = ref;
	}

	public function call(?args:Array<Dynamic>):Dynamic {
		throw haxe.exceptions.NotImplementedException;
	}

	public function destroy() {
		byd = null;
	}
}
#end