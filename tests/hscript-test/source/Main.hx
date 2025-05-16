package;

import utest.Runner;
import utest.ui.Report;
import testScripts.*;

class Main {
	static function main() {
		var runner = new Runner();
		runner.addCase(new OpCase());
		runner.addCase(new CustomClassCase());
		runner.addCase(new CustomEnumCase());
		runner.addCase(new ClassAndEnumCase());

  //b
		Report.create(runner);
		runner.run();
	}
}