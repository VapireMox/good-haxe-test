import haxe.macro.Expr;
import haxe.macro.Context;

class Main {
  static function main() {
    trace(parseExpr("function nb() {trace(\"hello world\");}"));
  }

  static macro function parseExpr(content:String) {
    var sb = Context.parse(content, Context.currentPos());

    return sb;
  }
}
