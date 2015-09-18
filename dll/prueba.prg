process Main2(int vid, int eners, int navd, int pf, int mf)
	begin		
		sonn2[0]=load_wav("sounds\054-Cannon03.ogg");
		sonn2[1]=load_wav("sounds\057-Wrong01.wav");
		sonn2[2]=load_wav("sounds\005-System05.ogg");
		sonn2[3]=load_wav("sounds\002-System02.ogg");
		set_wav_volume(sonn2[0],35);
		
		grafica=load_fpg("dll\prueba.fpg");
		fuentes=load_fnt("dll\fuente1.fnt");

		Put_screen(grafica,101);
		repeat
			frame;
		until(key(_space));
		while(!key(_space))
			frame;
		end
		Put_screen(grafica,105);
		vidasg=vid;
		energias=eners+500;
		ener=eners;
		navs=navd;
		
		stop_scroll(0);
		delete_text(0);
		
		energia_naveg();
		vidag();
		pbos=boss2();
		pnavs=naveesp();
		som=bossom2();
		
		loop
			frame;
		end
	end
	
process boss2()
	private
		int vida;
		int ID_Disparo_acertado,i=0;,j=0;
	end
	begin
		x=320;
		y=240;
		z=5;
		size=75;
		alpha=0;
		graph=92;
		vidaboss=10000000;
		angle=123153;
		
		prelojds=relojs(60);
		loop
			ID_Disparo_acertado=collision(type disparog);
			if (ID_disparo_acertado !=0)
				vidaboss-=100;
				play_wav(sonn2[0],0);
			end
			if(collision (type misiles))
				vidaboss-=1000;
				play_wav(sonn2[0],0);
			end
			if(collision (type bombitas))
				vidaboss-=500;
				play_wav(sonn2[0],0);
			end
			if(collision (type naveesp))
				energias-=20;
			end
			
			switch(tmpespc)
				case 1,9:
					size++;
				end
				case 2,10:
					size--;
				end
			end
			advance(5);
			if(angle==89761)
				angle=70000;
			end
			if(angle==100664)
				angle=123000;
			end
			
			if(y<0 or y>480)
				angle=get_angle(pnavs);
			end
			if(x<0)
				if(angle > 90000 and angle < 180000)
					angle=rand(1,89000);
					angle=rand(1,89000);
					angle=rand(1,89000);
					angle=rand(1,89000);
					angle=rand(1,89000);
				end
				if(angle > 180000 and angle < 270000)
					angle=rand(270000,360000);
					angle=rand(270000,360000);
					angle=rand(270000,360000);
					angle=rand(270000,360000);
				end
			end
			if(x>640)
				if(angle > 270000 and angle < 360000)
					angle=rand(180000,270000);
					angle=rand(180000,270000);
					angle=rand(180000,270000);
					angle=rand(180000,270000);
				end
				if(angle > 0 and angle <= 90000)
					angle=rand(91000,180000);
					angle=rand(91000,180000);
					angle=rand(91000,180000);
					angle=rand(91000,180000);
					angle=rand(91000,180000);
				end
			end
			
			frame;
			if(rand(1,1000)<=rand(1,250))
				kamikazes(pnavs);
			end
			if(tmpespc>15)
				tmpespc=1;
			end
		end
	end

process relojs(int fs)
	private
		int i;
	end
	begin
		loop
			for(i=0; i<fs; i++)
				frame;
			end
			tmpespc++;			
		end
	end	
	
