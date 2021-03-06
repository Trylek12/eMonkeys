/*

	Checks player perms for non existing perms and sends request to DYNPERMS if a non exitsting perm is found

*/

disableSerialization;
private["_checkout","_knownpermids","_force"];

_force = [_this, 0, false] call BIS_fnc_param;

_checkout = false;

//Check for checkout
_knownpermids = [];

{
	_knownpermids set [count _knownpermids, _x select 0];
}
foreach ([] call EMonkeys_fnc_perms);

{
	if(!( (_x select 0) in _knownpermids)) exitWith
	{
		_checkout = true;
	};
}
foreach (player getVariable "perms");

//Request if non-existing was found 
if((_force || _checkout) && !EMonkeys_dynperm_checkout_running) then
{
	systemChat ">PERMS< Unknown perms found ... looking for DYNPERMS";
	[ [player] , "EMonkeys_fnc_dynPermQuery" ,false, false] call EMonkeys_fnc_MP;
	
	EMonkeys_dynperm_checkout_running = true;
	
	//Close existing grp manager dialog 
	if (!isNull (findDisplay 29650)) exitWith
	{
		closeDialog 0;
		hint "Dialog geschlossen, da Perms geladen werden.";
	};
};