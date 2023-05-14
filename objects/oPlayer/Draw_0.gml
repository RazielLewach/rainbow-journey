#region Desplazamiento adicional para no atravesar muros.
	// Atrae hacia el vacuum.
	if (!isInDungeon)
	{
		xDraw = 0;
		yDraw = 0;
		zDraw = 0;
	}
	else
	{
		var _vac = getNearestVacuum(x, y, z);
		var _phi = getPhiFromCoords(x, y, _vac.x, _vac.y);
		var _theta = getThetaFromCoords(x, y, z, _vac.x, _vac.y, _vac.z);
		var _lon = radius*2*point_distance_3d(x, y, z, _vac.x, _vac.y, _vac.z)/_vac.radius;
		var _spd = maxSpeed*0.2;
		xDraw = tiendeAX(xDraw, +_lon*dcos(_phi)*dcos(_theta), _spd*abs(dcos(_phi)*dcos(_theta)));
		yDraw = tiendeAX(yDraw, -_lon*dsin(_phi)*dcos(_theta), _spd*abs(dsin(_phi)*dcos(_theta)));
		zDraw = tiendeAX(zDraw, -_lon*dsin(_theta), _spd*abs(dsin(_theta)));
	}
#endregion
#region Crea el modelo de la cabeza de la medusa.
	if (vertexJellyfishHead == noone and oControl.canCreateVertex)
	{
		oControl.canCreateVertex = false;
		vertexJellyfishHead = vertex_create_buffer();
		vertex_begin(vertexJellyfishHead,oControl.vertexFormat);
			// El núcleo.
			var _r = radius, _v = vertexJellyfishHead, _c = oControl.colorFinalEssence;
			setArrD3dOpciones(0,0,0,0,0,180,0,1,1,1);
			d3dAddSphere(_v,0,0,0,_r*0.6,-90,+90,true,9,oControl.colorFinalEssence,1,0.0,0.0,0.01,0.01);
			
			// La cáscara.
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
			d3dAddSphere(_v,0,0,0,_r*1.0,-90,+0,false,18,c_gray,1,0.0,0.0,5.0,1.0);
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
			d3dAddSphere(_v,0,0,0,_r*1.0,-90,+0,true,18,_c,1,0.0,0.0,5.0,1.0);
			
			// Los 5 brazos exteriores.
			for (var i = 0; i < 360; i += 360/5)
			{
				var _dir = i+180;
				var _x = +_r*1.00*dcos(_dir);
				var _y = -_r*1.00*dsin(_dir);
				
				setArrD3dOpciones(_x,_y,0,0,0,0,_dir+90,1,1,1);
				
				// TRIANGULITO TAPAR AGUJERO
				// Left top
				d3dAddTrioVertex(_v,_c,1,
					-_r*0.60,-_r*0.200,+_r*0.00,0.00,0.50, +0,+1,+0,
					-_r*0.30,-_r*0.043,-_r*0.00,0.25,0.50, +0,+1,+0,
					+_r*0.00,-_r*0.000,+_r*0.00,0.50,0.50, +0,+1,+0
				);
				// Right top.
				d3dAddTrioVertex(_v,_c,1,
					+_r*0.30,-_r*0.043,-_r*0.00,0.75,0.50, +0,+1,+0,
					+_r*0.60,-_r*0.200,+_r*0.00,1.00,0.50, +0,+1,+0,
					+_r*0.00,-_r*0.000,+_r*0.00,0.50,0.50, +0,+1,+0
				);
				
				// FRONT
				// Left top
				d3dAddQuadraVertex(_v, _c, 1,
					-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -1,+3,+0,
					-_r*0.60,-_r*0.20,+_r*0.00,0.00,0.50, -1,+3,+0,
					+_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, +0,+1,+0,
					+_r*0.00,+_r*0.00,+_r*0.00,0.50,0.50, +0,+3,-1
				);
				// Right top
				d3dAddQuadraVertex(_v, _c, 1,
					-_r*0.00,+_r*0.00,+_r*0.00,0.50,0.50, +1,+3,+0,
					+_r*0.60,-_r*0.20,+_r*0.00,1.00,0.50, +1,+3,+0,
					-_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, +0,+1,+0,
					+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +0,+3,-1
				);
				// Left bot
				d3dAddQuadraVertex(_v, _c, 1,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,+3,+1,
					-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -1,+3,+0,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,+3,+1,
					+_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, +0,+1,+0
				);
				// Right bot
				d3dAddQuadraVertex(_v, _c, 1,
					-_r*0.00,+_r*0.05,+_r*0.60,0.50,0.75, -0,+3,+1,
					+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +1,+3,+0,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,+3,+1,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,+1,+0
				);
				
				// BACK
				// Right top
				d3dAddQuadraVertex(_v, c_gray, 1,
					+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +1,-3,+0,
					+_r*0.60,-_r*0.20,+_r*0.00,1.00,0.50, +1,-3,+0,
					+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, +0,-1,+0,
					+_r*0.00,-_r*0.10,+_r*0.00,0.50,0.50, +0,-3,-1
				);
				// Left top
				d3dAddQuadraVertex(_v, c_gray, 1,
					+_r*0.00,-_r*0.10,+_r*0.00,0.50,0.50, -1,-3,+0,
					-_r*0.60,-_r*0.20,+_r*0.00,0.00,0.50, -1,-3,+0,
					+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, -0,-1,+0,
					-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -0,-3,-1
				);
				// Right bot
				d3dAddQuadraVertex(_v, c_gray, 1,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,-3,+1,
					+_r*0.36,-_r*0.20,+_r*0.60,0.80,0.75, +1,-3,+0,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, +0,-3,+1,
					-_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, +0,-1,+0
				);
				// Left bot
				d3dAddQuadraVertex(_v, c_gray, 1,
					+_r*0.00,-_r*0.30,+_r*0.60,0.50,0.75, -0,-3,+1,
					-_r*0.36,-_r*0.20,+_r*0.60,0.20,0.75, -1,-3,+0,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,-3,+1,
					-_r*0.00,+_r*0.00,+_r*1.20,0.50,1.00, -0,-1,+0
				);
			}
			
			setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		vertex_end(vertexJellyfishHead);
		vertex_freeze(vertexJellyfishHead);
	}
