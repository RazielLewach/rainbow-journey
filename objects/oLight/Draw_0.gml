#region Define la luz.	
	if (oControl.vertexSphere != noone)
	{
		matrix_set(matrix_world,matrixBuildExt(x,y,z, 0, 0, 0, 50,50,50));
		vertex_submit(oControl.vertexSphere,pr_trianglelist,oControl.txBlank);
	}
#endregion