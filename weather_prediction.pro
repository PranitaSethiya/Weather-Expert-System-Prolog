Domains
  cName = string
  longi, lat = real	
  

Database
  city (cName, lat, longi)
   
 

Predicates
  add_city
  list_cities
  consult_file
  menu
  process_choice ( char )
  read_file
  repeat
  save_file
  get_weather
  get_city (cName, lat, longi)
  isLatitudeValid( real )
  isLongitudeValid( real )
  weather(real, real, integer)

Clauses

  	menu :- 
  		repeat ,
    		makewindow(2,2,3," Menu ",5,5,12,50), nl ,
    		write("\nPress A to add City") ,
    		write("\nPress L to display List of Cities") ,
    		write("\nPress D to display weather predictions") ,
    		write("\nPress E to Exit\n\n") ,
    		write("Enter a Choice : ") ,
    		readchar(Choice) ,
    		upper_lower(Ch, Choice) ,
    		removewindow , 
    		process_choice(Ch) ,
    		Ch = 'E'.
		
  		process_choice('A') :- !, add_city.
  		process_choice('L') :- !, list_cities.
  		process_choice('D') :- !, get_weather.
  		process_choice('E').
	

  	add_city :-
    		makewindow(3,3,4,"New City",0,0,25,80) ,
    		repeat ,
          	clearwindow ,
		/*cursor(20, 5);
		write("Tip: Latitude ranges between -90 and 90");
		cursor(21, 5);
		write("Tip: Longitude ranges between -180 and 180");*/
      		field_str(0,2,14,"Name: ") ,
      		field_str(1,2,14,"Latitude: ") ,
      		field_str(2,2,14,"Longitude: ") ,
      		cursor(0, 17), readln(Name) ,
      		cursor(1, 17), readreal(Latitude) ,
		isLatitudeValid(Latitude),
	      	cursor(2, 17), readreal(Longitude) ,
		isLongitudeValid(Longitude),
          	cursor(11,4) ,
      		assertz( city( Name, Latitude, Longitude)),

    		write("\nDo you wish to add another City? (y/n): ") ,
    		readchar(Ans), write(Ans) ,
  		upper_lower(Ans, 'n'), ! ,
		save_file,
  		removewindow.


	list_cities :- 
        	write("City Name      Latitude  Longitude\n" ,
              	"=========      ========  =========\n") ,
        	city(Name,Latitude,Longitude) ,
		/*  str_int(Latitude,Latitude1) ,
  		str_int(Longitude,Longitude1) ,*/
  		writef("\n%-18 %-10 %-10", 
            	Name, Latitude, Longitude) ,
        	fail.
  	list_cities :-   
    		write("\n\n\nPress a key...") ,
    		readchar(_) ,
    		clearwindow.

	get_weather :-
		write("\t Enter City Name to get weather  ") ,
		field_str(1, 2, 12, "Name :") ,
		Cursor(1, 9) ,
  		readln(FNM) ,
		field_str(2, 2, 40, "Enter month(example: 1 for January): ");
		Cursor(2, 39) ,
  		readint(Humidity),
		/*Humidity = 0,!, 
		writef("\n\n%-10\n\n", Humidity) ,*/
