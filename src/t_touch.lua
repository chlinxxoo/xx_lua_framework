-- 触摸坐标配置表
-- 可以通过调用tc(_btn.main.armyOverview)点击“主界面的”x=104, y=24的“按钮”
-- 坐标使用数组形式，可以根据_orientation做自适应（同理亦可针对机型做自适应）

local ret = {
	main = {
		armyOverview = {
			{
				x = 104,
				y = 24,
			},
			{
				x = 0,
				y = 0,
			}
		},
	},
	army = {
		close = {
			{
				x = 350,
				y = 562,
			},
			{
				x = 0,
				y = 0,
			}
		},
	}
}

return ret