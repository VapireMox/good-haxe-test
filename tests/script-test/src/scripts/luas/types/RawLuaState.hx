package scripts.luas.types;

/**
 * 马德，天天冲成布尔值，我tm就把你变成布尔值！
 */
typedef RawLuaState = #if ALLOW_LUASCRIPT cpp.RawPointer<hxluajit.Types.Lua_State> #else Null<Bool> #end