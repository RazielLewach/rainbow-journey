#region Estado.
	radius = image_xscale*sprite_get_width(sprite_index)/2;
	z = image_angle;
	image_angle = 0;
	arrIdConnectedTo = []; // En caso de no ser túnel, a qué otro vacuums (id) está conectado.
	arrConnectionProcessed = []; // Indica qué conexiones ya han sido procesadas en modelo.
#endregion