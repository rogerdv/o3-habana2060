-- Third person camera

local TPCamera = 
{
    Properties =
    {
        -- Property definitions
        Horiz = {default = EntityId()}, --Camera horizontal entity
        Vertical = {default = EntityId()}, --Camera horizontal entity
        Test = {default = EntityId()},
        CamScriptEventRef = {default=ScriptEventsAssetRef()}
    }
}

local Target
local pitch = 0
local yaw = 0
local Delta=0

function TPCamera:OnActivate()
    -- Activation Code
    self.CamController = GlobalCameraEvents.Connect(self)
    self.TickBusHandler = TickBus.Connect(self)
    
end

function TPCamera:OnTick(dt, time)
	Delta=dt
	if self.Properties.Test~=nil then
		local TPos = TransformBus.Event.GetWorldTranslation(self.Properties.Test)
		TransformBus.Event.SetWorldTranslation(self.entityId, TPos)
	end
	
end

function  TPCamera:SetTarget(TargetEntity)
	Target = TargetEntity
end

function  TPCamera:UpdateVerticalAxis(Y)
	--Debug.Log("Update camera Y")
	local RotVec = Vector3()
	pitch = pitch+Y*0.01*Delta
	--math.Clamp(pitch, -25, 45)
	--Math.Clamp(pitch, -0.02, 0.01)
	if pitch<-0.02 then
		pitch=-0.02
	end
	if pitch>0.01 then
		pitch = 0.01
	end
	--Debug.Log(tostring(pitch))
	RotVec.x=Math.RadToDeg(pitch)
	
	TransformBus.Event.SetLocalRotation(self.Properties.Vertical, RotVec)
end

function TPCamera:UpdateHorizAxis(X)
	--Debug.Log("Update camera X")
	local RotVec = Vector3()
	yaw=yaw+X*0.01*Delta
	RotVec.z=Math.RadToDeg(yaw)
	
	TransformBus.Event.SetLocalRotation(self.Properties.Horiz, RotVec)
	
end

function TPCamera:UpdateCameraAxis(YawAndPitch)
	local PitchVec = Vector3()
	pitch = pitch+Y*self.Delta
	Math.Clamp(pitch, -10, 45)
	PitchVec.x=Math.RadToDeg(pitch)
	TransformBus.Event.SetLocalRotation(self.Properties.Horiz, PitchVec)
	local YawVec= Vector3()
	yaw=yaw+X*self.Delta
	PitchVec.z=Math.RadToDeg(yaw)
	TransformBus.Event.SetLocalRotation(self.Properties.Horiz, YawVec)
end

function TPCamera:OnDeactivate()
    -- Deactivation Code
    self.TickBusHandler:Disconnect()
end

return TPCamera