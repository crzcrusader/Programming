const int potPin = A5;  // Potentiometer connected to A2
const int led1 = 7;     // LED 1 connected to D2
const int led2 = 5;     // LED 2 connected to D5
const int led3 = 3;
const int spkr = 2;

void setup() {
    pinMode(led1, OUTPUT);
    pinMode(led2, OUTPUT);
    pinMode(led3, OUTPUT);
    pinMode(spkr, OUTPUT);
    pinMode(A5,INPUT);
    Serial.begin(9500); // Start serial monitor for debugging
      tone(spkr, 164);
      delay(500);
      tone(spkr,195);
      delay(500);
      tone(spkr,246);
      delay(5000);
}
void loop() {

       int potValue = analogRead(potPin);  // Read potentiometer value (0-1023)
  int delayTime; //delay time variable
    // Map pot value to delay range: Left (slow) = 500ms, Right (fast) = 50ms
    while(potValue > 0) { //start of loop to check for pot value
    int potValue = analogRead(A5);  // Read potentiometer value (0-1023)
        
      if (potValue < 400) {
        int potValue = analogRead(potPin);  // Read potentiometer value (0-1023)
        delayTime = 300;

          Serial.print("Pot Value: ");
          Serial.print(potValue);
          Serial.print(" | Delay Time: ");
          Serial.println(delayTime); // Show values in Serial Monitor

          digitalWrite(led1, HIGH);
          digitalWrite(led2, LOW);
          digitalWrite(led3, LOW);
          tone(spkr, 164);

          delay(delayTime);

          digitalWrite(led1, LOW);
          digitalWrite(led2, HIGH);
          digitalWrite(led3, LOW);
          tone(spkr,195);

          delay(delayTime);

          digitalWrite(led1, LOW);
          digitalWrite(led2, LOW);
          digitalWrite(led3, HIGH);
          tone(spkr,246);

          delay(delayTime);

    }else {
      delayTime = 1000;
      if(potValue > 400) {
        int potValue = analogRead(potPin);  // Read potentiometer value (0-1023)
        

          Serial.print("Pot Value: ");
          Serial.print(potValue);
          Serial.print(" | Delay Time: ");
          Serial.println(delayTime); // Show values in Serial Monitor

          digitalWrite(led1, HIGH);
          digitalWrite(led2, LOW);
          digitalWrite(led3, LOW);
        tone(spkr, 100);

          delay(delayTime);

          digitalWrite(led1, LOW);
          digitalWrite(led2, HIGH);
          digitalWrite(led3, LOW);
          tone(spkr,200);

          delay(delayTime);

          digitalWrite(led1, LOW);
          digitalWrite(led2, LOW);
          digitalWrite(led3, HIGH);
           tone(spkr,300);

          delay(delayTime);
        } //end of if Statement
     } //end of else statement
  } // end of while statement
}



void loop() {
  
int potValue = analogRead(potPin);
int delayTime; //delay time variable
    //Plays Song #1 Decpacito
    // Read potentiometer value (0-1023)
    if ((analogRead(potPin) > 0) && (analogRead(potPin) <= 300) ) {
      int NOTE_DUR = 58;
      int potValue = analogRead(A5);  // Read potentiometer value (0-1023)
       Serial.print("Pot Value: ");
          Serial.print(potValue);
          Serial.print(" | Delay Time: ");
          Serial.println(delayTime); // Show values in Serial Monitor
    tone(2, NOTE_D4);
    tone(2, NOTE_FS4);
    tone(2, NOTE_B4);
    tone(2, NOTE_D5);
    tone(NOTE_CS5, 1);
    tone(NOTE_B4, 1);
    tone(NOTE_AS4, 1);
    tone(NOTE_B4, 16); //m2
    delay(NOTE_DUR * 6);
    tone(NOTE_B4, 6);
    tone(NOTE_CS5, 6);
    tone(NOTE_D5, 6);
    tone(NOTE_E5, 6); //m3
    tone(NOTE_FS5, 7);
    tone(NOTE_D5, 7);
    tone(NOTE_FS5, 8);
    tone(NOTE_D5, 8);
    tone(NOTE_FS5, 22);
    delay(NOTE_DUR * 4);
    tone(NOTE_FS4, 2); //m4
    tone(NOTE_D5, 6);
    tone(NOTE_E4, 2);
    tone(NOTE_CS5, 6);
    tone(NOTE_D4, 2);
    tone(NOTE_B4, 4); //m5
    tone(NOTE_D4, 2);
    tone(NOTE_FS4, 4);
    tone(NOTE_B4, 2);
    tone(NOTE_D4, 4);
    tone(NOTE_B4, 4);
    tone(NOTE_D4, 2);
    tone(NOTE_FS4, 2);
    tone(NOTE_D5, 2);
    tone(NOTE_CS5, 2);
    tone(NOTE_B4, 2);
    tone(NOTE_A4, 2);
    tone(NOTE_B4, 4); //m6
    tone(NOTE_D4, 2);
    tone(NOTE_G4, 4);
    tone(NOTE_B4, 2);
    tone(NOTE_D4, 4);
    tone(NOTE_B4, 4);
    tone(NOTE_D4, 2);
    tone(NOTE_G4, 2);
    tone(NOTE_D5, 2);
    tone(NOTE_CS5, 2);
    tone(NOTE_B4, 2);
    tone(NOTE_A4, 2);
    tone(NOTE_D5, 4); //m7
    tone(NOTE_FS4, 2);
    tone(NOTE_A4, 4);
    tone(NOTE_D5, 2);
    tone(NOTE_FS4, 4);
    tone(NOTE_D5, 4);
    tone(NOTE_FS4, 2);
    tone(NOTE_A4, 2);
    tone(NOTE_D5, 2);
    tone(NOTE_CS5, 2);
    tone(NOTE_B4, 2);
    tone(NOTE_A4, 2);
    tone(NOTE_E5, 12); //m8
    delay(NOTE_DUR * 2);
    tone(NOTE_FS4, 2);
    tone(NOTE_D5, 6);
    tone(NOTE_E4, 2);
    tone(NOTE_CS5, 6);
    tone(NOTE_D4, 2);
    tone(NOTE_B4, 10); //m9
     Serial.print("Pot Value: ");
          Serial.print(potValue);
          Serial.print(" | Delay Time: ");
          Serial.println(delayTime); // Show values in Serial Monitor
}
//

}

  

 