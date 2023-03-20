#region create
	/// @func  create(x,y,object)
	function create(){
		return instance_create_depth(argument[0],argument[1],argument_count == 4 ? argument[3] : 0,argument[2]);
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





























