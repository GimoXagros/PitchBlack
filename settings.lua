data:extend{
	{
		--Desc: Max evolution value
		--Default: 100 (100%)
		type = "int-setting",
		name = "pitch-MaxEvolution",
		setting_type = "runtime-global",
		default_value = 100,
		minimum_value = 0,
		order = "pitch-a[Evolution]-a[MaxEvolution]"
	},
	{
		--Desc: Biter expansion scale
		--Default: 100 (100%)
		type = "int-setting",
		name = "pitch-ExpansionScale",
		setting_type = "runtime-global",
		default_value = 100,
		minimum_value = 0,
		maximum_value = 100,
		order = "pitch-a[Evolution]-b[ExpansionScale]"
	},
	{
		--Desc: Biter expansion scale
		--Default: 100 (100%)
		type = "double-setting",
		name = "pitch-ScalePollutionDamage",
		setting_type = "runtime-global",
		default_value = 1.0,
		minimum_value = 0.0,
		maximum_value = 1.0,
		order = "pitch-a[Evolution]-c[ScalePollutionDamage]"
	},
	{
		--Desc: Scalar value for how much the enemy evolves, must be greater than 0.
		--Default: 1 (100%)
		--Note: To make the enemies easier, use a smaller value. To make them harder, use a higher value.
		--ValType: Floating point
		type = "double-setting",
		name = "pitch-ScaleEvolutionRate",
		setting_type = "runtime-global",
		default_value = 1,
		minimum_value = 0.0001,
		order = "pitch-a[Evolution]-d[ScaleEvolutionRate]"
	},
	{
		type = "double-setting",
		name = "pitch-BiterDamageModifier",
		setting_type = "runtime-global",
		default_value = 0,
		minimum_value = -0.9,
		order = "pitch-a[Evolution]-e[BiterDamageModifier]"
	},
	{
		type = "double-setting",
		name = "pitch-SpitterDamageModifier",
		setting_type = "runtime-global",
		default_value = 0,
		minimum_value = -0.9,
		order = "pitch-a[Evolution]-f[SpitterDamageModifier]"
	},
	{
		--Desc: Number of real seconds in a game day
		--Default: 600 (10 minutes)
		--Note: A single day is not necessarily the cycle of the sun... E.G there could be multiple days with the sun up.
		type = "int-setting",
		name = "pitch-PhaseLength",
		setting_type = "runtime-global",
		default_value = 600,
		minimum_value = 1,
		order = "pitch-b[DayLength]-a[DayLength]"
	},
	{
		--Desc: Debug mode, affects things like how verbose logging is to file.
		--Default: false
		type = "bool-setting",
		name = "pitch-DebugMode",
		setting_type = "runtime-global",
		default_value = false,
		order = "pitch-z[Debug]-a[Debug]"
	},
	{

		--Desc: Scalar value for enemy health, must be greater than 0.
		--Default: 1 (100%)
		--Note: To make the enemies weaker, use a smaller value. To make them tougher, use a higher value.
		type = "double-setting",
		name = "pitch-EnemyHealthScale",
		setting_type = "startup",
		default_value = 2.75,
		minimum_value = 0.0001,
		order = "pitch-a[Evolution]-a[EnemyHealthScale]"
	},
	{
		--Desc: Scalar value for how much the enemy spawns, must be greater than 0.
		--Default: 1 (100%)
		--Note: To make the enemies easier, use a smaller value. To make them harder, use a higher value.
		--ValType: Floating point
		--EnemySwarmScale = 1.0,
		type = "double-setting",
		name = "pitch-EnemySwarmScale",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.0001,
		order = "pitch-a[Evolution]-b[EnemySwarmScale]"
	},
	{
		type = "double-setting",
		name = "pitch-BiterDamageScale",
		setting_type = "startup",
		default_value = 2.5,
		minimum_value = 0.0001,
		order = "pitch-a[Evolution]-c[BiterDamage]"
	},
	{
		type = "double-setting",
		name = "pitch-SpitterDamageScale",
		setting_type = "startup",
		default_value = 2,
		minimum_value = 0.0001,
		order = "pitch-a[Evolution]-d[SpitterDamage]"
	},
	{
		type = "double-setting",
		name = "pitch-EnemyMovementScale",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.0001,
		order = "pitch-a[Evolution]-e[EnemyMovementScale]"
	},
	{
		type = "bool-setting",
		name = "pitch-addResistances",
		setting_type = "startup",
		default_value = true,
		order = "pitch-a[Evolution]-f[addResistances]"
	},
	{
		type = "bool-setting",
		name = "pitch-disableSmoke",
		setting_type = "startup",
		default_value = true,
		order = "pitch-z[disableSmoke]-a[disableSmoke]"
	}
}

