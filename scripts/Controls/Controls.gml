#region keyP
	function keyP(_k) {
		return keyboard_check_pressed(_k);
	}
#endregion
#region keyR
	function keyR(_k) {
		return keyboard_check_released(_k);
	}
#endregion
#region key
	function key(_k) {
		return keyboard_check(_k);
	}
#endregion
#region mouse
	function mouse(_m) {
		return mouse_check_button(_m);
	}
#endregion
#region mouseP
	function mouseP(_m) {
		return mouse_check_button_pressed(_m);
	}
#endregion
#region mouseR
	function mouseR(_m) {
		return mouse_check_button_released(_m);
	}
#endregion
#region keyMoveRight
	/// @func  keyMoveRight()
	function keyMoveRight() {
		return key(vk_right) or key(ord("D"));
	}
#endregion
#region keyMoveLeft
	/// @func  keyMoveLeft()
	function keyMoveLeft() {
		return key(vk_left) or key(ord("A"));
	}
#endregion
#region keyMoveFront
	/// @func  keyMoveFront()
	function keyMoveFront() {
		return key(vk_up) or key(ord("W"));
	}
#endregion
#region keyMoveBack
	/// @func  keyMoveBack()
	function keyMoveBack() {
		return key(vk_down) or key(ord("S"));
	}
#endregion
#region keyMoveUp
	/// @func  keyMoveUp()
	function keyMoveUp() {
		return key(vk_shift) or key(ord("E"));
	}
#endregion
#region keyMoveDown
	/// @func  keyMoveDown()
	function keyMoveDown() {
		return key(vk_control) or key(ord("Q"));
	}
#endregion




