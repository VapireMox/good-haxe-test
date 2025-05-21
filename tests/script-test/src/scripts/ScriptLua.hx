package scripts;

#if ALLOW_LUASCRIPT
import hxlua.Types;
import hxlua.LuaL;
import hxlua.Lua;
import scripts.luas.LuaUtil;
import scripts.luas.LuaCallbackManager;
#end
import scripts.luas.LuaState;
import sys.FileSystem;
import sys.io.File;

using StringTools;

#if ALLOW_LUASCRIPT
using hxlua.Lua;
using hxlua.LuaL;
#end

/**
 * 🖕
 * ……
 * @author VapireMox(GeXie19)
 */
@:allow(scripts.luas.LuaUtil)
@:allow(scripts.luas.LuaCallbackManager)
class ScriptLua extends ScriptBase {
	/**
	 * 当某个脚本在进行某些操作时，这份静态变量就会集中到他身上，用处大大滴油！
	 */
	public static var focusOn(default, null):ScriptLua = null;

	static var debug: #if ALLOW_LUASCRIPT Lua_Debug = Lua_Debug.create() #else Dynamic = null #end;

	/**
	 * 用于lua的虚拟交互（然后被调教成布尔值了）
	 */
	public var heart(default, null):Null<LuaState>;

	var code:Null<String>;

	private var _closed:Bool;

	override function init() {
		_closed = false;
		#if ALLOW_LUASCRIPT
		heart = LuaL.newstate();
		heart.openlibs();
		LuaCallbackManager.registerCallback(this);
		#end
	}

	override function setup() {
		if(FileSystem.exists(path)) {
			try {
				code = File.getContent(path);
			} catch(e:haxe.Exception) {
				error({contents: [e.message], name: this.path, line: 0});
			}
		} else {
			error({contents: ['Invalid Path: $path, was not exist.'], name: this.path, line: 0});
		}

		#if ALLOW_LUASCRIPT
		set("print", function(infoArgs:Array<Dynamic>) {
			final stackDebug:cpp.RawPointer<Lua_Debug> = cpp.RawPointer.addressOf(debug);
			if(heart.getstack(1, stackDebug) == 1) {
				heart.getinfo("l", stackDebug);
			}

			var buf = new StringBuf();
			buf.add("(");
			for(index=>byd in infoArgs) {
				buf.add(Std.string(byd));
				if(index < infoArgs.length - 1)
					buf.add(", ");
			}
			buf.add(")");

			this.trace(buf.toString(), {name: this.path, line: stackDebug[0].currentline, prefixName: "Lua-Print", prefixStyle: SAFE});
		});
		#end
	}

	override function onCall(name:String, ?args:Array<Dynamic>) {
		if(!_closed) {
			final oldScript = focusOn;
			focusOn = this;

			var ret:Dynamic = null;
			var called:Bool = false;

			#if ALLOW_LUASCRIPT
			var split:Array<String> = name.split(".");

			if(split.length > 0)
				if(split.length == 1) {
					heart.getglobal(split[0]);
					if(heart.type(-1) != Lua.TFUNCTION) {
						heart.pop(1);
						return null;
					}

					ret = LuaUtil.callFunctionWithoutName(heart, (args == null ? [] : args));
					ret = {
						if(ret.length == 1) ret[0];
							else if(ret.length == 0) null;
							else ret;
						};
				} else {
					for(papy=>sanb in split) {
						if(papy == 0) {
							heart.getglobal(sanb);
						} else {
							heart.getfield(-1, sanb);
							//清除上一任表格
							heart.remove(-2);
						}
						if(papy < split.length - 1) {
							if(heart.istable(-1) != 1) break;
						} else {
							if(heart.type(-1) == Lua.TFUNCTION) {
								ret = LuaUtil.callFunctionWithoutName(heart, (args == null ? [] : args));
								//LuaUtil.callFunctionWithoutName会自动清除栈顶的值，需要判断
								called = true;

								ret = {
									if(ret.length == 1) ret[0];
									else if(ret.length == 0) null;
									else ret;
								};
							}
						}
					}
					if(!called) heart.pop(1);
				}

			#end

			focusOn = oldScript;
			return ret;
		}

		return null;
	}