process bossom2()
	private
		int i,j=0,aux;
	end
	begin
		graph=91;
		loop
			size=pbos.size;
			x=pbos.x;
			y=pbos.y;
			
			if(vidaboss<7500000)
				graph=104;
			end
			if(vidaboss<5000000)
				graph=103;
			end
			if(vidaboss<2500000)
				graph=102;
			end
			
			if(vidaboss<=0)
				signal(pbos,s_kill);
				break;
			end
			frame;
		end
		signal(prelojds,s_kill);
		z=5;
		prelojds=relojs(60);
		j=x;
		repeat
			disparogordo(rand(x-200,x+200),rand(y-200,y+200), 0, 200, 2);
			if(i!=1)
				if(x>j-3)
					x--;
				else
					i=1;
				end
			else
				if(x<j+3)
					x++;
				else
					i=0;
				end
			end
			frame;
		until(tmpespc>15);
		play_wav(sonn2[0],0);
		for(size=75;size<1000;size+=10)
			frame;
		end
		cleared();
	end 
	
process naveesp()
	private
		int cont=15;
	end
	begin
		x=320;
		y=470;
		
		if(navs==1)
			graph=93;
		else
			graph=100;
		end
		
		repeat			
			angle=get_angle(pbos);
			frame;
		until(key(_up) or key(_down) or key(_left) or key(_right) or key(_x))
		loop
			if (key(_up)) y-=7; end
			if (key(_down)) y+=7; end
			if (key(_left)) x-=7; end
			if (key(_right)) x+=7; end
			advance(2);
			
			if (x>627) x=627; end
			if (x<13) x=13; end
			if(y>470) y=470; end
			if(y<10) y=10; end
			
			angle=get_angle(pbos);
			
			if (key(_1))
				mejoras=1;
				rets=10;
			end
			if (key(_2))
				mejoras=2;
				rets=3;
			end
			if (key(_3))
				mejoras=3;
				rets=1;
			end
			
			if (key(_x))
				if(cont>rets)
					switch(mejoras)
						case 1://Azul
							misiles(X,Y,angle,4,97);
						end
						case 2://Rojo
							bombitas(X,Y,angle+8000,6,90);
							bombitas(X,Y,angle,6,90);
							bombitas(X,Y,angle-10000,6,90);						
						end
						case 3://Morado
							disparog(X,Y,angle+10000,8,95);
							disparog(X,Y,angle+8000,8,95);
							disparog(X,Y,angle,8,95);
							disparog(X,Y,angle,8,95);
							disparog(X,Y,angle-8000,8,95);
							disparog(X,Y,angle-10000,8,95);				
						end
					end
					cont=0;
				else
					cont++;
				end
			end
			frame;
			if(energias<=0)
				break;
			end
			if(vidaboss<=0)
				for(cont=0;cont<100;cont++)
					angle=get_angle(som);
					advance(-2);
					frame;
				end
				signal(pnavs,s_kill);
			end
		end
		play_wav(sonn2[0],0);
		for(cont=8;cont<=32;cont++)
			Graph=cont;
			frame;
		end
		vidasg--;
		if(vidasg>0)
			curar2();
			pnavs=naveesp();
		else
			gameover();
		end
	end
	
function curar2()
	begin
		energias=ener+500;
	end

process bombitas(x,y,angle,int vel,graph)
	private
		int i;
	end
	begin
		size=1;
		repeat
			advance(vel);
			size++;
			frame;
			if(vidaboss<=0)
				break;
			end
		until(size>50 or collision(type boss2))
		size*=2;
		for(i=8;i<=32;i++)
			graph=i;
			frame;
		end
	end
process disparog(x,y,angle,int vel,graph)
	private
		int i;
	end
	begin
		repeat
			advance(vel);
			frame;
			if(vidaboss<=0)
				break;
			end
		until(y>520 or x < -40 or x > 690 or y<-30 or collision(type boss2))
		size*=2;
		for(i=8;i<=32;i++)
			graph=i;
			frame;
		end
	end 
	
process misiles(x,y,angle,int vel,graph)
	private
		int i;
	end
	begin
		repeat
			if(angle<get_angle(pbos))
				angle+=5000;
			end
			if(angle>get_angle(pbos))
				angle-=5000;
			end
			advance(vel);
			frame;
			if(vidaboss<=0)
				break;
			end
		until(y>520 or x < -40 or x > 690 or y<-30 or collision(type boss2))
		size*=3;
		for(i=8;i<=32;i++)
			graph=i;
			frame;
		end
	end 
	
