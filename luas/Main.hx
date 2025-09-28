package;

import luahscript.LuaInterp;
import luahscript.LuaParser;
import luahscript.exprs.*;
import luahscript.exprs.LuaExpr;

class Main {
	public static function main() {
		var input:String = sys.io.File.getContent("stuff.lua");
		var input1:String = sys.io.File.getContent("stuff1.lua");

		final e = new LuaParser().parseFromString(input);
		final e1 = new LuaParser().parseFromString(input1);

		// input args
		trace(e);
		trace(e1);
	}
}


/*class MyHaxeClass {
    public var greeting:String;

    public function new(greeting:String = "Hello from Haxe!") {
        this.greeting = greeting;
    }

    public function sayHello():String {
        return greeting;
    }

    public function add(a:Int, b:Int):Int {
        return a + b;
    }
}
*/