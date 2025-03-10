import haxe.macro.Expr;
import haxe.macro.Context;

class Main {
  static function main() {
    trace(parseExpr(""));
  }

  static macro function parseExpr(content:String):Expr {
    return Context.parse(content, Context.currentPos());
  }
}
