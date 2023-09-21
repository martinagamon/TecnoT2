int estado = 0;
PImage inicio = loadImage("inicio.jpeg"), ganaste = loadImage("ganaste.jpg"), perdiste = loadImage("perdiste.jpg"), creditos = loadImage("creditos.jpg");
void dibujar() { 
    if (estado == 0) {
      pantallaInicio();
    }
    if (estado == 1) {
      pantallaJuego();
    
    }
    if (estado == 2) {
      pantallaGanaste();

    }
    if (estado == 3) {
      pantallaPerdiste();
    
    }
    if (estado == 4) {
      pantallaCreditos();
  
    }
  }
  
  void pantallaInicio(){
    
    image(inicio, 0, 0, 800, 600); 

    
  }
  
  void pantallaJuego(){
      dibujarStars();

  mostrarImagenesCajas();

  colisionPlanetas();

  hudsEstrellas();

  pinkyStar();
   
    
  }
  
  void pantallaGanaste(){
    
        image(ganaste, 0, 0, 800, 600); 
    
    
  }
  
  void  pantallaPerdiste(){
    
        
    image(perdiste, 0, 0, 800, 600); 
    
   
    
  }
  
  void pantallaCreditos(){
    
          
    image(creditos, 0, 0, 800, 600); 
    

    
    
  }
  
