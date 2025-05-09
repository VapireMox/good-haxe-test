package;

import utest.Runner;
import utest.ui.Report;
import tests.*;

class Main {
	public static function main() {
		var runner = new Runner();
		runner.addCase(new TestA());
		Report.create(runner);

		runner.run();
	}
}