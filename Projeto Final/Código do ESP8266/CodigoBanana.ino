// Incluindo as bibliotecas necessárias
#include <Wire.h>
#include <Adafruit_TCS34725.h>
#include <GyverOLED.h>

GyverOLED<SSH1106_128x64> oled; // Cria um objeto para controlar o display OLED
Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_614MS, TCS34725_GAIN_1X);


int id_database = 0;

// Declaração das portas para os LEDs e o display
int red = 15, green = 13, blue = 12, led = 2;


 // Configura as portas como saídas
void setup() {
  pinMode(red, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(blue, OUTPUT);
  pinMode(led, OUTPUT);

// Inicializa a comunicação serial
  Serial.begin(9600); 

  if (tcs.begin()) {
    Serial.println("Sensor de cores encontrado");
  } else {
    Serial.println("Sensor de cores não encontrado... Verifique as conexões");
    while (1); // Fica preso em um loop infinito se o sensor não for encontrado
  }

// Inicializa o display OLED com uma mensagem de boas-vindas
  oled.init();
  oled.setScale(3);
  oled.setCursor(10, 2);
  oled.print("Hello!");
  oled.update();
}

void loop() {
// Lê os valores do sensor de cores
  int color = 0;
  String statusFruta;
  uint16_t r, g, b, c, colorTemp, lux;
  tcs.getRawData(&r, &g, &b, &c);
  colorTemp = tcs.calculateColorTemperature_dn40(r, g, b, c);

  
// Atualiza o display OLED com a mensagem da cor detectada
  oled.init();
  oled.clear();
 statusFruta = getDetectedColor(r, g, b, colorTemp);
  oled.setScale(1);
  oled.setCursor(4, 2);
  oled.print(statusFruta);
  oled.update();
  delay(5000);  
}

// Função para determinar a cor detectada com base nos valores de RGB e temperatura de cor
String getDetectedColor(uint16_t r, uint16_t g, uint16_t b, uint16_t colorTemp) {
  int color;
  
  
  if (g > r && g > b && r > b && colorTemp > 3400) {
    color = 3;  // VERDE
  }  else if (g > r && g > b && r > b) {
    color = 1;  // AMARELA
  } else if (r > g && r > b && g > b && colorTemp > 2950 && colorTemp < 3550) {
    color = 2;  // Vermelho (MUITO Madura)
  }  else {
    color = 0;  // Cor desconhecida
  }

  
  String statusFruta;
  switch (color) {
    case 1: // AMARELA
     statusFruta = "MATURA";
      digitalWrite(red, HIGH);
      digitalWrite(blue, LOW);
      digitalWrite(green, HIGH);
     
      break;
    case 2: // Vermelha (MUITO Madura)
     statusFruta = "MUITO MADURA";
       digitalWrite(red, LOW);
      digitalWrite(green, HIGH);
      digitalWrite(blue, LOW);
      break;
    case 3: // VERDE
     statusFruta = "IMADURA";
       digitalWrite(red, LOW);
      digitalWrite(blue, HIGH);
      digitalWrite(green, HIGH);
      break;
    default:
     statusFruta = ".......";
      digitalWrite(red, LOW);
      digitalWrite(blue, HIGH);
      digitalWrite(green, HIGH);
      break;
  }
Serial.print(id_database);
Serial.print(",");
Serial.print("Maca");
Serial.print(",");
Serial.print(statusFruta);
Serial.println();

  id_database++;
  return statusFruta;
}









