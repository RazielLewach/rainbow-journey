#region Event inherited.
	event_inherited();
#endregion
#region Animaciones varias.
	spdDirSpeed = tiendeAX(spdDirSpeed,point_distance_3d(0,0,0,hSpeed,vSpeed,dSpeed)/2,1*isMoving);
	var _spd = spdDirSpeed;
	if (_spd == 0) _spd = brake/5;
	dirSpeed = angular(dirSpeed+_spd);
#endregion
#region Lógica de los tentáculos.
	for (var i = 0; i < array_length(arrTentaculo); ++i)
		with(arrTentaculo[i])
		{
			for (var j = 0; j < array_length(arrXBolas); ++j)
			{
				// Física de las bolas.
				if (j == 0)
				{
					// La primera bola está fija siempre. Es la referencia.
					var _coords = getCoordsBaseTentacle(i,other.radius,other.dirPhiLook,other.dirThetaLook);
					arrXBolas[0] = other.x+_coords[0];
					arrYBolas[0] = other.y+_coords[1];
					arrZBolas[0] = other.z+_coords[2];
				}
				else
				{					
					// Se ajusta al padre.
					var _dist = point_distance_3d(arrXBolas[j],arrYBolas[j],arrZBolas[j],arrXBolas[j-1],arrYBolas[j-1],arrZBolas[j-1]);
					var _maxSpd = other.maxSpeed*_dist/10;
					var _phi = getPhiFromCoords(arrXBolas[j-1],arrYBolas[j-1],arrXBolas[j],arrYBolas[j]);
					var _theta = getThetaFromCoords(arrXBolas[j-1],arrYBolas[j-1],arrZBolas[j-1],arrXBolas[j],arrYBolas[j],arrZBolas[j]);
					
					// Cerca del punto estable, se asigna.
					if (abs(_dist-SEP_NODE_TENTACLE) <= _maxSpd)
					{
						arrXBolas[j] = arrXBolas[j-1] + SEP_NODE_TENTACLE*dcos(_phi)*dcos(_theta);
						arrYBolas[j] = arrYBolas[j-1] - SEP_NODE_TENTACLE*dsin(_phi)*dcos(_theta);
						arrZBolas[j] = arrZBolas[j-1] - SEP_NODE_TENTACLE*dsin(_theta);
					}
					else
					{
						arrXBolas[j] -= _maxSpd*dcos(_phi)*dcos(_theta);
						arrYBolas[j] += _maxSpd*dsin(_phi)*dcos(_theta);
						arrZBolas[j] += _maxSpd*dsin(_theta);
					}
				}
			}
		}
#endregion