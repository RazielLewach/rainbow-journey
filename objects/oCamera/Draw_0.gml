#region Setea la cámara 3D.
	var _lon = 400;
	var _xLon = +_lon*dcos(dirCamPhi)*dcos(dirCamTheta);
	var _yLon = -_lon*dsin(dirCamPhi)*dcos(dirCamTheta);
	var _zLon = -_lon*dsin(dirCamTheta);
	x = oPlayer.x-_xLon;
	y = oPlayer.y-_yLon;
	z = oPlayer.z-_zLon;
	camera_set_view_mat(view_camera[0],matrix_build_lookat(x,y,z,x+_xLon,y+_yLon,z+_zLon,0,0,1));
	camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(65,window_get_width()/window_get_height(),10,INFINITE*2));
	camera_apply(view_camera[0]);
#endregion