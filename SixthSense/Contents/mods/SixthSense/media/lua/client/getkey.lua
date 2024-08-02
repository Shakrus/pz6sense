

require "TimedActions/ISBaseTimedAction"

get_key = ISBaseTimedAction:derive("get_key")

function get_key:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and
		vehicle:isDriver(self.character) and
		not vehicle:isEngineRunning() and
		not vehicle:isEngineStarted()
end

function get_key:update()
end

function get_key:start()
end

function get_key:stop()
	ISBaseTimedAction.stop(self)
end

function get_key:perform()
	local vehicle = self.character:getVehicle()

vehicle:softReset();
--vehicle:addKeyToGloveBox();
	--IsoGridSquare var1 = vehicle:getCell():getGridSquare((double)vehicle:getX(), (double)vehicle:getY(), (double)vehicle:getZ());
	local vehX = vehicle:getX()
	local vehY = vehicle:getY()
	local vehZ = vehicle:getZ()
	self.character:setHaloNote("Adding to square :["..tostring(vehX)..","..tostring(vehY)..","..tostring(vehZ).."]")
	
	local cell = vehicle:getCell()
	local gridSquare = cell:getGridSquare(vehX, vehY, vehZ)
	vehicle:addKeyToSquare(gridSquare);
	
	--sendClientCommand(self.character, "vehicle", "getKey", {vehicle = vehicle:getId()})
	ISBaseTimedAction.perform(self)
end

function get_key:new(character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.maxTime = 1
	return o
end
