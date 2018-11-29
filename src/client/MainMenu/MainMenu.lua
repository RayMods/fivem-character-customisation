local COORDS = {

  LSIA = { -1031.64, -2742.02, 12.2, 350.8 }
}

local _editItem = NativeUI.CreateItem('Edit Character', 'Edit your current character.')
local _initItem = NativeUI.CreateItem('Create Character', 'Create a brand new character.')
local _leaveItem = NativeUI.CreateItem('Leave Character Creation', 'Exit character creation menu and spawn at LSIA')
local _menu = NativeUI.CreateMenu('Character Management')

-- TODO: Move to utils
local function PhaseEntity(entity)
  -- TODO: Disable collision at start, enable at end
  for i = 0, 9 do
    if (i % 2 == 0) then
      SetEntityAlpha(PlayerPedId(), 100)
    else
      SetEntityAlpha(PlayerPedId(), 255)
    end

    Citizen.Wait(100)
  end
end

local function finish()
  DoScreenFadeOut(300)
  Citizen.Wait(300)
  StartPlayerTeleport(PlayerId(), table.unpack(COORDS.LSIA))

  while (IsPlayerTeleportActive()) do
    Citizen.Wait(50)
  end

  Citizen.Wait(300)
  DoScreenFadeIn(2500)
  PhaseEntity(PlayerPedId())
end

local function handleSelectOption(sender, item, index)
  if (item == _leaveItem) then
    finish()
  end
end

_menu:AddItem(_initItem)
_menu:AddItem(_editItem)
_menu:AddItem(_leaveItem)
_menu.OnItemSelect = handleSelectOption

function RegisterMainMenu(menuPool)
  menuPool:Add(_menu)

  return _menu
end
