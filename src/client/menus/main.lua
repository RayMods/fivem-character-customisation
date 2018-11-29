local _pool = NativeUI.CreatePool()

local MainMenu = NativeUI.CreateMenu('Character Creator')
_pool:Add(MainMenu)

function AddSexItem()
  local menuItem = NativeUI.CreateListItem('Sex', { 'Male', 'Female' }, 1)
  MainMenu:AddItem(menuItem)
end

function AddFeaturesMenu()
  local featuresMenu = _pool:AddSubMenu(MainMenu, 'Features', 'Select to alter your facial features.')

  local browItem = NativeUI.CreateListItem('Brow', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local eyesItem = NativeUI.CreateListItem('Eyes', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local noseItem = NativeUI.CreateListItem('Nose', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local noseProfileItem = NativeUI.CreateListItem('Nose Profile', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local noseTipItem = NativeUI.CreateListItem('Nose Tip', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local cheekbonesItem = NativeUI.CreateListItem('Cheekbones', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local cheeksItem = NativeUI.CreateListItem('Cheeks', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local lipsItem = NativeUI.CreateListItem('Lips', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local jawItem = NativeUI.CreateListItem('Jaw', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local chinProfileItem = NativeUI.CreateListItem('Chin Profile', { 'Custom' }, 1, 'Make changes to your physical Features.')
  local chinShapeItem = NativeUI.CreateListItem('Chin Shape', { 'Custom' }, 1, 'Make changes to your physical Features.')

  featuresMenu:AddItem(browItem)
  featuresMenu:AddItem(eyesItem)
  featuresMenu:AddItem(noseItem)
  featuresMenu:AddItem(noseProfileItem)
  featuresMenu:AddItem(noseTipItem)
  featuresMenu:AddItem(cheekbonesItem)
  featuresMenu:AddItem(cheeksItem)
  featuresMenu:AddItem(lipsItem)
  featuresMenu:AddItem(jawItem)
  featuresMenu:AddItem(chinProfileItem)
  featuresMenu:AddItem(chinShapeItem)
end

function addAppearanceItem(name, menu)
  local item = NativeUI.CreateListItem(name, { 'Current' }, 1, 'Make changes to your Appearance.')
  menu:AddItem(item)
end

function AddAppearanceMenu()
  local featuresMenu = _pool:AddSubMenu(MainMenu, 'Appearance', 'Select to change your Appearance.')

  addAppearanceItem('Hair', featuresMenu)
  addAppearanceItem('Eyebrows', featuresMenu)
  addAppearanceItem('Skin Blemishes', featuresMenu)
  addAppearanceItem('Skin Aging', featuresMenu)
  addAppearanceItem('Skin Complexion', featuresMenu)
  addAppearanceItem('Moles & Freckles', featuresMenu)
  addAppearanceItem('Skin Damage', featuresMenu)
  addAppearanceItem('Eye Color', featuresMenu)
  addAppearanceItem('Eye Makeup', featuresMenu)
  addAppearanceItem('Blusher', featuresMenu)
  addAppearanceItem('Lipstick', featuresMenu)
end

AddSexItem()
-- AddHeritageMenu()
CreateHeritageMenu(_pool, MainMenu)
AddFeaturesMenu()
AddAppearanceMenu()

local function flashPed()
  -- local dir = -1;
  for i = 0, 7 do
    if (i % 2  == 0) then
      SetEntityAlpha(PlayerPedId(), 50)
    else
      SetEntityAlpha(PlayerPedId(), 255)
    end

    Citizen.Wait(100)
  end
end

local function resetPlayerPed()
end

local function teleportToStart()
end

local function finishAndQuit()
  local lsiaCoords = { -1017.46, -2748.97, 0.0, 161.4 }

  DoScreenFadeOut(300)
  Citizen.Wait(300)
  StartPlayerTeleport(PlayerId(), table.unpack(lsiaCoords))
  while (IsPlayerTeleportActive()) do
    Citizen.Wait(5)
  end
  DoScreenFadeIn(300)
  flashPed()
  -- for i = 0, 5 do
  --   if (i % 2 == 0) then
  --     SetEntityAlpha(PlayerPedId(), 0)
  --   else
  --     SetEntityAlpha(PlayerPedId(), 255)
  --   end
  --   Citizen.Wait(500)
  -- end
end

local function CreateInteractionMenu()
  local interactionMenu = NativeUI.CreateMenu('Character Manager')
  local initItem = NativeUI.CreateItem('Create Character', 'Create a brand new character.')
  local editItem = NativeUI.CreateItem('Edit Character', 'Edit your current character')
  local leaveItem = NativeUI.CreateItem('Leave Character Creation', 'Exit creation menu and spawn at LSIA.')

  _pool:Add(interactionMenu)
  interactionMenu:AddItem(initItem)
  interactionMenu:AddItem(editItem)
  interactionMenu:AddItem(leaveItem)

  interactionMenu.OnItemSelect = function (sender, item, index)
    if (item == initItem) then
      print('init char creation')
    elseif (item == leaveItem) then
      finishAndQuit()
      -- DoScreenFadeOut(300)
      -- Citizen.Wait(300)
      -- StartPlayerTeleport(PlayerId(), -1017.46, -2748.97, 0.0, 161.4)
      -- local waited = 0;
      -- while (IsPlayerTeleportActive()) do
      --   Citizen.Wait(5)
      --   waited = waited + 5
      -- end
      -- DoScreenFadeIn(300)
    end
  end

  return interactionMenu
end

local _mainMenu = CreateMainMenu(_pool)
local _interactionMenu = CreateInteractionMenu()
_pool:RefreshIndex()


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    _pool:ProcessMenus()

    if (IsControlJustPressed(0, 166)) then
      _mainMenu:Visible(not _mainMenu:Visible())
    elseif (IsControlJustPressed(0, 167)) then
      _interactionMenu:Visible(not _interactionMenu:Visible())
    end
  end
end)
