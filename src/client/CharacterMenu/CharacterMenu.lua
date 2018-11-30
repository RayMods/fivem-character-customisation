local PED_ID = {
  GetHashKey('mp_f_freemode_01'),
  GetHashKey('mp_m_freemode_01'),
}

local _menu = NativeUI.CreateMenu('Character Creator')
local _sexSelector = NativeUI.CreateListItem('Sex', { 'Female', 'Male' }, 2)
local _values = {
  sex = 2,
}


local function setPlayerModelClothing(sex)
  SetPedDefaultComponentVariation(PlayerPedId())

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
end

local function updatePlayerSex(sex)
  local blendValues = GetPedHeadBlendData(PlayerPedId())
  local newModel = PED_ID[sex]

  RequestModel(newModel)
  while (not HasModelLoaded(newModel)) do
    Citizen.Wait(50)
  end
  SetPlayerModel(PlayerId(), newModel)
  setPlayerModelClothing(sex)

  _values.sex = sex;
end

local function handleChangeItem(send, item, index)
  if (item == _sexSelector) then
    updatePlayerSex(index)
  end
end

_menu:AddItem(_sexSelector)
_menu.OnListChange = handleChangeItem

function RegisterCharacterMenu(menuPool)
  menuPool:Add(_menu)
  CreateHeritageMenu(menuPool, _menu)

  menuPool:RefreshIndex()

  return _menu
end
