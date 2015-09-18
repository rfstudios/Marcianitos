function marcianitos_arc()
	begin
		procc=0;
		anim=0;
		bos=0;
		nav=0;
		rdis=0;
		muerto=0;
		ret=7;
		punt=0;
		matados=0;
		lvl=1;
		puntf=0;
		matadosf=0;
		bossmuerto=0;
		energia_jugador=200;
		mejora=3;
		vidas=3;
		enermax=0;	
		godmode=false;
		powermode=false;
		salir=0;

		tmpespc=0;
		vidaboss=10000;
		mejoras=1;
		rets=7;
		punts=0;

		control();
		
		fuente=load_fnt("dll\fuente1.fnt");
		fuente2=load_fnt("dll\fuente2.fnt");
		set_wav_volume(sonn[0],35);
		
		pantalla_sel();
		repeat
			frame;
		until(nav!=0);
		
		inicio();
		repeat
			frame;
		until(key(_enter));
		while(key(_enter))
			frame;
		end
		repeat
			frame;
		until(key(_enter));
		while(key(_enter))
			frame;
		end
		repeat
			frame;
		until(key(_enter));
		while(key(_enter))
			frame;
		end

		musica_arc();
		if(nav!=0)			
			for(lvl=1; lvl<5 or salir!=1; lvl++)
				
				//Guardamos la puntuación total y reseteamos la puntuación de nivel
					punt=0;
					matados=0;
				////////////////////////////////////////////////////////////////////
				
				panlev(lvl);
				
				while(!key(_enter) && salir!=1)
					frame;
				end
				bossmuerto=0;
				
				write(0,51,40,1," Tu puntuación");
				write_var(0,51,50,1,punt);
				write(0,60,65,1," Naves destruidas");
				write_var(0,50,75,1,matados);
				
				//Llamamos al nivel
					plvl=entreboss(lvl);
				////////////////////
				
				repeat
					frame;
				until(bossmuerto==1 or salir==1)
				plvl=clear(lvl);
				while(exists(type clear) && salir!=1)
					frame;
				end
				while(key(_enter))
					frame;
				end
				delete_text(0);
				
				if(lvl==2 and salir !=1)
					/// Animación ///
					anim=1;
					anim1();
					repeat
						frame;
					until(anim==0);
					/// Fin animación ///
				end
				if(lvl==4 and salir!=1)
					lvl=5;
					panlev(lvl);
				
					while(!key(_enter) && salir!=1)
						frame;
					end
					bossmuerto=0;
					
					Put_screen(graficos,0);
					Main2(vidas, energia_jugador+enermax,nav,puntf,matadosf);
					repeat
						frame;
					until(salir==1);			
				end
			end
		end
		let_me_alone();
	end 

process reloj(int boss) //Este proceso calcula el tiempo que se lleva jugando un nivel.
		private
			int i;
		end
		begin
			tmp=0;
			bss=0;
			segs=0;
			loop
				for(i=0; i<60; i++)
					frame;
				end
				switch(boss)
					case 0: //Mide el tiempo de un level
						tmp++;
						segs++;
					end
					case 1: //Mide el tiempo de un boss
						bss++;
						segs++;
					end					
				end
			end
		end
		
