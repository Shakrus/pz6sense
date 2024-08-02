require "TimedActions/ISBaseTimedAction"

get_info = ISBaseTimedAction:derive("get_info")

function get_info:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and
		vehicle:isDriver(self.character) and
		not vehicle:isEngineRunning() and
		not vehicle:isEngineStarted()
end

function get_info:update()
end

function get_info:start()
end

function get_info:stop()
	ISBaseTimedAction.stop(self)
end

function get_info:perform()
	local vehicle = self.character:getVehicle()
	local keyID = vehicle:getKeyId();


	local vehX = vehicle:getX()
	local vehY = vehicle:getY()
	local vehZ = vehicle:getZ()
	local cell = vehicle:getCell()
	local gridSquare = cell:getGridSquare(vehX, vehY, vehZ) --IsoGridSquare
	
	self.character:setHaloNote(
'POST = ignition='..tostring(vehicle:isKeysInIgnition())..
' door='..tostring(vehicle:isKeyIsOnDoor())..
' Key=?'..tostring(vehicle:getKeySpawned())..
' KeyID='..tostring(keyID)..
'GoodCar?'..tostring(vehicle:isGoodCar()))
	local objs = gridSquare:getObjects();
	
	--local objs = gridSquare.getObjects();
	
	--for i = 1,objs:size()-1 do
		--local obj = objs:get(i);
		--local name = obj:getObjectName();
		--local invItem = obj:getItem();
		
		--if (invItem) then 
		--	local obj_type = invItem:getType();
		--	local st_type  = invItem:getStringItemType()
		--	local o_n = invItem:getObjectName();
			--local o_cid = obj:getClassID(); 
			--local o_kid = obj:getKeyId();
		--	print (st_type)
		--else	
		--	print ('nil')
		--local o_n = obj:getObjectName();
		--local o_cid = obj:getClassID(); 
		--local o_kid = obj:getKeyId();
		--end		
	--end
	--for obj in objs do
		--obj:debugPrintout()
	--end
--	for(var6 = 1; var6 < var5.getObjects().size(); ++var6) { --перебираем обьекты
	

	--IsoGridSquare var1 = vehicle:getCell():getGridSquare((double)vehicle:getX(), (double)vehicle:getY(), (double)vehicle:getZ());
--	local vehX = vehicle:getX()
--	local vehY = vehicle:getY()
--	local vehZ = vehicle:getZ()
	--self.character:setHaloNote("Adding to square :["..tostring(vehX)..","..tostring(vehY)..","..tostring(vehZ).."]")
	
	--local cell = vehicle:getCell()
	--local gridSquare = cell:getGridSquare(vehX, vehY, vehZ)
	--vehicle:addKeyToSquare(gridSquare);
	
	--sendClientCommand(self.character, "vehicle", "getKey", {vehicle = vehicle:getId()})
	ISBaseTimedAction.perform(self)
end

function get_info:new(character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.maxTime = 1
	return o
end
