package;

import scripts.ScriptUtil;
import scripts.ScriptGroup;
import scripts.ScriptLua;
#if ALLOW_LUASCRIPT
import scripts.luas.types.RawLuaState;
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
	public static function list(byd:RawLuaState, ?prefix:String) {
		var buf = new StringBuf();
		final origin = Lua.gettop(byd);
		buf.add("\n――――――――――――――――――――――――――――――\n");
		buf.add("\033[33m");
		buf.add((prefix == null ? '' : prefix));
		buf.add("[");
		for(i in 0...origin) {
			buf.add(Lua.typename(byd, Lua.type(byd, i + 1)));
			if(i < origin - 1) buf.add(" .. ");
		}
		buf.add("]\033[0m");
		buf.add('\n――――――――――――――――――――――――――――――\n');
		trace(buf.toString().toLowerCase());
	}
	#end

	public static function reportAccess(condition:Bool, ?prefix:String) {
		var abab:String = {
			if(condition) "\033[32m已通过\033[0m";
			else "\033[31m已失败\033[0m";
		};
			Sys.println('

=======================================================
${(prefix != null ? Std.string(prefix) : '') + "		" + abab}
=======================================================

');
	}

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
		Sys.println('result: \033[33m[\n\t${one.path}: ${Std.string(one.load())}\n\t${two.path}: ${Std.string(two.load())}\n]\033[0m');
		reportAccess(#if ALLOW_LUASCRIPT true #else false #end, "是否已正常加载：");
		#if ALLOW_LUASCRIPT
		@:privateAccess {
			trace("\n\t当前Lua回调池状况：" + scripts.luas.LuaCallbackManager._pool);
			reportAccess(Lambda.count(scripts.luas.LuaCallbackManager._pool) != 0, "当前Lua回调池是否有余：");
		}
		//检查栈中是否还有残余的值
		Sys.println("_____CHECKING_STACK_____");
		list(one.heart, "第一机子的栈空间：");
		reportAccess(Lua.gettop(one.heart) == -1, "第一机子的栈空间是否为空：");
		list(two.heart, "第二机子的栈空间：");
		reportAccess(Lua.gettop(two.heart) == -1, "第二机子的栈空间是否为空：");
		#end
		one.destroy();
		two.destroy();

		#if ALLOW_LUASCRIPT
		@:privateAccess {
			trace("\n\t当前Lua回调池状况：" + scripts.luas.LuaCallbackManager._pool);
			reportAccess(Lambda.count(scripts.luas.LuaCallbackManager._pool) == 0, "当前Lua回调池是否为空：");
		}
		#end
	}
}