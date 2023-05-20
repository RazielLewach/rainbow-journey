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
#region canReachThisVacuum
	/// @func  canReachThisVacuum(idVacuumCurrent, idVacuumObjective, depth)
	function canReachThisVacuum(_vacCur, _vacObj, _depth) {
		// Caso base: lo hemos encontrado.
		if (_vacCur.id == _vacObj.id) return true;
		
		// Caso base: a profundidad mayor al número de vacuums nos paramos, pues nos hemos embuclado.
		if (_depth > oControl.nVacuums) return false;
		
		// Caso recursivo: llamamos a todas las conexiones.
		for (var i = 0; i < array_length(_vacCur.arrIdConnectedTo); ++i)
			if (canReachThisVacuum(_vacCur.arrIdConnectedTo[i], _vacObj, _depth+1)) return true;
		
		// Caso final: ni lo hemos encontrado, ni ninguna conexión lo encontró.
		return false;
	}
#endregion
#region setJellyfishAndTentacles
	/// @func  setJellyfishAndTentacles(idEntity, x, y, z, phi, theta, minRand, maxRand)
	function setJellyfishAndTentacles(_idEntity, _x, _y, _z, _phi, _theta, _minRand, _maxRand) {
		with(_idEntity)
		{
			x = _x;
			y = _y;
			z = _z;
			dirPhiLook = _phi;
			dirThetaLook = _theta;
			
			for (var i = 0; i < 5; ++i)
			{
				var _coords = getCoordsBaseTentacle(i,radius,dirPhiLook,dirThetaLook);
				var _phiBase = dirPhiLook+180;
				for (var j = 0; j <= 10; ++j)
				{
					var _lon = 25*j;
					var _xBase = j == 0 ? x+_coords[0] : arrTentaculo[i].arrXBolas[j-1];
					var _yBase = j == 0 ? y+_coords[1] : arrTentaculo[i].arrYBolas[j-1];
					var _zBase = j == 0 ? z+_coords[2] : arrTentaculo[i].arrZBolas[j-1];
					arrTentaculo[i].arrXBolas[j] = _xBase+_lon*dcos(_phiBase);
					arrTentaculo[i].arrYBolas[j] = _yBase-_lon*dsin(_phiBase);
					arrTentaculo[i].arrZBolas[j] = _zBase;
					arrTentaculo[i].arrHSpeed[j] = 0;
					arrTentaculo[i].arrVSpeed[j] = 0;
					arrTentaculo[i].arrDSpeed[j] = 0;
					
					_phiBase += random_range(_minRand, _maxRand);
				}
			}
		}
	}
#endregion










