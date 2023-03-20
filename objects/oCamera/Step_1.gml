#region Mueve la cámara con el ratón.
	dirCamPhi = angular(dirCamPhi-(display_mouse_get_x()-display_get_width()/2)*0.1);
	dirCamTheta = angular(dirCamTheta-(display_mouse_get_y()-display_get_height()/2)*0.1);	
	if (window_has_focus()) display_mouse_set(display_get_width()/2,display_get_height()/2);
#endregion