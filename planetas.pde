String ConseguirNombre(FBody cuerpo){
  String nombre = "nada";
    if(cuerpo != null){
    nombre = cuerpo.getName();
  }
   if(nombre == null){
     nombre = "nada";
     
   }

   return nombre;
  
  
}
void mostrarImagenesCajas() {
  PImage[] imagenesCajas = new PImage[8];
  for (int i = 0; i < 8; i++) {
    imagenesCajas[i] = loadImage("caja" + i + ".PNG");
  }
  for (int i = 0; i < 8; i++) {
    FBox caja = cajas[i];
    PImage imagenCaja = imagenesCajas[i];
    
    // Obtener la posición de la caja
    float x = caja.getX();
    float y = caja.getY();
    
    // Dibujar la imagen de la caja en la posición de la caja
    image(imagenesCajas[i], x, y, caja.getWidth(), caja.getHeight());
  }
}

void colisionPlanetas(){
  
  
  // Detectar colisiones y rebotes de FBox caja con FBox[] cajas
  for (int i = 0; i < cajas.length; i++) {
    if (caja != cajas[i]) { // Evitar la colisión consigo misma
      if (areBoxesTouching(caja, cajas[i])) { // Verificar si la caja principal toca otra caja
        // Verificar si la caja principal se está moviendo hacia abajo
        if (velocidadY > 0) {
          // Simular el rebote como si fuera un trampolín
          velocidadY = -velocidadY * 1.2; // Aumenta el factor de rebote para un rebote más alto
        }
      }
    }
  }

  // Detectar colisiones y rebotes con otras cajas
  for (int i = 0; i < cajas.length; i++) {
    if (caja != cajas[i]) { // Evitar la colisión consigo misma
      if (areBoxesTouching(caja, cajas[i])) { // Verificar si la caja principal toca otra caja
        // Calcular la dirección del rebote
        float deltaX = caja.getX() - cajas[i].getX();
        float deltaY = caja.getY() - cajas[i].getY();
        float angle = atan2(deltaY, deltaX);

        // Calcular la distancia para separar las cajas (evita superposición)
        float overlap = (caja.getWidth() + cajas[i].getWidth()) / 2 - dist(caja.getX(), caja.getY(), cajas[i].getX(), cajas[i].getY());

        // Separar las cajas en la dirección opuesta
        float moveX = cos(angle) * overlap;
        float moveY = sin(angle) * overlap;
        caja.adjustPosition(moveX / 2, moveY / 2); // Mover la caja principal
        //cajas[i].adjustPosition(-moveX / 2, -moveY / 2); // Mover la otra caja
      }
    }
  }
  
  
  
  
  
  
  
  
  
}