process Entreboss(int nivel)
	private
		int modi,pv;
	end
	begin
		preloj=reloj(0);
		switch(nivel)
			case 1:
				//Nivel 1 //////////////////////////////////////////////////////////////////////////////////////////////////
				modi=100;
				pnav=nave();
				energia_nave();
				vida();
				Start_scroll(0,graficos,1,0,0,2);
				conts=retard;
				repeat
					modi=punt+100;
					if(tmp<100)
						scroll[0].y0=scroll[0].y0-2;
					
						//Llamamos a paquete de mejora
							if(rand(1,1000)<=rand(1,15))
								conts--;
								if(conts<=0)
									paquete_mejora(rand(0,640),rand(3,4));
									conts=retard;
								end
							end
						/////////////////////////////////////////////////////////////
							
						//Llamamos a enemigos////////////////////////////////////////
							if(rand(0,100)<(modi/100))
								enemigo(rand(0,640), rand(-3,3),rand(1,3));
							end	
						/////////////////////////////////////////////////////////////
					
						frame;
					else
						//Paramos el tiempo
							signal(preloj,s_kill);
							
						//Llamar al boss
							boss(1);
							repeat
								frame;
							until(bossmuerto==1);
					end
				until(bossmuerto==1);
				signal(pnav, s_kill);
				//Fin del nivel 1 //////////////////////////////////////////////////////////////////////////////////////////
			end
			case 2:
				//Nivel 2 //////////////////////////////////////////////////////////////////////////////////////////////////
				modi=4000;
				curar();
				pnav=nave();
				Start_scroll(0,graficos,63,0,0,2);
				conts=retard;
				loop
					modi=punt+4000;
					if(tmp<110)
						scroll[0].y0=scroll[0].y0-4;
					
						//Llamamos a enemigos////////////////////////////////////////
						if(punt<modi)	
							if(rand(0,1000)<(modi/100))
								enemigo(rand(0,640), rand(-3,3),rand(1,3));
							end
						else	
							if(rand(0,punt+1000)<(punt/100))
								enemigo(rand(0,640), rand(-3,3),rand(1,3));
							end
						end
						/////////////////////////////////////////////////////////////
						//Llamamos a paquete de mejora
							if(rand(1,1000)<=rand(1,15))
								conts--;
								if(conts<=0)
									paquete_mejora(rand(0,640),rand(5,6));
									conts=retard;
								end
							end
						/////////////////////////////////////////////////////////////
					else
						//Paramos el tiempo
							signal(preloj,s_kill);

						//Llamamos a boss;
							boss(2);
							repeat
								frame;
							until(bossmuerto==1);
							signal(pnav, s_kill);
							break;
					end
					frame;
				end
			end
			case 3:	
				
				//Nivel 3 //////////////////////////////////////////////////////////////////////////////////////////////////
				modi=7000;
				curar();
				pnav=nave();
				Start_scroll(0,graficos,86,0,0,2);
				conts=retard;
				
				loop
					modi=punt+4000;
					if(tmp<120)
						scroll[0].y0=scroll[0].y0-8;
						
						//Enemigos básicos
						if(punt<modi)	
							if(rand(0,1000)<(modi/100))
								enemigo(rand(0,640), rand(-3,3),rand(1,3));
							end
						else	
							if(rand(0,punt+1000)<(punt/100))
								enemigo(rand(0,640), rand(-3,3),rand(1,3));
							end
						end
						
						//Bombarderos
						if(rand(1,1000)<=rand(1,100))
							bombardero(rand(1,640), rand(-3,3),rand(1,3),60);
						end
						//Llamamos a paquete de mejora
							if(rand(1,1000)<=rand(1,25))
								conts--;
								if(conts<=0)
									paquete_mejora(rand(0,640),rand(3,4));
									conts=retard;
								end
							end
						else
						//Paramos el tiempo
							signal(preloj,s_kill);

						//Llamamos a boss;
							animgra=boss(3);
							bossom();
							repeat
								frame;
							until(bossmuerto==1);
							signal(pnav, s_kill);
							break;
					end
					frame;
				end
			end
			case 4:					
				//Nivel 4 //////////////////////////////////////////////////////////////////////////////////////////////////
				modi=7000;
				curar();
				pnav=nave();
				Start_scroll(0,graficos,86,0,0,2);
				conts=retard;
				
				pv=20000;
				tmp=0;
				loop
					modi=punt+4000;
					if(tmp<130)
						if(pv<punt)
							curar();
							pv+=20000;
						end
						scroll[0].y0=scroll[0].y0-10;
					
						//Enemigos básicos
						if(punt<modi)	
							if(rand(0,1000)<(modi/100))
								enemigo(rand(0,640), rand(-3,3),rand(1,3));
							end
						else	
							if(rand(0,punt+1000)<(punt/300))
								enemigo(rand(0,640), rand(-3,3),rand(1,3));
							end
						end
						
						// Naves kamikaze
						if(rand(1,1000)<=rand(1,50))
							kamikaze(rand(1,640),pnav);
						end
							
						//Naves que disparan
						if(rand(1,1000)<=rand(1,100))
							enemdis(rand(1,640), rand(-3,3),rand(1,3),60);
						end
						
						//Llamamos a paquete de mejora
						if(rand(1,1000)<=rand(1,55))
							conts--;
							if(conts<=0)
								paquete_mejora(rand(0,640),rand(3,4));
								conts=retard;
							end
						end
					else
						bossmuerto=1;
						signal(pnav, s_kill);
					end
					frame;
				end
			end
			default:
				Put_screen(graficos,999);
				frame;
			end
		end
	end 

//Pantalla de selección
process pantalla_sel() 
	private
		int sel=1;
	end
	begin
		graph=57;
		Z=-1;
		repeat
			Put_screen(graficos,58);
			switch(sel)
				case 1:
					X=167;
					Y=293;
				end
				case 2:
					X=441;
					Y=293;
				end
			end
			
			if(key(_right))
				while(key(_right))
					frame;
				end
				sel+=1;
			end
			if(key(_left))
				while(key(_left))
					frame;
				end
				sel-=1;
			end
			
			if(sel>2)
				sel=1;
			end
			if(sel<1)
				sel=2;
			end
			frame;			
		until(key(_enter))
		while(key(_enter))
			frame;
		end
		switch(sel)
			case 1:
				nav=1;
			end
			case 2:
				nav=2;
			end
		end
	end 
//Fin del proceso "Pantalla de selección

// Inicio
	process inicio()
		private
			int ainx;
		end
		begin
			Put_screen(graficos,106);
			repeat
				frame;
			until(key(_enter));
			while(key(_enter))
				frame;
			end
			
			screen_clear();
			Put_screen(graficos,107);
			repeat
				frame;
			until(key(_enter));
			while(key(_enter))
				frame;
			end
			
			screen_clear();
			Put_screen(graficos,108);
			repeat
				frame;
			until(key(_enter));
			while(key(_enter))
				frame;
			end
		end
