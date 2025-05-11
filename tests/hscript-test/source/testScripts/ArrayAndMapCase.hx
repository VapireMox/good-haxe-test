package testScripts;

class ArrayAndMapCase extends HScriptCase {
	public function test_array_and_map() {
		Assert.equals(execute("['ky', 'xxs', 'bingo',][2]"), 'bingo');
		Assert.equals(execute("['one' => 1, 'two' => 2, 'three' => 3,]['three']"), 3);
	}
}