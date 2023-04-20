#region Crea los solids (Sala de testing).
	// Sala de testing.
	if (room == rTesting)
	{
		createSolidMorphed(0,0,0,500,[
			newHole(500, 0, 0, 300)
		]);
		
		createSolidMorphed(room_width,0,0,500,[]);
		createSolidMorphed(0,room_height,0,500,[]);
		createSolidMorphed(room_width,room_height,0,500,[]);
	}
#endregion
#region Crea el vertex del escenario (General).
	if (vertexEscenarioRoca != noone) vertex_delete_buffer(vertexEscenarioRoca);
	vertexEscenarioRoca = vertex_create_buffer();
		
	vertex_begin(vertexEscenarioRoca, vertexFormat);
		
	with(oSolid)
	{
		setArrD3dOpciones(x,y,z,0,0,0,0,radius,radius,radius);
		d3dAddSphere(oControl.vertexEscenarioRoca,0,0,0,1,-90,+90,true,10,c_white,1,0.0,0.0,1.0,1.0,arrHoles);
	}
		
	vertex_end(vertexEscenarioRoca);
	vertex_freeze(vertexEscenarioRoca);
#endregion