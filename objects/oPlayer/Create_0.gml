#region Físicas.
	z = -1000; // Altura.
	hSpeed = 0; // Velocidad horizontal.
	vSpeed = 0; // Velocidad vertical.
	dSpeed = 0; // Velocidad profunda.
	maxSpeed = 10; // Velocidad de movimiento.
	maxSpeedWaves = 1; // Velocidad de los tentáculos al ondear.
	acceleration = 2; // Acceleración we.
	brake = 0.3; // Freno we.
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
		var _arrXBolas = [
			x+_coords[0]-000, x+_coords[0]-025, x+_coords[0]-050, x+_coords[0]-075, x+_coords[0]-100,
			x+_coords[0]-125, x+_coords[0]-150, x+_coords[0]-175, x+_coords[0]-200, x+_coords[0]-225,
			x+_coords[0]-250
		];
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
	for (var i = 0; i < array_length(arrTentaculo); ++i) vertexJellyfishTentacle[i] = noone; // El tentáculo de la medusa.
	txJellyfishTentacle = sprite_get_texture(sJellyfishTentacle,0); // El tentáculo.
#endregion