--Author: chl
--Email: haolin.chen1991@gmail.com
--2015.11.17 20:34

_isDebug = false

_fsw, _fsh = getScreenSize()
_sw = _fsh - 1
_sh = _fsw - 1
_orientation = 1		--0 竖屏、1 home右、 2 home左

require "t_config"
_curR = "r".._fsw.._fsh

printChl("Global Value:")
printChl("_orientation:", _orientation, "_fsw:", _fsw, "_fsh:", _fsh, "_sw:", _sw, "_sh:", _sh, "_curR:", _curR)

if not _config[_curR] then
	dialogRet("不支持当前分辨率", "XXXXX", "", "", 0)
	writePasteboard("xxosyfz")
	do return end
end
_btn = require(_config[_curR].touch)