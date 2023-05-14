#region Setea la cámara 3D.
	// Setea a dónde apunta la cámara.
	var _lon = 400;
	var _xLon = +_lon*dcos(dirCamPhi)*dcos(dirCamTheta);
	var _yLon = -_lon*dsin(dirCamPhi)*dcos(dirCamTheta);
	var _zLon = -_lon*dsin(dirCamTheta);
	
	// Setea las coordenadas de la cámara.
	var _coords = matrix_transform_vertex(matrixBuildExt(0,0,0,0,dirCamTheta,dirCamPhi,1,1,1),0,0,-200);
	x = oPlayer.x-_xLon+_coords[0];
	y = oPlayer.y-_yLon+_coords[1];
	z = oPlayer.z-_zLon+_coords[2];
	
	// La encaja dentro de los sólidos.
	if (oControl.iProgressLoad == -1)
	{
		var _vac = getNearestVacuum(x, y, z);
		if (_vac != noone)
		{
			var _lon = point_distance_3d(_vac.x, _vac.y, _vac.z, x, y, z);
			var _sep = _vac.radius-L*1.1;
			if (_lon > _sep)
			{
				var _phi = getPhiFromCoords(_vac.x, _vac.y, x, y);
				var _theta = getThetaFromCoords(_vac.x, _vac.y, _vac.z, x, y, z);
				x = _vac.x + _sep*dcos(_phi)*dcos(_theta);
				y = _vac.y - _sep*dsin(_phi)*dcos(_theta);
				z = _vac.z - _sep*dsin(_theta);
			}
		}
	}
	
	// Procede.
	camera_set_view_mat(view_camera[0],matrix_build_lookat(x,y,z,x+_xLon,y+_yLon,z+_zLon,0,0,1));
	camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(65,window_get_width()/window_get_height(),10,INFINITE*2));
	camera_apply(view_camera[0]);
#endregion