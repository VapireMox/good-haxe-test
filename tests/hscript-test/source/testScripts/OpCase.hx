package testScripts;

class OpCase extends HScriptCase {
	public function testBinop() {
		Assert.equals(execute("1 + 1"), 2);
		Assert.equals(execute("1 - 1"), 0);
		Assert.equals(execute("1 * 2"), 2);
		Assert.equals(execute("1 / 2"), 0.5);
		Assert.equals(execute("53 % 2"), 1);
	}
}