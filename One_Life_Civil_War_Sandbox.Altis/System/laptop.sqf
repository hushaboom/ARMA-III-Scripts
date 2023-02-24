params ["_laptop", "_box", "_building"];

private _typeOfCar = "LandVehicle";
recover = 0;

_laptop addAction

[
	"Sell Items",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		
		if (msrFail == 2)
			
			then {hint "You joking me?  YOU ARE BANNED FROM ALL WAREHOUSE SERVICES."}
				
				else {
							
					_box = _arguments;
					_wearable = everyContainer _box;
					_guns = weaponCargo _box;
					_mags = magazineCargo _box;
					_items = itemCargo _box;
					
					_total = 0;
					
					{
						if ((_x in _mags) or (_x in _wearable) or (_x in _guns))
							
							then {}
								
								else {
									
									_total = _total + 5;
									
									};
								
						} forEach _items;
					
					{_total = _total + 15} forEach _wearable;
					
					{_total = _total + 25} forEach _guns;
					
					{_total = _total + 60} forEach _mags;
					
					clearItemCargo _box;
					clearWeaponCargo _box;
					clearMagazineCargo _box;
					clearBackpackCargo _box;
					
					cash = cash + _total;
					
					_playerMap = playerMap get (name _caller);
					_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
					_money = _money + _total;
					
					_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];

					playerMap set [(name _caller), _playerMap];

					postIt = 1;

					hint format ["Your loot was worth $%1.", _total];
				
				};
				
		// script
	},
	_box,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
	
];

_laptop addAction

[
	"Sell Vehicle",	// title
	{
		
		params ["_target", "_caller", "_actionId", "_arguments"];
		_car = nearestObject [_target, "LandVehicle"];
		_thing = (typeOf _car);
		
		if (msrFail == 2)
			
			then {hint "Get bent.  If you can't handle our cargo with care, then we don't want your crap.  Good luck surviving without money!"}
				
				else {
							
					cash = 0;
					
					if (_car in registeredCars)
					
						then {hint "You cannot sell registered vehicles here, we're not a salvage yard!"}
					
							else {
							
								_total = 0;
								_loot = 0;
								_rate = getDammage _car;
								
								_wearable = everyContainer _car;
								_guns = weaponCargo _car;
								_mags = magazineCargo _car;
								_items = itemCargo _car;
								
								{
									_total = _total + 5;
					
									} forEach _items;
								
								{_loot = _loot + (35 * lootLevel)} forEach _wearable;
								
								{_loot = _loot + (125 * lootLevel)} forEach _guns;
								
								{_loot = _loot + (40 * lootLevel)} forEach _mags;
								
								clearItemCargo _car;
								clearWeaponCargo _car;
								clearMagazineCargo _car;
								clearBackpackCargo _car;
								
								_value = getNumber (configFile >> "CfgVehicles" >> _thing >> "cost");
								_total = floor ((_value/(12/lootLevel)/(10/lootLevel)));
								
								_txtB = "";
								_dam = _total * _rate;
								
								if (_rate > 0)
									
									then {_txtB = format ["This vehicle is damaged. $%1 has been deducted for damages.", (_dam)]};
									
								_txt0 = format ["You recieved $%1 for the loot stored in %2", _loot, _thing];
								_txt1 = format ["You sold %1 for $%2.", _thing, _total];
								_txtOut = parseText format ["%4<br></br>%1<br></br>%2<br></br>Your total is %3.", _txt0, _txt1, (_loot + _total), _txtB];
								
								cash = cash + _total + _loot;
								
								hint _txtOut;
								deleteVehicle _car;
								
								_playerMap = playerMap get (name _caller);
								_playerMap params ["_tickets", "_points", "_money", "_roster", "_claims", "_kills", "_shots"];
								_money = (_money + _total + _loot) - _dam;
								
								_playerMap = [_tickets, _points, _money, _roster, _claims, _kills, _shots];

								playerMap set [(name _caller), _playerMap];

								postIt = 1;
								
							};
							
						};
						
					// script
					
	},
	_box,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"True", 	// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
	
];