// Fin de inicio
//Pantalla de clear
process clear(int level)
	private
		int i, j, k, l;
	end
	begin
		X=320;
		Y=240;
		
		stop_scroll(0);
		switch(level)
			case 1:
				Put_screen(graficos,61);
			end
			case 2:
				Put_screen(graficos,72);
			end
			case 3:
				Put_screen(graficos,73);
			end
			case 4:
				Put_screen(graficos,98);
			end
		end
		puntf+=punt;
		matadosf+=matados;
		delete_text(0);
		
		write_var(fuente,145,250,3,i);
		write_var(fuente,297,272,3,j);
		write_var(fuente,364,321,3,k);
		write_var(fuente,339,345,3,l);
		
		for(i=0; i<=punt && !key(_enter); i++)
			frame(1);
		end
		i=punt;
		
		for(j=0; j<=matados && !key(_enter); j++)
			frame(1);
		end
		j=matados;
		
		for(k=0; k<=puntf && !key(_enter); k++)
			frame(1);
		end
		k=puntf;
		
		for(l=0; l<=matadosf && !key(_enter); l++)
			frame(1);
		end
		l=matadosf;
		
		play_wav(sonn[2],0);
		graph=60;
		
		switch(lvl)
			case 1:
				if(punt>15000)
					enermax+=50;
					vidas++;
				end
			end
			case 2:
				if(punt>25000)
					enermax+=100;
					vidas++;
				end
			end
			case 3:
				if(punt>35000)
					enermax+=50;
					vidas++;
				end
			end
			case 4:
				if(punt>45000)
					enermax+=100;
					vidas++;
				end
			end
		end
		while(key(_enter))
			frame;
		end
		curar();
		while(!key(_enter))
			frame;
		end
	end
//Fin del proceso "Pantalla de clear"

//Pantalla de inicio de level
process panlev(int lev)
	private
		int aux,posx=320;
		string texto;
	end
	begin
		stop_scroll(0);
		Put_screen(graficos,0);
		delete_text(0);
		
		aux=anim2();
				
		texto="Level " + lev;
		if(lev==5)
			texto="Final Boss";
		end
		write_var(fuente,posx,100,1,texto);
		repeat
			frame;
		until(key(_enter));
		signal(aux,s_kill);
		delete_text(0);
	end

//Fin de "Pantalla de inicio de level"

//Gameover
process gameover()
	begin
		stop_scroll(0);
		Put_screen(graficos,62);
		delete_text(0);
		let_me_alone();
		
		repeat
			frame;
		until(key(_esc));
		menu();
	end
//Fin de "Gameover"

//Enemigos básicos
process enemigo (x,int inc_x,int inc_y)
	private
		int ID_disparo_acertado,cont;
		int energia=0, daño;
		int	vidadm, sizmin, sizmax, moddaño, modpunt;
	end
	begin
		switch(lvl)
			case 1:
				vidadm=0;
				moddaño=0;
				sizmin=65;
				sizmax=91;
				modpunt=20;
			end
			case 2:
				vidadm=1;
				moddaño=10;
				sizmin=74;
				sizmax=103;
				modpunt=30;
			end
			case 3:
				vidadm=3;
				moddaño=20;
				sizmin=80;
				sizmax=141;
				modpunt=90;
			end
			case 4:
				vidadm=6;
				moddaño=30;
				sizmin=97;
				sizmax=191;
				modpunt=150;
			end
		end
		
		Size=rand(sizmin,sizmax);
		
		if (size>=65 and size<78)
			Graph=4;
			energia=1;
			daño=1+moddaño;
		else 
			if(size>=78 and size<91)
				Graph=5;
				energia=1;
				daño=5+moddaño;
			else
				if(size>=91 and size<103)
					Graph=6;
					energia=2+vidadm;
					daño=10+moddaño;
				else
					if(size>=103 and size<141)
						Graph=7;
						energia=3+vidadm;
						daño=20+moddaño;
					else
						Graph=74;
						energia=4+vidadm;
						daño=30+moddaño;
					end
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
			
			ID_Disparo_acertado=collision(type disparo);
			if (ID_disparo_acertado !=0 && anim==0)
				signal(ID_disparo_acertado,s_kill);
				energia=energia-1;
				if (energia==0)
					punt+=((size/10)+modpunt);
					matados+=1;
					play_wav(sonn[0],0);
					break;
				end
			end
			if(collision (type nave) && anim==0)
				energia_jugador=energia_jugador-daño;
				mejora=3;
				rdis=0;
				punt+=((size/10)+modpunt);
				play_wav(sonn[0],0);
				break;
			end
			frame;
		until (y > 520 or x < -20 or x > 670)
		for(cont=8;cont<=32;cont++)
			graph=cont;
			frame;
		end
	end
//Fin del proceso "Enemigos básicos"

