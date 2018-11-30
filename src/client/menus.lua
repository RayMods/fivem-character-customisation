local MAIN_MENU = 166;


local _pool = NativeUI.CreatePool();
local _mainMenu = RegisterMainMenu(_pool);
local _characterMenu = RegisterCharacterMenu(_pool)

local function initCharacterCreator(action)
  local changePedModel = action == 'create'

  if (_mainMenu:Visible()) then
    _mainMenu:Visible(false)
  end

  TriggerEvent('characterCreatorPlayAnim', changePedModel)
end

local function showCharacterMenu()
  _characterMenu:Visible(true)
end


AddEventHandler('characterCreatorInit', initCharacterCreator)
AddEventHandler('characterCreatorInitialized', showCharacterMenu)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    _pool:ProcessMenus()

    if (IsControlJustPressed(0, 166)) then
      if (_characterMenu:Visible()) then
        _characterMenu:Visible(false)
      end

      _mainMenu:Visible(not _mainMenu:Visible())
    elseif (IsControlJustPressed(0, 167)) then
      -- TODO: Activate this from main menu using events and don't allow direct activation with hot key

      if (_mainMenu:Visible()) then
        _mainMenu:Visible(false)
      end

      _characterMenu:Visible(not _characterMenu:Visible())
    end
  end
end)
