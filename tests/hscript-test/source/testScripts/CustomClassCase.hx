package testScripts;

import plugins.extended.*;
import Type.ValueType;

class CustomClassCase extends HScriptCase {
	public function new() {
		super();

		setVariable("ExtendedPoint", ExtendedPoint);
		execute('
class Test {
	public var b:Int;
	public var y:String;
	public var d:Dynamic;

	public function new() {
		b = 1;
		y = "hello world";
		d = {b: b, y: y};
	}
}

class AccessStaticTest {
	public static var name:String = "GeXue";
	static var privateName:String = "GeXie";
	public static function getPrivateName() {
		return privateName;
	}
}

class Point extends ExtendedPoint {
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}
}
		');
	}

	public function test_CustomClass_WithoutExtend() {
		Assert.equals(execute("new Test().b"), 1, "b not is 1");
		Assert.equals(execute("new Test().y"), "hello world", "y not is 'hello world'");
		Assert.isTrue(Reflect.isObject(execute("new Test().d")), "d not is Object");
	}

	public function test_CustomClass_WithoutExtend_To_AccessStaticField() {
		Assert.equals(execute("AccessStaticTest.name"), "GeXue");
		Assert.equals(execute("AccessStaticTest.getPrivateName()"), "GeXie", "not equals or cannot access this field");
	}

	public function test_CustomClass_Extend_ExtendedA_SuperClass_Access() {
		execute("var point = new Point(12, 24);");
		Assert.equals(execute("point.x"), 12);
		Assert.equals(execute("point.y"), 24);

		execute("var copyPoint = point.copy();");
		Assert.isOfType(execute("copyPoint"), ExtendedPoint, "Copy Point Is Not ExtendedPoint");
		Assert.equals(execute("copyPoint.x"), 12);
		Assert.equals(execute("copyPoint.y"), 24);

		execute("point.alias(new ExtendedPoint(114514, 1919810));");
		Assert.equals(execute("point.x"), 114514, "alias.x was not 114514");
		Assert.equals(execute("point.y"), 1919810, "alias.y was not 1919810");
	}
	
	public function test_CustomClass_Extend_ExtendB_SuperClass_CheckType() {
		execute("var point = new Point();");
		var e = execute("point");
		Assert.isTrue(e is hscript.customclass.CustomClass, "please go dead");
		Assert.isTrue(e.superClass is ExtendedPoint, "point is not ExtendedPoint");
	}
}