//Enemigos que disparan
process enemdis(x, int inc_x, int inc_y, int ret)
	private
		int ID_disparo_acertado,cont;
		int energia=0, daño, angulo, sizmin, sizmax,modpunt;
		int i;
	end
	begin
		switch(lvl)
			case 4:
				energia=1;
				daño=10;
				sizmin=75;
				sizmax=85;
				modpunt=150;
			end
		end
		
		Size=rand(sizmin,sizmax);
		
		graph=75;
		
		if(inc_x==0)
			inc_x+=1;
		end
		Y=-40;
		repeat
			if(i>=ret and y<480 and y>0 and x<640 and x>0)
				angulo=get_angle(pnav);
				edisparo(x,y,angulo,15,(daño)/2);
				i=0;
			end
			
			X=X+inc_x;
			Y=Y+inc_y;
			
			i++;
			
			ID_Disparo_acertado=collision(type disparo);
			if (ID_disparo_acertado !=0 && anim==0)
				signal(ID_disparo_acertado,s_kill);
				energia=energia-1;
				if (energia==0)
					punt+=((size/10)+modpunt);
					matados+=1;
					play_wav(sonn[0],0);
					break;
				end
			end
			if(collision (type nave) && anim==0)
				energia_jugador=energia_jugador-daño;
				mejora=3;
				rdis=0;
				punt+=((size/10)+modpunt);
				play_wav(sonn[0],0);
				break;
			end
			frame;
		until (y > 520 or x < -20 or x > 670)
		for(cont=8;cont<=32;cont++)
			graph=cont;
			frame;
		end
	end
//Fin del proceso "Enemigos que disparan"

//Bombarderos
process bombardero(x, int inc_x, int inc_y, int ret)
	private
		int ID_disparo_acertado,cont;
		int energia=0, daño, angulo, sizmin, sizmax,modpunt;
		int i;
	end
	begin
		graph=75;
		switch(lvl)
			case 3:
				energia=1;
				daño=5;
				sizmin=45;
				sizmax=100;
				modpunt=30;
			end
			case 4:
				energia=1;
				daño=10;
				sizmin=45;
				sizmax=100;
				modpunt=40;
			end
		end
		
		Size=rand(sizmin,sizmax);
		
		
		if(inc_x==0)
			inc_x+=1;
		end
		Y=-40;
		
		repeat
			if(i>=ret)
				edisparo(x,y,270000,15,(daño)/2);
				i=0;
			end
			
			X+=inc_x;
			Y+=inc_y;
			
			i++;
			
			ID_Disparo_acertado=collision(type disparo);
			if (ID_disparo_acertado !=0 && anim==0)
				signal(ID_disparo_acertado,s_kill);
				energia=energia-1;
				if (energia==0)
					punt+=modpunt;
					matados+=1;
					play_wav(sonn[0],0);
					break;
				end
			end
			if(collision (type nave) && anim==0)
				energia_jugador=energia_jugador-daño;
				mejora=3;
				rdis=0;
				punt+=((size/10)+modpunt);
				play_wav(sonn[0],0);
				break;
			end
			frame;
		until (y > 520 or x < -20 or x > 670)
		for(cont=8;cont<=32;cont++)
			graph=cont;
			frame;
		end
	end
//Fin de "Bombarderos"

// Nave kamikaze
process kamikaze(x,int objetivo)
	private
		int ID_Disparo_acertado,cont;
	end
	begin
		y=-10;
		size=45;
		graph=90;
		repeat
			angle=get_angle(objetivo);
			advance(4);
			
			ID_Disparo_acertado=collision(type disparo);
			if (ID_disparo_acertado !=0 && anim==0)
				signal(ID_disparo_acertado,s_kill);
				punt+=size;
				matados+=1;
				play_wav(sonn[0],0);
				break;
			end
			if(collision (type nave) && anim==0)
				energia_jugador=energia_jugador-10;
				punt+=size;
				play_wav(sonn[0],0);
				break;
			end
			frame;
		until (y > 520 or y < -10 or x < -20 or x > 670)
		for(cont=8;cont<=32;cont++)
			graph=cont;
			frame;
		end
	end		
//Fin de "Nave kamikaze"

//nave jugadora
process nave ()
	private
		int cont=0,j;
	end
	begin
		//Cargamos el color y posición de la nave)
			switch(nav)
				case 1:
					graph=2;
				end
				case 2:
					graph=42;
				end
			end
			
			X=320;
			Y=470;
		////////////////////////////////////////////
		repeat
			frame;
		until(!collision(type disparogordo));
		muerto=0;
		loop
			cont=cont-1;
			if(cont<0) cont=0; end
			if (key(_up)) y-=7; end
			if (key(_down)) y+=7; end
			if (key(_left)) x-=7; end
			if (key(_right)) x+=7; end
			if(lvl!=4)
				if(y<200) y=200; end
			else
				if(y<10) y=10; end
			end
			if (x>627) x=627; end
			if (x<13) x=13; end
			if(y>470) y=470; end
	
///////////////////////////////////////////////////////////////////////////	
		// Modo dios
			if(key(_control) & key(_alt) & key(_g))
				while(key(_control) & key(_alt) & key(_g))
					frame;
				end
				if(godmode==false)
					godmode=true;
				else
					godmode=false;
				end
			end
			if(godmode==true)
				curar();
			end
		/////////////////
		
		// Power mode
			if(key(_control) & key(_alt) & key(_p))
				while(key(_control) & key(_alt) & key(_p))
					frame;
				end
				if(powermode==false)
					powermode=true;
				else
					powermode=false;
				end
			end
			if(powermode==true)
				mejora=89;
				rdis=10;
			end
		//////////////////////
		
		// Pause
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
		/////////////////////
