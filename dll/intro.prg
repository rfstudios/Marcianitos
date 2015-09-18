function intro()
	public
		int i,j,iy,eq,aux;
	end
	begin
		
		fade(0,0,0,100);
		while(fading)
			frame;
		end
		screen_put(Graficos,201);
		fade(100,100,100,1);
		while(fading)
			frame;
		end
		for(i=0;i<120;i++)
			frame;
		end
		fade(0,0,0,1);
		while(fading)
			frame;
		end
		clear_screen();

		i=new_map(640,480,32);
		map_clear(0,i,rgb(255,255,255));
		put_screen(0,i);

		fade(100,100,100,64);
		
		eq=100;
		iy=195;
		
		set_fps(120,1);
		mostrar=true;
		for(i=55;i<560;i+=3)
			for(j=129;j<350;j+=3)
				switch(rand(1,4))
					case 1:
						aux=rand(0,480);
						punto(-1,aux,i,j);
					end
					case 2:
						aux=rand(0,640);
						punto(aux,-1,i,j);
					end
					case 3:
						aux=rand(0,480);
						punto(641,aux,i,j);
					end
					case 4:
						aux=rand(0,640);
						punto(aux,481,i,j);
					end
				end
			end
		end
		for(i=0;i<400;i++)
			frame;
		end
		mostrar=false;
		set_fps(60,1);
	end
	
process punto(int x, int y, int eq, int iy)
	private
		int aux,i,j;
		int vel=1;
		bool llegado=false;
	end
	begin
		graph=new_map(3,3,32);

		for(i=0;i<3;i++)
			for(j=0;j<3;j++)
				map_put_pixel(0,graph,i,j,map_get_pixel(Graficos,202,i+eq,j+iy));
			end
		end

		vel=rand(1,3);

		repeat
			if(x<eq)
				x++;
			end
			if(eq<x)
				x--;
			end
			if(y<iy)
				y++;
			end
			if(iy<y)
				y--;
			end
			
			frame;
			
			for(i=0;i<rand(1,3)+vel;i++)
				if(x<eq)
					x++;
				end
				if(eq<x)
					x--;
				end
			end
			for(i=0;i<rand(0,3);i++)
				if(y<iy)
					y++;
				end
				if(iy<y)
					y--;
				end
			end

			if(x==eq && y==iy)
				llegado=true;
			end
		until(mostrar!=true || llegado!=false)
		repeat
			frame;
		until(mostrar!=true)
	end 
