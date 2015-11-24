--Author: chl
--Email: haolin.chen1991@gmail.com
--2015.11.17 20:16

function findBtn(module)
    for k, v in pairs(_btn[module]) do
    	local x, y = findImageInRegionFuzzy(k .. ".png", 90, 0, 0, _sw, _sh, 0xffffff);
		if x ~= -1 and y ~= -1 then 
			printChl("match", k..".png", x, y)
		else
			printChl("can not match", k..".png")
			dialog("0.5秒后请点击"..k..".png所在位置", 0)
			ss()
			x,y = catchTouchPoint()
		end
		_btn[module][k] = {
			x = x,
			y = y,
		}
    end
end

function grepTouchPos()
	while true do
		local x,y = catchTouchPoint()
	    printChl(x, y)
	    ss()
	    touchUp(1, x * 2, y * 2)
	end
end

-- grepTouchPos()