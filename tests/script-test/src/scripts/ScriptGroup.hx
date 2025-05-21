package scripts;

import scripts.interfaces.IScriptUsed;
import scripts.ScriptSortStyle;

#if ALLOW_HSCRIPT
typedef HScriptGroup = TypedScriptGroup<ScriptHaxe>
#end
#if ALLOW_LUASCRIPT
typedef LUAScriptGroup = TypedScriptGroup<ScriptLua>
#end
typedef ScriptGroup = TypedScriptGroup<ScriptBase>

/**
 * 一个用于管理一堆脚本的组合，在面对大多数的脚本管理时使用这个效果更好（应该吧
 */
class TypedScriptGroup<T:IScriptUsed> implements IScriptUsed {
	/**
	 * 指定包名（差不多无用的
	 */
	public var name(default, null):String;
	/**
	 * 已装载脚本的数量
	 */
	public var length(get, never):Int;
	inline function get_length():Int
		return _members.length;
	/**
	 * 装载脚本的容器
	 */
	public var members(get, never):Array<T>;
	inline function get_members():Array<T>
		return _members;

	/**
	 * 是否已运行该脚本组
	 */
	public var loaded:Bool;
	/**
	 * 我懒得说
	 */
	public var active:Bool = false;

	@:allow(scripts.ScriptUtil)
	var _stats:Map<String, sys.FileStat>;
	var _members:Array<T>;
	var _sortStyle:ScriptSortStyle;

	/**
	 * 创建脚本管理包
	 * @param packName			  与name挂钩，可以当做一种标签吧
	 * @param ?sortStyle		  排序方式，即脚本要先从那个运行开始运行，比如`NAME(INCREASE)`，除了使用`ScriptUtil`里的`loadScriptsFromDirectory`，只能使用`NAME`
	 */
	public function new(packName:String, ?sortStyle:ScriptSortStyle) {
		if(sortStyle == null) sortStyle = NAME(INCREASE);

		name = packName;
		_sortStyle = sortStyle;

		loaded = false;
		active = true;
		init();
	}

	/**
	 * 添加符合的脚本
	 * @param sc		  选择添加的脚本
	 */
	public function add(sc:T) {
		members.push(sc);
		configureScript(sc);
	}

	/**
	 * 移除已存在的脚本
	 * @param sc		  选择移除的脚本
	 */
	public function remove(sc:T) {
		if(members.contains(sc)) {
			members.remove(sc);
		}
	}

	/**
	 * 插入符合的脚本
	 * @param pos	  选择的位置来插入
	 * @param sc		  选择插入的脚本
	 */
	public function insert(pos:Int, sc:T) {
		members.insert(pos, sc);
		configureScript(sc);
	}

	/**
	 * 用于配置已加入包中的脚本……当脚本加入到管理包时，此函数就会调用，此函数拥有dynamic性质，在舔加脚本前可以修改其值，达到配置脚本的效果
	 * 例如：
	 * ```haxe
	 * var scGroup = ScriptGroup();
	 * scGroup.configuteScript = function (sc:IScriptUsed) {
	 *   if(sc is ScriptHaxe) {
	 *     sc.set("Std", Std);
	 *     sc.set("Math", Math);
	 *   }
	 * };
	 * scGroup.add(new ScriptHaxe("something.hx"));
	 * scGroup.load();
	 * ```
	 * @param sc		  脚本，没啥好说的……
	 */
	public dynamic function configureScript(sc:T) {}

	/**
	 * 调用已加入此组里的所有脚本里的指定函数，若不存在……那就是不存在喽
	 * @param name		  指定函数名
	 * @param ?args		  封装输入参数
	 + @return 返回最近被调用的脚本函数的非null返回值
	 */
	public function call(name:String, ?args:Array<Dynamic>):Dynamic {
		if(members.length > 0 && active) {
			var ret:Dynamic = null;
			var i:Int = -1;
			while(i++ < members.length - 1) {
				final sc = members[i];

				final oldRet = ret;
				ret = sc.call(name, args);
				if(ret == null) ret = oldRet;
			}

			return ret;
		}

		return null;
	}

