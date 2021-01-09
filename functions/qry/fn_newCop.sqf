private["_unit"];
_unit = _this select 0;
if (local _unit) then {
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeBackpack _unit;
	removeAllWeapons _unit;
	removeHeadgear _unit;
	removeVest _unit;
	
	_unit forceAddUniform "U_C_Poor_2";
	_unit addHeadgear 'H_Cap_police';
    _unit addVest 'V_TacVest_blk_POLICE';
   
    _unit addMagazines["hlc_30Rnd_9x19_B_MP5",6];
    _unit addWeapon 'hlc_smg_mp5a4';
	
    _unit addPrimaryWeaponItem 'optic_ACO_grn';
    _unit addPrimaryWeaponItem 'acc_flashlight';
    //FIX
    _unit addMagazines["16Rnd_9x21_Mag",3];
    _unit addWeapon 'hgun_Rook40_F';
    
	_unit addMagazines["SmokeShell",1];
	_unit addMagazines["Chemlight_blue",3];
	
	_unit addItem "FirstAidKit";
	_unit addItem "FirstAidKit";
	_unit addItem "FirstAidKit";
	_unit addItem "ACE_epinephrine";
	_unit addItem "ACE_epinephrine";
	_unit addWeapon "Binocular";
	_unit linkItem "ItemGPS";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemRadio";
	
	
	if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
		_unit addItem "ACRE_PRC148";
	};
	
	if (isClass(configFile >> "CfgPatches" >> "ace_hearing")) then {
		_unit setVariable ["ACE_hasEarPlugsIn", true, true];
	};
	// 148
		
};


