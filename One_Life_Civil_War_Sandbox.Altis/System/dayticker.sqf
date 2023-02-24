if (!isServer) exitWith{};

params ["_day"];

_dtxt = format ["Day %1", _day];

_sun = date call BIS_fnc_sunriseSunsetTime;
_time = _sun select 0;

//waitUntil {dayTime toFixed 2 >= _time toFixed 2};
[ _dtxt, format ["%1/%2/%3", date select 0,date select 1,date select 2]] spawn BIS_fnc_infoText;

sleep 0.1;

setTimeMultiplier 7.5;

