include("shared.lua")

function ENT:Initialize()
end


function ENT:Draw()
	self:DrawModel()

	local pos = self:GetPos()
	local ang = self:GetAngles()
	local Ang = self:GetAngles()
	local Pos = self:GetPos()
	
	surface.SetFont("HUDNumber5")
	local TxtWidth = surface.GetTextSize("Dumpster")
	
	cam.Start3D2D(pos + Vector(0, 0, 50), ang + Angle(0, 90, 90), 0.11)
		draw.RoundedBox(0, -200, -102.5, 400, 193, Color(33, 255, 0, 100))
		draw.SimpleText("Dumpster", "HUDNumber5", 0, -70, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	cam.End3D2D()
	
	cam.Start3D2D(Pos + Ang:Up() * 10.7, Ang, 0.16)

	cam.End3D2D()
	
	if self:GetDTInt(0) > 0 then
		surface.SetFont("HUDNumber5")
		local TxtWidth2 = surface.GetTextSize(string.FormattedTime(self:GetDTInt(0), "%01i:%02i"))
	
		cam.Start3D2D(pos + Vector(0, 0, 60), ang + Angle(0, 90, 90), .5)
			draw.WordBox(0, -28, 10, string.FormattedTime(self:GetDTInt(0), "%01i:%02i"), "HUDNumber5", Color(33, 255, 0, 0), Color(255,255,255,255))
		cam.End3D2D()
	end
end

function ENT:Think()
end


function ENT:Think()
end
