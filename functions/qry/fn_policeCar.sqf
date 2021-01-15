_unit = _this select 0;
_unit setVariable ["BIS_enableRandomization", false];

if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
	    _unit addItemCargoGlobal ["ACE_bodyBag", 10];  
};

_unit addItemCargoGlobal["FirstAidKit",2];
