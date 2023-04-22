#region Setea la cámara 3D.
	var _lon = 400;
	var _xLon = +_lon*dcos(dirCamPhi)*dcos(dirCamTheta);
	var _yLon = -_lon*dsin(dirCamPhi)*dcos(dirCamTheta);
	var _zLon = -_lon*dsin(dirCamTheta);
	var _coords = matrix_transform_vertex(matrixBuildExt(0,0,0,0,dirCamTheta,dirCamPhi,1,1,1),0,0,-150);
	x = oPlayer.x-_xLon+_coords[0];
	y = oPlayer.y-_yLon+_coords[1];
	z = oPlayer.z-_zLon+_coords[2];
	camera_set_view_mat(view_camera[0],matrix_build_lookat(x,y,z,x+_xLon,y+_yLon,z+_zLon,0,0,1));
	camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(65,window_get_width()/window_get_height(),10,INFINITE*2));
	camera_apply(view_camera[0]);
#endregion