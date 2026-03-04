

local PlayerController = 
{
    Properties =
    {
        -- Property definitions
        Player = {default = EntityId()}
    }
}

function PlayerController:OnActivate()
    -- Activation Code
    self.ForwardBack = {}
    self.LeftRight = {}
    self.Jump = {}
    self.CamPitch = {}
    self.CamYaw = {}
    --CharacterGameplayRequestBus.Broadcast.SetFallingVelocity(0,0,-20)
    
    --local t = ComponentApplicationBus.Broadcast.GetEntityName(self.Properties.Player)
    --Debug.Log(t)   
    
    -- Player stuff
    self.ForwardBack.OnHeld = function(_, value)    	
     	--Debug.Log(tostring(value))
     	local DirVec = Vector2()
     	DirVec.y = value
        InputEvents.Event.InputMove(self.Properties.Player, DirVec)
    end
    
    self.ForwardBack.OnReleased = function(_, value)    	
     	--Debug.Log(tostring(value))
     	local DirVec = Vector2()
     	DirVec.y = 0
        InputEvents.Event.InputMove(self.Properties.Player, DirVec)
    end
    
    self.LeftRight.OnHeld = function(_, value)    	
     	--Debug.Log(tostring(value))
     	local DirVec = Vector2()
     	DirVec.x = value
        InputEvents.Event.InputMove(self.Properties.Player, DirVec)
    end
    
    self.LeftRight.OnReleased= function(_, value)    	
     	--Debug.Log(tostring(value))
     	local DirVec = Vector2()
     	DirVec.y = 0
        InputEvents.Event.InputMove(self.Properties.Player, DirVec)
    end
    
    self.Jump.OnPressed = function(_, value)    	
     	
        
    end
    
    self.Jump.OnReleased = function(_, value)    	
     	
    end
    
    --Camera stuff
    self.CamPitch.OnHeld = function(_, value)
    	--Debug.Log("Rot Value ")
    	
     	GlobalCameraEvents.Broadcast.UpdateVerticalAxis(value)
        
    end
    
    self.CamPitch.OnReleased = function(_, value)    	
     	GlobalCameraEvents.Broadcast.UpdateVerticalAxis(0)        
    end
    
    self.CamYaw.OnHeld = function(_, value)
    	
     	--Debug.Log(tostring(value))
     	GlobalCameraEvents.Broadcast.UpdateHorizAxis(value)
        
    end
    
    self.CamYaw.OnReleased = function(_, value)
    	
     	--Debug.Log(tostring(value))
     	GlobalCameraEvents.Broadcast.UpdateHorizAxis(0)
        
    end   
    
    
    self.FBInputHandler = InputEventNotificationBus.Connect(self.ForwardBack, InputEventNotificationId("ForwardBack"))
    self.LRInputHandler = InputEventNotificationBus.Connect(self.LeftRight, InputEventNotificationId("LeftRight"))
    self.JumpInputHandler = InputEventNotificationBus.Connect(self.LeftRight, InputEventNotificationId("Jump"))
    self.CamPitchInputHandler = InputEventNotificationBus.Connect(self.CamPitch, InputEventNotificationId("CameraPitch"))
	self.CamYawInputHandler = InputEventNotificationBus.Connect(self.CamYaw, InputEventNotificationId("CameraYaw"))
	
	GlobalCameraEvents.Broadcast.SetCameraFollowTarget(self.Properties.Player)
end

function PlayerController:OnDeactivate()
    -- Deactivation Code
end

return PlayerController