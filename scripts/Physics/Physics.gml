#region getCoordsBaseTentacle
	/// @func  getCoordsBaseTentacle(i,radius,phi,theta)
	function getCoordsBaseTentacle(_i,_radius,_phi,_theta) {
		var _dirPhi = _i*72-18;
		var _lon = _radius*0.5;
		return matrix_transform_vertex(
			matrixBuildExt(0,0,0,0,_theta,_phi,1,1,1),
			0,+_lon*dcos(_dirPhi),-_lon*dsin(_dirPhi)
		);
	}
#endregion
#region createLight
	/// @func  createLight(x,y,z,radius)
	function createLight(_x,_y,_z,_radius) {
		var _lig = create(_x,_y,_z,oLight);
		_lig.radius = _radius;
		return _lig;
	}
#endregion
#region addMatLight
	/// @func  addMatLight(x,y,z,radius,phi,theta,angCone)
	function addMatLight(_x,_y,_z,_radius,_phi,_theta,_angCone) {
		matLights[7*nLights + 0] = _x;
		matLights[7*nLights + 1] = _y;
		matLights[7*nLights + 2] = _z;
		matLights[7*nLights + 3] = _radius;
		matLights[7*nLights + 4] = _phi;
		matLights[7*nLights + 5] = _theta;
		matLights[7*nLights + 6] = _angCone;
		++nLights;
	}
#endregion
#region getNearestVacuum
	/// @func  getNearestVacuum(x,y,z)
	function getNearestVacuum(_x,_y,_z) {
		var _ratMin = INFINITE, _vac = noone;
		
		for (var i = 0; i < instance_number(oVacuum); ++i)
		{
			var _iVac = instance_find(oVacuum, i);
			var _rat = point_distance_3d(_x, _y, _z, _iVac.x, _iVac.y, _iVac.z)/_iVac.radius;
			if (_rat < _ratMin)
			{
				_ratMin = _rat;
				_vac = _iVac;
			}
		}
		
		return _vac;
	}
#endregion
#region adjustInsideNearestVacuum
	/// @func  adjustInsideNearestVacuum(radius)
	function adjustInsideNearestVacuum(_radius) {
		var _vac = getNearestVacuum(x, y, z);
		var _lon = _vac.radius - _radius;
		if (point_distance_3d(x, y, z, _vac.x, _vac.y, _vac.z) > _lon)
		{
			var _phi = getPhiFromCoords(_vac.x, _vac.y, x, y);
			var _theta = getThetaFromCoords(_vac.x, _vac.y, _vac.z, x, y, z, );
			x = _vac.x + _lon*dcos(_phi)*dcos(_theta);
			y = _vac.y - _lon*dsin(_phi)*dcos(_theta);
			z = _vac.z - _lon*dsin(_theta);
		}
	}
#endregion








