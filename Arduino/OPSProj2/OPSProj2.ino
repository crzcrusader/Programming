#include "Pitches.h"

const int potPin = A5;  // Potentiometer connected to A2
const int led1 = 7;     // LED 1 connected to D2
const int led2 = 5;     // LED 2 connected to D5
const int led3 = 3;
const int spkr = 2;
const int NOTE_DUR = 58;  // Set tempo to be faster

void setup() {
    pinMode(led1, OUTPUT);
    pinMode(led2, OUTPUT);
    pinMode(led3, OUTPUT);
    pinMode(spkr, OUTPUT);
    pinMode(A5,INPUT);
    Serial.begin(9500); // Start serial monitor for debugging

}
void play(int note, int duration) {

    tone(spkr, note);

    delay(duration * NOTE_DUR);

    noTone(spkr);

    delay(duration * NOTE_DUR);

}


void loop() {
  
int potValue = analogRead(potPin);
int delayTime; //delay time variable
    
    // Read potentiometer value (0-1023)
if ((analogRead(potPin) > 0) && (analogRead(potPin) <= 300) ) { //Plays Song #1 Decpacito
      digitalWrite(led1, HIGH);
      digitalWrite(led2, LOW);
      digitalWrite(led3, LOW);
    Serial.print("Potentiometer Value: ");
    Serial.println(potValue);
    Serial.println("Decpacito");
    play(NOTE_D4, 1);
    play(NOTE_FS4, 1);
    play(NOTE_B4, 1);
    play(NOTE_D5, 1);
    play(NOTE_CS5, 1);
    play(NOTE_B4, 1);
    play(NOTE_AS4, 1);
    play(NOTE_B4, 16); //m2
    delay(NOTE_DUR*6);
    play(NOTE_B4, 6);
    play(NOTE_CS5, 6);
    play(NOTE_D5, 6);
    play(NOTE_E5, 6); //m3
    play(NOTE_FS5, 7);
    play(NOTE_D5, 7);
    play(NOTE_FS5, 8);
    play(NOTE_D5, 8);
    play(NOTE_FS5, 22);
    delay(NOTE_DUR*4);
    play(NOTE_FS4, 2); //m4
    play(NOTE_D5, 6);
    play(NOTE_E4, 2);
    play(NOTE_CS5, 6);
    play(NOTE_D4, 2);
    play(NOTE_B4, 4); //m5
    play(NOTE_D4, 2);
    play(NOTE_FS4, 4);
    play(NOTE_B4, 2);
    play(NOTE_D4, 4);
    play(NOTE_B4, 4);
    play(NOTE_D4, 2);
    play(NOTE_FS4, 2);
    play(NOTE_D5, 2);
    play(NOTE_CS5, 2);
    play(NOTE_B4, 2);
    play(NOTE_A4, 2);
    play(NOTE_B4, 4); //m6
    play(NOTE_D4, 2);
    play(NOTE_G4, 4);
    play(NOTE_B4, 2);
    play(NOTE_D4, 4);
    play(NOTE_B4, 4);
    play(NOTE_D4, 2);
    play(NOTE_G4, 2);
    play(NOTE_D5, 2);
    play(NOTE_CS5, 2);
    play(NOTE_B4, 2);
    play(NOTE_A4, 2);
    play(NOTE_D5, 4); //m7
    play(NOTE_FS4, 2);
    play(NOTE_A4, 4);
    play(NOTE_D5, 2);
    play(NOTE_FS4, 4);
    play(NOTE_D5, 4);
    play(NOTE_FS4, 2);
    play(NOTE_A4, 2);
    play(NOTE_D5, 2);
    play(NOTE_CS5, 2);
    play(NOTE_B4, 2);
    play(NOTE_A4, 2);
    play(NOTE_E5, 12); //m8
    delay(NOTE_DUR*2);
    play(NOTE_FS4, 2);
    play(NOTE_D5, 6);
    play(NOTE_E4, 2);
    play(NOTE_CS5, 6);
    play(NOTE_D4, 2);
    play(NOTE_B4, 10); //m9
    } //end of song #1
  if((analogRead(potPin) > 301) && (analogRead(potPin) <= 650) ) { //Plays song 2 Gravity Falls
    digitalWrite(led1, LOW);
    digitalWrite(led2, HIGH);
    digitalWrite(led3, LOW);
    Serial.print("Potentiometer Value: ");
    Serial.println(potValue);
    Serial.println("Gravity Falls");
      play(NOTE_F5, 2);
      play(NOTE_D5, 2);
      play(NOTE_A4, 2);
      play(NOTE_D5, 2);
      play(NOTE_F5, 2);
      play(NOTE_D5, 2);
      play(NOTE_A4, 2);
      play(NOTE_D5, 2);

      play(NOTE_F5, 2);
      play(NOTE_C5, 2);
      play(NOTE_A4, 2);
      play(NOTE_C5, 2);
      play(NOTE_F5, 2);
      play(NOTE_C5, 2);
      play(NOTE_A4, 2);
      play(NOTE_C5, 2);


      play(NOTE_E5, 2);
      play(NOTE_CS5, 2);
      play(NOTE_A4, 2);
      play(NOTE_CS5, 2);
      play(NOTE_E5, 2);
      play(NOTE_CS5, 2);
      play(NOTE_A4, 2);
      play(NOTE_CS5, 2);
      play(NOTE_E5, 2);
      play(NOTE_CS5, 2);
      play(NOTE_A4, 2);
      play(NOTE_CS5, 2);
      play(NOTE_E5, 4);
      play(NOTE_A6, 4);
     
      
      play(NOTE_D4, 7);
      play(NOTE_E4, 4);
      play(NOTE_F4, 7);

      play(NOTE_A4, 6);
      play(NOTE_G4, 6);
      play(NOTE_A4, 4);
      play(NOTE_C4, 8);

      play(NOTE_D4, 8);
      play(NOTE_E4, 3);
      play(NOTE_F4, 5);
      play(NOTE_E4, 4);
      play(NOTE_G4, 4);
      play(NOTE_A4, 4);
      play(NOTE_G4, 4);
      play(NOTE_F4, 8);

      play(NOTE_F4, 3);
      play(NOTE_F4, 3);
      play(NOTE_F4, 3);
      play(NOTE_A4, 3);
      play(NOTE_A4, 3);
      play(NOTE_G4, 3);
      play(NOTE_F4, 7);

      play(NOTE_A4, 3);
      play(NOTE_A4, 3);
      play(NOTE_A4, 3);
      play(NOTE_G4, 3);
      play(NOTE_A4, 3);
      play(NOTE_G4, 3);
      play(NOTE_F4, 7);

      play(NOTE_F4, 3);
      play(NOTE_F4, 3);
      play(NOTE_F4, 3);
      play(NOTE_A4, 3);
      play(NOTE_A4, 3);
      play(NOTE_G4, 3);
      play(NOTE_F4, 7);

      play(NOTE_A4, 3);
      play(NOTE_A4, 3);
      play(NOTE_A4, 7);
      play(NOTE_CS5, 3);
      play(NOTE_CS5, 3);
      play(NOTE_CS5, 7);

  } //End of Song #2
//Spiderman song#3
if((analogRead(potPin) > 651) && (analogRead(potPin) <= 1023) ) {
   digitalWrite(led1, LOW);
    digitalWrite(led2, LOW);
    digitalWrite(led3, HIGH);
    Serial.print("Potentiometer Value: ");
    Serial.println(potValue);
    Serial.println("Spiderman");
    
    play(NOTE_D4, 3);
    play(NOTE_F4, 2);
    play(NOTE_A4, 5);
    delay(NOTE_DUR * 2);
    play(NOTE_GS4, 3);
    play(NOTE_F4, 2);
    play(NOTE_D4, 5);
    delay(NOTE_DUR * 2);
    play(NOTE_D4, 3);
    play(NOTE_F4, 2);
    play(NOTE_A4, 3);
    play(NOTE_AS4, 2);
    play(NOTE_A4, 3);
    play(NOTE_GS4, 3);
    play(NOTE_F4, 2);
    play(NOTE_D4, 5);

    delay(NOTE_DUR * 2);

    play(NOTE_G4, 3);
    play(NOTE_AS4, 2);
    play(NOTE_D5, 5);
    delay(NOTE_DUR * 2);
    play(NOTE_C5, 3);
    play(NOTE_AS4, 2);
    play(NOTE_G4, 5);
    delay(NOTE_DUR * 4);
 play(NOTE_D4, 3);
    play(NOTE_F4, 2);
    play(NOTE_A4, 3);
    play(NOTE_AS4, 2);
    play(NOTE_A4, 3);
    play(NOTE_GS4, 3);
    play(NOTE_F4, 2);
    play(NOTE_D4, 5);
    play(NOTE_AS4, 2);
    play(NOTE_A4, 5);

     play(NOTE_GS4, 2);
      play(NOTE_G4, 3);
      play(NOTE_F4, 2);
      play(NOTE_G4, 3);
      play(NOTE_F4, 2);
       play(NOTE_D4, 8);
       delay(NOTE_DUR * 4);
  
    }
    
