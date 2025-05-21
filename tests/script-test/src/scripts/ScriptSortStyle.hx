package scripts;

enum ScriptSortStyle {
	/**
	 * 按名字排序
	 */
	NAME(order:ScriptOrderStyle);
	/**
	 * 按日期排序（可能会存在问题，也可能是我蔡🦶）
	 */
	DATE(order:ScriptOrderStyle, date:ScriptDateStyle);
	/**
	 * 按文件大小排序
	 */
	SIZE(order:ScriptOrderStyle);
}

enum ScriptOrderStyle {
	/**
	 * 排序由大到小
	 */
	DWINDING;
	/**
	 * 排序由小到大
	 */
	INCREASE;
}

enum abstract ScriptDateStyle(Int) from Int {
	/**
	 * 指定上一次文件访问时间
	 */
	var DACCESS:ScriptDateStyle = 0x0f;
	/**
	 * 指定上一次文件修改时间（推荐）
	 */
	var DMODIFIE:ScriptDateStyle = 0x1f;
	/**
	 * 指定文件创建时间（官方说在某些系统上会失效，所以不怎么推荐用）
	 */
	var DCREATE:ScriptDateStyle = 0x2f;
}