//////////////////////////////////////////////////////////////////////////////
			//Armas
				if (key(_x) and anim==0)
					if(cont==0)
						cont=retardo-rdis;
						switch(mejora)
							case 34:
								disparo(X-2, Y-2);
								disparo(X+2, Y-2);
							end
							case 35:
								disparo(X-4, Y-2);
								disparo(X, Y-2);
								disparo(X+4, Y-2);
							end
							case 39:
								disparo(X-6, Y-2);
								disparo(X-2, Y-2);
								disparo(X+2, Y-2);
								disparo(X+6, Y-2);
							end
							case 41:
								disparo(X-8, Y-2);
								disparo(X-4, Y-2);
								disparo(X, Y-2);
								disparo(X, Y-2);
								disparo(X+4, Y-2);
								disparo(X+8, Y-2);
							end
							case 76:
								disparo(X-12, Y-1);
								disparo(X-8, Y-4);
								disparo(X-4, Y-1);
								disparo(X, Y-1);								
								disparo(X, Y-4);
								disparo(X, Y-1);
								disparo(X+4, Y-1);
								disparo(X+8, Y-4);
								disparo(X+12, Y-1);
							end
							case 89:
								disparo(X-12, Y-4);
								disparo(X-12, Y-4);
								disparo(X-8, Y-1);
								disparo(X-8, Y-1);
								disparo(X-4, Y-4);
								disparo(X-4, Y-4);
								disparo(X, Y-1);	
								disparo(X, Y-4);								
								disparo(X, Y-4);							
								disparo(X, Y-1);
								disparo(X+4, Y-4);
								disparo(X+4, Y-4);
								disparo(X+8, Y-1);
								disparo(X+8, Y-1);
								disparo(X+12, Y-4);
								disparo(X+12, Y-4);
							end
							default:
								disparo(X, Y-2);
							end
						end
						play_wav(sonn[1],0);
					end
				end			
			///////////////////////////////////////////////////////
			
			if(energia_jugador<=0)
				curar();
				vidas-=1;
				break;
			end
			frame;
		end
		anim=1;
		for(cont=8;cont<=32;cont++)
			Graph=cont;
			frame;
		end
		if(vidas>0)
			psegs=segs+2;
			repeat
				frame;
			until(segs>=psegs);
			muerto=1;
			pnav=nave();
		else
			gameover();
		end
		anim=0;
	end
//Fin del proceso nave jugadora

//Salud de la nave
process energia_nave ()
	begin
		X=110;
		Y=30;
		Z=-1;
		Graph=33;
		Region=1;
		loop
			if (energia_jugador<0)
				energia_jugador=0;
			end
			if(bossmuerto!=1)
				Define_region(1,10,25,energia_jugador,10);
			else
				Define_region(1,10,25,0,0);
			end
			frame;
		end
	end

PROCESS vida()
	begin
		X=36;
		Y=470;
		Z=-1;
		Size=70;
		loop
			if(bossmuerto!=1)
				switch(nav)
					case 1:
						switch(vidas)
							case 1:
								Graph=46;
								X=36;
							end
							case 2:
								Graph=47;
								X=36;
							end
							case 3:
								Graph=48;
								X=36;
							end
							case 4:
								Graph=64;
								X=44;
							end
							case 5:
								Graph=66;
								X=52;
							end
							case 6:
								Graph=68;
								X=59;
							end
						end
					end
					case 2:
						switch(vidas)
							case 1:
								Graph=49;
								X=36;
							end
							case 2:
								Graph=50;
								X=36;
							end
							case 3:
								Graph=51;
								X=36;
							end
							case 4:
								Graph=65;
								X=44;
							end
							case 5:
								Graph=67;
								X=52;
							end
							case 6:
								Graph=69;
								X=59;
							end
						end
					end
				end
			else
				graph=0;
			end
			frame;
		end
	end 
/////////////////////////////////////
	
//Disparo láser
process disparo(X,Y)
	private
		int i;
	end
	begin
		X=X;
		Y=Y;
		Z=1;
		
		repeat
			graph=mejora;
			y=y-15;
			if(collision(type boss))
				break;
			end
			frame;
		until (y < -15)
		if(bos==1)
			play_wav(sonn[0],0);
			for(i=8;i<=32;i++)
				graph=i;
				frame;
			end
					
		end
	end
	//Fin del proceso "Disparo láser
	
process paquete_mejora (x, int inc_y)
	private
		INT ID_disparo_acertado, cont;
		INT tipo, mejor, rdistr, graf;
	END
	begin
		Size=100;
		Y=-40;
		
		switch(lvl)
			case 1:
				tipo=rand(1,3);
			end
			case 2:
				tipo=rand(2,4);
			end
			case 3:
				tipo=rand(3,5);
			end
			case 4:
				//tipo=rand(4,6);
				tipo=6;
			end
		end
		switch(tipo)
			case 1:
				mejor=34;
				Graph=36;
				rdistr=3;
			end
			case 2:
				mejor=35;
				Graph=37;
				rdistr=6;
			end
			case 3:
				if(Punt>300)
					mejor=39;
					Graph=38;
					rdistr=8;
				else
					mejor=34;
					Graph=36;
					rdistr=3;
				end
			end
			case 4:
				if(Punt>500)
					mejor=41;
					Graph=40;
					rdistr=9;
				else
					mejor=35;
					Graph=37;	
					rdistr=6;		
				end
			end			
			case 5:
				if(Punt>500)
					mejor=76;
					Graph=77;
					rdistr=9;
				else
					mejor=39;
					Graph=38;	
					rdistr=8;		
				end
			end		
			case 6:
				if(Punt>1000)
					mejor=89;
					Graph=37;
					rdistr=10;
				else
					mejor=41;
					Graph=40;
					rdistr=9;	
				end
			end
		end
		repeat
			X=X;
			Y=Y+inc_y;
			ID_Disparo_acertado=collision(type disparo);
			if (ID_disparo_acertado !=0)
				signal(ID_disparo_acertado, s_kill);
				mejora=mejor;
				rdis=rdistr;
				play_wav(sonn[3],0);
				break;
			end
			if(collision (type nave))
				mejora=mejor;
				rdis=rdistr;
				play_wav(sonn[3],0);
				break;
			end
			frame;
		until (y > 520)
		for(cont=8;cont<=32;cont++)
			graph=cont;
			frame;
		end
	end
	
