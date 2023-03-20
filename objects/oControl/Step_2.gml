#region Gestiona el estado.
	// General.
	dirAngular0001 = angular(dirAngular0001+0.01);
	dirAngular0002 = angular(dirAngular0002+0.02);
	dirAngular0003 = angular(dirAngular0003+0.03);
	dirAngular0004 = angular(dirAngular0004+0.04);
	dirAngular0005 = angular(dirAngular0005+0.05);
	dirAngular001 = angular(dirAngular001+0.1);
	dirAngular002 = angular(dirAngular002+0.2);
	dirAngular003 = angular(dirAngular003+0.3);
	dirAngular005 = angular(dirAngular005+0.5);
	dirAngular007 = angular(dirAngular007+0.7);
	dirAngular01 = angular(dirAngular01+01);
	dirAngular02 = angular(dirAngular02+02);
	dirAngular03 = angular(dirAngular03+03);
	dirAngular05 = angular(dirAngular05+05);
	dirAngular10 = angular(dirAngular10+10);
	dirAngular12 = angular(dirAngular12+12);
	nStep++;
	if (nStep >= 600*FPS) nStep = 0;
#endregion