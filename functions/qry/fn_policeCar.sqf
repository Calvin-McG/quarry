_unit = _this select 0;
_unit setVariable ["BIS_enableRandomization", false];

if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
	    _unit addItemCargoGlobal ["ACE_bodyBag", 10];  
};

_unit addItemCargoGlobal["FirstAidKit",2];

//0 = [_unit, [  ["RoadCone", 3],   ["Land_coneLight", 3],  ["RoadBarrier_light", 2] ]] execVM "R3F_LOG\USER_FUNCT\auto_load_in_vehicle.sqf";
//"RoadBarrier_long",  "RoadBarrier_long",