//Salud de la nave
process energia_naveg()
	begin
		X=110;
		Y=30;
		Z=-1;
		Graph=33;
		Region=1;
		loop
			if (energias<0)
				energias=0;
			end
			if(energias<600)
				Define_region(1,10,25,energias,10);
			else				
				Define_region(1,10,25,600,10);
			end
			frame;
		end
	end

PROCESS vidag()
	begin
		X=36;
		Y=470;
		Z=-1;
		Size=70;
		loop
			switch(navs)
				case 1:
					switch(vidasg)
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
					switch(vidasg)
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
			frame;
		end
	end 
/////////////////////////////////////
	process kamikazes(int objetivo)
	private
		int ID_Disparo_acertado,cont;
	end
	begin
		x=pbos.x;
		y=pbos.y;
		size=5;
		graph=91;
		loop
			angle=get_angle(objetivo);
			advance(4);
			
			if(ID_Disparo_acertado=collision(type disparog))
				signal(ID_disparo_acertado,s_kill);
				punts+=size;
				play_wav(sonn2[0],0);
				break;
			end
			if(ID_Disparo_acertado=collision(type bombitas))
				signal(ID_disparo_acertado,s_kill);
				punts+=size;
				play_wav(sonn2[0],0);
				break;
			end
			if(ID_Disparo_acertado=collision(type misiles))
				signal(ID_disparo_acertado,s_kill);
				punts+=size;
				break;
			end
			if(collision (type naveesp))
				energias-=10;
				punts+=size;
				play_wav(sonn2[0],0);
				break;
			end
			frame;
			if(vidaboss<=0)
				break;
			end
		end
		size*=3;
		for(cont=8;cont<=32;cont++)
			graph=cont;
			frame;
		end
	end
	
//Pantalla de clear del boss
process cleared()
	private
		int i, j, k, l;
		string arg;
	end
	begin
		let_me_alone();
		
		X=320;
		Y=240;
		
		Put_screen(grafica,99);
		puntsf+=punts;
		matadsf+=1;
		delete_text(0);
		
		write_var(fuentes,145,250,3,i);
		write_var(fuentes,297,272,3,j);
		write_var(fuentes,364,321,3,k);
		write_var(fuentes,339,345,3,l);
		
		for(i=0; i<=punts; i++)
			frame(1);
		end
		for(j=0; j<=1; j++)
			frame(1);
		end
		for(k=0; k<=puntsf; k++)
			frame(1);
		end
		for(l=0; l<=matadsf; l++)
			frame(1);
		end
		
		play_wav(sonn2[2],0);
		graph=60;
		
		repeat
			frame;
		until(key(_enter));
		
		creditos();
		graph=0;
		loop
			if(key(_esc))
				repeat frame; until(!key(_esc));
				let_me_alone();
				menu();
				break;
			end
			frame;
		end
	end
//Fin del proceso "Pantalla de clear"
process creditos()
	private
		int yis=240, tx;
		string testo="";
		int pf;
	end
	begin
		screen_clear();
		delete_text(0);
		
		tmpespc=0;
		prelojds=relojs(60);
		write(fuentes,320,yis,1,"The End");
		repeat
			frame;
		until(tmpespc>2);
		
		
		for(yis=240; yis>-20;yis--)
		    delete_text(0);
			tx=write(fuentes,320,yis,1,"The End");
			frame;
		end
		delete_text(0);
		write_var(fuentes,320,240,1,testo);
		
		pf=fopen("dll\creds.yawin",1);
		repeat
			testo=fgets(pf);
			for(yis=0;yis<160;yis++)
				frame;
			end
		until(feof(pf))
		write(fuentes,2,470,3,"Pulsa ESC para salir");
	end 
