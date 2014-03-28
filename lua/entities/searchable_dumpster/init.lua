AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local cooldown = 90

local items = { -- Edit props here
	Props = {
		"models/props_c17/BriefCase001a.mdl",
		"models/props_c17/playgroundTick-tack-toe_block01a.mdl",
		"models/props_combine/breenclock.mdl",
		"models/props_junk/garbage_newspaper001a.mdl",
		"models/props_lab/reciever01d.mdl",
		"models/Gibs/wood_gib01e.mdl",
		"models/props_junk/garbage_glassbottle001a.mdl",
		"models/props_junk/garbage_coffeemug001a.mdl",
		"models/props_junk/garbage_milkcarton002a.mdl",
		"models/props_junk/garbage_metalcan001a.mdl",
		"models/props_lab/huladoll.mdl",
		"models/props_lab/harddrive01.mdl",
		"models/props_junk/PopCan01a.mdl",
		"models/props_c17/computer01_keyboard.mdl",
		"models/props_interiors/Furniture_chair01a.mdl",
		"models/props_interiors/pot02a.mdl",
		"models/props_c17/doll01.mdl",
		"models/props_c17/metalPot001a.mdl",
		"models/props_lab/bindergreen.mdl",
		"models/props_lab/bindergraylabel01a.mdl",
		"models/props_lab/binderbluelabel.mdl",
		"models/props_lab/clipboard.mdl",
		"models/props_lab/frame001a.mdl",
		"models/props_lab/frame002a.mdl",
		"models/props_trainstation/payphone_reciever001a.mdl",
		"models/props_vehicles/carparts_muffler01a.mdl",
		"models/props_vehicles/carparts_wheel01a.mdl",
		"models/props_lab/jar01b.mdl",
		"models/props_lab/box01a.mdl",
		"models/props_junk/garbage_glassbottle002a.mdl",
		"models/props_junk/garbage_glassbottle003a.mdl",
		"models/props_junk/garbage_metalcan002a.mdl",
		"models/props_junk/garbage_plasticbottle003a.mdl",
		"models/props_junk/PlasticCrate01a.mdl",
		"models/props_junk/cardboard_box004a.mdl",
		"models/props_junk/CinderBlock01a.mdl",
		"models/props_junk/garbage_carboard002a.mdl"
	},
	
	Guns = { -- Please, add your own guns here, since ill use the default DarkRP Weapons
		"weapon_deagle2",
		"weapon_fiveseven2",
		"weapon_glock2",
		"weapon_p2282",
		"weapon_mac102"
	},
	
	Entities = { -- As usual, only default stuff will be used! Edit this!
		"lockpick"
	}
}

	
local AllowedTeams = {
	TEAM_HOBO,
}

function ENT:Initialize()
	self:SetModel("models/props_junk/TrashDumpster01a.mdl")
	self:SetColor(Color(79, 60, 10, 255))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end


	
function ENT:GiveItems()
	local spawnpos = self:GetPos() + Vector(0, 0, 50)
	
	for i = 1, math.random(2, 5) do
		if math.random(1, 100) <= 3 then
			local ent = ents.Create(table.Random(items["Guns"]))
			ent:SetPos(spawnpos)
			ent:Spawn()
		elseif math.random(1, 100) <= 10 then
			local ent = ents.Create(table.Random(items["Entities"]))
			ent:SetPos(spawnpos)
			ent:Spawn()
		elseif math.random(1, 100) <= 100 then
			local prop = ents.Create("prop_physics")
			prop:SetModel(table.Random(items["Props"]))
			prop:SetPos(spawnpos)
			prop:Spawn()
			
			timer.Simple(60, function()
				if prop:IsValid() then
					prop:Remove()
				end
			end)
		end
	end
end

function ENT:PlayerUse(playerteam)
	if self:GetDTInt(0) > 0 then return end
	
	if table.HasValue(AllowedTeams, playerteam:Team()) then
		self:SetDTInt(0, cooldown)
		self:GiveItems()
		timer.Create("cooldown " ..self:EntIndex(), 1, 90, function()
			self:TimerRemove()
		end)
	end
end

function ENT:TimerRemove()
	self:SetDTInt(0, self:GetDTInt(0) - 1)
	
	if self:GetDTInt(0) <= 0 then
		if timer.Exists("DTime " ..self:EntIndex()) then
			timer.Destroy("DTime " ..self:EntIndex())
		end
	end
end