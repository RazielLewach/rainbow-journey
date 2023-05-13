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
	
	// Procede.
	camera_set_view_mat(view_camera[0],matrix_build_lookat(x,y,z,x+_xLon,y+_yLon,z+_zLon,0,0,1));
	camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(65,window_get_width()/window_get_height(),10,INFINITE*2));
	camera_apply(view_camera[0]);
#endregion
#region Modelo 3D de la occlusion.
	if (vertexOcclusion == noone) {
		vertexOcclusion = vertex_create_buffer();
		vertex_begin(vertexOcclusion, oControl.vertexFormat);
		
		setArrD3dOpciones(0,0,0,0,0,90,0, 400, 400, 400);
		d3dAddSphere(vertexOcclusion,0,0,0,1,0,+90,false,10,c_green,1,0.0,0.0,1.0,1.0);
		
		vertex_end(vertexOcclusion);
		vertex_freeze(vertexOcclusion);
	}
#endregion
#region Dibuja el occlusion.
	if (vertexOcclusion != noone and !key(vk_space))
	{
		/*var _vac = getNearestVacuum(oPlayer.x, oPlayer.y, oPlayer.z);
		if (_vac != noone)
		{
			var _lon = _vac.radius;
			var _phi = getPhiFromCoords(_vac.x, _vac.y, x, y);
			var _theta = getThetaFromCoords(_vac.x, _vac.y, _vac.z, x, y, z);
			
			matrix_set(matrix_world, matrixBuildExt(
				_vac.x+_lon*dcos(_phi)*dcos(_theta),
				_vac.y-_lon*dsin(_phi)*dcos(_theta),
				_vac.z-_lon*dsin(_theta),
				0, _theta, _phi, 1, 1, 1
			));
			vertex_submit(vertexOcclusion, pr_trianglelist, oControl.txBlank);
		}*/
	}
#endregion