//BOSS
process boss(int lev)
	private
		int vida, ID_disparo_acertado;
		int i, j, aux=0;
	end
	begin
		bos=1;
		switch(lev)
			case 1:
				//Animación de bajada
					X=318;
					Y=-149;
					graph=59;
					size=200;
					vida=3000;
					Z=0;
					preloj=reloj(1);
					for(i=0;i<15;i++)
						frame;
					end
					repeat
						anim=1;
						for(i=0;i<10;i++)
							frame;
						end					
						Y+=2;
						frame;
					until(bss>25);
					signal(preloj,s_kill);
					anim=0;
					i=0;
				//Fin de la animación
				
				//Batalla
					preloj=reloj(1);
					repeat
						if(bss>=16)
							bss=1;
						end
						ID_Disparo_acertado=collision(type disparo);
						if (ID_disparo_acertado !=0)
							vida=vida-1;
						end
						if(collision (type nave) and anim==0)
							energia_jugador=0;
							mejora=3;
							rdis=0;
							anim=1;
						end
						switch(bss)
							case 1:
								disparogordo(X+5, 228, 34, 500, 1);
								aux=0;
							end
							case 4:
								disparogordo(X-265, 215, 39, 200, 1);
								disparogordo(X-190, 215, 39, 200, 1);
								disparogordo(X+189, 215, 39, 200, 1);
								disparogordo(X+260, 215, 39, 200, 1);
							end
							case 8:
								disparogordo(X+5, 228, 34, 500, 1);
								if(rand(0,100)<(50))
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									if(aux<1)
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										aux=1;
									end
								end	
							end
							case 12:
								disparogordo(X+5, 228, 34, 500, 1);
								
								disparogordo(X-265, 215, 39, 200, 1);
								disparogordo(X-190, 215, 39, 200, 1);
								disparogordo(X+189, 215, 39, 200, 1);
								disparogordo(X+260, 215, 39, 200, 1);
								aux=0;
							end
							case 15:
								if(rand(0,100)<(50))
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									if(aux<1)
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										aux=1;
									end
								end	
							end
						end
						if(i==0)
							if(X<278)
								i=1;
							else
								X-=1;
							end
						else
							if(X>358)
								i=0;
							else
								x+=1;
							end
						end
						frame;
					until(vida<=0);
					signal(preloj,s_kill);
				//Fin de batalla
				
				//Animación de fin de batalla				
					anim=1;
					Z=5;
					j=0;
					aux=0;
					repeat
						for(i=0;i<=5;i++)
							frame;
						end
						if(aux<4)
							disparogordo(rand(0,640),rand(50,149), 0, 200, 2);
							disparogordo(rand(0,640),rand(50,149), 0, 200, 2);
							disparogordo(rand(0,640),rand(50,149), 0, 200, 2);
							if(j==0)
								if(X<328)
									j=5;
									aux+=1;
								else
									X-=5;
								end
							else
								if(X>338)
									j=0;
								else
									x+=5;
								end
							end
						else
							disparogordo(rand(0,640),rand(0,Y+100), 0, 200, 2);
							disparogordo(rand(0,640),rand(0,Y+100), 0, 200, 2);
							disparogordo(rand(0,640),rand(0,Y+100), 0, 200, 2);
							if(j==0)
								if(X<328)
									j=1;
								else
									X-=8;
								end
							else
								if(X>338)
									j=0;
								else
									x+=8;
								end
							end
							Y-=2;
						end
						until(Y<-149);
					punt+=10000;
					matados+=1;
					anim=0;
				//Fin de la animación	
			end
			case 2:
				//Animación de bajada
					X=318;
					Y=-149;
					graph=70;
					size=200;
					vida=4000;
					Z=0;
					preloj=reloj(1);
					bss=0;
					for(i=0;i<15;i++)
						frame;
					end
					repeat
						anim=1;
						for(i=0;i<10;i++)
							frame;
						end					
						Y+=2;
						frame;
					until(bss>25);
					signal(preloj,s_kill);
					anim=0;
					i=0;
				//Fin de la animación
				
				//Batalla
					preloj=reloj(1);
					repeat
						if(bss>=16)
							bss=1;
						end
						ID_Disparo_acertado=collision(type disparo);
						if (ID_disparo_acertado !=0)
							vida=vida-1;
						end
						if(collision (type nave) and anim==0)
							energia_jugador=0;
							mejora=3;
							rdis=0;
							anim=1;
						end
						switch(bss)
							case 1:
								disparogordo(X+5, 228, 41, 500, 1);
								aux=0;
							end
							case 4:
								disparogordo(X-265, 215, 35, 200, 1);
								disparogordo(X-190, 215, 34, 200, 1);
								disparogordo(X+189, 215, 34, 200, 1);
								disparogordo(X+260, 215, 35, 200, 1);
							end
							case 8:
								disparogordo(X+5, 228, 41, 500, 1);
								if(rand(0,100)<(50))
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									if(aux<1)
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										aux=1;
									end
								end	
							end
							case 12:
								disparogordo(X+5, 228, 41, 500, 1);
								
								disparogordo(X-265, 215, 35, 200, 1);
								disparogordo(X-190, 215, 34, 200, 1);
								disparogordo(X+189, 215, 34, 200, 1);
								disparogordo(X+260, 215, 35, 200, 1);
								aux=0;
							end
							case 13:
								y+=1;
								if(rand(0,100)<10) edisparo(x-345,225,315000,50,15); end
							end
							case 14:
								if(rand(0,100)<(50))
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									if(aux<1)
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										aux=1;
									end
								end	
							end
							case 15:
								y-=1;
								if(rand(0,100)<10) edisparo(x+340,225,225000, 50,15); end
							end
						end
						if(i==0)
							if(X<278)
								i=1;
							else
								X-=1;
							end
						else
							if(X>358)
								i=0;
							else
								x+=1;
							end
						end
						frame;
					until(vida<=0);
					signal(preloj,s_kill);
				//Fin de batalla
				
				//Animación de fin de batalla				
					anim=1;
					Z=5;
					j=0;
					aux=0;
					repeat
						for(i=0;i<=5;i++)
							frame;
						end
						if(aux<4)
							disparogordo(rand(0,640),rand(50,149), 0, 200, 2);
							disparogordo(rand(0,640),rand(50,149), 0, 200, 2);
							disparogordo(rand(0,640),rand(50,149), 0, 200, 2);
							if(j==0)
								if(X<328)
									j=5;
									aux+=1;
								else
									X-=5;
								end
							else
								if(X>338)
									j=0;
								else
									x+=5;
								end
							end
						else
							disparogordo(rand(0,640),rand(0,Y+100), 0, 200, 2);
							disparogordo(rand(0,640),rand(0,Y+100), 0, 200, 2);
							disparogordo(rand(0,640),rand(0,Y+100), 0, 200, 2);
							if(j==0)
								if(X<328)
									j=1;
								else
									X-=8;
								end
							else
								if(X>338)
									j=0;
								else
									x+=8;
								end
							end
							Y-=2;
						end
						until(Y<-149);
					punt+=10000;
					matados+=1;
					anim=0;
				//Fin de la animación					
			end
			case 3:
				//Animación de bajada
					X=318;
					Y=-149;
					graph=87;
					size=200;
					vida=6500;
					Z=0;
					preloj=reloj(1);
					bss=0;
					for(i=0;i<15;i++)
						frame;
					end
					repeat
						anim=1;
						for(i=0;i<10;i++)
							frame;
						end					
						Y+=2;
						frame;
					until(bss>25);
					signal(preloj,s_kill);
					anim=0;
					i=0;
				//Fin de la animación
				
				//Batalla
					preloj=reloj(1);
					repeat
						procc=vida;
						if(bss>=18)
							bss=1;
						end
						ID_Disparo_acertado=collision(type disparo);
						if (ID_disparo_acertado !=0)
							vida=vida-1;
						end
						if(collision (type nave) and anim==0)
							energia_jugador=0;
							mejora=3;
							rdis=0;
							anim=1;
						end
						switch(bss)
							case 1:
								y+=1;
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								aux=0;
							end							
							case 3:
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 25,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 25,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 25,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 25,15); end
							end
							case 5:
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
							end
							case 7:
								y-=1;
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<(50))
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									if(aux<1)
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										aux=1;
									end
								end	
							end
							case 9:
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
							end
							case 11:
								y+=1;
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								aux=0;
							end
							case 13:
								y-=1;
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
							end
							case 15:
								y+=1;
								if(rand(0,100)<(50))
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									enemigo(rand(0,640), rand(-3,3),rand(1,3));
									if(aux<1)
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										paquete_mejora(rand(0,640),rand(3,4));
										aux=1;
									end
								end	
							end
							case 17:
								y-=1;
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
								if(rand(0,100)<10) edisparo(rand(213,472),rand(50,100),get_angle(pnav), 50,15); end
							end
						end
						if(i==0)
							if(X<278)
								i=1;
							else
								X-=1;
							end
						else
							if(X>358)
								i=0;
							else
								x+=1;
							end
						end
						
						pnav.y-=2;;
						if(pnav.x > x)
							pnav.x-=2;
						end
						if(pnav.x < x)
							pnav.x+=2;
						end
						frame;
					until(vida<=0);
					signal(preloj,s_kill);
				//Fin de batalla
				
				//Animación de fin de batalla				
					anim=1;
					Z=5;
					j=0;
					aux=0;
					repeat
						for(i=0;i<=5;i++)
							frame;
						end
						if(aux<4)
							disparogordo(rand(213,472),rand(0,100), 0, 200, 2);
							disparogordo(rand(213,472),rand(0,100), 0, 200, 2);
							disparogordo(rand(213,472),rand(0,100), 0, 200, 2);
							if(j==0)
								if(X<328)
									j=5;
									aux+=1;
								else
									X-=5;
								end
							else
								if(X>338)
									j=0;
								else
									x+=5;
								end
							end
						else
							disparogordo(rand(213,472),rand(0,y+50), 0, 200, 2);
							disparogordo(rand(213,472),rand(0,y+50), 0, 200, 2);
							disparogordo(rand(213,472),rand(0,y+50), 0, 200, 2);
							if(j==0)
								if(X<328)
									j=1;
								else
									X-=8;
								end
							else
								if(X>338)
									j=0;
								else
									x+=8;
								end
							end
							Y-=2;
						end
						until(Y<-149);
					punt+=10000;
					matados+=1;
					anim=0;
				//Fin de la animación				
			end
		end
		bos=0;
		bossmuerto=1;
	end 
	
