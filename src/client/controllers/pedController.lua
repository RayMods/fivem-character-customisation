local INITIAL_BLEND = {
  {
    face = 0.25,
    skin = 0.25,
  },
  {
    face = 0.75,
    skin = 0.75,
  },
}

local PED_ID = {
  GetHashKey('mp_f_freemode_01'),
  GetHashKey('mp_m_freemode_01'),
}


local function setPlayerModel(sex)
  local newModel = PED_ID[sex]
  local pedId

  RequestModel(newModel)
  while (not HasModelLoaded(newModel)) do
    Citizen.Wait(50)
  end
  SetPlayerModel(PlayerId(), newModel)

  pedId = PlayerPedId()
  SetPedDefaultComponentVariation(pedId)
  if (sex == 1) then
    -- Female Clothing
    SetPedComponentVariation(PlayerPedId(), 3, 12, 0, 2)   -- torso
    SetPedComponentVariation(PlayerPedId(), 4, 3, 15, 2)  -- pants
    SetPedComponentVariation(PlayerPedId(), 6, 4, 2, 2)   -- shoes
    SetPedComponentVariation(PlayerPedId(), 8, 14, 0, 2) -- shirt
    SetPedComponentVariation(PlayerPedId(), 11, 118, 0, 2) -- jacket
  else
    -- Male Clothing
    SetPedComponentVariation(PlayerPedId(), 3, 5, 0, 2);   -- torso
    SetPedComponentVariation(PlayerPedId(), 4, 7, 15, 2);  -- pants
    SetPedComponentVariation(PlayerPedId(), 6, 7, 0, 0);   -- shoes
    SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 2);  -- shirt
    SetPedComponentVariation(PlayerPedId(), 11, 5, 0, 2)   -- jacket
  end

  SetPedHeadBlendData(
    PlayerPedId(),
    HERITAGE_MOTHERS[1].faceId,
    HERITAGE_FATHERS[1].faceId,
    nil, -- third face id
    HERITAGE_MOTHERS[1].skinId, -- first skin id (mother skin tone?)
    HERITAGE_FATHERS[1].skinId, -- second skin id (father skin tone?)
    nil, -- third skin id
    INITIAL_BLEND[sex].face, -- shape mix (face)
    INITIAL_BLEND[sex].skin, -- skin mix,
    nil, -- third mix,
    false  -- not a parent ped
  )
end

local function setPedParentFaces(mother, father)
end

local function setPedParentFaceBlend(pct)
end

local function setPedParentSkinBlend(pct)
end


AddEventHandler('cc_initPlayerModel', setPlayerModel)
AddEventHandler('cc_heritageChange', setPedParentFaces)
AddEventHandler('cc_faceBlendChange', setPedParentFaceBlend)
AddEventHandler('cc_skinBlendChange', setPedParentSkinBlend)
