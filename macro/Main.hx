import haxe.macro.Expr;
import haxe.macro.Context;

class Main {
  static function main() {
    trace(parseExpr("
class Test {
  public function new() {}
}
    "));
  }

  static function parseExpr(content:String) {
    return Context.parse(content, Context.currentPos());
  }
}
