import haxe.macro.Expr;
import haxe.macro.Context;

class Main {
  static function main() {
    trace(parseExpr("class Sb {}"));
  }

  static macro function parseExpr(content:String) {
    var sb = Context.parse(content, Context.currentPos());

    Context.defineType(sb);
    return sb;
  }
}
