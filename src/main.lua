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
  DoScreenFadeOut()
  Citizen.Wait(500)

  DoScreenFadeIn(6500)
end)


function createCam(x, y, z)
  return CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', x, y, z, -10.0, 0, 0, 60.0, true, 2)
end

-- Camera Anim Thread
Citizen.CreateThread(function ()
  Citizen.Wait(500)

  local startCoord = {
    x = 402.0,
    y = -1002.2399,
    z = -99,
  }
  local endCoord = {
    x = 402.8,
    y = -999.0,
    z = -99,
  }


  local cam1 = createCam(402.8, -1002.2399, -98.65)
  local cam2 = createCam(402.8, -999.125, -98.65)
  local cam3 = createCam(402.8, -999.1, -98.65)

  while (not DoesCamExist(cam1) and not DoesCamExist(cam2) and not DoesCamExist(cam3)) do
    Citizen.Wait(5)
  end

  SetCamActive(cam1, true)
  RenderScriptCams(true, true, 0, false, false)
  Citizen.Wait(100)
  SetCamActiveWithInterp(cam2, cam1, 3500, 0, 0)
  DestroyCam(cam1)
  Citizen.Wait(3500)
  SetCamActiveWithInterp(cam3, cam2, 500, 0, 0)
  DestroyCam(cam2)
end)

-- Ped Anim Thread
Citizen.CreateThread(function ()
  Citizen.Wait(0)
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
    TaskPlayAnim(PlayerPedId(), animKey, 'loop', 1.0, -1.0, 5000, 0, 2, true, true, true)
    times = times + 1
    Citizen.Wait(5000)
  end
end

function setPlayerModel(modelKey)
  -- if(GetEntityModel(PlayerPedId()) ~= modelKey) then
    RequestModel(modelKey)
    while (not HasModelLoaded(modelKey)) do
      Citizen.Wait(100)
    end

    SetPlayerModel(PlayerId(), modelKey)
    SetPedDefaultComponentVariation(PlayerPedId())

    -- Male Clothing
    SetPedComponentVariation(PlayerPedId(), 3, 5, 0, 2);   -- torso
    SetPedComponentVariation(PlayerPedId(), 4, 7, 15, 2);  -- pants
    SetPedComponentVariation(PlayerPedId(), 6, 7, 0, 0);   -- shoes
    SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 2);  -- shirt
    SetPedComponentVariation(PlayerPedId(), 11, 5, 0, 2)   -- jacket

    -- Female Clothing
    -- SetPedComponentVariation(PlayerPedId(), 3, 4, 0, 2)   -- torso
    -- SetPedComponentVariation(PlayerPedId(), 4, 3, 15, 2)  -- pants
    -- SetPedComponentVariation(PlayerPedId(), 6, 4, 2, 2)   -- shoes
    -- SetPedComponentVariation(PlayerPedId(), 8, 14, 0, 2) -- shirt
    -- SetPedComponentVariation(PlayerPedId(), 11, 118, 0, 2) -- jacket
  -- end
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
