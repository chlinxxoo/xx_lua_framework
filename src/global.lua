--Author: chl
--Email: haolin.chen1991@gmail.com
--2015.11.17 20:34

_fsw, _fsh = getScreenSize()		--固定屏幕尺寸
_fsw = _fsw - 1
_fsh = _fsh - 1
_sw = _fsw							--开发尺寸
_sh = _fsh
_orientation = 0					--方向

_btn = require "t_touch"
_color = require "t_color"
_ui = require "t_ui"

printChl("Global Value:")
printChl(_fsw, _fsh)
printChl(_sw, _sh)