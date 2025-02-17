package;

class Main {
  public static function main():Void {
    sys.thread.Thread.create(() -> {
      while (true) {
        trace("other thread");
        Sys.sleep(1);
      }
    });
    Sys.sleep(5);
  }
}
