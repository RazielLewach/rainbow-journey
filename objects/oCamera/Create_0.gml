#region Estado.
	depth = 10+INFINITE;
	matRotation = matrix_build(0,0,0,0,0,0,1,1,1); // La matrix que acumulará las rotaciones.
	display_mouse_set(display_get_width()/2,display_get_height()/2);
	dirCamPhi = 0; // Dirección phi de la cámara.
	dirCamTheta = 0; // Dirección theta de la cámara.
	z = 0; // Altura.
#endregion