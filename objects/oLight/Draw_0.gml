#region Define la luz.	
	if (oControl.vertexSphere != noone)
	{
		matrix_set(matrix_world,matrixBuildExt(x,y,z, 0, 0, 0, 10, 10, 10));
		vertex_submit(oControl.vertexSphere,pr_trianglelist,oControl.txBlank);
	}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion