#region getMultCercano
	/// @func  getMultCercano(value,multiple)
	function getMultCercano(_val,_mult) {
		return floor((_val + _mult/2)/_mult)*_mult;
	}
#endregion
#region getMultCercanoOffset
	/// @func  getMultCercanoOffset(value,multiple,offset)
	function getMultCercanoOffset(_val,_mult,_off) {
		return floor((_val + _mult/2 - _off)/_mult)*_mult + _off;
	}
#endregion
#region angular
	/// @func  angular(direction)
	function angular(_dir) {
		return (_dir%360+360)%360;
	}
#endregion
#region tiendeAX
	function tiendeAX(_valor,_obj,_inc) {
		if _inc == 0 return _obj;

		if _valor < _obj _valor = min(_valor+_inc,_obj);
		else _valor = max(_valor-_inc,_obj);

		return _valor;
	}
#endregion
#region dirTiendeAX
function dirTiendeAX(_valor,_obj,_inc) {
	if _inc == 0 return _obj;

	_valor -= _inc*sign(angle_difference(_valor,_obj));
	if abs(angle_difference(_valor,_obj)) < _inc _valor = _obj;

	return angular(_valor);
}
#endregion
#region inRange
	/// @func  inRange(value,min,max)
	function inRange(_val,_min,_max) {
		return _val >= _min and _val <= _max;
	}
#endregion
#region prob
	/// @func  prob(value)
	function prob(_v) {
		return random(100) < _v;
	}
#endregion
#region inView
	/// @func  inView(x,y,rad)
	function inView(_x,_y,_rad) {
		var _dist = point_distance(oCamera.x,oCamera.y,_x,_y);
		return _dist < 10000 and (
			abs(angle_difference(oCamera.dirPhi,point_direction(oCamera.x,oCamera.y,_x,_y))) < 60 or
			_dist < 1000
		);
	}
#endregion
#region getThousandSeparators
	/// @func  getThousandSeparators(value)
	function getThousandSeparators(_value) {
		var _str = string(round(_value));
		var _ret = "", _cnt = 0;
		for (var i = string_length(_str); i > 0; --i)
		{
			_ret = string_char_at(_str,i) + (_cnt%3 == 0 ? " " : "") + _ret;
			_cnt++;
		}
		return _ret;
	}
#endregion
#region getPhiFromCoords
	/// @func  getPhiFromCoords(x1,y1,x2,y2)
	function getPhiFromCoords(_x1,_y1,_x2,_y2) {
		return point_direction(_x1,_y1,_x2,_y2);
	}
#endregion
#region getThetaFromCoords
	/// @func  getThetaFromCoords(x1,y1,z1,x2,y2,z2)
	function getThetaFromCoords(_x1,_y1,_z1,_x2,_y2,_z2) {
		return point_direction(0,_z1,point_distance(_x1,_y1,_x2,_y2),_z2);
	}
#endregion