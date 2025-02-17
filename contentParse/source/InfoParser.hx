package;

using StringTools;

class InfoParser {
  public static function parseFromString(content:String):Dynamic {
    return new InfoParser().parseString(content);
  }

  public function new() {
    
  }

  public function parseString(content:String) {
    var grpMap:Map<String, String> = new Map();
    for(line in content.split("\n")) {
      var needIndex:Int = line.indexOf(":");
      var newKey:String = line.substr(0, needIndex).trim();
      var newValue:String = line.substr(needIndex + 1).trim();

      grpMap.set(newKey, newValue);
    }

    var idk:Dynamic = {};
    for(aa=>bb in grpMap) {
      Reflect.setField(idk, aa, bb);
    }
    return idk;
  }
}
