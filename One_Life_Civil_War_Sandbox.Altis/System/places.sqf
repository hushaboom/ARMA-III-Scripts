
_loCount = 0;

_industrial = nearestLocations [xPos,["NameLocal"],27000];
_city = nearestLocations [xPos,["NameCity"],27500];
_capital = nearestLocations [xPos,["NameCityCapital"],27500];
_towns = nearestLocations [xPos,["NameVillage"],27000];

{

	_size = size _x;
	_name = text _x;
	_pos = getPos _x;
	_rad = sqrt(((_size select 0)^2) + (_size select 1)^2)/2;
	_color = "colorRed";
	
	_mr = createMarker [_name,(getPos _x)];
	_mr setMarkerShape "ELLIPSE";
	_mr setMarkerSize [_rad + 150, _rad + 150];
	_mr setMarkerAlpha 0.5;
	
	if (_name == "Pyrgos") then 
		
		{
			_color = "colorBlue";
			_mr setMarkerSize [_rad + 75, _rad + 75];
			
			};
	
	if (_name == "Athira") then 
		
		{
			_color = "colorGreen";
			_mr setMarkerSize [_rad, _rad];
			
			};
	
	_mr setMarkerColor _color;
	markerHold = markerHold + [_mr];
	cityHold = cityHold + [_mr];

	} forEach (_capital);
	
{
	_markerstr = format ["C%1",_loCount];
	
	if (isNil "_x") then 
		
		{} else {
			
			_size = size _x;
			_name = text _x;
			_pos = getPos _x;
			_rad = sqrt(((_size select 0)^2) + (_size select 1)^2)/2;
			
			_mr = createMarker [_name,(getPos _x)];
			_mr setMarkerShape "ELLIPSE";
			_mr setMarkerColor "colorWhite";
			_mr setMarkerSize [_rad, _rad];
			_mr setMarkerAlpha 0;
			
			markerHold = markerHold + [_mr];
			cityHold = cityHold + [_mr];
			
			_loCount = _loCount + 1;
					
		};
	
	} forEach (_city);

_loCount = 0;

{
	_markerstr = format ["T%1",_loCount];
	
	if (isNil "_x") then 
		
		{} else {
			
			_size = size _x;
			_name = text _x;
			_pos = getPos _x;
			_rad = sqrt(((_size select 0)^2) + (_size select 1)^2)/2;
			
			_mr = createMarker [_name,(getPos _x)];
			_mr setMarkerShape "ELLIPSE";
			_mr setMarkerColor "colorOrange";
			_mr setMarkerSize [_rad, _rad];
			_mr setMarkerAlpha 0;
			
			if (
				
				_name == "Selakano"
				
				) then {
					
					deleteMarker _mr;
					_name = format ["Rose%1", RoseOpperators];
					_mr = createMarker [_name,(getPos _x)];
					_mr setMarkerColor "colorBlack";
					_mr setMarkerAlpha 0.5;
					_mr setMarkerSize [_rad + 75, _rad + 75];
					RoseLand = RoseLand + [_mr];
					
					};
			
			markerHold = markerHold + [_mr];
			townHold = townHold + [_mr];
			
			_loCount = _loCount + 1;
					
		};
	
	} forEach (_towns);
	
vx = 10;

_loCount = 0;

{
	_markerstr = format ["I%1",_loCount];
	
	if (isNil "_x") then 
		
		{} else {
			
			_size = size _x;
			_name = text _x;
			_pos = getPos _x;
			_rad = sqrt(((_size select 0)^2) + (_size select 1)^2);
			
			_mr = createMarker [_name,(getPos _x)];
			_mr setMarkerShape "ELLIPSE";
			_mr setMarkerColor "colorYellow";
			_mr setMarkerSize [_rad, _rad];
			_mr setMarkerAlpha 0;
			
			markerHold = markerHold + [_mr];
			comHold = comHold + [_mr];
			_loCount = _loCount + 1;
					
		};
	
	} forEach (_industrial);
	

