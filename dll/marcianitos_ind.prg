FUNCTION marcianitos_ind()
	BEGIN
		punt=100;
		matados=0;
		energia_jugador=200;
		mejora=0;
		graf_laser=3;
		gretard=5;
		vidas=3;

		idfich=fopen("dll\punts_ind.yawin",1);
		for(i=0;i<5;i++)
			puntuaciones[i]=fgets(idfich);
		end
		set_wav_volume(sonn[0],35);
		Put_screen(graficos,1);
		
		nav=nave_ind();
		vida_ind();
		//raton_ind();
		energia_nave_ind();
		musica_ind();
		Start_scroll(0,graficos,1,0,0,2);
		
		write(0,51,40,1," Tu puntuación");
		write_var(0,51,50,1,Punt);
		write(0,60,65,1," Naves destruidas");
		write_var(0,50,75,1,Matados);
		
		conts=gretard;
		LOOP
			scroll[0].y0=scroll[0].y0-2;
			if(rand(1,1000)<=rand(1,15))
				conts-=1;
				if(conts<=0)
					paquete_mejora_ind(rand(0,640),rand(3,4));
					conts=gretard;
				end
			end
			If(rand(0,100)<(Punt/100))
				enemigo_ind(rand(0,640), rand(-3,3),rand(1,3));
			End
			If (key(_esc)) break; end
			FRAME;
			If (vidas<=0)
					break;
			End
		END

		let_me_alone();
		
		fclose(idfich);
		idfich=fopen("dll\punts_ind.yawin",2);
		for(i=0;i<5;i++)
			if(puntuaciones[i]<Punt)
				a=i;
				for(i=4;i>a;i--)
					puntuaciones[i]=puntuaciones[i-1];
				end
				puntuaciones[a]=punt;
				i=5;
			end
		end
		for(i=0;i<5;i++)
			fputs(idfich, puntuaciones[i]);
		end
		delete_text(0);
		write(0,400,200,1,"MEJORES PUNTUACIONES");
		for(i=0;i<5;i++)
			write_var(0,400, 220+(i*10),1, puntuaciones[i]);
		end
		write(0,218,200,1,"FIN DEL JUEGO");
		write(0,220,220,1,"Tu puntuación");
		write_var(0,220,230,1,Punt);
		write(0,219,245,1,"Naves destruidas");
		write_var(0,220,255,1,Matados);
		write(0,319,285,1,"Pulsa ENTER para continuar");
		repeat
			frame;
		until(key(_enter));
		repeat
			frame;
		until(!key(_enter));
		
		menu();
	END
	
PROCESS nave_ind()
	Private
		Int cont=0;
	end
	BEGIN
		//No es necesario utilizar la variable FILE porque sólo hemos cargado un FPG
		Graph=2;
		X=320;

		//La nave está a 10 píxeles del extremo inferior de la ventana
		Y=470;
		LOOP
			Cont=cont-1;
			If(cont<0) cont=0; end
			If (key(_up)) y-=7; end
			If (key(_down)) y+=7; end
			If (key(_left)) x-=7; end
			If (key(_right)) x+=7; end
			If (x>627) x=627; end
			If (x<13) x=13; end
			If(y>470) y=470; end
			If(y<200) y=200; end
			If (key(_x) or mouse.left)
				if(cont==0)
					cont=retardo-mejora;
					switch(mejora)
						case 3:
							disparo_ind(X-2, Y-2);
							disparo_ind(X+2, Y-2);
						end
						case 6:
							disparo_ind(X-4, Y-2);
							disparo_ind(X, Y-2);
							disparo_ind(X+4, Y-2);
						end
						case 8:
							disparo_ind(X-6, Y-2);
							disparo_ind(X-2, Y-2);
							disparo_ind(X+2, Y-2);
							disparo_ind(X+6, Y-2);
						end
						case 9:
							disparo_ind(X-8, Y-2);
							disparo_ind(X-4, Y-2);
							disparo_ind(X, Y-2);
							disparo_ind(X, Y-2);
							disparo_ind(X+4, Y-2);
							disparo_ind(X+8, Y-2);
						end
						default:
							disparo_ind(X, Y-2);
						end
					end
					play_wav(sonn[1],0);
				end
			end
			Frame;
			if(energia_jugador<=0)
				energia_jugador=200;
				vidas-=1;
				break;
			end
		END
		for(cont=8;cont<=32;cont++)
			Graph=cont;
			frame;
		end
		nav=nave_ind();
	END

process disparo_ind(X,Y)
	Begin
		Y=Y;
		X=X;
		Z=1;
		
		Repeat
			Graph=graf_laser;
			y=y-15;
			frame;
		until (y < -15)
	end
	
