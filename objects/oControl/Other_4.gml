#region Crea los solids (Sala de testing).
	// Sala de testing.
	if (room == rTesting)
	{
		var _RAD = room_width/2;
		createVacuum(+0,+0,-_RAD,_RAD);
		createVacuum(+_RAD*1.5,+0,-_RAD,_RAD);
		
		createLight(-_RAD,0,-_RAD,2000);
	}
#endregion
#region Crea el vertex del escenario (General).
	if (vertexEscenarioRoca != noone) vertex_delete_buffer(vertexEscenarioRoca);
	vertexEscenarioRoca = vertex_create_buffer();
		
	vertex_begin(vertexEscenarioRoca, vertexFormat);
	
	// Todos los sólidos.
	with(oVacuum)
	{
		setArrD3dOpciones(x,y,z,0,0,0,0,radius,radius,radius);
		var _maxText = round(radius/100);
		var _cal = 10 - 10*oControl.scCalidad;
		if (_cal == 4) _cal = 5;
		else if (_cal == 7 or _cal == 8) _cal = 9;
		d3dAddSphere(oControl.vertexEscenarioRoca,0,0,0,1,-90,+90,false,_cal,c_white,1,0.0,0.0,_maxText,_maxText);
	}
		
	vertex_end(vertexEscenarioRoca);
	vertex_freeze(vertexEscenarioRoca);
#endregion