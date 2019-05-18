#include <stdio.h>
#include <allegro5/allegro.h>
#include <allegro5/allegro_image.h>
#include <allegro5/allegro_native_dialog.h>

#include "project.h"


void drawPoint(int x, int y, ALLEGRO_BITMAP *bitmap);
void bezierProc(int);
void drawPoints(int* x, int* y, ALLEGRO_BITMAP *bitmap);


int main(int argc, char* argv[])
{
	ALLEGRO_DISPLAY *window = NULL;			//wskaznik na okienko
	ALLEGRO_EVENT_QUEUE *event_queue = NULL; 	//kolejka przechowujaca generowane zdarzenia
	ALLEGRO_BITMAP *canvas	= NULL; 		// bitmapa po ktorej rysuje
	ALLEGRO_LOCKED_REGION *reg = NULL;
	
	int clicks = 0;
	int x[MAX_POINTS];
	int y[MAX_POINTS];
	unsigned int repaint;
	unsigned char *PixelBuffer;

	
	if(!al_init())
	{
		printf("Init error!\n");
		return 0;
	}
	
	al_install_mouse(); 
	al_init_image_addon();
	
	window = al_create_display(WIDTH, HEIGHT);
	if(!window)
	{
		printf("Window creation error!");
		return 0;
	}
	
	event_queue = al_create_event_queue();
	if (!event_queue){
		printf("Event queue creation error\n");
		return 0;
	}
	
	al_set_window_title(window, "Projekt x86: Krzywe Beziera");
	canvas = al_create_bitmap(WIDTH, HEIGHT);
	
	al_set_target_bitmap(canvas);			// ustawienie bitmapy do rysowania
	al_clear_to_color(al_map_rgb(255, 255, 255));	
	al_set_target_backbuffer(window);
	
	/* zdefiniowanie zrodel zdarzen */
	al_register_event_source(event_queue, al_get_display_event_source(window));
	al_register_event_source(event_queue, al_get_mouse_event_source());
	
	al_draw_bitmap(canvas, 0,0,ALLEGRO_FLIP_HORIZONTAL);
	al_flip_display();

	while(true)
	{
		ALLEGRO_EVENT e;
		al_wait_for_event(event_queue, &e);	// czeka az w kolejce pojawi sie zdarzenie
		
		switch(e.type)
		{
			case ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
				printf("%d\n", clicks);
				if(clicks <= 4)
				{		
					x[clicks] = e.mouse.x;
					y[clicks] = e.mouse.y;
					drawPoint(e.mouse.x, e.mouse.y, canvas);
					if(clicks == 4)
					{
						reg = al_lock_bitmap(canvas, ALLEGRO_PIXEL_FORMAT_ABGR_8888, ALLEGRO_LOCK_READWRITE);
						PixelBuffer = (unsigned char*) reg -> data;
						PixelBuffer -= (-reg->pitch * (HEIGHT-1));
					
						drawCurve(PixelBuffer, x, y);	
				
						al_unlock_bitmap(canvas);
						al_draw_bitmap(canvas, 0, 0, 0);
						
						drawPoints(x,y,canvas);
					}
									
					al_flip_display();
				}
				/*else if(clicks == 4)
				{
					x[clicks] = e.mouse.x;
					y[clicks] = e.mouse.y;
					drawPoint(e.mouse.x, e.mouse.y, canvas);
					
					al_flip_display();
				}*/	
				else if(clicks == 5) 
				{
					repaint = 1;
					break;
				}
				clicks++;				
				break;
				
				
			case ALLEGRO_EVENT_DISPLAY_CLOSE:
				al_save_bitmap("./bezier.bmp", canvas);
				return 0;
			default:
				break;
		}	

		if(repaint)
		{
			clicks = 0;
			repaint = 0;
			al_set_target_bitmap(canvas);
			al_clear_to_color(al_map_rgb(255, 255, 255));
			al_set_target_backbuffer(window);

			al_draw_bitmap(canvas, 0, 0, 0);
			al_flip_display();		
		}
		
	}	
}

/* funkcja do rysowania pojedynczego punktu */
void drawPoint(int x, int y, ALLEGRO_BITMAP *bitmap)
{	
	al_lock_bitmap(bitmap, ALLEGRO_PIXEL_FORMAT_ABGR_8888, ALLEGRO_LOCK_READWRITE);
	for(int i = x-1; i <= x+1; i++)
	{
		for(int j = y-1; j <= y+1; j++)
		{
			al_put_pixel(i,j, al_map_rgb(255,1,179));
		}
	}
	al_unlock_bitmap(bitmap);
}

/* funkcja do rysowania wszystkich punktow */
void drawPoints(int x[], int y[], ALLEGRO_BITMAP *bitmap)
{	
	int k,w;
	al_lock_bitmap(bitmap, ALLEGRO_PIXEL_FORMAT_ABGR_8888, ALLEGRO_LOCK_READWRITE);
	for(int i = 0; i < 5; i++)
	{
		w = x[i];
		k = y[i];
		for(int j = w-1; j <= w+1; j++)
		{
			for(int p = k-1; p <= k+1; p++)
			{
				al_put_pixel(j,p, al_map_rgb(255,1,179));
			}
		}		
	}
	al_unlock_bitmap(bitmap);
}


