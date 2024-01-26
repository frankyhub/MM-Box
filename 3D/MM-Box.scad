/*
*******************************************
Objekt Info: Parametrierbare Box 
mit zwei Schalen und Front/Backpanel

*******************************************
Version: 30.04.2022 khf
*******************************************
*/           

//***************   Auswahl   *************

//Top shell
  TShell        = 1;// [0:No, 1:Yes]
//Bottom shell
  BShell        = 1;// [0:No, 1:Yes]
//Back panel  
  BPanel        = 1;// [0:No, 1:Yes]
//Front panel
  FPanel        = 1;// [0:No, 1:Yes]
  // PCB Füße (x4) 
  PCBFeet       = 1;// [0:No, 1:Yes]
// - Lüftungsschlitze
  Vent          = 1;// [0:No, 1:Yes]
//Front text
  Text          = 1;// [0:No, 1:Yes]
  //Text
  txt           = "Makers Monday"; 

//***************   Libraries  ************

//keine

//*****************************************

//***************  Parmeter   *************

// - Länge 
  Length        = 110;       
// - Breite
  Width         = 90;                     
// - Höhe  
  Height        = 30;  
// - Dicke und Abstand der Lüftungsschlitze
  Thick         = 2;//[2:5]  
  
/* [Box options] */

// - Decoration-Holes width (in mm)
  Vent_width    = 1.5;   
          
// - Font size  
  TxtSize       = 4;                 
// - Font  
  Police        ="Arial Black"; 
// - Diamètre Coin arrondi - Filet diameter  
  Filet         = 2;//[0.1:12] 
// - lissage de l'arrondi - Filet smoothness  
  Resolution    = 50;//[1:100] 
// - Tolérance - Tolerance (Panel/rails gap)
  m             = 0.9;
  
/* [PCB_FüßeS] */
//Bemaßung von der Mitte aus
// - Links X 
PCBPosX         = 7;
// - Links Y
PCBPosY         = 6;
// - Länge
PCBLength       = 70;
// - Breite
PCBWidth        = 50;
// - Füße Höhe
FootHeight      = 10;
// - Füße Durchmesser
FootDia         = 8;
// - Schraubloch Durchmesser
FootHole        = 3;  

// - Gehäusefarbe 
Couleur1        = "silver";       
// - Front/Backpanel Farbe   
Couleur2        = "Blue";    

//*****************************************

//**************   Programm  **************

// Lüftungsschlitze
Dec_Thick       = Vent ? Thick*2 : Thick; 
// - Depth decoration
Dec_size        = Vent ? Thick*2 : 0.8;

//PCB
PCBL= PCBLength+PCBPosX>Length-(Thick*2+7) ? Length-(Thick*3+20+PCBPosX) : PCBLength;
PCBW= PCBWidth+PCBPosY>Width-(Thick*2+10) ? Width-(Thick*2+12+PCBPosY) : PCBWidth;
PCBL=PCBLength;
PCBW=PCBWidth;
//echo (" PCBWidth = ",PCBW);


module RoundBox($a=Length, $b=Width, $c=Height){
                    $fn=Resolution;            
                    translate([0,Filet,Filet]){  
                    minkowski (){                                              
                        cube ([$a-(Length/2),$b-(2*Filet),$c-(2*Filet)], center = false);
                        rotate([0,90,0]){    
                        cylinder(r=Filet,h=Length/2, center = false);
                            } 
                        }
                    }
                }

      
