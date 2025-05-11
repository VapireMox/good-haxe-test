package testScripts;

using StringTools;

class HScriptCase extends Test {
	public var interp:Interp;
	public var parser:Parser;

	public function new(allowGlobal:Bool = true) {
		super();
		
		interp = new Interp();
		interp.errorHandler = errorHandler;

		parser = new Parser();
		parser.allowTypes = parser.allowMetadata = allowGlobal;
	}

	public function setVariable(name:String, value:Dynamic) {
		if(!interp.variables.exists(name)) interp.variables.set(name, value);
	}

	public function execute(code:String):Null<Dynamic> {
		var expr = parse(code);

		if(expr != null)
			return interp.execute(expr);

		return null;
	}

	private function checkByAccess():Bool {
		var result:Null<Assertation> = null;
		if((result = Assert.results.last()) != null) {
			return (switch(result) {
				case Success(pos): true;
				case Warning(msg): true;
				case Ignore(msg): true;
				default: false;
			});
		}

		return true;
	}

	private function parse(code:String):Dynamic {
		var expr:Expr = null;

		try {
			if(code != null && code.trim() != "")
				expr = parser.parseString(code);
		} catch(error:Error) {
			errorHandler(error);
		}

		return expr;
	}

	private function errorHandler(e:Error) {
		Assert.warn('HScript Error: ${e.toString()}');
	}
}