#region create
	/// @func  create(x,y,object)
	function create(){
		return instance_create_depth(argument[0],argument[1],argument_count == 4 ? argument[3] : 0,argument_count == 3 ? argument[2] : argument[3]);
	}
#endregion
#region destroy
	/// @func  destroy(object)
	function destroy(_obj) {
		with(_obj) instance_destroy();
	}
#endregion
#region viewWView
	/// @func  viewWView()
	function viewWView() {
		return camera_get_view_width(view_camera[0]);
	}
#endregion
#region viewHView
	/// @func  viewHView()
	function viewHView() {
		return camera_get_view_height(view_camera[0]);
	}
#endregion
#region viewXView
	/// @func  viewXView()
	function viewXView() {
		return camera_get_view_x(view_camera[0]);
	}
#endregion
#region viewYView
	/// @func  viewYView()
	function viewYView() {
		return camera_get_view_y(view_camera[0]);
	}
#endregion
#region setShaderParameterFloat
	/// @func  setShaderParameterFloat(shader,key,value)
	function setShaderParameterFloat(_shader,_key,_value)
	{
		var _uniform = shader_get_uniform(_shader, _key);
		shader_set_uniform_f(_uniform, _value);
	}
#endregion
#region setShaderParameterVec
	/// @func  setShaderParameterVec(shader,key,value)
	function setShaderParameterVec(_shader,_key,_value)
	{
		var _uniform = shader_get_uniform(_shader, _key);
		shader_set_uniform_f_array(_uniform, _value);
	}
#endregion



























