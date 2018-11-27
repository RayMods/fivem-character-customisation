
local FATHERS = {
  'Benjamin',
  'Daniel',
  'Joshua',
  'Noah',
  'Andrew',
  'Juan',
  'Alex',
  'Isaac',
  'Evan',
  'Ethan',
  'Veincent',
  'Angel',
  'Deigo',
  'Adrian',
  'Gabriel',
  'Michael',
  'Santiago',
  'Kevin',
  'Louis',
  'Samuel',
  'Anthony',
  'Claude',
  'Niko',
}
local MOTHERS = {
  'Hannah',
  'Audrey',
  'Jasmine',
  'Giselle',
  'Amelia',
  'Isabella',
  'Zoe',
  'Ava',
  'Camila',
  'Violet',
  'Sophia',
  'Evelyn',
  'Nicole',
  'Ashley',
  'Grace',
  'Brianna',
  'Natalie',
  'Olivia',
  'Elizabeth',
  'Charlotte',
  'Emma',
  'Misty',
}

local _menu = nil
local _heritageWindow = nil
local _values = {
  dad = 0,
  mom = 0,
}


local function addParentItem(name, options, description)
  local menuItem = NativeUI.CreateListItem(name, options, 0, description)
  _menu:AddItem(menuItem)
end

local function addSliderItem(name, options, description)
  local menuItem = NativeUI.CreateSliderItem(name, options, 50, description, true)
  _menu:AddItem(menuItem)
end

local function addHeritageWindow(mom, dad)
  _heritageWindow = NativeUI.CreateHeritageWindow()
  _menu:AddWindow(_heritageWindow)
end

local function updateHeritageWindow(parent, index)
  print(index)
  _values[parent] = index - 1
  _heritageWindow:Index(_values.mom, _values.dad)
end

function CreateHeritageMenu(menuPool, parentMenu)
  local pct = {}
  for i = 1, 100 do
    pct[i] = i
  end

  _menu = menuPool:AddSubMenu(parentMenu, 'Heritage', 'Select to choose your parents.')

  addHeritageWindow()
  addParentItem('Dad', FATHERS, 'Select your Dad.')
  addParentItem('Mom', MOTHERS, 'Select your Mom.')
  addSliderItem('Resemblance', pct, 'Select if your features are influenced more by your Mother or your Father.')
  addSliderItem('Skin Tone', pct, 'Select if your skin tone is influenced more by your Mother or your Father.')

  _menu.OnListChange = function (sender, item, index)
    updateHeritageWindow(item:Text():lower(), index)
  end

  return _menu
end
