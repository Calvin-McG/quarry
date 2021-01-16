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
	
	_unit forceAddUniform "demian2435_police_man_uniform";
	_unit addHeadgear 'H_Cap_police';
    _unit addVest 'TRYK_V_tacv1LP_BK';
    _unit addBackpack "ACE_TacticalLadder_Pack";

    _unit addMagazines["ACE_40mm_Flare_white",4];
    _unit addMagazines["1Rnd_Smoke_Grenade_shell",4];

    _unit addMagazines["hlc_30Rnd_9x19_GD_MP5",6];
    _unit addWeapon 'hlc_smg_9mmar';

    //FIX
    _unit addMagazines["rhsusf_mag_17Rnd_9x19_JHP",3];
    _unit addWeapon 'rhsusf_weap_glock17g4';
    _unit addWeaponItem ["rhsusf_weap_glock17g4", "ACE_muzzle_mzls_smg_02"];
    _unit addWeaponItem ["rhsusf_weap_glock17g4", "acc_flashlight_pistol"];

	_unit addMagazines["ACE_Chemlight_HiBlue",4];
	
	_unit addItem "FirstAidKit";
	_unit addItem "ACE_Flashlight_XL50";
	_unit addItem "FirstAidKit";
	_unit addItem "FirstAidKit";
	_unit addItem "ACE_epinephrine";
	_unit addItem "ACE_epinephrine";
	_unit addItem "ACE_EarPlugs";
	_unit addWeapon "Binocular";
	_unit linkItem "rhsusf_ANPVS_14";
	_unit linkItem "ItemGPS";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemRadio";
    _unit linkItem "ItemRadioAcreFlagged";
		
};


