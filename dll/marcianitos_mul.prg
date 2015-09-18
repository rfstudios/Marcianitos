function marcianitos_mul()
	begin
		Punt=100;
		matados=0;
		energia_jugador=200;
		energia_jugador2=200;
		mejora=0;
		graf_laser=3;	
		mejora2=0;
		graf_laser2=3;
		gretard=5;
		vidas1=3;
		vidas2=3;

		idfich=fopen("dll/punts_mult.yawin",1);
		for(i=0;i<5;i++)
			puntuaciones[i]=fgets(idfich);
		end
		set_wav_volume(sonn[0],35);
		Put_screen(graficos,1);
		
		nav=nave_mult();
		nav2=nave_mult2();
		energia_nave_mult();
		energia_nave_mult2();
		vida_mult();
		vida_mult2();
		musica_mult();
		Start_scroll(0,graficos,1,0,0,2);
		
		write(0,67,40,1," Vuestra puntuación");
		write_var(0,51,50,1,Punt);
		write(0,60,65,1," Naves destruidas");
		write_var(0,50,75,1,Matados);
		
		conts=gretard;
		loop
			scroll[0].y0=scroll[0].y0-2;
			if(rand(1,1000)<=rand(1,15))
				conts-=1;
				if(conts<=0)
					paquete_mejora_mult(rand(0,640),rand(3,4));
					conts=gretard;
				end
			end
			if(rand(0,100)<(Punt/100))
				enemigo_mult(rand(0,640), rand(-3,3),rand(1,3));
			end
			if (key(_esc)) break; end
			frame;
			if (vidas1<=0 and vidas2<=0)
					break;
			end
		end
		let_me_alone();
		
		fclose(idfich);
		idfich=fopen("dll/punts_mult.yawin",2);
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
		write(0,220,220,1,"Vuestra puntuación");
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
	end
	
process nave_mult()
	private
		int cont=0;
	end
	begin
		//No es necesario utilizar la variable FiLE porque sólo hemos cargado un FPG
		Graph=2;
		X=470;

		//La nave está a 10 píxeles del extremo inferior de la ventana
		Y=460;
		loop
			Cont=cont-1;
			if(cont<0) cont=0; end
			if (key(_up)) y-=7; end
			if (key(_down)) y+=7; end
			if (key(_left)) x-=7; end
			if (key(_right)) x+=7; end
			if (x>627) x=627; end
			if (x<13) x=13; end
			if(y>470) y=470; end
			if(y<200) y=200; end
			if (key(_l))
				if(cont==0)
					cont=retardo-mejora;
					switch(mejora)
						case 3:
							disparo_mult(X-2, Y-2);
							disparo_mult(X+2, Y-2);
						end
						case 6:
							disparo_mult(X-4, Y-2);
							disparo_mult(X, Y-2);
							disparo_mult(X+4, Y-2);
						end
						case 8:
							disparo_mult(X-6, Y-2);
							disparo_mult(X-2, Y-2);
							disparo_mult(X+2, Y-2);
							disparo_mult(X+6, Y-2);
						end
						case 9:
							disparo_mult(X-8, Y-2);
							disparo_mult(X-4, Y-2);
							disparo_mult(X, Y-2);
							disparo_mult(X, Y-2);
							disparo_mult(X+4, Y-2);
							disparo_mult(X+8, Y-2);
						end
						default:
							disparo_mult(X, Y-2);
						end
					end
					play_wav(sonn[1],0);
				end
			end
			frame;
			if(energia_jugador<=0)
				energia_jugador=200;
				vidas1-=1;
				break;
			end
		END
		for(cont=8;cont<=32;cont++)
			Graph=cont;
			frame;
		end
		if(vidas1>0)
			nav=nave_mult();
		end
		if(vidas1<=0)
			write(0,585,30,1,"Jugador muerto");
				energia_jugador=0;
			loop
				frame;
			end
		end
	end
	
process nave_mult2()
	private
		int cont=0;
	end
	begin
		//No es necesario utilizar la variable FiLE porque sólo hemos cargado un FPG
		Graph=42;
		X=170;

		//La nave está a 10 píxeles del extremo inferior de la ventana
		Y=460;
		loop
			Cont=cont-1;
			if(cont<0) cont=0; end
			if (key(_w)) y-=7; end
			if (key(_s)) y+=7; end
			if (key(_a)) x-=7; end
			if (key(_d)) x+=7; end
			if (x>627) x=627; end
			if (x<13) x=13; end
			if(y>470) y=470; end
			if(y<200) y=200; end
			if (key(_g))
				if(cont==0)
					cont=retardo-mejora2;
					switch(mejora2)
						case 3:
							disparo_mult2(X-2, Y-2);
							disparo_mult2(X+2, Y-2);
						end
						case 6:
							disparo_mult2(X-4, Y-2);
							disparo_mult2(X, Y-2);
							disparo_mult2(X+4, Y-2);
						end
						case 8:
							disparo_mult2(X-6, Y-2);
							disparo_mult2(X-2, Y-2);
							disparo_mult2(X+2, Y-2);
							disparo_mult2(X+6, Y-2);
						end
						case 9:
							disparo_mult2(X-8, Y-2);
							disparo_mult2(X-4, Y-2);
							disparo_mult2(X, Y-2);
							disparo_mult2(X, Y-2);
							disparo_mult2(X+4, Y-2);
							disparo_mult2(X+8, Y-2);
						end
						default:
							disparo_mult2(X, Y-2);
						end
					end
					play_wav(sonn[1],0);
				end
			end
			frame;
			if(energia_jugador2<=0);
				energia_jugador2=200;
				vidas2-=1;
				break;
			end
		END
		for(cont=8;cont<=32;cont++)
			Graph=cont;
			frame;
		end
		if(vidas2>0)
			nav2=nave_mult2();
		end
		if(vidas2<=0)
			write(0,67,30,1,"Jugador muerto");
			energia_jugador2=0;
			loop
				frame;
			end
		end
	end
	
