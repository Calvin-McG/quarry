_unit = _this select 0;
_unit setVariable ["BIS_enableRandomization", false];
//_null = _unit spawn {_this setObjectTexture [0, "\A3\soft_F\Offroad\Data\Offroad_ext_BASE01_CO.paa"];}; //"police_suv.paa"
_unit animate ["HidePolice", 0]; 
_unit animate ["HideServices", 1];  
_unit animate ["HideBackpacks", 1];  
_unit animate ["HideBumper1", 0];  
_unit animate ["HideBumper2", 0];  
_unit animate ["HideConstruction", 1];  
_unit animate ["HideDoor1", 0];   
_unit animate ["HideDoor2", 0];  
_unit animate ["HideDoor3", 0];  
_unit animate ["HideGlass2", 0];  

_unit setObjectTexture [0, "\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE02_CO.paa"]; 
_unit setObjectTexture [1, "\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE02_CO.paa"]; 

_unit addAction ["Beacons On",{(_this select 0) animate ["BeaconsStart",1]},[],50,false,true,"","_target animationPhase 'BeaconsStart' < 0.5 AND Alive(_target) AND driver _target == _this"]; 
_unit addAction ["Beacons Off",{(_this select 0) animate ["BeaconsStart",0]},[],51,false,true,"","_target animationPhase 'BeaconsStart' > 0.5 AND Alive(_target) AND driver _target == _this"];  

if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
	    _unit addItemCargoGlobal ["ACE_bodyBag", 10];  
};

_unit addItemCargoGlobal["FirstAidKit",2];

0 = [_unit, [  ["RoadCone", 3],   ["Land_coneLight", 3],  ["RoadBarrier_light", 2] ]] execVM "R3F_LOG\USER_FUNCT\auto_load_in_vehicle.sqf";
//"RoadBarrier_long",  "RoadBarrier_long", 