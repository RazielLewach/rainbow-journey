#region Event inherited.
	event_inherited();
#endregion
#region Físicas.
	maxSpeedWaves = 0.3; // Velocidad de los tentáculos al ondear.
	dirSpeed = 0; // Dirección para senos por velocidad.
	spdDirSpeed = 0; // Velocidad para la dirspeed.
#endregion
#region Estado.
	radius = 50;
#endregion
#region Los tentáculos.
	for (var i = 0; i < 5; ++i)
	{
		var _coords = getCoordsBaseTentacle(i,radius,dirPhiLook,dirThetaLook);
		var _arrXBolas = [];
		for (var j = 0; j <= 10; ++j) array_push(_arrXBolas, x+_coords[0]-25*j);
		arrTentaculo[i] = {
			arrXBolas: _arrXBolas,
			arrYBolas: array_create(11,y+_coords[1]),
			arrZBolas: array_create(11,z+_coords[2]),
			arrHSpeed: array_create(11,0),
			arrVSpeed: array_create(11,0),
			arrDSpeed: array_create(11,0)
		}
	}
#endregion
#region Vertex buffers.
	vertexJellyfishHead = noone; // La cabeza de la medusa.
	txJellyfishSkin = sprite_get_texture(sJellyfishSkin,0); // La piel de la cabeza.
	vertexJellyfishTentacle = noone; // El tentáculo de la medusa.
	txJellyfishTentacle = sprite_get_texture(sJellyfishTentacle,0); // El tentáculo.
#endregion