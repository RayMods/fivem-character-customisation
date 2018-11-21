--[[
  Lineup Coords:
    X: 403.9289
    Y: -996.6722
    Z: -100
]]--

local FEMALE_MODEL = GetHashKey('mp_f_freemode_01')
local MALE_MODEL = GetHashKey('mp_m_freemode_01')


local dictName = 'mp_character_creation@lineup@male_a'
Citizen.CreateThread(function ()
  RequestModel(MALE_MODEL)
  while (not HasModelLoaded(MALE_MODEL)) do
    Citizen.Wait(100)
  end

  SetPlayerModel(PlayerId(), MALE_MODEL)
  SetPedDefaultComponentVariation(PlayerPedId())

  --[[
    Play anims to imitate GTA:O opening anim into mugshot:

    RequestAnimDict('mp_character_creation@lineup@male_a')
    while (not HasAnimDictLoaded('mp_character_creation@lineup@male_a')) do
      Citizen.Wait(100)
    end

    TaskPlayAnim(PlayerPedId(), 'mp_character_creation@lineup@male_a', 'intro', 1.0, -1.0, 5000, 0, 1, true, true, true)
    Citizen.Wait(5000)
    TaskPlayAnim(PlayerPedId(), 'mp_character_creation@lineup@male_a', 'intro', 1.0, -1.0, 5000, 0, 1, true, true, true);

    TODO: Sync up the two animations above so the first results in ped facing correct direction when
    second plays. Might require updating ped's coords between animations. Also need to set the ped's
    start coords outside the mugshot room to walk in.
  ]]--
end)

Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)
    local playerCoords = GetEntityCoords(PlayerPedId())

    SetTextScale(0, 0.25)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString('Player Coords:')
    DrawText(0.005, 0.35)
    SetTextScale(0, 0.25)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString('x: ' .. playerCoords.x .. ' y: ' .. playerCoords.y .. ' z: ' .. playerCoords.z)
    DrawText(0.01, 0.375)
    SetTextScale(0, 0.25)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(IsPointOnRoad(table.unpack(playerCoords)) and 'On Road' or 'Not On Road')
    DrawText(0.01, 0.4)
  end
end)