process enemigo_ind(x,int inc_x,int inc_y)
	Private
		INT ID_disparo_acertado,cont;
		Int energia=0,daño;
	END
	Begin
		Size=rand(65,115);
		if (size>=65 and size<78)
			Graph=4;
			energia=1;
			daño=1;
		else 
			if(size>=78 and size<91)
				Graph=5;
				energia=1;
				daño=5;
			else
				if(size>=91 and size<103)
					Graph=6;
					energia=2;
					daño=10;
				else
					Graph=7;
					energia=3;
					daño=20;
				end
			end
		end
		if(inc_x==0)
			inc_x+=1;
		end
		Y=-40;
		Repeat
			X=X+inc_x;
			Y=Y+inc_y;
			ID_Disparo_acertado=collision(type disparo_ind);
			If (ID_disparo_acertado !=0)
				Signal(ID_disparo_acertado,s_kill);
				Energia=energia-1;
				If (energia==0)
					Punt+=size/10;
					matados+=1;
					play_wav(sonn[0],0);
					break;
				End
			End
			If(collision (type nave_ind))
				Energia_jugador=energia_jugador-daño;
				mejora=0;
				graf_laser=3;
				Punt+=size/10;
				play_wav(sonn[0],0);
				break;
			end
			Frame;
		Until (y > 520 or x < -20 or x > 670)
		For(cont=8;cont<=32;cont++)
			Graph=cont;
			Frame;
		End
	end
	
process energia_nave_ind()
	begin
		X=110;
		Y=30;
		Z=-1;
		Graph=33;
		Region=1;
		Loop
			If (energia_jugador<0)
				Energia_jugador=0;
			End
			If (energia_jugador>200)
				Energia_jugador=200;
			End
			Define_region(1,10,25,energia_jugador,10);
			Frame;
		End
	end
	
process paquete_mejora_ind(x, int inc_y)
	private
		INT ID_disparo_acertado,cont;
		INT tipo,mejor,graf;
	END
	begin
		Size=100;
		Y=-40;
		tipo=rand(1,4);
		switch(tipo)
			case 1:
				mejor=3;
				graf=34;
				Graph=36;
			end
			case 2:
				mejor=6;
				graf=35;
				Graph=37;
			end
			case 3:
				if(Punt>300)
					mejor=8;
					graf=39;
					Graph=38;
				else
					mejor=3;
					graf=34;
					Graph=36;
				end
			end
			case 4:
				if(Punt>500)
					mejor=9;
					graf=41;
					Graph=40;
				else
					mejor=6;
					graf=35;
					Graph=37;				
				end
			end
		end
		Repeat
			X=X;
			Y=Y+inc_y;
			ID_Disparo_acertado=collision(type disparo_ind);
			If (ID_disparo_acertado !=0)
				Signal(ID_disparo_acertado,s_kill);
				mejora=mejor;
				graf_laser=graf;
				play_wav(sonn[3],0);
				break;
			End
			if(collision (type nave_ind))
				mejora=mejor;
				graf_laser=graf;
				play_wav(sonn[3],0);
				break;
			end
			Frame;
		Until (y > 520)
		For(cont=8;cont<=32;cont++)
			Graph=cont;
			Frame;
		End
	end
	
PROCESS musica_ind()
	PRIVATE
		INT can[6];
		INT i,j=0;
	END
	BEGIN
			can[0]=load_song("sounds\1.ogg");
			can[1]=load_song("sounds\2.ogg");
			can[2]=load_song("sounds\3.ogg");
			can[3]=load_song("sounds\4.ogg");
			can[4]=load_song("sounds\5.ogg");
		for(i=0;i<=5;i++)
			if(key(_p))
				while(key(_p))
					frame;
				end
				if(j==0)
					signal(type main, s_freeze_tree);
					j=1;
				else
					signal(type main, s_wakeup);
					j=0;
				end
			end
			if(i==5)
				i=0;
			end
			if(IS_PLAYING_SONG())
				i-=1;
			else
				set_song_volume(128);
				Play_song(can[i],0);
			end
			frame;
		end
	END
	
process raton_ind()
	private	
		INT ant_x, ant_y;
	end
	begin
		ant_x=mouse.x;
		ant_y=mouse.y;
		loop
			if(ant_x!=mouse.x || ant_y!=mouse.y)
				nav.x=mouse.x;
				nav.y=mouse.y;
				ant_x=mouse.x;
				ant_y=mouse.y;
			else
				mouse.x=nav.x;
				mouse.y=nav.y;
				ant_x=mouse.x;
				ant_y=mouse.y;
			end
			frame;
		end
	end

PROCESS vida_ind()
	begin
		X=36;
		Y=470;
		Z=-1;
		Size=70;
		loop
			switch(vidas)
				case 1:
					Graph=46;
				end
				case 2:
					Graph=47;
				end
				case 3:
					Graph=48;
				end
			end
			frame;
		end
	end 

	