process disparogordo(X, Y, int g, int siz, int modo)
	private
		int i;
	end
	begin
		Z=1;
		size=siz;
		if(modo==1)
			repeat
				graph=g;
				y=y+10;
				if(collision (type nave) and muerto==0 and anim==0)
					energia_jugador-=25;
					mejora=3;
					rdis=0;
					break;
				end
				frame;
			until (y < -15 or y > 670)
		else
			play_wav(sonn[0],0);
			for(i=8;i<=32;i++)
				graph=i;
				frame;
			end
		end
	end

process edisparo(x,y,angle,size,daño)
	private
		int i;
	end
	begin
		graph=71;
		repeat
			advance(5);
				if(collision (type nave) and muerto==0 and anim==0)
					energia_jugador-=daño;
					if(bos==1)
						mejora=3;
						rdis=0;
					end
					
					play_wav(sonn[0],0);
					for(i=8;i<=32;i++)
						graph=i;
						frame;
					end
					
					break;
				end
			frame;
		until(y>480 or x < -20 or x > 670 or y<-20)
	end 
	
///////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// ANIMACIONES ////////////////////////////////////////////////////////////////////////	
process anim1()
	private
		int i,j=0,aux;
	end
	begin
		Put_screen(graficos,63);
		aux=anim2();
		X=318;
		Y=-149;
		graph=80;
		size=200;
				
		repeat
			for(i=0;i<10;i++)
				frame;
			end					
			Y+=2;
			switch(j)
				case 50:
					graph=81;
				end
				case 77:
					graph=82;
				end
				case 110:
					graph=83;
				end
			end
			frame;
			j++;
		until(j>130);
		
		j=0;
		
		repeat
			for(i=0;i<10;i++)
				frame;
			end					
			switch(j)
				case 5:
					graph=82;
				end
				case 31:
					graph=81;
				end
				case 57:
					graph=80;
				end
			end
			frame;
			j++;
		until(j>85);
		
		signal(aux,s_kill);
		j=0;
		
		repeat
			for(i=0;i<10;i++)
				frame;
			end					
			Y-=4;
			frame;
			j++;
		until(j>100);
		anim=0;
	end 
	