#endregion
#region Dibuja el modelo de la cabeza de la medusa.
	var _scH = 1.0+0.2*dcos(dirSpeed);
	var _scV = 1.0+0.4*dsin(dirSpeed);
	if (vertexJellyfishHead != noone) {
		shader_set(shJellyfishHead);
		setShaderParameterVec(shJellyfishHead,"uMatLight",oControl.matLights);
		setShaderParameterInt(shJellyfishHead,"uNLights",oControl.nLights);
		setShaderParameterVec(shJellyfishHead,"uOrigin",[x+xDraw, y+yDraw, z+zDraw]);
		setShaderParameterFloat(shJellyfishHead,"uDirSpeed",dirSpeed);
		setShaderParameterFloat(shJellyfishHead,"uRatLight",ratLight);
		setShaderParameterFloat(shJellyfishHead,"uDirWaterWave",oControl.dirWaterWave);
		
		matrix_set(matrix_world,matrixBuildExt(x+xDraw,y+yDraw,z+zDraw,0,dirThetaLook-90,dirPhiLook,_scH,_scH,_scV));
		vertex_submit(vertexJellyfishHead,pr_trianglelist,txJellyfishSkin);
		
		shader_reset();
	}
#endregion
#region Crea los modelos de los tentáculos de la medusa.
	if (vertexJellyfishTentacle == noone and oControl.canCreateVertex)
	{
		oControl.canCreateVertex = false;
		vertexJellyfishTentacle = vertex_create_buffer();
		vertex_begin(vertexJellyfishTentacle,oControl.vertexFormat);
		
		var _r = radius, _v = vertexJellyfishTentacle, _c = oControl.colorFinalEssence;
		
		// El palo.
		for (var i = 0; i < 10; ++i)
		{
			var _alpha = i/10;
			setArrD3dOpciones(i*25,0,0,0,0,0,0,1,1.0,1.0);
			d3dAddPipe(_v,0,0,0,5,5,25,true,false,45,_c,_alpha,_alpha,0.0,0.0,0.5,1.0);
			d3dAddSphere(_v,0,0,0,5.0,-90,+90,true,45,_c,_alpha,0.0,0.0,0.5,1.0);
		}
		
		setArrD3dOpciones(250,0,0,0,0,0,0,1,1,1.0);
		d3dAddSphere(_v,0,0,0,5.0,-90,+90,true,45,_c,0.9,0.0,0.0,0.5,1.0);
		
		vertex_end(vertexJellyfishTentacle);
		vertex_freeze(vertexJellyfishTentacle);
	}
#endregion
#region Dibuja los modelos de los tentáculos de la medusa.
	for (var i = 0; i < array_length(arrTentaculo); ++i)
		if (vertexJellyfishTentacle != noone) {
			with(arrTentaculo[i])
			{
				shader_set(shJellyfishTentacle);
				setShaderParameterVec(shJellyfishTentacle,"uMatLight",oControl.matLights);
				setShaderParameterInt(shJellyfishTentacle,"uNLights",oControl.nLights);
				setShaderParameterFloat(shJellyfishTentacle,"uRatLight",other.ratLight);
				setShaderParameterVec(shJellyfishTentacle,"uArrXBolas",arrXBolas);
				setShaderParameterVec(shJellyfishTentacle,"uArrYBolas",arrYBolas);
				setShaderParameterVec(shJellyfishTentacle,"uArrZBolas",arrZBolas);
				setShaderParameterVec(shJellyfishTentacle,"uExtraOrigin",[other.xDraw, other.yDraw, other.zDraw]);
				setShaderParameterFloat(shJellyfishTentacle,"uDirWaterWave",oControl.dirWaterWave);
				
				matrix_set(matrix_world,matrixBuildExt(
					arrXBolas[0]+oPlayer.xDraw,
					arrYBolas[0]+oPlayer.yDraw,
					arrZBolas[0]+oPlayer.zDraw,
				0, 0, 0, 1,1,1));
				vertex_submit(other.vertexJellyfishTentacle,pr_trianglelist,other.txJellyfishTentacle);
				
				shader_reset();
			}
		}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion