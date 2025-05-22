package scripts.luas.types;

typedef RawLuaDebug = #if ALLOW_LUASCRIPT cpp.RawPointer<hxluajit.Types.Lua_Debug> #else Null<Bool> #end

typedef LuaDebug = #if ALLOW_LUASCRIPT hxluajit.Types.Lua_Debug #else Dynamic #end