import oscP5.*;
import fisica.*;
import processing.core.PImage;
import java.util.ArrayList;

FWorld mundo;
FBox caja;
PImage imagen; // Variable para almacenar la imagen
PImage fondo; 
float velocidadY = 0; // Velocidad en el eje Y
float prevPosX, prevPosY, posX, posY, posZ; // Variables para almacenar la posición anterior de la mano
int numCajas = 17; // Cambiado a 17
FBox[] cajas = new FBox[numCajas]; // Usamos FBox en lugar de FCircle
OscP5 osc;

float[] cajaX = {100, 280, 120, 690, 500, 330, 500, 740};
float[] cajaY = {50, 550, 360, 430, 480, 200, 100, 220}; // Altura constante para todas las cajas
float[] cajaWidth = {100, 176, 230, 150, 70, 185, 80, 265, 125}; // Ancho de las cajas
float[] cajaHeight = {100, 176, 230, 150, 70, 185, 80, 265, 125}; // Alto de las cajas

ArrayList<Estrella> estrellas; // Lista de estrellas
int estrellasRecolectadas = 0; // Contador de estrellas recolectadas

void setup() {
  size(800, 600);
  Fisica.init(this);

  mundo = new FWorld();
  mundo.setGravity(0, 0); // Sin gravedad
  mundo.setEdges();
  osc = new OscP5(this, 8008);

  // Carga la imagen (ajusta la ruta de la imagen según su ubicación)
  imagen = loadImage("Pinky.png");
  fondo = loadImage("fondo.jpg");


  prevPosX = width / 2; // Inicializa la posición anterior de la mano
  prevPosY = height / 2;

  for (int i = 0; i < cajaX.length; i++) {
    FBox caja = new FBox(cajaWidth[i], cajaHeight[i]);
    caja.setPosition(cajaX[i], cajaY[i]);
    caja.setStatic(true);
    caja.setName("planeta" + i); // Nombre único para cada caja
    mundo.add(caja);
    caja.setNoFill();
    caja.setNoStroke();
    cajas[i] = caja; // Agregar la caja al arreglo
  } 


  // Crear la caja principal
  caja = new FBox(70, 70);
  // Configura la caja contenedora de la estrella sin fill visible
  caja.setNoFill();
  caja.setNoStroke();
  caja.setPosition(width / 2, height / 2);
  caja.setName("pinkyPrincipal");
  mundo.add(caja);

  // Configuración de amortiguación para Pinky
  float amortiguacion = 0.1;  // Ajusta la amortiguación según tus necesidades
  caja.setDamping(amortiguacion);

  // Inicializar la lista de estrellas
  estrellas = new ArrayList<Estrella>();

  // Crear las estrellas y agregarlas a la lista
  for (int i = 0; i < 8; i++) {
    float x = random(width);
    float y = random(height);
    float tam = 20; // Tamaño de las estrellas
    Estrella estrella = new Estrella(x, y, tam);
    estrellas.add(estrella);
  }
}

void draw() {

  background(255);
  image(fondo, 400, 300);
  mundo.draw();
  mundo.step();

  pantallaInicio();
    
  if (frameCount>20) {
      estado = 1;
    }
   

  pantallaJuego();
  
}

 
void oscEvent(OscMessage m) {
  if (m.addrPattern().equals("/annotations/palmBase")) {
    // Obtener la posición de la mano desde OSC y utilizarla para controlar la imagen
    posX = m.get(0).floatValue();
    posY = m.get(1).floatValue();
    posZ = m.get(2).floatValue();
  }
}

String Nombre(FBody cuerpo) {
  return cuerpo.getName();
}

boolean areBoxesTouching(FBox box1, FBox box2) {
  if (box1 != null && box2 != null) { // Verificar si las referencias no son nulas
    float x1 = box1.getX();
    float y1 = box1.getY();
    float w1 = box1.getWidth();
    float h1 = box1.getHeight();

    float x2 = box2.getX();
    float y2 = box2.getY();
    float w2 = box2.getWidth();
    float h2 = box2.getHeight();

    // Verificar si las cajas se superponen en los ejes X y Y
    boolean overlapX = x1 < x2 + w2 && x1 + w1 > x2;
    boolean overlapY = y1 < y2 + h2 && y1 + h1 > y2;

    // Si hay superposición en ambos ejes, las cajas están tocándose
    return overlapX && overlapY;
  } else {
    // Si una de las referencias es nula, no hay superposición
    return false;
  }
}
class Estrella {
  float x, y;
  float tam;
  boolean recolectada;

  Estrella(float x, float y, float tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    this.recolectada = false;
  }

  void mostrar() {
    if (!recolectada) {
      fill(255, 255, 0); // Color de la estrella
      stroke(0);
      strokeWeight(2);
      ellipse(x, y, tam, tam);
    }
  }

  void actualizar() {
    // Implementa lógica adicional si es necesario
    // Por ejemplo, hacer que las estrellas se muevan o aparezcan en momentos específicos
  }

  boolean estaRecolectada(FBox jugador) {
    if (!recolectada && dist(x, y, jugador.getX(), jugador.getY()) < tam / 2) {
      recolectada = true;
      return true;
    }
    return false;
  }
}