////////////////////////////////// 
module Coque(){
    Thick = Thick*2;  
    difference(){    
        difference(){
            union(){    
                     difference() {
                      
                        difference(){
                            union() {          
                            difference(){  
                                RoundBox();
                                translate([Thick/2,Thick/2,Thick/2]){     
                                        RoundBox($a=Length-Thick, $b=Width-Thick, $c=Height-Thick);
                                        }
                                        }
                                difference(){//largeur Rails        
                                     translate([Thick+m,Thick/2,Thick/2]){
                                          RoundBox($a=Length-((2*Thick)+(2*m)), $b=Width-Thick, $c=Height-(Thick*2));
                                                          }
                                     translate([((Thick+m/2)*1.55),Thick/2,Thick/2+0.1]){ 
                                          RoundBox($a=Length-((Thick*3)+2*m), $b=Width-Thick, $c=Height-Thick);
                                                    }           
                                                }
                                    }
                               translate([-Thick,-Thick,Height/2]){
                                    cube ([Length+100, Width+100, Height], center=false);
                                            }                                            
                                      }
                               translate([-Thick/2,Thick,Thick]){
                                    RoundBox($a=Length+Thick, $b=Width-Thick*2, $c=Height-Thick);       
                                    }                          
                                }                                          


                difference(){// Fixation box legs
                    union(){
                        translate([3*Thick +5,Thick,Height/2]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }
                            
                       translate([Length-((3*Thick)+5),Thick,Height/2]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }

                        }
                            translate([4,Thick+Filet,Height/2-57]){   
                             rotate([45,0,0]){
                                   cube([Length,40,40]);    
                                  }
                           }
                           translate([0,-(Thick*1.46),Height/2]){
                                cube([Length,Thick*2,10]);
                           }
                    } 
            }

        union(){
            //if(Thick==1){Thick=2;
            for(i=[0:Thick:Length/4]){

              
                    translate([10+i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,Height/4]);
                    }
                    translate([(Length-10) - i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,Height/4]);
                    }
                    translate([(Length-10) - i,Width-Dec_size,1]){
                    cube([Vent_width,Dec_Thick,Height/4]);
                    }
                    translate([10+i,Width-Dec_size,1]){
                    cube([Vent_width,Dec_Thick,Height/4]);
                    }
  
                
                    }
               
                }
            }


            union(){ 
                $fn=50;
                translate([3*Thick+5,20,Height/2+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),20,Height/2+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([3*Thick+5,Width+5,Height/2-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),Width+5,Height/2-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
            }

        }
}

                            
module Panels(){//Panels
    color(Couleur2){
        translate([Thick+m,m/2,m/2]){
             difference(){
                  translate([0,Thick,Thick]){ 
                     RoundBox(Length,Width-((Thick*2)+m),Height-((Thick*2)+m));}
                  translate([Thick,-5,0]){
                     cube([Length,Width+10,Height]);}
                     }
                }
         }
}

module foot(FootDia,FootHole,FootHeight){
    Filet=2;
    color("Orange")   
    translate([0,0,Filet-1.5])
    difference(){
    
    difference(){
            //translate ([0,0,-Thick]){
                cylinder(d=FootDia+Filet,FootHeight-Thick, $fn=100);
                        //}
                    rotate_extrude($fn=100){
                            translate([(FootDia+Filet*2)/2,Filet,0]){
                                    minkowski(){
                                            square(10);
                                            circle(Filet, $fn=100);
                                        }
                                 }
                           }
                   }
            cylinder(d=FootHole,FootHeight+1, $fn=100);
               }          
}// Fin module foot
  
module Feet(){     
   
    translate([3*Thick+2,Thick+5,FootHeight+(Thick/2)-0.5]){
    
    %square ([PCBL+10,PCBW+10]);
       translate([PCBL/2,PCBW/2,0.5]){ 
        color("Olive")
        %text("PCB", halign="center", valign="center", font="Arial black");
       }
    } // Fin PCB 
  
        
    translate([3*Thick+7,Thick+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
    }
    translate([(3*Thick)+PCBL+7,Thick+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
        }
    translate([(3*Thick)+PCBL+7,(Thick)+PCBW+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
        }        
    translate([3*Thick+7,(Thick)+PCBW+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
    }   

} 


if(BPanel==1)
//Rück Panel
translate ([-m/2,0,0]){
Panels();
}

if(FPanel==1)
//Front Panel
rotate([0,0,180]){
    translate([-Length-m/2,-Width,0]){             
     Panels();
       }
   }

if(Text==1)
// Front text
color(Couleur1){     
     translate([Length-(Thick),Thick*10,(Height-(Thick*4+(TxtSize/2)))]){// x,y,z
          rotate([90,0,90]){
              linear_extrude(height = 0.25){
              text(txt, font = Police, size = TxtSize,  valign ="center", halign ="left");
                        }
                 }
         }
}


if(BShell==1)
// Boden
color(Couleur1){ 
Coque();
}


if(TShell==1)
// Deckel
color( Couleur1,1){
    translate([0,Width,Height+0.2]){
        rotate([0,180,180]){
                Coque();
                }
        }
}

if (PCBFeet==1)
// Füße
translate([PCBPosX,PCBPosY,0]){ 
Feet();
 }