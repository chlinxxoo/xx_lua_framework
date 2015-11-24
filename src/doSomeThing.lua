--Author: chl
--Email: haolin.chen1991@gmail.com
--2015.11.17 22:41
-- 按数字从小到大，顺序执行，非数字函数不会执行，适合写功能实现的主逻辑

local f = {}

f.init = function (...)
	return f
end

f[1] = function (...)
	printChl("点击A")
	-- ...
end

f[5] = function (...)
    printChl("点击B")
    -- ...
end

f[13] = function (...)
	-- ...
end

f[15] = function (...)
-- ...
end

return f