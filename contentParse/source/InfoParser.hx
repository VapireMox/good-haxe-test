package;

using StringTools;

class InfoParser {
  public static function parseFromString(content:String):Dynamic {
    return new InfoParser().parseString(content);
  }

  public function new() {
    
  }

  public function parseString(content:String) {
    for(line in content.split("\n"))
      var needIndex:Int = line.indexOf(":");
  }
}
