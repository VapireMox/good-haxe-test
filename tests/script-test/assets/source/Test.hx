class Test {
	public static function main() {
		trace("hello world");
		new Test();
	}

	var test:String = "14";

	public function new() {
		trace(Std.parseFloat(test));
	}
}