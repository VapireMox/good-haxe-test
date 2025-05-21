package;

import scripts.ScriptUtil;
import scripts.ScriptGroup;
import scripts.ScriptLua;
#if ALLOW_LUASCRIPT
import scripts.luas.LuaState;
import hxluajit.Lua;
#end

class Main {
	static function main() {
		var scriptsGroup = ScriptUtil.loadScriptsFromDirectory("assets/scripts", (sc) -> {
			sc.set("ImASB", function() {
				return "我就是一个大傻逼！";
			});
		});
		Sys.println("_____loading_____");
		scriptsGroup.load();
		scriptsGroup.call("new");
		#if ALLOW_LUASCRIPT
		Sys.println("_____checking Lua_____");
		for(sc in scriptsGroup) {
			if(sc is ScriptLua)
				list(cast(scriptsGroup.members[0], ScriptLua).heart);
		}
		#end
		scriptsGroup.destroy();
	}

	#if ALLOW_LUASCRIPT
	public static function list(byd:LuaState) {
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
}