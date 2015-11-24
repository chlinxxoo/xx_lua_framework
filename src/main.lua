--Author: chl
--Email: haolin.chen1991@gmail.com
--2015.11.17 20:15

function main()
    require "enum"
	require "util"
	require "global"

    init("0", _orientation)
	
	require "init"
	require "actionMgr"

	local actionConfig = require("doSomeThing").init()
	runOnce(actionConfig)
end

-- lua异常捕捉
function error(msg)
	local errorMsg = "[LUA ERROR]"..msg
	printChl(errorMsg)    
end

xpcall(main, error)
