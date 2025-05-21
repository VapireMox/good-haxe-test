package scripts;

import haxe.io.Path;
import scripts.ScriptInfo;
import scripts.interfaces.IScriptUsed;

/**
 * 构成一切缑氏的基础，dddd🤓
 */
class ScriptBase implements IScriptUsed {
	/**
	 * 脚本名字（不包含后缀）
	 */
	public var name(default, null):String;
	/**
	 * 脚本文件名（包含后缀）
	 */
	public var fileName(default, null):String;
	/**
	 * 脚本后缀
	 */
	public var extension(default, null):String;
	/**
	 * 指定脚本路径的目录
	 */
	public var directory(default, null):String;
	/**
	 * 脚本路径
	 */
	public var path(default, null):String;

	/**
	 * 是否已运行脚本
	 */
	public var loaded(default, null):Bool;
	/**
	 * 活动性，如果为false将会导致许多脚本功能丧失
	 */
	public var active:Bool = false;

	/**
	 * 创建新的脚本
	 * @param path	  指定路径，同时解析fileName、name、extension等等
	 */
	public function new(path:String) {
		this.path = path;
		this.fileName = Path.withoutDirectory(this.path);
		this.name = Path.withoutExtension(this.fileName);
		this.extension = Path.extension(this.path);
		this.directory = Path.directory(this.path);

		active = true;
		loaded = false;

		init();
		setup();
	}

	/**
	 * 回调脚本的函数，主要是腾空间😰
	 * @param funcName	  函数名字
	 * @param ?args				  输入参数
	 * @return 						  如果函数没有返回值，默认返回null
	 */
	public function call(funcName:String, ?args:Array<Dynamic>) {
		if(active) {
			return onCall(funcName, args);
		}

		return null;
	}

	/**
	 * 从脚本中获取资产
	 * @param name	  资产名字
	 * @return 			  返回获取的资产值，如果资产不存在会返回null
	 */
	public function get(name:String):Dynamic {
		if(active) {
			return onGet(name);
		}

		return null;
	}

	/**
	 * 设立脚本中的资产
	 * @param name		  设立资产的名字
	 * @param value		  设立资产的值
	 */
	public function set(name:String, value:Dynamic) {
		if(!active) return;

		onSet(name, value);
	}

	/**
	 * 加载脚本并运行，通常只会运行一次
	 */
	public function load() {
		if(active && !loaded) {
			loaded = true;
			return execute();
		}

		return null;
	}

	function error(info:ScriptInfo) {
		if(!active) return;
		var newInfo:ScriptPosInfo = {prefixName: "Script Error", prefixStyle: ERROR, line: Reflect.hasField(info, "line") ? Reflect.field(info, "line") : null, name: Reflect.hasField(info, "name") ? Reflect.field(info, "name") : null};

		for(content in info.contents) {
			this.trace(content, newInfo);
		}

		active = false;
	}

	/**
	 * 印刷
	 * @param point			  ……
	 * @param posInfo	  ……
	 */
	public function trace(point:Dynamic, ?posInfo:ScriptPosInfo) {
		final content:String = Std.string(point);
		if(posInfo == null) {
			Sys.println('${this.path}: $content');
		} else {
			final prefixStyle:ScriptStyle = (Reflect.hasField(posInfo, "prefixStyle") && Reflect.field(posInfo, "prefixStyle") != null ? posInfo.prefixStyle : NORMAL);
			final prefix:String = (Reflect.hasField(posInfo, "prefixName") && Reflect.field(posInfo, "prefixName") != null ? '${posInfo.prefixName}' : '');
			final origin:String = (Reflect.hasField(posInfo, "name") && Reflect.field(posInfo, "name") != null ? '${posInfo.name}:' : '');
			final line:String = (Reflect.hasField(posInfo, "line") && Reflect.field(posInfo, "line") != null ? '${posInfo.line}:' : '');

			var buf:StringBuf = new StringBuf();
			if(prefix != '') {
				if(prefixStyle != NORMAL) {
					buf.add('\033[${Std.string(prefixStyle)}m');
				}
				buf.add(prefix);
				if(prefixStyle != NORMAL) {
					buf.add('\033[0m');
				}
				buf.add(":");
			} else {
				var prefix = Type.getClassName(Type.getClass(this));
				buf.add(prefix.substring(prefix.lastIndexOf(".") + 1) + ": ");
			}
			if(origin != '') buf.add(origin);
			if(line != '') buf.add(line);
			buf.add(' $content');
			Sys.println(buf.toString());
		}
	}

	function init() {}
	function setup() {}
	function onSet(name:String, value:Dynamic) {}
	function onGet(name:String):Dynamic {throw haxe.exceptions.NotImplementedException;}
	function execute():Dynamic {throw haxe.exceptions.NotImplementedException;}
	function onCall(name:String, ?args:Array<Dynamic>):Dynamic {throw haxe.exceptions.NotImplementedException;}

	public function toString():String {
		return ScriptUtil.printScriptFieldString("SCRIPT-BASE", [
			"name" => this.name,
			"path" => this.path,
			"loaded" => this.loaded,
			"active" => this.active,
		]);
	}

	/**
	 * 破坏一切！
	 */
	public function destroy() {
		active = false;
	}
}