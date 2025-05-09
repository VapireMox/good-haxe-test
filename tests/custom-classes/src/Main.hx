package;

import hscript.Interp;
import hscript.Parser;
import hscript.Expr;

class Main {
	static final code:String = '
class Test extends ExtendedA {
	private var shift:Int = -1;

	public function new(c:BYD) {
		super(c);

		this.b += "byd";
		this.y += 1;
		Reflect.setField(this.d, "th", "Thanks For The World");
	}
}

var test = new Test({
	b: "ak",
	y: 0.01,
	d: {}
});
test.b = "The World! JS";
test.y = 114514;
Reflect.setField(test.d, "light", 87);

trace(test);
trace(Reflect.compare(Reflect.getProperty(test, "interp").allowStaticAccessClasses, Reflect.getProperty(Test, "interp").allowStaticAccessClasses));

trace(test.shift);
	';

	public static function main() {
		var interp = new Interp();
		interp.errorHandler = errorHandler;
		var parser = new Parser();
		parser.allowMetadata = parser.allowTypes = parser.allowJSON = true;

		interp.variables.set("Type", Type);
		interp.variables.set("Reflect", Reflect);
		interp.variables.set("ExtendedA", tests.ExtendedA);

		interp.execute(parser.parseString(code));
	}

	private static function errorHandler(error:Error) {
		Sys.print('HScript Error: $error');
	}
}