local biters = {'small-biter', 'medium-biter', 'big-biter', 'behemoth-biter'}
local spitters = {'small-spitter', 'medium-spitter', 'big-spitter', 'behemoth-spitter'}

for i, name in pairs(biters) do
	data:extend({
		{
			type = "double-setting",
			name = "pitch-" .. name .. "-resistance",
			setting_type = "startup",
			default_value = 10*(i-1)+5,
			minimum_value = 0,
			order = "pitch-a[Evolution]-f[addResistances]-a-" .. i
		},
	})
end

for i, name in pairs(spitters) do
	data:extend({
		{
			type = "double-setting",
			name = "pitch-" .. name .. "-resistance",
			setting_type = "startup",
			default_value = 10*(i-1)+5,
			minimum_value = 0,
			order = "pitch-a[Evolution]-f[addResistances]-b-" .. i
		},
	})
end

local DayPhase = {'First', 'Second', 'Third', 'Fourth'}

-- Day Phase Length&Brightness
for i, name in pairs(DayPhase) do
	data:extend({
		{
			type = "int-setting",
			name = "pitch-" .. name .. "DayPhaseMaxLength",
			setting_type = "runtime-global",
			default_value = 12-(i*2),
			minimum_value = 1,
			order = "pitch-b[DayLength]-b[MaxDayLength]-" .. i
		},
		{
			type = "int-setting",
			name = "pitch-" .. name .. "DayPhaseMinLength",
			setting_type = "runtime-global",
			default_value = 12-(i*2),
			minimum_value = 1,
			order = "pitch-b[DayLength]-c[MinDayLength]-" .. i
		},
		{
			type = "int-setting",
			name = "pitch-" .. name .. "NightPhaseMaxLength",
			setting_type = "runtime-global",
			default_value = i,
			minimum_value = 1,
			order = "pitch-b[DayLength]-d[MaxDayLength]-" .. i
		},
		{
			type = "int-setting",
			name = "pitch-" .. name .. "NightPhaseMinLength",
			setting_type = "runtime-global",
			default_value = i,
			minimum_value = 1,
			order = "pitch-b[DayLength]-e[MinDayLength]-" .. i
		},
		{
			type = "double-setting",
			name = "pitch-" .. name .. "DayPhaseMaxBrightness",
			setting_type = "runtime-global",
			default_value = 1.0-(i*0.2),
			minimum_value = 0.0,
			maximum_value = 1.0,
			order = "pitch-c[Brightness]-a[MaxDayBrightness]-" .. i
		},
		{
			type = "double-setting",
			name = "pitch-" .. name .. "DayPhaseMinBrightness",
			setting_type = "runtime-global",
			default_value = 1.0-(i*0.2),
			minimum_value = 0.0,
			maximum_value = 1.0,
			order = "pitch-c[Brightness]-b[MinDayBrightness]-" .. i
		},
		{
			type = "double-setting",
			name = "pitch-" .. name .. "NightPhaseMaxBrightness",
			setting_type = "runtime-global",
			default_value = 0.0,
			minimum_value = 0.0,
			maximum_value = 1.0,
			order = "pitch-c[Brightness]-c[MaxDayBrightness]-" .. i
		},
		{
			type = "double-setting",
			name = "pitch-" .. name .. "NightPhaseMinBrightness",
			setting_type = "runtime-global",
			default_value = 0.0,
			minimum_value = 0.0,
			maximum_value = 1.0,
			order = "pitch-c[Brightness]-d[MinDayBrightness]-" .. i
		},
	})
end