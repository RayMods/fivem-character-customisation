
local FATHER_MAP = {
  {
    name = 'Benjamin',
    faceId = 0,
    textureId = 0,
  },
  {
    name = 'Daniel',
    faceId = 1,
    textureId = 1,
  },
  {
    name = 'Joshua',
    faceId = 2,
    textureId = 2,
  },
  {
    name = 'Noah',
    faceId = 3,
    textureId = 3,
  },
  {
    name = 'Andrew',
    faceId = 4,
    textureId = 4,
  },
  {
    name = 'Juan',
    faceId = 5,
    textureId = 5,
  },
  {
    name = 'Alex',
    faceId = 6,
    textureId = 6,
  },
  {
    name = 'Isaac',
    faceId = 7,
    textureId = 7,
  },
  {
    name = 'Evan',
    faceId = 8,
    textureId = 8,
  },
  {
    name = 'Ethan',
    faceId = 9,
    textureId = 9,
  },
  {
    name = 'Vincent',
    faceId = 10,
    textureId = 10,
  },
  {
    name = 'Angel',
    faceId = 11,
    textureId = 11,
  },
  {
    name = 'Deigo',
    faceId = 12,
    textureId = 12,
  },
  {
    name = 'Adrian',
    faceId = 13,
    textureId = 13,
  },
  {
    name = 'Gabriel',
    faceId = 14,
    textureId = 14,
  },
  {
    name = 'Michael',
    faceId = 15,
    textureId = 15,
  },
  {
    name = 'Santiago',
    faceId = 16,
    textureId = 16,
  },
  {
    name = 'Kevin',
    faceId = 17,
    textureId = 17,
  },
  {
    name = 'Louis',
    faceId = 18,
    textureId = 18,
  },
  {
    name = 'Samuel',
    faceId = 19,
    textureId = 19,
  },
  {
    name = 'Anthony',
    faceId = 20,
    textureId = 20,
  },
  {
    name = 'Claude',
    faceId = 42,
    textureId = 21,
  },
  {
    name = 'Niko',
    faceId = 43,
    textureId = 22,
  },
  {
    name = 'John',
    faceId = 44,
    textureId = 23,
  },
}

local MOTHER_MAP = {
  {
    name = 'Hannah',
    faceId = 21,
    textureId = 0,
  },
  {
    name = 'Audrey',
    faceId = 22,
    textureId = 1,
  },
  {
    name = 'Jasmine',
    faceId = 23,
    textureId = 2,
  },
  {
    name = 'Giselle',
    faceId = 24,
    textureId = 3,
  },
  {
    name = 'Amelia',
    faceId = 25,
    textureId = 4,
  },
  {
    name = 'Isabella',
    faceId = 26,
    textureId = 5,
  },
  {
    name = 'Zoe',
    faceId = 27,
    textureId = 6,
  },
  {
    name = 'Ava',
    faceId = 28,
    textureId = 7,
  },
  {
    name = 'Camila',
    faceId = 29,
    textureId = 8,
  },
  {
    name = 'Violet',
    faceId = 30,
    textureId = 9,
  },
  {
    name = 'Sophia',
    faceId = 31,
    textureId = 10,
  },
  {
    name = 'Evelyn',
    faceId = 32,
    textureId = 11,
  },
  {
    name = 'Nicole',
    faceId = 33,
    textureId = 12,
  },
  {
    name = 'Ashley',
    faceId = 34,
    textureId = 13,
  },
  {
    name = 'Grace',
    faceId = 35,
    textureId = 14,
  },
  {
    name = 'Brianna',
    faceId = 36,
    textureId = 15,
  },
  {
    name = 'Natalie',
    faceId = 37,
    textureId = 16,
  },
  {
    name = 'Olivia',
    faceId = 38,
    textureId = 17,
  },
  {
    name = 'Elizabeth',
    faceId = 39,
    textureId = 18,
  },
  {
    name = 'Charlotte',
    faceId = 40,
    textureId = 19,
  },
  {
    name = 'Emma',
    faceId = 41,
    textureId = 20,
  },
  {
    name = 'Misty',
    faceId = 42,
    textureId = 21,
  },
}

local _menu = nil
local _heritageWindow = nil
local _values = {
  dad = 1,
  mom = 1,
  faceMix = 0.5,
  skinMix = 0.5,
}


local function addParentItem(name, options, description)
  local optionNames = {}
  for i = 1, #options do
    optionNames[i] = options[i].name
  end

  local menuItem = NativeUI.CreateListItem(name, optionNames, 0, description)
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
  local father
  local mother

  _values[parent] = index;

  father = FATHER_MAP[_values.dad]
  mother = MOTHER_MAP[_values.mom]

  _heritageWindow:Index(mother.textureId, father.textureId)


  print(mother.name)
  print(father.name)

  -- TODO: Emit event and have a ped controller class update the head blend.
  SetPedHeadBlendData(
    PlayerPedId(),
    mother.faceId,
    father.faceId,
    0, -- third face id
    0, -- first skin id (mother skin tone?)
    0, -- second skin id (father skin tone?)
    0, -- third skin id
    _values.faceMix, -- shape mix (face)
    _values.skinMix, -- skin mix,
    0.0, -- third mix,
    false  -- not a parent ped
  )
end

function CreateHeritageMenu(menuPool, parentMenu)
  local pct = {}
  for i = 1, 100 do
    pct[i] = i
  end

  _menu = menuPool:AddSubMenu(parentMenu, 'Heritage', 'Select to choose your parents.')

  addHeritageWindow()
  addParentItem('Dad', FATHER_MAP, 'Select your Dad.')
  addParentItem('Mom', MOTHER_MAP, 'Select your Mom.')
  addSliderItem('Resemblance', pct, 'Select if your features are influenced more by your Mother or your Father.')
  addSliderItem('Skin Tone', pct, 'Select if your skin tone is influenced more by your Mother or your Father.')

  _menu.OnListChange = function (sender, item, index)
    updateHeritageWindow(item:Text():lower(), index)
  end

  return _menu
end
