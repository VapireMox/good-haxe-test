package;

import hscript.Interp;
import hscript.Parser;

class Main {
	static final code:String = '
class Test extends ExtendedA {
	public function new(c:BYD) {
		super(c);
	}
}

var test = new Test({
	b: "ak",
	y: 0.01,
	d: {}
});
trace(test);
	';

	public static function main() {
		var interp = new Interp();
		var parser = new Parser();
		parser.allowMetadata = parser.allowTypes = parser.allowJSON = true;

		interp.variables.set("ExtendedA", tests.ExtendedA);

		interp.execute(parser.parseString(code));
	}
}