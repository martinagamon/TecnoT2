void dibujarStars(){
    // Dibuja y actualiza las estrellas
  for (int i = estrellas.size() - 1; i >= 0; i--) {
    Estrella estrella = estrellas.get(i);
    estrella.mostrar();
    estrella.actualizar();

    // Verifica la recolección de estrellas
    if (estrella.estaRecolectada(caja)) {
      estrellas.remove(i);
      estrellasRecolectadas++;
    }
  }
  
}

void hudsEstrellas(){
   // Dibuja el contador de estrellas recolectadas
  fill(0);
  textSize(24);
  text("Estrellas recolectadas: " + estrellasRecolectadas, 20, 30);

  // Comprobar si se han recolectado suficientes estrellas para llegar a la Tierra
  if (estrellasRecolectadas >= 8) {
    // Permite que Pinky llegue a la Tierra (implementa tu lógica aquí)
    // Por ejemplo, puedes mostrar un mensaje de victoria o cambiar la posición de Pinky.
  }
  
  
  
  
  
  
  
  
}
