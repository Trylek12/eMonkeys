//Function zum l�schen aus dem 2 Dim Array mit unterschiedlichen Geararten
//Parameter [das 2 Dim Array mit dem Gear,Array mit zu l�schendem Gear]
//WICHTIG  Die Arrays sollten alle nur ein und den selben Datentyp enthalten (z.B String)
private ["_helper","_gear_Array","_delete"];
_gear_array = _this select 0;
_delete =_this select 1;
//Herausl�schen der �bergebenen Arrays. Geht nicht mit "-" Operator, da Duplikate gleich mit entfernt werden
{
	for [{_y = 0},{_y < count _gear_array},{_y = _y+1}] do {
		if (_gear_array select _y == _x) exitWith {_gear_array set [_y,"deleteThis"]};
	};
} foreach _delete;
_gear_array = _gear_array - ["deleteThis"];
//L�schen beendet
_gear_array;