#region Setea la cámara 3D.
	x = oPlayer.x;
	y = oPlayer.y;
	z = oPlayer.z;
	var _xTo = x+dcos(dirCamPhi)*dcos(dirCamTheta);
	var _yTo = y-dsin(dirCamPhi)*dcos(dirCamTheta);
	var _zTo = z-dsin(dirCamTheta);
	camera_set_view_mat(view_camera[0],matrix_build_lookat(x,y,z,_xTo,_yTo,_zTo,0,0,1));
	camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(65,window_get_width()/window_get_height(),10,INFINITE*2));
	camera_apply(view_camera[0]);
#endregion