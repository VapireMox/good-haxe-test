package;

import hscript.Interp;
import hscript.Parser;
import hscript.Expr;

class Main {
	static final code:String = '
class Test extends ExtendedA {
	private static var yourDad:String = "GeXue";
	public static function makePublic() {
		return yourDad;
	}

	private var shift:Int = -1;

	public function new(c:BYD) {
		super(c);

		shift += 1;

		this.b += "byd";
		this.y += 1;
		Reflect.setField(this.d, "th", "Thanks For The World");
	}
}

class Test1 {
	public static function quelSB() {
		return Test.yourDad + " & GeXie";
	}

	public var test:Test;

	public function new() {
		test = new Test({b: "bbq", y: 3.14, d: "wow o!"});
		test.shift += 10;
		trace(test.shift);
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

final abab = Reflect.getProperty(Reflect.getProperty(test, "__customClass"), "interp");
trace(abab);

final sb = Reflect.getProperty(Test, "staticInterp");
trace(sb);

trace(Reflect.compare(abab.allowStaticAccessClasses, sb.allowStaticAccessClasses));

trace(Test.makePublic());
trace(Test1.quelSB());

trace(Test.yourDad);
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