process disparo_mult (X,Y)
	begin
		Y=Y;
		X=X;
		Z=1;
		
		repeat
			Graph=graf_laser;
			y=y-15;
			frame;
		until (y < -15)
	end
	
process disparo_mult2 (X,Y)
	begin
		Y=Y;
		X=X;
		Z=1;
		
		repeat
			Graph=graf_laser2;
			y=y-15;
			frame;
		until (y < -15)
	end
	
process enemigo_mult (x,int inc_x,int inc_y)
	private
		int ID_disparo_acertado, ID_disparo_acertado2, cont;
		int energia=0,daño;
	end
	begin
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
		repeat
			X=X+inc_x;
			Y=Y+inc_y;
			ID_Disparo_acertado=collision(type disparo_mult);
			ID_Disparo_acertado2=collision(type disparo_mult2);
			if (ID_disparo_acertado !=0)
				Signal(ID_disparo_acertado,s_kill);
				Energia=energia-1;
				if (energia==0)
					Punt+=size/10;
					matados+=1;
					play_wav(sonn[0],0);
					break;
				end
			end
			if (ID_disparo_acertado2 !=0)
				Signal(ID_disparo_acertado2,s_kill);
				Energia=energia-1;
				if (energia==0)
					Punt+=size/10;
					matados+=1;
					play_wav(sonn[0],0);
					break;
				end
			end
			if(collision (type nave_mult))
				Energia_jugador=energia_jugador-daño;
				mejora=0;
				graf_laser=3;
				Punt+=size/10;
				play_wav(sonn[0],0);
				break;
			end
			if(collision (type nave_mult2))
				Energia_jugador2=energia_jugador2-daño;
				mejora2=0;
				graf_laser2=3;
				Punt+=size/10;
				play_wav(sonn[0],0);
				break;
			end
			frame;
		until (y > 520 or x < -20 or x > 670)
		for(cont=8;cont<=32;cont++)
			Graph=cont;
			frame;
		end
	end
	
process energia_nave_mult2()
	begin
		X=110;
		Y=30;
		Z=-1;
		Graph=33;
		Region=1;
		loop
			if (energia_jugador2<0)
				Energia_jugador2=0;
			end
			if (energia_jugador2>200)
				Energia_jugador2=200;
			end
			Define_region(1,10,25,energia_jugador2,10);
			frame;
		end
	end

process energia_nave_mult()
	begin
		X=525;
		Y=25;
		Z=-1;
		Graph=33;
		Region=2;
		loop
			if (energia_jugador<0)
				Energia_jugador=0;
			end
			if (energia_jugador>200)
				Energia_jugador=200;
			end
			Define_region(2,425,25,energia_jugador,10);
			frame;
		end
	end
	
process paquete_mejora_mult (x, int inc_y)
	private
		int ID_disparo_acertado, ID_disparo_acertado2, cont;
		int tipo,mejor,graf;
	end
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
		repeat
			X=X;
			Y=Y+inc_y;
			ID_Disparo_acertado=collision(type disparo_mult);
			if (ID_disparo_acertado !=0)
				Signal(ID_disparo_acertado,s_kill);
				mejora=mejor;
				graf_laser=graf;
				play_wav(sonn[3],0);
				break;
			end
			if(collision (type nave_mult))
				mejora=mejor;
				graf_laser=graf;
				play_wav(sonn[3],0);
				break;
			end
			ID_Disparo_acertado2=collision(type disparo_mult2);
			if (ID_disparo_acertado2 !=0)
				Signal(ID_disparo_acertado2,s_kill);
				mejora2=mejor;
				graf_laser2=graf;
				play_wav(sonn[3],0);
				break;
			end
			if(collision (type nave_mult2))
				mejora2=mejor;
				graf_laser2=graf;
				play_wav(sonn[3],0);
				break;
			end
			frame;
		until (y > 520)
		for(cont=8;cont<=32;cont++)
			Graph=cont;
			frame;
		end
	end
	
process musica_mult()
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
	
	PROCESS vida_mult()
		begin
			X=604;
			Y=470;
			Z=-1;
			Size=70;
			loop
				switch(vidas1)
					case 1:
						Graph=46;
					end
					case 2:
						Graph=47;
					end
					case 3:
						Graph=48;
					end
					default:
						Graph=52;
					end
				end
				frame;
			end
		end 
	
	PROCESS vida_mult2()
		begin
			X=36;
			Y=470;
			Z=-1;
			Size=70;
			loop
				switch(vidas2)
					case 1:
						Graph=49;
					end
					case 2:
						Graph=50;
					end
					case 3:
						Graph=51;
					end
					default:
						Graph=53;
					end
				end
				frame;
			end
		end 
