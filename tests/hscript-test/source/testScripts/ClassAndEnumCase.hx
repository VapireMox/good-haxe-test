package testScripts;

class ClassAndEnumCase extends HScriptCase {
	public function new() {
		super();

		execute('
class EnumTest {
	public static function toEnum(val:String):Test {
		return switch(val.toLowerCase()) {
			case "a": Test.A;
			case "b": Test.B;
			case "c": Test.C;
			case "d": Test.D;
			case "e": Test.E;
			case "f": Test.F;
			default: throw "Enum Test Has No This" + "\'" + val + "\'";
		};
	}

	public static function fromEnum(en:Test):String {
		return en.name;
	}
}

enum Test {
	A;
	B;
	C;
	D;
	E;
	F;
}
		');
	}

	public function test_Class_And_Enum_From_Static() {
		Assert.equals(execute("EnumTest.fromEnum(EnumTest.toEnum('A'))"), "A");
		Assert.equals(execute("EnumTest.fromEnum(EnumTest.toEnum('B'))"), "B");
		Assert.equals(execute("EnumTest.fromEnum(EnumTest.toEnum('C'))"), "C");
		Assert.equals(execute("EnumTest.fromEnum(EnumTest.toEnum('D'))"), "D");
		Assert.equals(execute("EnumTest.fromEnum(EnumTest.toEnum('E'))"), "E");
		Assert.equals(execute("EnumTest.fromEnum(EnumTest.toEnum('F'))"), "F");
	}
}