package tests;

import utest.Assert;
import utest.Test;

class TestA extends Test {
	public function firstTest() {
		Assert.equals(1 + 1, 2);
	}
}