
void pinkyStar(){  
  
     // Mapear posX inversamente en nX
 float nX = map(posX, 0, 800, width, 0);
   boolean imagenEnMovimiento = dist(nX, posY, prevPosX, prevPosY) > 0.3;

// Aumenta la velocidad vertical para un rebote más alto
velocidadY += 0.6;

// Actualiza la posición de la imagen de acuerdo a los datos OSC
imagen.resize(50, 50); // Ajusta el tamaño de la imagen según tu preferencia
nX = constrain(nX, 0, width - imagen.width);
posY = constrain(posY + velocidadY, 0, height - imagen.height);

// Si la mano está en movimiento, detiene la gravedad
if (imagenEnMovimiento) {
  velocidadY = 0;
}

// Actualizar la posición anterior de la mano
prevPosX = nX;
prevPosY = posY;

// Actualizar la posición de la caja de acuerdo a los datos OSC
caja.setPosition(nX, posY);

imageMode(CENTER);
image(imagen, caja.getX(), caja.getY(), caja.getWidth(), caja.getHeight());
  
  
  
  
  
  
  
}
