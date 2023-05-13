#region Estado.
	depth = 10+INFINITE;
	display_mouse_set(display_get_width()/2,display_get_height()/2);
	dirCamPhi = 0; // Dirección phi de la cámara.
	dirCamTheta = 0; // Dirección theta de la cámara.
	z = 0; // Altura.
#endregion
#region Vertex y textures.
	vertexOcclusion = noone; // La semiesfera de oclusión.
#endregion