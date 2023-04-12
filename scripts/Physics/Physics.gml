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