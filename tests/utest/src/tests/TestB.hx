package tests;

import haxe.ds.List;

class TestB extends Test {
	public var data:Dynamic;
	public var data1:Dynamic;

	private var sureSameType:Bool;
	public function new(data:Dynamic, data1:Dynamic) {
		super();

		this.data = data;
		this.data1 = data1;
	}

	public function specCompareType() {
		(Type.typeof(data) == Type.typeof(data)) || Type.typeof(data) == TFloat;
	}

	public function testCompareValue() {
		checkType();
		if(sureSameType) {
			Assert.fail("A And B Was Not Same Type!");
			return;
		}

		
	}

	function checkType() {
		if(Assert.results.length > 0) {
			for(result in Assert.results) {
				switch(result) {
					case Success(info):
						sureSameType = true;
					default:
						sureSameType = false;
				}
			}

			Assert.results = new List();
			return;
		}

		sureSameType = false;
	}
}