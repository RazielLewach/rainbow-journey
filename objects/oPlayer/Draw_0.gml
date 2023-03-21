#region Crea y dibuja el modelo de la cabeza de la medusa.
	if (vertexJellyfishHead == noone) {
		vertexJellyfishHead = vertex_create_buffer();
		setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		vertex_begin(vertexJellyfishHead,oControl.vertexFormat);
			d3dAddSphere(vertexJellyfishHead,0,0,0,radius,-90,+20,false,10,c_red,1,0.0,0.0,1.0,1.0);
			d3dAddSphere(vertexJellyfishHead,0,0,0,radius,-90,+20,true,10,c_white,1,0.0,0.0,1.0,1.0);
		vertex_end(vertexJellyfishHead);
		vertex_freeze(vertexJellyfishHead);
	}
	if (vertexJellyfishHead != noone) {
		/*shader_set(shJellyfishFlux);
		setShaderParameter(shJellyfishFlux,"scaling",0.8+0.5*dcos(oControl.dirAngular10));
		setShaderParameter(shJellyfishFlux,"xOrigin",x);
		setShaderParameter(shJellyfishFlux,"yOrigin",y);
		setShaderParameter(shJellyfishFlux,"zOrigin",z);*/
		var _scH = 0.8+0.2*dcos(dirSpeed);
		var _scV = 0.8+0.2*dsin(dirSpeed);
		matrix_set(matrix_world,matrixBuildExt(x,y,z,0,dirThetaLook-90,dirPhiLook,_scH,_scH,_scV));
		vertex_submit(vertexJellyfishHead,pr_trianglelist,oControl.txBlank);
		//shader_reset();
	}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion