function onGetKey(playerObj)
	ISTimedActionQueue.add(get_key:new(playerObj));
	
end

local old_ISVehicleMenu_showRadialMenu = ISVehicleMenu.showRadialMenu

function ISVehicleMenu.showRadialMenu(playerObj)
	local isPaused = UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0
	if isPaused then return end
	old_ISVehicleMenu_showRadialMenu(playerObj)
	local vehicle = playerObj:getVehicle()
	if vehicle ~= nil then
		local menu = getPlayerRadialMenu(playerObj:getPlayerNum())
		
	if menu:isReallyVisible() then
		if menu.joyfocus then
			setJoypadFocus(playerObj:getPlayerNum(), nil)
		end
		menu:undisplay()
		return
	end
		
		-- un-hotwire and get key
		if vehicle:isDriver(playerObj) and
			not vehicle:isEngineStarted() and
			not vehicle:isEngineRunning() and
			not SandboxVars.VehicleEasyUse and
			not vehicle:isKeysInIgnition() and
			not playerObj:getInventory():haveThisKeyId(vehicle:getKeyId()) then
				menu:addSlice(getText("ContextMenu_VehicleLocKey "), getTexture("media/ui/vehicles/KeyBlindToKey.png"), onGetKey, playerObj);
		end
		menu:addToUIManager()
	end
end