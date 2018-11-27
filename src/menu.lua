local _pool = NativeUI.CreatePool()

local MainMenu = NativeUI.CreateMenu('Character Creator')
_pool:Add(MainMenu)

function AddSexItem()
  local menuItem = NativeUI.CreateListItem('Sex', { 'Male', 'Female' }, 1)
  MainMenu:AddItem(menuItem)
end

function AddHeritageMenu()
  local heritageMenu = _pool:AddSubMenu(MainMenu, 'Heritage', 'Select to choose your parents.')
  local fatherOptions = { 'Adrian', 'Alex', 'Andrew', 'Angel', 'Anthony', 'Benjamin', 'Claude', 'Daniel', 'Diego', 'Ethan', 'Evan', 'Gabriel', 'Isaac', 'John', 'Joshua', 'Juan', 'Kevin', 'Louis', 'Michael', 'Niko', 'Samual', 'Santiago', 'Vincent' }
  local motherOptions = { 'Amelia', 'Ashely', 'Audrey', 'Ava', 'Briana', 'Camila', 'Charlotte', 'Elizabeth', 'Emma', 'Evelyn', 'Giselle', 'Grace', 'Hannah', 'Isabella', 'Jasmine', 'Misty', 'Natalie', 'Nicole', 'Olivia', 'Sophie', 'Violet', 'Zoe' }
  local resemblanceAmt = {}
  local skinToneAmt = {}

  for i = 1, 100 do
    resemblanceAmt[i] = i
    skinToneAmt[i] = i
  end

  local fatherItem = NativeUI.CreateListItem("Dad", fatherOptions, 1, 'Select your Dad.')
  local motherItem = NativeUI.CreateListItem("Mom", motherOptions, 1, 'Select your Mom.')
  local resemblanceItem = NativeUI.CreateSliderItem("Resemblance", resemblanceAmt, 50, "Select if your features are influenced more by your Mother or your Father.", true)
  local skinToneItem = NativeUI.CreateSliderItem("Skin Tone", resemblanceAmt, 50, "Select if your skin tone is influenced more by your Mother or your Father.", true)
  heritageMenu:AddItem(motherItem)
  heritageMenu:AddItem(fatherItem)
  heritageMenu:AddItem(resemblanceItem)
  heritageMenu:AddItem(skinToneItem)
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
AddHeritageMenu()
AddFeaturesMenu()
AddAppearanceMenu()
_pool:RefreshIndex()


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    _pool:ProcessMenus()
    if IsControlJustPressed(1, 51) then
      MainMenu:Visible(not MainMenu:Visible())
    end
  end
end)