process anim2()
	private
		int i, j=0;
	end
	begin
		x=320;
		y=240;
		
		loop
			if(nav==1)
				for(i=78;i<=79;i++)
					graph=i;
					frame(400);
				end
			else
				for(i=84;i<=85;i++)
					graph=i;
					frame(400);
				end
			end
		end
	end 
	
process bossom()
	begin
		graph=88;
		size=200;
		repeat
			x=animgra.x;
			y=animgra.y+205;
			frame;
		until(bossmuerto==1);
	end
//////////////// FIN ANIMACIONES ////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// FUNCIONES ////////////////////////////////////////////////////////////////////////
function curar()
	begin
		energia_jugador=200+enermax;
	end
//////////////// FIN FUNCIONES ////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
	process musica_arc()
		private
			INT can[6];
			INT i,j=0;
		end
		begin
			can[0]=load_song("sounds\1.ogg");
			can[1]=load_song("sounds\2.ogg");
			can[2]=load_song("sounds\3.ogg");
			can[3]=load_song("sounds\4.ogg");
			can[4]=load_song("sounds\5.ogg");
			can[5]=load_song("sounds\boss.ogg");
			
			loop
				if(IS_PLAYING_SONG() && i==lvl)
					if(exists(type boss))
						for(j=128;j>0;j--)
							set_song_volume(j);
							frame;
						end
						pause_song();
						set_song_volume(128);
						Play_song(can[5],0);
						while(exists(type boss))
							frame;
						end
						for(j=128;j>0;j--)
							set_song_volume(j);
							frame;
						end
						pause_song();
					end
				else
					set_song_volume(128);
					Play_song(can[lvl-1],0);
					i=lvl;
				end
				frame;
			end
		end

process control()
	begin
		loop
			if(key(_esc))
				let_me_alone();
				menu();
			end
			frame;
		end
	end 
