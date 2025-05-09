package tests;

import utest.Assert;
import utest.Test;

class TestA extends Test {
	public function testOne() {
		Assert.equals(1 + 1, 2);
	}
}