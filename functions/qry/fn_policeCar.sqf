_unit = _this select 0;
_unit setVariable ["BIS_enableRandomization", false];
clearItemCargoGlobal _unit;
_unit addItemCargoGlobal ["ACE_bodyBag", 10];
_unit addItemCargoGlobal["ACE_fieldDressing",8];
_unit addItemCargoGlobal["ACE_elasticBandage",8];
_unit addItemCargoGlobal["ACE_quikclot",8];
_unit addItemCargoGlobal["ACE_epinephrine",8];
_unit addItemCargoGlobal["ACE_morphine",8];
_unit addItemCargoGlobal["ACE_packingBandage",8];
_unit addItemCargoGlobal["ACE_personalAidKit",8];
_unit addItemCargoGlobal["ACE_tourniquet",8];
_unit addItemCargoGlobal["ACE_bloodIV",2];
