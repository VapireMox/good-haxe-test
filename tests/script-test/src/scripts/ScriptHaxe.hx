package scripts;

#if ALLOW_HSCRIPT
import hscript.Interp;
import hscript.Parser;
import hscript.Expr;
import hscript.Tools;
import hscript.customclass.*;
#end
import scripts.ScriptInfo;
import sys.FileSystem;
import sys.io.File;

using StringTools;

/**
 * 对于haxe脚本的管理，即hscript
 */
#if ALLOW_HSCRIPT
@:access(hscript.Interp)
#end
class ScriptHaxe extends ScriptBase {
	#if ALLOW_HSCRIPT
	/**
	 * 控制台
	 */
	public var interp(default, null):Interp;
	/**
	 * 解析器
	 */
	public var parser(default, null):Parser;
	/**
	 * 解析后的格式
	 */
	public var expr(default, null):Null<Expr>;
	#end

	var code:Null<String>;

	#if ALLOW_HSCRIPT
	override function init() {
		interp = new Interp();
		interp.errorHandler = errorHandler;
		interp.allowPublicVariables = interp.allowStaticVariables = true;

		parser = new Parser();
		parser.allowMetadata = parser.allowTypes = parser.allowJSON = true;
	}
	#end

	override function setup() {
		if(FileSystem.exists(this.path)) {
			try {
				code = File.getContent(this.path);
			} catch(e:haxe.Exception) {
				error({contents: [e.message, Std.string(e.stack)], name: this.path, line: 0});
			}
		} else {
			error({contents: ['This Path "${this.path}" was not exist.'], name: this.path, line: 0});
		}

		#if ALLOW_HSCRIPT
		if(code != null && code.trim() != "") {
			try {
				expr = parser.parseString(code, this.path);
			} catch(e:Error) {
				errorHandler(e);
			}
		}
		#end

		set("trace", Reflect.makeVarArgs(function(content:Dynamic) {
			var info = interp.posInfos();
			this.trace(content, {name: info.fileName, line: info.lineNumber, prefixName: "HScript-Trace", prefixStyle: SAFE});
		}));
		set("__sc__", this);
	}

	override function execute():Dynamic {
		#if ALLOW_HSCRIPT
		if(expr != null) {
			return interp.execute(expr);
		}
		#end

		return null;
	}

	override function onGet(name:String):Dynamic {
		#if ALLOW_HSCRIPT
		if(interp.variables.exists(name))
			return interp.variables.get(name);
		if(interp.customEnums.exists(name))
			return interp.customEnums.get(name);
		#if CUSTOM_CLASSES
		if(interp.allowStaticAccessClasses.contains(name) && Interp.customClassExist(name))
			return Interp.getCustomClass(name);
		#end
		#end

		return null;
	}

	override function onCall(name:String, ?args:Array<Dynamic>):Dynamic {
		#if ALLOW_HSCRIPT
		if(interp.variables.exists(name) && Reflect.isFunction(interp.variables.get(name))) {
			try {
				return Reflect.callMethod(null, interp.variables.get(name), (args != null ? args : []));
			} catch(e:haxe.Exception) {
				error({contents: [e.message, Std.string(e.stack)], name: this.path, line: 0});
			}
		}
		#end

		return null;
	}

	#if ALLOW_HSCRIPT
	override function onSet(name:String, value:Dynamic) {
		if(value is HScriptEnum) {
			interp.customEnums.set(name, cast (value, HScriptEnum));
			return;
		}

		#if CUSTOM_CLASSES
		if(value is CustomClassDecl) {
			final customClassDecl = cast (value, CustomClassDecl);
			Interp.registerCustomClass(customClassDecl, (name != customClassDecl.classDecl.name ? name : null));
			if(name != customClassDecl.classDecl.name) interp.allowStaticAccessClasses.push(name);
			interp.allowStaticAccessClasses.push(customClassDecl.classDecl.name);
			return;
		}
		#end

		interp.variables.set(name, value);
	}
	#end

	override function toString():String {
		return ScriptUtil.printScriptFieldString("SCRIPT-HAXE", [
			"name" => this.name,
			"path" => this.path,
			"loaded" => this.loaded,
			"active" => this.active,
		]);
	}

	#if ALLOW_HSCRIPT
	@:noCompletion function errorHandler(err:Error) {
		var info:String = '${err.origin}:${err.line}: ';
		error({contents: [err.toString().substr(info.length * 2)], name: err.origin, line: err.line});
	}
	#end
}