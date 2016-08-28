/* 
 
 Set net house inventory (impunding) 
  
 f [ house_name, player, inventory, illegalvalue] 
 
*/ 
 
private["_house","_unit","_inventory","_setarr","_illegalvalue"]; 
 
_house = _this select 0; 
_unit = _this select 1; 
_inventory = _this select 2; 
_illegalvalue = _this select 3; 
 
 
 
//GENERATE STRING from array 
_inventory_str = format["'%1'", str _inventory]; 
 
//WRITE TO DB using house name from exdata* 
//call command 
_setarr = [ ["inventory", _inventory_str] ]; //todo 
 
["EMonkeys_fnc_execHouseImpound", _house, [_illegalvalue], _unit, _setarr,"owned='1'"] call HOUSE_fnc_writeData;