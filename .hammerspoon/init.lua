--------------- 依赖定义 ------------------

hs.loadSpoon("ModalMgr")
hs.loadSpoon("WinWin")
hs.loadSpoon("KSheet")
hs.loadSpoon("SpeedMenu")
hs.loadSpoon("BingDaily")

-------------- 自定义配置 -----------------

--- 禁用热键提示，开始使用的时候可以先设置成 1
hs.hotkey.alertDuration = 0

--- 禁用切换应用时的文件名提示
hs.hints.showTitleThresh = 0

--- 禁用动画
hs.window.animationDuration = 0

-------------- 自定义功能 -----------------

--- 应用快速布局
if spoon.WinWin then
	spoon.ModalMgr:new("FastLayout")
	local cmodal = spoon.ModalMgr.modal_list["FastLayout"]

	-- 定义进入环境后的快捷键
	cmodal:bind('', 'escape', '退出快速布局', function() spoon.ModalMgr:deactivate({"FastLayout"}) end)
	cmodal:bind('shift', '/', '查看帮助', function() spoon.ModalMgr:toggleCheatsheet() end)
	cmodal:bind('', 'F', '全屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end)
	cmodal:bind('', 'C', '居中', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("center") end)
	cmodal:bind('', 'H', '移动到左半屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end)
	cmodal:bind('', 'L', '移动到右半屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end)
	cmodal:bind('', 'K', '移动到上半屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfup") end)
	cmodal:bind('', 'J', '移动到下半屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfdown") end)
	cmodal:bind('', 'Y', '移动到左三分之一屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("onethirdleft") end)
	cmodal:bind('', 'O', '移动到右三分之一屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("onethirdright") end)
	cmodal:bind('', 'U', '移动到上三分之一屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("onethirdup") end)
	cmodal:bind('', 'I', '移动到下三分之一屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("onethirddown") end)
	cmodal:bind('', 'N', '移动到左三分之二屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("twothirdsleft") end)
	cmodal:bind('', '.', '移动到右三分之二屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("twothirdsright") end)
	cmodal:bind('', 'M', '移动到上三分之二屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("twothirdsup") end)
	cmodal:bind('', ',', '移动到下三分之二屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("twothirdsdown") end)
	cmodal:bind('', '=', '放大', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
	cmodal:bind('', '-', '缩小', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)

	-- 按下 alt + L 进入快速布局
	spoon.ModalMgr.supervisor:bind({"alt"}, "L", "Enter FastLayout Environment", function()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({"FastLayout"})
	end)
end

--- 应用的快速切换
spoon.ModalMgr:new("GoApp")
local cmodal = spoon.ModalMgr.modal_list["GoApp"]
cmodal:bind('', 'escape', 'Deactivate GoApp', function() spoon.ModalMgr:deactivate({"GoApp"}) end)
cmodal:bind('shift', '/', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
hsapp_list = {
	{key = 'A', name = 'Alacritty'},
	{key = 'C', name = 'Google Chrome'},
	{key = 'W', name = 'WeChat'},
	{key = 'Y', name = '网易有道词典'},
	{key = 'M', id = 'com.apple.ActivityMonitor'},
}

for _, v in ipairs(hsapp_list) do
	if v.id then
		local located_name = hs.application.nameForBundleID(v.id)
		if located_name then
			cmodal:bind('', v.key, located_name, function()
				hs.application.launchOrFocusByBundleID(v.id)
				spoon.ModalMgr:deactivate({"GoApp"})
			end)
		end
	elseif v.name then
	   cmodal:bind('', v.key, v.name, function()
			hs.application.launchOrFocus(v.name)
			spoon.ModalMgr:deactivate({"GoApp"})
		end)
	end
end

spoon.ModalMgr.supervisor:bind({"alt"}, "G", "Enter GoApp Environment", function()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({"GoApp"})
end)

--- 当前应用快捷键提示
if spoon.KSheet then
	spoon.ModalMgr:new("KeySheet")
	local cmodal = spoon.ModalMgr.modal_list["KeySheet"]

	cmodal:bind('', 'escape', 'Deactivate KeySheet', function()
		spoon.KSheet:hide()
		spoon.ModalMgr:deactivate({"KeySheet"})
	end)

	-- 按下 alt + shift + / 查看当前应用快捷键
	spoon.ModalMgr.supervisor:bind({"alt", "shift"}, "/", "Enter KeySheet Environment", function()
		spoon.KSheet:show()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({"KeySheet"})
	end)
end

--- Esc 自动中文输入法切换为英文，使用 Vim 写 Markdown 时用
tapper = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
	if event:getKeyCode() == 53 then
		if hs.keycodes.currentSourceID() ~= 'com.apple.keylayout.ABC' then
			hs.keycodes.currentSourceID('com.apple.keylayout.ABC')
		end
	end
end)

if tapper then
	spoon.ModalMgr:new("MarkdownEsc")
	local cmodal = spoon.ModalMgr.modal_list["MarkdownEsc"]

	cmodal:bind({"alt"}, 'M', 'Deactivate MarkdownEsc', function()
		tapper:stop()
		spoon.ModalMgr:deactivate({"MarkdownEsc"})
	end)

	spoon.ModalMgr.supervisor:bind({"alt"}, "M", "Enter MarkdownEsc Environment", function()
		tapper:start()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({"MarkdownEsc"})
	end)
end

--- 浏览页面时使用 j、k 代替上下
tapper2 = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  if event:getCharacters() == "j" then
		return true, {hs.eventtap.event.newKeyEvent({}, "down", true)}
	elseif event:getCharacters() == "k" then
		return true, {hs.eventtap.event.newKeyEvent({}, "up", true)}
	end
end)

if tapper2 then
	spoon.ModalMgr:new("ReadPage")
	local cmodal = spoon.ModalMgr.modal_list["ReadPage"]

	cmodal:bind({"alt"}, 'R', 'Deactivate ReadPage', function()
		tapper2:stop()
		spoon.ModalMgr:deactivate({"ReadPage"})
	end)

	spoon.ModalMgr.supervisor:bind({"alt"}, "R", "Enter ReadPage Environment", function()
		tapper2:start()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({"ReadPage"})
	end)
end

--- 默认开启网速提示
if spoon.SpeedMenu then
	spoon.SpeedMenu:start()
end

--- 默认开启 supervisor 的环境，按 ctrl + cmd + shift + q 切换 supervisor 开启关闭。 按 ctrl + cmd + shift + / 打开环境帮助。
--- 只有开启 supervisor 环境时，才能输入热键开启其他环境。比如按下 alt + L 进入 FastLayout 环境。
spoon.ModalMgr.supervisor:enter()
