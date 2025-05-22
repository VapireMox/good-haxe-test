package;

import scripts.ScriptUtil;
import scripts.ScriptGroup;
import scripts.ScriptLua;
#if ALLOW_LUASCRIPT
import scripts.luas.RawLuaState;
import hxluajit.Lua;
#end

class Main {
	/**static function main() {
		var scriptsGroup = ScriptUtil.loadScriptsFromDirectory("assets/scripts");
		Sys.println("_____loading_____");
		scriptsGroup.load();
		scriptsGroup.set("obj1.sb", function() {
			return 114514;
		});
		scriptsGroup.call("new");
		#if ALLOW_LUASCRIPT
		Sys.println("_____checking Lua_____");
		@:privateAccess trace(scripts.luas.LuaCallbackManager._pool);
		for(sc in scriptsGroup) {
			if(sc is ScriptLua)
				list(cast(scriptsGroup.members[0], ScriptLua).heart);
		}
		#end
		scriptsGroup.destroy();
	}*/

	#if ALLOW_LUASCRIPT
	public static function list(byd:RawLuaState) {
		var buf = new StringBuf();
		final origin = Lua.gettop(byd);
		buf.add("[");
		for(i in 0...origin) {
			buf.add(Lua.typename(byd, Lua.type(byd, i + 1)));
			if(i < origin - 1) buf.add("..");
		}
		buf.add("]");
		trace(buf.toString().toLowerCase());
	}
	#end

	public static function main() {
		var one = new ScriptLua("assets/scripts/test1.lua");
		var two = new ScriptLua("assets/scripts/test2.lua");

		one.set("objTest", {});
		one.set("objTest.add", function(expr1:Float, expr2:Float) {
			return expr1 + expr2;
		});
		two.set("objTest", {});
		two.set("objTest.add", function(expr1:Float, expr2:Float) {
			return expr1 + expr2;
		});

		Sys.println("____LOADING__");
		Sys.println('result: [${Std.string(one.load())}, ${Std.string(two.load())}]');
		#if ALLOW_LUASTATE
		//检查栈中是否还有残余的值
		Sys.println("_____CHECKING_STACK_____");
		list(one.heart);
		list(two.heart);
		#end
		one.destroy();
		two.destroy();
	}
}