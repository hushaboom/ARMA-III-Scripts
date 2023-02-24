_guy = _this select 0;
_car = _this select 1;

private ["_callPos"];

private _myCar = (vehicle _guy);

if ((isNil "_car"))
	
	then {
		
		private _car = serv;
		
		};

if ((isNil "_myCar") or (_myCar distance _guy > 50) or (vehicle _guy) == _guy)
	
	then {
		
		private _myCar = nearestObject [_guy, "LandVehicle"];
		
		if (_myCar distance _guy > 50)
			
			exitWith {
				
				hint "Dude, where's your car?";
				
				};
		
		}
			
			else {
				
				hint format ["%1", _myCar];
				
				};

_garage = nearestObjects [_guy, ["Land_CarService_F"], 2000];
_roads = (_garage select 0) nearRoads 250;

_roads = [_roads, [], { (_garage select 0) distance _x }, "ASCEND"] call BIS_fnc_sortBy;
_road = (_roads select 0);

private _info = getRoadInfo _road;
_info params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];
		
_dirP = [[_begPos, _endPos], [], { (_garage select 0) distance _x }, "ASCEND"] call BIS_fnc_sortBy;

if (damage _car > 0.5)
	
	then {
		
		private _carB = (typeOf _car) createVehicle ((_dirP select 0) vectorAdd [0,-(_width/2),0]);
		_car = _carB;
		
		}
		
		else {
		
			_car allowDamage false;
			_car setPosATL ((_dirP select 0) vectorAdd [0,-(_width/2),0]);
			
			};

_pg = createGroup civilian;

_car setDir (_car getDir _guy);
_driver = _pg createUnit ["I_G_engineer_F", [[0,0,1000], 3, 5, 1, 0, 3, 0, [], []] call BIS_fnc_findSafePos, [], 1, "FORM"];
_driver allowDamage false;
_driver assignAsDriver _car;
_driver moveInDriver _car;

_roads = _guy nearRoads 500;

_roads = [_roads, [], { _guy distance _x }, "ASCEND"] call BIS_fnc_sortBy;
_road = (_roads select 0);

private _info2 = getRoadInfo _road;
_info2 params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];

_wp = _pg addWaypoint [_begPos, 1];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";

_wp = _pg addWaypoint [(getPos _guy), 5];
_wp setWaypointType "MOVE";

waitUntil {_car distance _guy < 25};

_wp = _pg addWaypoint [(getPos _myCar), 1];
_wp setWaypointType "MOVE";

waitUntil {_car distance _myCar < 10};

sleep 1.6;
_myCar allowDamage false;
_myCar setFuel 0;
_myCar setVectorUp surfaceNormal position _myCar;

sleep 1.6;
_myCar setDamage 0;
_myCar setFuel 1;
_myCar allowDamage true;

sleep 0.4;

hint "Your vehicle has been repaired.";

_wp = _pg addWaypoint [_begPos, 1];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";

waitUntil {_car distance _begPos < 5};

{deleteVehicle _x} forEach [_car, (driver _car)];