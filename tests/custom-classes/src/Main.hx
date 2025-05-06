package;

import hscript.Interp;
import hscript.Parser;
import hscript.Expr;

class Main {
	static final code:String = '
class Test extends ExtendedA {
	public function new(c:BYD) {
		super(c);

		b += "byd";
	}
}

var test = new Test({
	b: "ak",
	y: 0.01,
	d: {}
});
trace(test.b);
test.b += "b";

trace(test.y);
test.y += 1;

trace(test.d);
Reflect.setField(test.d, "th", "Thanks For The World");

trace(test);
	';

	public static function main() {
		var interp = new Interp();
		interp.errorHandler = errorHandler;
		var parser = new Parser();
		parser.allowMetadata = parser.allowTypes = parser.allowJSON = true;

		interp.variables.set("Reflect", Reflect);
		interp.variables.set("ExtendedA", tests.ExtendedA);

		interp.execute(parser.parseString(code));

		var obj = {};
		try {
			Reflect.setProperty(obj, "sb", 114514);
		} catch(e:Dynamic) {
			trace(Std.string(e));
		}
	}

	private static function errorHandler(error:Error) {
		Sys.print('HScript Error: $error');
	}
}