	/**
	 * 获取脚本中的资产值
	 * @param get		  指定的资产名
	 * @return				  返回优先获取到的资产非null值，否则都是null
	 */
	public function get(name:String):Dynamic {
		if(members.length > 0 && active) {
			var i:Int = -1;
			while(i++ < members.length - 1) {
				final sc = members[i];

				if(sc.get(name) != null) {
					return sc.get(name);
				}
			}
		}

		return null;
	}

	/**
	 * 这还用多说？就是加载已加入组中的脚本并运行，只能加载一次
	 * @return 返回无论是什么妖魔鬼怪，返回的都是null（懒了）
	 */
	public function load():Dynamic {
		if(members.length > 0 && active) {
			sortMembers();

			var i:Int = -1;
			while(i++ < members.length - 1) {
				final sc = members[i];

				sc.load();
			}
		}

		return null;
	}

	/**
	 * 设立已加入组中的所有脚本中指定的资产
	 * @param name		  资产名字
	 * @param value		  设立资产的值
	 */
	public function set(name:String, value:Dynamic) {
		if(members.length > 0 && active) {
			var i:Int = -1;
			while(i++ < members.length - 1) {
				final sc = members[i];

				sc.set(name, value);
			}
		}
	}

	public function iterator() {
		if(_members == null) return null;
		return _members.iterator();
	}

	function init() {
		_stats = new Map();
		_members = [];
	}

	/**
	 * 根据已选定的排序方式来排列脚本
	 */
	public function sortMembers() {
		if(!active) return;

		switch(_sortStyle) {
			case NAME(byd):
				_members.sort((left:T, right:T) -> (byd == INCREASE ? 1 : -1) * Reflect.compare(left.name.toLowerCase(), right.name.toLowerCase()));
			case SIZE(byd):
				_members.sort((left:T, right:T) -> {
					var leftSize:Int = 0;
					var rightSize:Int = 0;
					if(_stats.get(left.name) != null) {
						leftSize = _stats.get(left.name).size;
					}
					if(_stats.get(right.name) != null) {
						rightSize = _stats.get(right.name).size;
					}

					return (byd == INCREASE ? 1 : -1) * (leftSize < rightSize ? -1 : 1);
				});
			case DATE(byd, mode):
				_members.sort((left:T, right:T) -> {
					var leftDelta:Float = 0;
					var rightDelta:Float = 0;
					if(_stats.get(left.name) != null) {
						var time:Null<Date> = switch(mode) {
							case DACCESS: _stats.get(left.name).atime;
							case DMODIFIE: _stats.get(left.name).mtime;
							case DCREATE: _stats.get(left.name).ctime;
						};
						if(time == null) return 1;
						leftDelta = time.getTime();
					}
					if(_stats.get(right.name) != null) {
						var time:Null<Date> = switch(mode) {
							case DACCESS: _stats.get(left.name).atime;
							case DMODIFIE: _stats.get(left.name).mtime;
							case DCREATE: _stats.get(left.name).ctime;
						};
						if(time == null) return 1;
						rightDelta = time.getTime();
					}
					return (byd == INCREASE ? 1 : -1) * (leftDelta < rightDelta ? -1 : 1);
				});
			default: //nothing
		}
	}

	public function toString():String {
		return ScriptUtil.printScriptFieldString("SCRIPT-GROUP", [
			"name" => this.name,
			"counts" => this.length,
			"loaded" => this.loaded,
			"active" => this.active,
		]);
	}

	/**
	 * 破坏已加入组的脚本
	 * 顺带带上了自己
	 */
	public function destroy() {
		active = false;

		if(members.length > 0) {
			var i:Int = -1;
			while(i++ < members.length - 1) {
				final sc = members[i];
				sc.destroy();
			}
		}

		_stats = null;
		_members = null;
	}
}