/*		field_str(3, 2, 56, "Enter Time in Army Time(example: 2330 for 11:30 PM): ");
		Cursor(3, 56) ,*/
  		/*readint(Humidity2) ,nl,
		Humidity = 0,!, 
		writef("\n\n%-10\n\n", Humidity) ,
		field_str(4, 2, 20, "Enter Humidity: ");
		Cursor(4, 18) ,*/
  		/*readint(Humidity3) ,
		Humidity = 0,!, */
		/*writef("%-10", Humidity) ,
		write("\nTime: "),*/
  		write("----------------------------------------\n\nName:") ,
		get_city(Name, _, _) ,
		city(Name, Latitude, Longitude),
		writef("%-18", Name) ,
		write("\nLatitude: "),
		writef("%-10", Latitude) ,
		write("\nLongitude: "),
		writef("%-10", Longitude) ,
		/*write("\nMonth: "),
		writef("%-10", Humidity);*/
		/*str_int(Month,Month1),
		str_real(Time,Time1),
		str_real(Humidity,Humidity1),
		*/
		
		/*write("\nHumidity: "),
		writef("%-10", Time) ,*/
		
		weather(Latitude, Longitude, Humidity),
		fail.
  	get_weather   :-  	
  		write("\n\n\nPress any key...") ,
  		readchar(_) , 
  		clearwindow.


	get_city (Name, Latitude, Longitude) :-
  		city (Name, Latitude, Longitude),
  		! ; write("City Name not found!\n" ,
            	"Press a key to continue...") ,
  		readchar(_), clearwindow, fail.
    



  	repeat :- true;repeat.

	save_file :-
		write("\nSaving Database...\n") ,
		save("city.dba") , 
    		write("\n\nSuccess! Press any Key : ") ,
		readchar(_), 
		clearwindow.


  	consult_file :-
		city (_,_,_), !.
  		consult_file :-
    		existfile("city.dba"), !,
    		read_file.
	consult_file.
    
  	read_file :-             
    		consult("City.dba"), ! ,
    		clearwindow ; beep ,
        	write("ERROR in database!\n" ,
              	"Press any key to continue...") ,
        	readchar(_), clearwindow.

	isLatitudeValid(Latitude):-
		-90>Latitude,Latitude>90,
		write("Invalid Latitude (Latitude ranges between -90 and 90)"),
		write("\n\n\nPress any key to continue...") ,
  		readchar(_), 
		removewindow, 		
		add_city.
	isLatitudeValid(Latitude):-
		-90<=Latitude,Latitude<=90.
	

	isLongitudeValid(Longitude):-
		-180>Longitude,Longitude>180,
		write("Invalid Latitude (Latitude ranges between -180 and 180)"),		 
		write("\n\n\nPress any key to continue...") ,
		readchar(_),
		removewindow,
		add_city.
	isLongitudeValid(Longitude):-
		-180<=Longitude,Longitude<=180.

	weather(Lat, Longi, M):- 
		15<=Lat,Lat<=75,
		0<=Longi,Longi<=180,
		1<=M,M<=2,
		write("\nRegion: Asia"),
		write("\nFreezing and Cold","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		15<=Lat,Lat<=75,
		0<=Longi,Longi<=180,
		M=3,
		write("\nRegion: Asia"),
		write("\nSpring","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		15<=Lat,Lat<=75,
		0<=Longi,Longi<=180,
		4<=M,M<=5,
		write("\nRegion: Asia"),
		write("\nHot, Summer is here","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		15<=Lat,Lat<=75,
		0<=Longi,Longi<=180,
		6<=M,M<=8,
		write("\nRegion: Asia"),
		write("\nRainy, Monsoon time","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		15<=Lat,Lat<=75,
		0<=Longi,Longi<=180,
		9<=M,M<=10,
		write("\nRegion: Asia"),
		write("\nAutumn","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		15<=Lat,Lat<=75,
		0<=Longi,Longi<=180,
		11<=M,M<=12,
		write("\nRegion: Asia"),
		write("\nFreezing, Winter is Coming!!","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=40,
		-15<=Longi,Longi<=50,
		1<=M,M<=2,
		write("\nRegion: Europe"),
		write("\nFreezing and Cold","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=40,
		-15<=Longi,Longi<=50,
		M=3,
		write("\nRegion: Europe"),
		write("\nSpring","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=40,
		-15<=Longi,Longi<=50,
		4<=M,M<=6,
		write("\nRegion: Europe"),
		write("\nHot, Summer is here!!","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=40,
		-15<=Longi,Longi<=50,
		M=7,
		write("\nRegion: Europe"),
		write("\nRainy, Monsoon time.","\n\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=40,
		-15<=Longi,Longi<=50,
		8<=M,M<=10,
		write("\nRegion: Europe"),
		write("\nAutumn","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=40,
		-15<=Longi,Longi<=50,
		11<=M,M<=12,
		write("\nRegion: Europe"),
		write("\nFreezing, Enjoy Winter!!","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=-10,
		120<=Longi,Longi<=180,
		1<=M,M<=4,
		write("\nRegion: Australia"),
		write("\nFreezing and Cold","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=-10,
		120<=Longi,Longi<=180,
		M=5,
		write("\nRegion: Australia"),
		write("\nSpring","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=-10,
		120<=Longi,Longi<=180,
		M=6,
		write("\nRegion: Australia"),
		write("\nHot, Summer is here","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=-10,
		120<=Longi,Longi<=180,
		M=7,
		write("\nRegion: Australia"),
		write("\nIcy Rain and thunderstorms, Monsoon is here","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=-10,
		120<=Longi,Longi<=180,
		8<=M,M<=9,
		write("\nRegion: Australia"),
		write("\nAutumn","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-40<=Lat,Lat<=-10,
		120<=Longi,Longi<=180,
		10<=M,M<=12,
		write("\nRegion: Australia"),
		write("\nSnowy!!","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-55<=Lat,Lat<=90,
		-180<=Longi,Longi<=15,
		1<=M,M<=4,
		write("\nRegion: America"),
		write("\nFreezing and Cold","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-55<=Lat,Lat<=90,
		-180<=Longi,Longi<=15,
		M=5,
		write("\nRegion: America"),
		write("\nHot, Summer is here!!","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
	weather(Lat, Longi, M):- 
		-55<=Lat,Lat<=90,
		-180<=Longi,Longi<=15,
		6<=M,M<=8,
		write("\nRegion: America"),
		write("\nIcy Rain and thunderstorms!!","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.

	weather(Lat, Longi, M):- 
		-55<=Lat,Lat<=90,
		-180<=Longi,Longi<=15,
		10<=M,M<=12,
		write("\nRegion: America"),
		write("\nSnow and Hail Storms.","\n\nPress a key to continue...") ,
  		readchar(_), clearwindow, fail.
GOAL
  makewindow(1,2,3," Weather Predictions ",0,0,25,80) ,
  consult_file,
  menu.  



