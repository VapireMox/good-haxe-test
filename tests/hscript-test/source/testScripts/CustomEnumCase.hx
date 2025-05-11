package testScripts;

class CustomEnumCase extends HScriptCase {
	public function new() {
		super();

		execute('
enum CheckMate {
	JIANG;
	BING(x:Float, y:Float);
	ZHU(x:Float, y:Float);
	MA(id:String);
}
		');
	}

	public function test_single() {
		Assert.equals(execute("CheckMate.JIANG.name"), "JIANG");
	}

	public function test_params() {
		Assert.isTrue(execute("CheckMate.BING(0, 1).compare(CheckMate.BING(0, 1))"), "EnumValue Compare Failed!");
	}
}