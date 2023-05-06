#region Físicas.
	z = -1000; // Altura.
	hSpeed = 0; // Velocidad horizontal.
	vSpeed = 0; // Velocidad vertical.
	dSpeed = 0; // Velocidad profunda.
	maxSpeed = 3; // Velocidad de movimiento.
	maxSpeedWaves = 0.3; // Velocidad de los tentáculos al ondear.
	acceleration = 1; // Acceleración we.
	brake = 0.1; // Freno we.
	dirPhiLook = 0; // Dirección phi a la que miras.
	dirThetaLook = 0; // Dirección theta a la que miras.
	dirSpeed = 0; // Dirección para senos por velocidad.
	spdDirSpeed = 0; // Velocidad para la dirspeed.
	ratLight = 0; // Ratio de oscuridad.
	dirPhiMoving = 0; // Dirección phi a la que te mueves.
	dirThetaMoving = 0; // Dirección theta a la que te mueves.
#endregion
#region Estado.
	radius = 50; // Radio de la medusa.
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