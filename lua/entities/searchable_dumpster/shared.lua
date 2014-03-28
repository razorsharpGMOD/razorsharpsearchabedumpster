ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Searchable Dumpster"
ENT.Author = "Razor Sharp"
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:DTVar("Int", 0, "cooldown")
end