	override function onGet(name:String):Dynamic {
		if(!_closed) {
			final oldScript = focusOn;
			focusOn = this;
			var ret:Dynamic = null;

			#if ALLOW_LUASCRIPT
			var split:Array<String> = name.split(".");
			if(split.length > 0) {
				if(split.length == 1) {
					final oldtop = heart.gettop();
					heart.getglobal(name);
					ret = LuaUtil.convertFromLua(this.heart, -1);

					heart.pop(1);
				} else {
					for(index=>key in split) {
						if(index == 0) {
							heart.getglobal(key);
						} else {
							heart.getfield(-1, key);
							//清除上一任表格
							heart.remove(-2);
						}
						if(index < split.length - 1) {
							if(heart.istable(-1) != 1) break;
						} else {
							ret = LuaUtil.convertFromLua(this.heart, -1);
						}
					}
					heart.pop(1);
				}
			}
			#end

			focusOn = oldScript;
			return ret;
		}
		return null;
	}

	override function onSet(name:String, value:Dynamic) {
		if(_closed) return;

		final oldScript = focusOn;
		focusOn = this;

		#if ALLOW_LUASCRIPT
		var split:Array<String> = name.split(".");

		if(split.length > 0) {
			if(split.length == 1) {
				if(!Reflect.isFunction(value)) {
					LuaUtil.convertToLua(this.heart, value);
					heart.setglobal(name);
				} else {
					LuaCallbackManager.addCallback(this, name, value);
				}
			} else {
				for(index=>key in split) {
					if(index == 0) {
						heart.getglobal(key);
					} else if(index < split.length - 1) {
						heart.getfield(-1, key);
						//清除上一任表格
						heart.remove(-2);
					}
					if(index < split.length - 1) {
						if(heart.istable(-1) != 1) break;
					} else {
						if(!Reflect.isFunction(value)) {
							LuaUtil.convertToLua(heart, value);
							heart.setfield(-2, key);
						}//由于某些原因（其实就是懒），表格里不支持设置函数
					}
				}
				heart.pop(1);
			}
		}
		#end

		focusOn = oldScript;
	}

	#if ALLOW_LUASCRIPT
	override function execute() {
		if(code != null && !_closed) {
			final origin = heart.gettop();
			if(heart.dostring(code) == Lua.OK) {
				var ret:Dynamic = null;
				final oldScript = focusOn;
				focusOn = this;
				if(heart.gettop() > origin) {
					final count:Int = Std.int(Math.abs(heart.gettop() - origin));
					if(count == 1) ret = LuaUtil.convertFromLua(this.heart, -1);
					else ret = [for(i in 1...(count + 1)) LuaUtil.convertFromLua(this.heart, -i)];

					heart.pop(count);
				}
				focusOn = oldScript;
				return ret;
			} else {
				var content:ScriptInfo = parseErrorHandler(Std.string(heart.tostring(-1)));
				heart.pop(1);
				error(content);
			}
		}

		return null;
	}
	#end

	/**
	 * 用于切断lua交互虚拟机，释放内存
	 */
	public inline function close() {
		if(_closed || heart == null) return;

		#if ALLOW_LUASCRIPT
		LuaCallbackManager.logOffCallback(this);
		heart.close();
		#end
		_closed = true;
	}

	/**
	 * 本处主要针对lua内置的报错信息进行提炼信息并返回一个对象，直通error函数
	 */
	public function parseErrorHandler(str:String):ScriptInfo {
		final ereg:EReg = new EReg('\\[string\\W+\\".*\\"\\]\\W*\\:\\W*([0-9]+)\\W*:(.*)', '');
		if(ereg.match(str)) {
			return cast {contents: [ereg.matched(2).trim()], name: this.path, line: Std.parseInt(ereg.matched(1))};
		}

		return cast {contents: [str], name: this.path, line: 0};
	}

	override function error(info:ScriptInfo) {
		if(_closed) return;

		super.error(info);
		close();
	}

	/**
	 * 这没啥好说的
	 */
	public override function destroy() {
		close();
		super.destroy();
		heart = null;
		if(focusOn == this) focusOn = null;
	}

	override function toString():String {
		return ScriptUtil.printScriptFieldString("SCRIPT-LUA", [
			"name" => this.name,
			"path" => this.path,
			"loaded" => this.loaded,
			"active" => this.active,
			"closed" => this._closed,
		]);
	}
}