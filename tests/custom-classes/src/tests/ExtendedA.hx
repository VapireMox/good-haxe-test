class ExtendedA {
	public var a:Int = -1;

	public var b(get, set):String;
	function get_b():String {
		if(c != null) return c.b;

		throw "The Variable 'c' Wass Null!! You Cannot Getter This";
	}
	function set_b(val:String):String {
		if(c != null) return c.b = val;

		throw "The Variable 'c' Wass Null!! You Cannot Getter This";
	}

	public var y(get, set):Float;
	function get_y():Float {
		if(c != null) return c.y;

		throw "The Variable 'c' Wass Null!! You Cannot Getter This";
	}
	function set_y(val:Float):Float {
		if(c != null) return c.y = val;

		throw "The Variable 'c' Wass Null!! You Cannot Getter This";
	}

	public var d(get, set):Dynamic;
	function get_d():Dynamic {
		if(c != null) return c.d;

		throw "The Variable 'c' Wass Null!! You Cannot Getter This";
	}
	function set_d(val:Dynamic):Dynamic {
		if(c != null) return c.d = val;

		throw "The Variable 'c' Wass Null!! You Cannot Getter This";
	}

	private var c:BYD;

	public function new(C:BYD) {
		c = C;
	}

	public function toString():String {
		return Std.string(c);
	}
}

typedef BYD = {
	var b:String;
	var y:Float;
	var d:Dynamic;
}