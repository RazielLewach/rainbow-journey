#region Físicas.
	z = -1000; // Altura.
	hSpeed = 0; // Velocidad horizontal.
	vSpeed = 0; // Velocidad vertical.
	dSpeed = 0; // Velocidad profunda.
	maxSpeed = 100; // Velocidad de movimiento.
	acceleration = 2; // Acceleración we.
	brake = 1; // Freno we.
	dirPhiLook = 0; // Dirección phi a la que miras.
	dirThetaLook = 90; // Dirección theta a la que miras.
	dirSpeed = 0; // Dirección para senos por velocidad.
	spdDirSpeed = 0; // Velocidad para la dirspeed.
#endregion
#region Los tentáculos.
	for (var i = 0; i < 5; ++i)
	{
		arrTentaculo[i] = {
			arrDirPhi: array_create(10,0),
			arrOffsetPhi: array_create(10,0),
			arrOffsetPhiDraw: array_create(10,0),
			arrDirTheta: array_create(10,0),
			arrOffsetTheta: array_create(10,0),
			arrOffsetThetaDraw: array_create(10,0)
		}
	}
#endregion
#region Estado.
	radius = 50; // Radio de la medusa.
#endregion
#region Vertex buffers.
	vertexJellyfishHead = noone; // La cabeza de la medusa.
	txJellyfishSkin = sprite_get_texture(sJellyfishSkin,0); // La piel de la cabeza.
	vertexJellyfishTentacle = noone; // El tentáculo de la medusa.
	txJellyfishTentacle = sprite_get_texture(sJellyfishTentacle,0); // El tentáculo.
#endregion