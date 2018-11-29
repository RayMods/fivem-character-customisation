local MAIN_MENU = 166;


local _pool = NativeUI.CreatePool();
local _mainMenu = RegisterMainMenu(_pool);


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    _pool:ProcessMenus()

    if (IsControlJustPressed(0, 166)) then
      _mainMenu:Visible(not _mainMenu:Visible())
    end
  end
end)
