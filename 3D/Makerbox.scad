/*
*******************************************
Objekt Info: Parametrierbare Box mit Deckel

*******************************************
Version: 30.04.2022 khf
*******************************************
*/           

//***************   Auswahl   *************

//         1:Box  2:Deckel 3:Deckel mit Senklöcher

                 part = "1";

//*****************************************

//***************   Libraries  ************

include <lib/box_lib.scad>;

//*****************************************

//***************  Parmeter   *************
x = 70;  //Breite
y = 100;  //Länge
z = 40;  //Höhe
d1 = 3;   //Wand-Dicke mind. 3mm
b1 = 3;   //Durchmesser Bohrung mind. 3mm
//*****************************************

//**************   Programm  **************


a=3;
d= d1<a ? 3 : d1;

c=3;
b= b1<c ? 3 : b1;

print_part();

module print_part() 
 {
	if (part == "1") { 
        
        difference() {
		Box();
            //Durchbruch Display
            translate(v = [35, 0, -1.5])
            cube(size = [10,50.9,19.6], center=true);
            
            //Durchbruch USB
            translate(v = [-8.6, 50, 9])
            cube(size = [12,9,6], center=true);
           
            } 
       	} 
        
    else if (part == "2") {
        difference() {		
        Deckel();
       }        
 	}
   
   else if (part == "3") {
        difference() {		
        Deckel();
        Senkloecher(); 
       }        
 	}     
}


/*
Messen:
translate([-8, 50, 6.5])
cube(size = [2,2,9.3], center = true/false);

translate([-5, 50, 11])
cube(size = [40,4,5], center = true/false);

translate([-35, 50, 11])
cube(size = [23,4,5], center = true/false);

*/

















