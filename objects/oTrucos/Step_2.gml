#region End Step
	cntCierra = tiendeAX(cntCierra,1*(key(vk_escape)),0.02);
	if (cntCierra == 1) game_end();
	cntRestart = tiendeAX(cntRestart,1*(key(vk_backspace)),0.02);
	if (cntRestart == 1) game_restart();
	if keyP(vk_f4) window_set_fullscreen(!window_get_fullscreen());

	if key(ord("M")) room_speed = 1;
	else room_speed = 60;

	if key(vk_numpad8) ajustes++;
	else if key(vk_numpad2) ajustes--;
	if key(vk_numpad6) arreglos++;
	else if key(vk_numpad4) arreglos--;
	if key(vk_numpad3) apanyos++;
	else if key(vk_numpad1) apanyos--;
#endregion