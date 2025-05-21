package scripts;

/**
 * 孩子们，这并不好看
 */
typedef ScriptInfo = {> ScriptPosInfo,
	var contents:Array<Dynamic>;
}

typedef ScriptPosInfo = {
	var name:Null<String>;
	var line:Null<Int>;
	var ?prefixName:Null<String>;
	var ?prefixStyle:Null<ScriptStyle>;
}

enum abstract ScriptStyle(Int) to Int {
	var NORMAL:ScriptStyle = 0;
	var SAFE:ScriptStyle = 32;
	var ERROR:ScriptStyle = 31;
	var WARNING:ScriptStyle = 33;
}