#region Gestiona la cámara.
	// Mira a tu love.
	if (cntSeeLove > 0)
	{
		cntSeeLove = max(cntSeeLove-1, 0);
		if (oControl.iProgressLoad > 12 and point_distance_3d(x, y, z, oLover.x, oLover.y, oLover.z) < 700) cntSeeLove = 0;
		dirCamPhi = getPhiFromCoords(x, y, oLover.x, oLover.y);
		dirCamTheta = getThetaFromCoords(x, y, z, oLover.x, oLover.y, oLover.z-100);
		if (dirCamTheta > 180) dirCamTheta -= 360;
	}
	// Mueve la cámara con el ratón.
	else
	{
		dirCamPhi = angular(dirCamPhi-(display_mouse_get_x()-display_get_width()/2)*oControl.scCameraPrecision);
		dirCamTheta -= (display_mouse_get_y()-display_get_height()/2)*oControl.scCameraPrecision;
	}
	if (dirCamTheta > 89) dirCamTheta = 89;
	else if (dirCamTheta < -89) dirCamTheta = -89;
	if (window_has_focus()) display_mouse_set(display_get_width()/2,display_get_height()/2);
#endregion