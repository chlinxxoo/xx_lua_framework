--Author: chl
--Email: haolin.chen1991@gmail.com
--2015.11.17 20:19

-- 统一输出函数，可以制定样式，支持多参数如printChl("a", "b", "c")
printChl = function (...)
	do return end
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

-- 使用触摸，结合t_XXXX配置表，可以通过调用tc(_btn.main.armyOverview)点击x=104, y=24的坐标
tc = function (tb, sleep)
	local pos = tb[_orientation]		-- 可以根据屏幕方向做自适应
	if pos and pos.x and pos.y then
	    touchDown(1, pos.x * 2, pos.y * 2)
	    mSleep(sleep or 50)
	    touchUp(1, pos.x * 2, pos.y * 2)
	else
		printChl("click failed! x or y is not offer")
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
	local current_time = os.date("%Y-%m-%d-"..suffix, os.time())
	_snapshot(current_time..".png", 0, 0, _fsw, _fsh)    
end

dg = function (content)
    dialog(content, 3)
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

sortTable = function (s)
	local sort = {}
	local copy = {}
	for k,v in pairs(s) do
		copy[k] = v
	end
	for k,v in pairs(s) do
		local curK, curV = nil, nil
		for k2,v2 in pairs(copy) do
			if not curK then 
				curK = k2 
			else
				printChl(k2, k)
				if k2 <= curK then
					curK = k2
					curV = v2
				end
			end
		end
		printChl(curK)
		table.insert(sort, {k = curK, v = curV})
		copy[curK] = nil
	end
	return sort
end

local bb = require("badboy")
json = bb.json
