package scripts;

import haxe.io.Path;
import scripts.ScriptSortStyle;
import sys.FileSystem;

class ScriptUtil {
	/**
	 * 支持的脚本格式，可添加或重改
	 */
	public static var scriptExtensions:Map<String, Array<String>> = [
		#if ALLOW_HSCRIPT "haxe" => ["hx", "hxs", "hsc", "hxc"], #end
		#if ALLOW_LUASCRIPT "lua" => ["lua"], #end
	];

	/**
	 * 从一个文件夹中获取所有支持`scriptExtensions`所包含格式的文件，并运用到脚本中
	 * @param directory		  指定目录
	 * @param ?sortStyle		  排序方式，默认按文件名（不包含格式）从小排到大
	 * @param ?con					  配置已加入的脚本
	 * @return 							  返回一个script组
	 */
	public static function loadScriptsFromDirectory(directory:String, ?sortStyle:ScriptSortStyle, ?con:ScriptBase->Void):ScriptGroup {
		if(sortStyle == null) sortStyle = NAME(INCREASE);

		if(FileSystem.exists(directory) && FileSystem.isDirectory(directory)) {
			var scGroup = new ScriptGroup(Path.withoutDirectory(directory), sortStyle);
			if(con != null) scGroup.configureScript = con;

			var files = FileSystem.readDirectory(directory);
			for(file in files) {
				final path = Path.addTrailingSlash(directory) + file;
				if(!FileSystem.isDirectory(path)) {
					for(key=>se in scriptExtensions) {
						if(se.contains(Path.extension(path))) {
							var sc:ScriptBase = null;
							switch(key) {
								case "haxe":
									sc = new ScriptHaxe(path);
								case "lua":
									sc = new ScriptLua(path);
								default: //nothing
							}

							if(sc != null) {
								try {
									scGroup._stats.set(sc.name, FileSystem.stat(path));
								}
								scGroup.add(sc);
							}
						}
					}
				}
			}

			return scGroup;
		} else throw 'Cannot Read Directory, Invalid Directory: $directory';
	}

	/**
	 * 印刷脚本的字符串输出
	 * 如下…
	 * ```haxe
	 * trace(printScriptFieldString("Script", [
	 *   "name" => this.name, //脚本名字
	 *   "extension" => this.extension, //脚本后缀
	 * ])); //output: Script_[ (name : checkout) | (extension : byd) ]_Script
	 * ```
	 * @param name		  名字
	 * @param map			  map
	 * @return					  返回字符串
	 */
	public static function printScriptFieldString(name:String, map:Map<String, Dynamic>):String {
		var buf:StringBuf = new StringBuf();

		buf.add('${name}_');
		buf.add("[");
		final arrs:Array<String> = new SANB(map.keys()).array();
		arrs.sort((l, r) -> -1);
		for(i=>key in arrs) {
			buf.add(' ($key : ${Std.string(map.get(key))}) ');
			if(i < arrs.length - 1) {
				buf.add("|");
			}
		}
		buf.add("]");
		buf.add('_$name');

		return buf.toString();
	}
}

private class SANB {
	@:noCompletion var iter:Iterator<String>;

	public function new(iter:Iterator<String>) {
		this.iter = iter;
	}

	public function iterator():Iterator<String> {
		return this.iter;
	}
}