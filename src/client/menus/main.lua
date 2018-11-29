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
_pool:RefreshIndex()

local _mainMenu = CreateMainMenu(_pool)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    _pool:ProcessMenus()
    if IsControlJustPressed(1, 51) then
      _mainMenu:Visible(not MainMenu:Visible())
    end
  end
end)
