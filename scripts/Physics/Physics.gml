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
#region createSolidMorphed
	/// @func  createSolidMorphed(x,y,z,radius,arrHoles)
	function createSolidMorphed(_x,_y,_z,_radius,_arrHoles) {
		var _sol = create(_x,_y,_z,oSolid);
		_sol.radius = _radius;
		_sol.arrHoles = _arrHoles;
	}
#endregion
#region newHole
	/// @func  newHole(lon,phi,theta,radius)
	function newHole(_lon, _phi, _theta, _radius) {
		return {
			lon:_lon,
			phi:_phi,
			theta:_theta,
			radius:_radius
		};
	}
#endregion
#region isFreeTo
	/// @func  isFreeTo(x,y,z,solid)
	function isFreeTo(_x,_y,_z,_sol) {
		return point_distance_3d(_x, _y, _z, _sol.x, _sol.y, _sol.z) > _sol.radius*1.1 + oPlayer.radius;
	}
#endregion