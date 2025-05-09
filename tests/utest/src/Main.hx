package;

import utest.UTest;
import tests.*;

class Main {
	public static function main() {
		UTest.run([new TestA()], onComplete);
	}

	static function onComplete() {
		trace("Input Finished...");
	}
}