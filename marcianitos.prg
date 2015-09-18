import "mod_video";
import "mod_map";
import "mod_screen";
import "mod_key";
import "mod_grproc";
import "mod_proc";
import "mod_rand";
import "mod_text";
import "mod_sound";
import "mod_scroll";
import "mod_mouse";
import "mod_file";
import "mod_sys"
import "mod_draw";

CONST
	retardo=13; //Retardo del arma;
	retard=10; //Retardo de los paquetes;
END

GLOBAL
	INT menu=1,opcion=0;
	INT Graficos, punt;
	int pantalla=1;
	INT puntuaciones[5];
	INT matados=0;
	INT energia_jugador=200;
	INT mejora=0, graf_laser=3;
	INT conts, gretard=5;
	INT sonn[4];
	INT nav;
	INT idfich,i,a;
	INT vidas=3;
	int animgra,procc=0;
	int fuente, fuente2;
	int anim=0; //Marca si una animación está activa o no;
	int bos=0; //Marca si un boss está activo o no;
	int rdis=0, muerto=0, ret=7;
	int lvl=1, puntf=0, matadosf=0;
	int pnav, plvl, pboss; //Id de los procesos nave, nivel, boss y megaboss final;
	int bossmuerto=0; //Indentifica si el boss del nivel ha muerto;
	int tmp, preloj, bss, segs, psegs; //tmp=Tiempo de nivel, preloj=ID del proceso reloj, bss=contador de tiempo del boss, segundos (a secas);
	int enermax=0; //Energía, arma y vidas del jugador;
	string arg;
	bool godmode=false, powermode=false;
	int salir=0;

	int pbos,som,vidasg,energias,ener,navs,puntsf,matadsf;
	int pnavs, prelojds,tmpespc=0,vidaboss=10000, mejoras=1, rets=7;
	int punts=0,aux,grafica,fuentes,sonn2[4];

	INT energia_nod=400;

	int energia_jugador2=200, mejora2, vidas2, graf_laser2, nav2,vidas1;
	bool mostrar=false;
END

include "dll/prueba.prg";
include "dll/arcade_ind.prg";
include "dll/marcianitos_ind.prg";
include "dll/marcianitos_mul.prg";
include "dll/intro.prg";

PROCESS Main()
	BEGIN
		set_mode(640,480,32,MODE_FULLSCREEN);
		set_fps(60,1);
		Graficos=load_fpg("dll\prueba.fpg");
		sonn[0]=load_wav("sounds\054-Cannon03.ogg");
		sonn[1]=load_wav("sounds\057-Wrong01.wav");
		sonn[2]=load_wav("sounds\005-System05.ogg");
		sonn[3]=load_wav("sounds\002-System02.ogg");

		intro();
		menu();		
	END

FUNCTION menu()
	BEGIN
		delete_text(0);
		stop_song();
		stop_scroll(0);

		opcion=0;		
		musica();
		Put_screen(graficos,43);

		repeat
			repeat
				switch(menu)
					case 1:
						Signal(punt,s_kill);
						punt=puntero(300);
						if(key(_enter))
							while(key(_enter))
								frame;
							end
							opcion=1;
						end
	
					end
					case 2:
						Signal(punt,s_kill);
						punt=puntero(350);
						if(key(_enter))
							while(key(_enter))
								frame;
							end
							opcion=2;
						end
					
					end
					case 3:
						Signal(punt,s_kill);

						punt=puntero(400);
						if(key(_enter))
							while(key(_enter))
								frame;
							end
							opción=3;
						end
					end
					case 4:
						Signal(punt,s_kill);
						punt=puntero(450);
						if(key(_enter))
							while(key(_enter))
								frame;
							end
							opcion=4;
							let_me_alone();
							exit(0);
						end
	
					end
				end
				if(key(_down))
					while(key(_down))
						frame;
					end
					menu+=1;
				end
				if(key(_up))
					while(key(_up))
						frame;
					end
					menu-=1;
				end
				if(menu<1)
					menu=4;
				end
				if(menu>4)
					menu=1;
				end
				
				frame;
			until(opción!=0);
			
			switch(opción)
				case 1:
					let_me_alone();
					Stop_song();
					marcianitos_arc();
				end
				case 2:
					let_me_alone();
					Stop_song();
					marcianitos_ind();
				end
				case 3:
					let_me_alone();
					Stop_song();
					marcianitos_mul();
				end
			end

			frame;
		until(opcion==4)
		let_me_alone();
		Unload_fpg(graficos);
		exit();
	END
	
	PROCESS puntero(Y)
		BEGIN
			X=225;
			Y=Y;
			Graph=109;
			loop
				frame;
			end
		END
		
	PROCESS musica()
		PRIVATE
			INT can;
			INT i,j=0;
		END
		BEGIN
			can=load_song("sounds\NA-14.ogg");
			for(i=0;i<=6;i++)
				if(i==6)
					i=0;
				end
				if(IS_PLAYING_SONG())
					i-=1;
				else
					if(i==0)
						set_song_volume(200);
					else
						set_song_volume(200);
					end
					Play_song(can,0);
				end
				frame;
			end
		END

	
