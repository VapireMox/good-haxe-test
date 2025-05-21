package scripts.interfaces;

interface IScriptUsed {
	public var name(default, null):String;

	public var active:Bool;
	public var loaded(default, null):Bool;

	public function load():Dynamic;
	public function call(name:String, ?args:Array<Dynamic>):Dynamic;
	public function set(name:String, value:Dynamic):Void;
	public function get(name:String):Dynamic;

	public function toString():String;
	public function destroy():Void;
}