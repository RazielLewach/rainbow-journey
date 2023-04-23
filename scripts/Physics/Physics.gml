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
#region isFreeTo
	/// @func  isFreeTo(x,y,z,solid)
	function isFreeTo(_x,_y,_z,_sol) {
		return point_distance_3d(_x, _y, _z, _sol.x, _sol.y, _sol.z) > _sol.radius*1.1 + oPlayer.radius;
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