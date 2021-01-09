
//Modified SHK_POS For Triggers instead of markers.

private ["_area","_pos","_empty"];
_area = _this select 0; // marker should be trigger
_empty = _this select 1;
_pos = [];


private ["_dst","_veh","_p"];

_veh = "";

_tArea = triggerArea _area;
_isRect = _tArea select 3;


_veh = typeOf _empty;
	
// Limited loop so the script won't get stuck
private ["_i","_exit"];
_exit = false;
_i=0;

for [{_i = 0}, {_i < 100 && !_exit}, {_i = _i + 1}] do {

	// Rectangle or Ellipse marker given?
    private ["_center","_centerX","_centerY"];
    _center  = position _area;
    _centerX = _center select 0;
    _centerY = _center select 1;
    
    // Size
    private ["_sizeX","_sizeY"];
    _sizeX = _tArea select 0;
    _sizeY = _tArea select 1;
    
    private["_dir"];
    _dir    = (_tArea select 2) * -1;
    _dir    = _dir % 360;
	if (true) then { //_isRect

        // Direction and make sure it's between 0 and 360.
        private ["_dirCos","_dirSin"];

        _dirCos = cos _dir;
        _dirSin = sin _dir;

        private ["_rndX","_rndY","_posX","_posY"];
        // Select random X and Y
        _rndX = (random (_sizeX * 2)) - _sizeX;
        _rndY = (random (_sizeY * 2)) - _sizeY;

        // If area is angled, shift X and Y
        if (_dir != 0) then {
          _posX = _centerX + (_dirCos * _rndX - _dirSin * _rndY);
          _posY = _centerY + (_dirSin * _rndX + _dirCos * _rndY);
        } else {
          _posX = _centerX + _rndX;
          _posY = _centerY + _rndY;
        };

        _pos = [_posX,_posY,0];
	} else {
        // Direction and make sure it's between 0 and 360.
        private ["_dirMrk"];
        _dirMrk = _dir;
        _dirMrk = _dirMrk % 360;

        // If B axis is longer than A, switch them and fix direction.
        if (_sizeX < _sizeY) then {
          _sizeX = _size select 1;
          _sizeY = _size select 0;
          _dirMrk = _dirMrk + 90;
        };

        // Randomly pick a direction, 
        private ["_dir","_posX","_posY","_rand","_pos"];
        _dir  = random 360;
        _rand = sqrt random 1;
        _posX = (_sizeX * (cos _dir)) * _rand;
        _posY = (_sizeY * (sin _dir)) * _rand;
        _pos  = [_posX,_posY];

        /*if (_dirMrk != 0) then {
          _pos = [_pos,_dirMrk] call SHK_pos_fnc_rotatePosition;
        };*/

        _posX = _centerX + (_pos select 0);
        _posY = _centerY + (_pos select 1);

        _pos = [_posX,_posY,0];
	};

	// Find empty position
	
	if (count _pos > 0) then {
      if !(surfaceIsWater _pos) then {
          if (count (_pos findEmptyPosition [0, 0]) > 0) then { _exit = true };
      };
      
	};

};


// Return position
_pos