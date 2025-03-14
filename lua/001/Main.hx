import llua.Lua;
import llua.LuaL;
import llua.State;

class Main {
  public static function main() {
    new Main("
print('hello lua');
    ").execute();
  }

  private var code:String;
  private var heart:State:

  private function new(code:String) {
    this.code = code;
    create();
  }

  private function execute() {
    if(Lua.dostring(heart, this.code) != Lua.LUA_OK) {
      throw Lua.tostring(heart, -1);
    }
  }

  private function create() {
    heart = LuaL.newstate();
    Lua.openlibs(heart);
  }
}
