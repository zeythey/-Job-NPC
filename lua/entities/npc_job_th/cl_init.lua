include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()
	local pos = self:GetPos()

	local ang = LocalPlayer():EyeAngles()

	ang:RotateAroundAxis(LocalPlayer():EyeAngles():Right() , 180)
	ang:RotateAroundAxis(LocalPlayer():EyeAngles():Forward() , 90)
	ang:RotateAroundAxis(LocalPlayer():EyeAngles():Up() , 90)

	cam.Start3D2D( pos+Vector(0,	0,	85), ang, 0.30 )
		draw.SimpleTextOutlined("NPC Job",	"Trebuchet24",	0,	0,	Color(255,	255,	255,	255),TEXT_ALIGN_CENTER,0,1,Color(0,	0,	0,	255))
	cam.End3D2D()
	
end