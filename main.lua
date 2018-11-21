--[[
  Lineup Coords:
    X: 403.9289
    Y: -996.6722
    Z: -100

  Customise Anim Start:
    X: 405.62100
    Y: -997.099365
    Z: -100
    Rotation: 85
]]--

local FEMALE_ANIM = 'mp_character_creation@customise@female_a';
local FEMALE_MODEL = GetHashKey('mp_f_freemode_01')
local MALE_ANIM = 'mp_character_creation@customise@male_a';
local MALE_MODEL = GetHashKey('mp_m_freemode_01')


Citizen.CreateThread(function ()
  setPlayerModel(MALE_MODEL)
  playIntroAnim(MALE_ANIM)
end)

function playIntroAnim(animKey)
  RequestAnimDict(animKey)
  while (not HasAnimDictLoaded(animKey)) do
    Citizen.Wait(100)
  end

  StartPlayerTeleport(PlayerId(), 405.421, -997.099365, -100.0, 92.0)
  while (IsPlayerTeleportActive()) do
    Citizen.Wait(5)
  end
  TaskPlayAnim(PlayerPedId(), animKey, 'intro', 1.0, -1.0, 5000, 0, 1, true, true, true)
  Citizen.Wait(5000)
  -- TODO: End this when customization is done
  local times = 0
  while times < 1 do
    TaskPlayAnim(PlayerPedId(), animKey, 'drop_intro', 1.0, -1.0, 5000, 0, 2, true, true, true)
    times = times + 1
    Citizen.Wait(5000)
  end
end

function setPlayerModel(modelKey)
  if(GetEntityModel(PlayerPedId()) ~= modelKey) then
    RequestModel(modelKey)
    while (not HasModelLoaded(modelKey)) do
      Citizen.Wait(100)
    end

    SetPlayerModel(PlayerId(), modelKey)
    SetPedDefaultComponentVariation(PlayerPedId())
  end
end

Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())

    SetTextScale(0, 0.25)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString('Player Coords:')
    DrawText(0.005, 0.35)
    SetTextScale(0, 0.25)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString('x: ' .. playerCoords.x .. ' y: ' .. playerCoords.y .. ' z: ' .. playerCoords.z .. ' head: ' .. heading)
    DrawText(0.01, 0.375)
    SetTextScale(0, 0.25)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(IsPointOnRoad(table.unpack(playerCoords)) and 'On Road' or 'Not On Road')
    DrawText(0.01, 0.4)
  end
end)
