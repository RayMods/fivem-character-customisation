local _pool = NativeUI.CreatePool()

local MainMenu = NativeUI.CreateMenu('Character Creator')
_pool:Add(MainMenu)

function AddSexItem()
  local menuItem = NativeUI.CreateListItem('Sex', { 'Male', 'Female' }, 1)
  MainMenu:AddItem(menuItem)
end

function AddHeritageMenu()
  local heritageMenu = _pool:AddSubMenu(MainMenu, "Heritage")
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

AddSexItem()
AddHeritageMenu()
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
