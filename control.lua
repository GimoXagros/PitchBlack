require 'Libs/PitchBlack/main'


--On load game for first time
script.on_init(function()
    Main:On_Init()
end)

--On mod version different or if mod did not previously exist
script.on_configuration_changed(function(data)
    if data.mod_changes and data.mod_changes.PitchBlack then
        if not data.mod_changes.PitchBlack.old_version or data.mod_changes.PitchBlack.old_version < '0.2.5' then
            if settings.global["pitch-BiterDamageModifier"] then
                game.forces.enemy.set_ammo_damage_modifier('melee', settings.global["pitch-BiterDamageModifier"].value)
            end
            if settings.global["pitch-SpitterDamageModifier"] then
                game.forces.enemy.set_ammo_damage_modifier('biological', settings.global["pitch-SpitterDamageModifier"].value)
            end
        end
    end
    Main:On_Configuration_Changed(data)
end)

--Called once per in-game tick
--local smoke = {"fire-smoke", "fire-smoke-without-glow", "soft-fire-smoke"}
--local max = 0
--local triggered = false
script.on_event(defines.events.on_tick, function(event)
    --    local count
    --    for _, name in pairs(smoke) do
    --        count = game.surfaces.nauvis.count_entities_filtered{type="smoke"}
    --        if count > max then max = count end
    --        if count and count > 0 then
    --            if not triggered then triggered = true end
    --            log(string.format("%s: %s", name, count))
    --        end
    --        if count == 0 and triggered then
    --            log("max: " .. max)
    --            triggered = false
    --        end
    --    end
    Main:On_Tick(event)
end)

script.on_event(defines.events.on_biter_base_built, 
	function(event)
		Main:On_BiterBuild(event)
	end
)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    local _, err = pcall(function()
        if event.setting == "pitch-DebugMode" then
            pbLogger.debug_mode = settings.global["pitch-DebugMode"].value
        end
        if event.setting == "pitch-DayLength" then
            Time.DayLength = settings.global["pitch-DayLength"].value
        end
        if event.setting == "pitch-FirstDayPhaseLength" then
            Time.DayPhaseConfig.VariableData[1].MinLength = settings.global["pitch-FirstDayPhaseLength"].value
            Time.DayPhaseConfig.VariableData[1].MaxLength = settings.global["pitch-FirstDayPhaseLength"].value
        end

        if event.setting == "pitch-BiterDamageModifier" then
            game.forces.enemy.set_ammo_damage_modifier('melee', settings.global["pitch-BiterDamageModifier"].value)
        end
        if event.setting == "pitch-SpitterDamageModifier" then
            game.forces.enemy.set_ammo_damage_modifier('biological', settings.global["pitch-SpitterDamageModifier"].value)
        end
    end)
    if err then
        game.print("Pitch Black: Error occured, see log")
        log(serpent.block(err))
    end
end)

script.on_event(defines.events.on_player_died, function(event)
    local _, _ = pcall(function()
        local player = game.players[event.player_index]
        player.surface.create_entity({name = "pitch_explosion", position=player.position})
    end)
end)

remote.add_interface("PitchBlack", 
{
	SkipTimePhase = 
	function() 
		Time.SkipPhase()
	end
})