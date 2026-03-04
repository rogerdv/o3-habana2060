-- NewComponent.lua

local Player = 
{
    Properties =
    {
        -- Property definitions
         PlayerScriptEventRef = {default=ScriptEventsAssetRef()},
         Camera = {default = EntityId()},
         Actor = {default = EntityId()}
         
    }
}

local MoveVector = Vector3()
--local Camera
local look_target

function Player:OnActivate()
    -- Activation Code
    MoveVector.x=0
    MoveVector.y=0
    self.controller = InputEvents.Connect(self, self.entityId)
    self.TickBusHandler = TickBus.Connect(self)
    --Camera = CameraSystemRequestBus.Broadcast.GetActiveCamera()
    AnimGraphComponentRequestBus.Event.SetParameterFloat(self.Properties.Actor,"Speed", 0)
    
    
end

function Player:OnTick(dt, time)	
	--local CamRotation = TransformBus.Event.GetWorldRotationQuaternion(self.Properties.Camera)
	--local DirVector = Vector3(MoveVector.x, MoveVector.y, 0)
	  
    
	CharacterControllerRequestBus.Event.AddVelocityForTick(self.entityId, look_target*150*dt)
	--RigidBodyRequestBus.Event.ApplyLinearImpulse(self.entityId, look_target*5*dt)
	
end

function Player:InputMove(MoveAxis)
	if MoveAxis.y==0 then
		--not moveing, stop
		AnimGraphComponentRequestBus.Event.SetParameterFloat(self.Properties.Actor,"Speed", 0)
	else
		AnimGraphComponentRequestBus.Event.SetParameterFloat(self.Properties.Actor,"Speed", 5)
	end
	--if CharacterGameplayRequestBus.Event.IsOnGround(self.entityId) then
	MoveVector.x=MoveAxis.x
	MoveVector.y=MoveAxis.y	
	--MoveVector.z=MoveAxis.z	
	
	local current_cam_tm  = TransformBus.Event.GetWorldTM(self.Properties.Camera)
	local cam_fwd = Transform.GetBasisY(current_cam_tm)
    cam_fwd.z = 0
    local cam_rgt = Transform.GetBasisX(current_cam_tm)
    cam_rgt.z = 0
    look_target = (cam_rgt*MoveVector.x) + (cam_fwd*MoveVector.y)
    local current_pos = TransformBus.Event.GetWorldTranslation(self.entityId)
    local move_to = current_pos + (look_target)*0.1
    local fw_norm = Vector3.GetNormalized(cam_fwd)
    local r = Vector3(0,1,0)
    local axis = Vector3.Cross(r, fw_norm)
    local dotP = Vector3.Dot(r, fw_norm)
    local angle = Math.ArcCos(dotP)    
    axis = axis:GetNormalized()
    local w = Math.Cos(angle/2)
    local x = axis.x*Math.Sin(angle/2)
    local y = axis.y*Math.Sin(angle/2)
    local z = axis.z*Math.Sin(angle/2)
    local RotQuat = Quaternion.CreateFromValues(x,y,z,w)
    
    TransformBus.Event.SetWorldRotationQuaternion(self.entityId, RotQuat)  
    
end

function Player:InputJump()

end

function Player:OnDeactivate()
    -- Deactivation Code
    self.TickBusHandler:Disconnect()
end

return Player