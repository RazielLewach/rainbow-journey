#region Mueve la cámara con el ratón.
	dirCamPhi = angular(dirCamPhi-(display_mouse_get_x()-display_get_width()/2)*oControl.scCameraPrecision);
	dirCamTheta -= (display_mouse_get_y()-display_get_height()/2)*oControl.scCameraPrecision;	
	if (dirCamTheta > 89) dirCamTheta = 89;
	else if (dirCamTheta < -89) dirCamTheta = -89;
	if (window_has_focus()) display_mouse_set(display_get_width()/2,display_get_height()/2);
#endregion