-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

include("nh2/soundscripts/announcer_soundfiles.lua")
include("nh2/soundscripts/captionsample.lua")
include("nh2/soundscripts/emily_soundfiles.lua")
include("nh2/soundscripts/game_sounds.lua")
include("nh2/soundscripts/game_sounds_ambient_generic.lua")
include("nh2/soundscripts/game_sounds_weapons.lua")
include("nh2/soundscripts/nh2sounds.lua")
include("nh2/soundscripts/npc_sounds_nh_guard.lua")
include("nh2/soundscripts/npc_sounds_nhdemon.lua")
include("nh2/soundscripts/npc_sounds_nhzombie.lua")
include("nh2/soundscripts/npc_sounds_stalker.lua")
include("nh2/soundscripts/romero_soundfiles.lua")
include("nh2/soundscripts/swat_soundfiles.lua")

include("nh2/networks.lua")

AddCSLuaFile("nh2/soundscripts/announcer_soundfiles.lua")
AddCSLuaFile("nh2/soundscripts/captionsample.lua")
AddCSLuaFile("nh2/soundscripts/emily_soundfiles.lua")
AddCSLuaFile("nh2/soundscripts/game_sounds.lua")
AddCSLuaFile("nh2/soundscripts/game_sounds_ambient_generic.lua")
AddCSLuaFile("nh2/soundscripts/game_sounds_weapons.lua")
AddCSLuaFile("nh2/soundscripts/nh2sounds.lua")
AddCSLuaFile("nh2/soundscripts/npc_sounds_nh_guard.lua")
AddCSLuaFile("nh2/soundscripts/npc_sounds_nhdemon.lua")
AddCSLuaFile("nh2/soundscripts/npc_sounds_nhzombie.lua")
AddCSLuaFile("nh2/soundscripts/npc_sounds_stalker.lua")
AddCSLuaFile("nh2/soundscripts/romero_soundfiles.lua")
AddCSLuaFile("nh2/soundscripts/swat_soundfiles.lua")

AddCSLuaFile("nh2/networks.lua")

if SERVER then
    hook.Add("EntityEmitSound", "NH2::EntityEmitSound", function(data)
        local name = data.OriginalSoundName
        local filen = data.SoundName
        local level = data.SoundLevel
        local pos = data.Pos

        if not IsValid(data.Entity) then return end
        
        net.Start(NH2NET.CC)
            net.WriteString(name)
            net.WriteString(filen)
        net.Broadcast()
    end)
end

if CLIENT then
    net.Receive(NH2NET.CC, function(len, ply)
        local name = net.ReadString()
        local filen = net.ReadString()
        local text = language.GetPhrase(name)

        if text == name or text == '' or text == ' ' then return end
        if string.find(text, "<sfx>") then return end

        text = string.gsub(text, "<sfx>", "")

        -- Extract duration from <len:DURATION>
        local duration = SoundDuration(filen)
        local lenTag = string.match(text, "<len:([%d%.]+)>")
        if lenTag then
            duration = tonumber(lenTag) or duration
        end
        
        gui.AddCaption('<norep:1>' .. text, duration, false)
    end)
end