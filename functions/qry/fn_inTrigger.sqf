
_trigger = _this select 0;
_testPos = _this select 1;

// ASSUMES IS RECTANGLE.
// [quarry_trigger,getPos player] call qry_fnc_inTrigger

_pos = position _trigger;
//_pos = _pos call bis_fnc_position;
_posX = _pos select 0;
_posY = _pos select 1;
_area = triggerArea _trigger;
_sizeX = (_area select 0);
_sizeY = (_area select 1);
_dir = (_area select 2);

_inside = false;
//Create relative pos

_mkrCount = 1;

_txt=format["roadMkr%1",_mkrCount];
_debugMkr=createMarker [_txt,_pos];
_debugMkr setMarkerShape "ICON";
_debugMkr setMarkerType "hd_dot";
_debugMkr setMarkerColor "ColorBlue";
_mkrCount = _mkrCount + 1;


_x = (_testPos select 0) - (_pos select 0);
_y = (_testPos select 1) - (_pos select 1);

_txt=format["roadMkr%1",_mkrCount];
_debugMkr=createMarker [_txt,[_x,_y]];
_debugMkr setMarkerShape "ICON";
_debugMkr setMarkerType "hd_dot";
_debugMkr setMarkerColor "ColorBlue";
_mkrCount = _mkrCount + 1;


_newX = (_x * cos(-_dir)) + (_y * sin(-_dir));
_newY = (_x * sin(-_dir)) + (_y * cos(-_dir)); // Y <->sizeX

_txt=format["roadMkr%1",_mkrCount];
_debugMkr=createMarker [_txt,[_newX,_newY]];
_debugMkr setMarkerShape "ICON";
_debugMkr setMarkerType "hd_dot";
_debugMkr setMarkerColor "ColorRed";
_mkrCount = _mkrCount + 1;




systemChat str[_newX,_newY,_sizeX,_sizeY];
hint str[_newX,_newY,_sizeX,_sizeY,_x,_y];

if ((abs _newX) <= (_sizeX)) then {
    if ((abs _newY) <= (_sizeY)) then {
        _inside = true;
    };
};

_inside

