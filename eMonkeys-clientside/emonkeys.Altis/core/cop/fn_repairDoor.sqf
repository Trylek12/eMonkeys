/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Re-locks the door mainly for the federal reserve structures.
*/
private["_building","_doors","_door","_cP","_cpRate","_ui","_title","_titleText"];
_building = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _building) exitWith {};
if(!(_building isKindOf "House_F")) exitWith {hint "You are not looking at a house door."};
_doors = 1;
_doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "NumberOfDoors");

_door = 0;
//Find the nearest door
for "_i" from 1 to _doors do {
	_selPos = _building selectionPosition format["Door_%1_trigger",_i];
	_worldSpace = _building modelToWorld _selPos;
		if(player distance _worldSpace < 5) exitWith {_door = _i;};
};
if(_door == 0) exitWith {hint "You are not near a door!"}; //Not near a door to be broken into.
if((_building getVariable[format["bis_disabled_Door_%1",_door],0]) == 1) exitWith {hint "This door is already locked!"};
eM_action_inUse = true;
if(currentWeapon player != "") then {
			EMonkeys_curWep_h = currentWeapon player;
			player action ["SwitchWeapon", player, player, 100];
};
closeDialog 0;
//Setup the progress bar
disableSerialization;
_title = "Repairing Door";
5 cutRsc ["EMonkeys_progress","PLAIN"];
_ui = uiNamespace getVariable "EMonkeys_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

switch (typeOf _building) do {
	case "Land_Dome_Small_F": {_cpRate = 0.008;};
	case "Land_Research_house_V1_F": {_cpRate = 0.005;};
	default {_cpRate = 0.08;}
};

while {true} do
{
			if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
				uisleep 0.8;
				player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
			};
	uisleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["EMonkeys_progress","PLAIN"];
		_ui = uiNamespace getVariable "EMonkeys_progress";
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR ((!alive player) || (player getVariable["onkill",FALSE]))) exitWith {};
	if(eM_interrupted) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";
		if(!isNil "EMonkeys_curWep_h" && {(EMonkeys_curWep_h != "")}) then {
			if(EMonkeys_curWep_h in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
				player selectWeapon EMonkeys_curWep_h;
			};
		};
if(((!alive player) || (player getVariable["onkill",FALSE]))) exitWith {eM_action_inUse = false;};
if(eM_interrupted) exitWith {eM_interrupted = false; titleText["Action cancelled","PLAIN"]; eM_action_inUse = false;};
eM_action_inUse = false;
_building animate [format["door_%1_rot",_door],0];
_building animate [format["door_%1a_move",_door],0];
_building animate [format["door_%1b_move",_door],0];
_building setVariable[format["bis_disabled_Door_%1",_door],1,true]; //Unlock the door.