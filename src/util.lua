--Author: chl
--Email: haolin.chen1991@gmail.com
--2015.11.17 20:19

-- 统一输出函数，可以制定样式，支持多参数如printChl("a", "b", "c")
local bb = require("badboy")
bb.loadutilslib()
json = bb.getJSON()

printChl = function (...)
	if not _isDebug then
		do return end
	end
	local params = {...}
	local str = nil
	for k,v in pairs(params) do
		if not str then
			str = tostring(v)
		else
			str = str .. ", " .. tostring(v)
		end
	end
    sysLog("[CHLINXXOO]>>>>"..str)
end

local print = sysLog
local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next

-- 格式化输出table（力荐）
printr = function (root, notPrint, params)
	if not _isDebug then
		do return end
	end
	local rootType = type(root)
	if rootType == "table" then
		local tag = params and params.tag or "Table detail:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		local cache = {  [root] = "." }
		local isHead = false
		local function _dump(t, space, name)
			local temp = {}
			if not isHead then
				temp = {tag}
				isHead = true
			end
			for k,v in pairs(t) do
				local key = tostring(k)
				if cache[v] then
					tinsert(temp, "+" .. key .. " {" .. cache[v] .. "}")
				elseif type(v) == "table" then
					local new_key = name .. "." .. key
					cache[v] = new_key
					tinsert(temp, "+" .. key .. _dump(v, space .. (next(t, k) and "|" or " " ) .. srep(" ", #key), new_key))
				else
					tinsert(temp, "+" .. key .. " [" .. tostring(v) .. "]")
				end
			end
			return tconcat(temp, "\n" .. space)
		end
		if not notPrint then
			print(_dump(root, "", ""))
			print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
		else
			return _dump(root, "", "")
		end
	else
		print("[printr error]: not support type")
	end
end

-- local posCache = {}
tc = function (config)
	if config then
		local x, y = nil
		if config.posFunc then
			-- local posCache[config.catchKey]
			x, y = config.posFunc()
			-- posCache[config.catchKey] = {x = x, y = y}
		else
			x, y = config.x, config.y
		end
		if x and y and x ~= -1 and y ~= -1 then
			printChl("tcing:", x, y)
			tap(x, y)
		else
			printChl("tcing error! x and y is nil")
		end
	else
		printChl("click failed! config is not legal")
	end
end

tcAll = function (config, loop, rc)
	if config then
		local ret = config.posFunc()
		printChl("found", #ret)
		for i, v in ipairs(ret) do
			-- 找到一个点就点rc次
			for i=1, rc do
				tc(v)
			end
		end
		if loop and #ret ~= 0 then
			ss()
			printChl("looping")
			tcAll(config, loop, rc)
		end
	else
		printChl("click failed! config is not legal")
	end
end

tm = function (pos)
	if pos and pos.x1 and pos.y1 and pos.x2 and pos.y2 then
	    touchDown(1, pos.x1, pos.y1)
	    mSleep(100)
	    touchMove(1, pos.x2, pos.y2)
	    mSleep(100)
	    touchUp(pos.x2, pos.y2)
    else
		printChl("move failed! xs or ys is not offer")
	end
end

s = function (time)
    mSleep(time or 100)
end

ss = function (time)
    s(time or 500)
end

local _snapshot = snapshot
snapshot = function (suffix)
	suffix = suffix or ""
	local current_time = os.date("%Y-%m-%d-"..suffix, os.time())
	_snapshot(current_time..".png", 0, 0, _fsw - 1, _fsh - 1)
	printChl("snapshot success!", current_time)
end

dg = function (content)
	toast(content)
    -- dialog(content, 3)
end

decodeTwo = function (str, ...)
	local p = {...}
    local ret = {}
	local keyFlag = true
	for w in string.gmatch(str, p[1]) do
		local key = nil
		for d in string.gmatch(w, p[2]) do
			if keyFlag then
				key = d
				keyFlag = false
			else
				ret[tostring(key)] = tonumber(d)
				key = nil
				keyFlag = true
			end
		end
	end
	return ret
end

isColor = function (c, s)
	local rr, gg, bb = getColorRGB(c.x * 2, c.y * 2)
	if rr >= c.r - s and rr <= c.r + s then
		if gg >= c.g - s and gg <= c.g + s then
			if bb >= c.b - s and bb <= c.b + s then
				printChl("isColor match", rr, gg, bb)
				return true
			end
		end
	end
	printChl("isColor not match", rr, gg, bb)
end

sortTable = function (s, func)
	local sort = {}
	local copy = {}
	for k,v in pairs(s) do
		copy[k] = v
	end
	for k,v in pairs(s) do
		local isFirst = true
		local curK, curV = nil, nil
		for k2,v2 in pairs(copy) do
			if isFirst then 
				curK = k2
				curV = v2
				isFirst = false
			else
				if func then
					-- printChl(curK, s[curK])
					-- printr(s[curK])
					if func(s[k2], s[curK], k2, curK) then
						curK = k2
						curV = v2
					end
				else
					if k2 <= curK then
						curK = k2
						curV = v2
					end
				end
			end
		end
		table.insert(sort, {k = curK, v = curV})
		copy[curK] = nil
	end
	return sort
end

formatJson = function (fileName, ...)
	return string.format(getUIContent(fileName), _jsonSize.width, _jsonSize.height, unpack(...))
end

resetConfig = function (...)
	dg("数据升级，重置中..")
	for i=1, _configCount do
	    setStringConfig("configName"..tostring(i), _configDefaultName)
	    setStringConfig(tostring(i-1), "")
	end
end