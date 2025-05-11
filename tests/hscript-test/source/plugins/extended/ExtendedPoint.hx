package plugins.extended;

class ExtendedPoint {
	public var x:Float;
	public var y:Float;

	public function new(X:Float = 0, Y:Float = 0) {
		x = X;
		y = Y;
	}

	public function set(X:Float = 0, Y:Float = 0) {
		x = X;
		y = Y;

		return this;
	}

	public function copy() {
		return new ExtendedPoint().set(x, y);
	}

	public function alias(point:ExtendedPoint) {
		this.x = point.x;
		this.y = point.y;

		return this;
	}

	public function toObject() {
		return {x: this.x, y: this.y};
	}

	private function toString():String {
		return '{ x: ${this.x}, y: ${this.y}}';
	}
}