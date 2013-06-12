char currentChar;

void processHttpRequests(EthernetClient client) {

  boolean currentLineIsBlank = true;
  while (client.connected() && client.available()) {
    Serial.println("Client connected");
    // read first two words
    currentChar = client.read();
    String verb = readNextWord(client);
    Serial.println("WebService - HTTP request verb: " + verb);
    
    findNextNonWhitespaceCharacter(client);
    String path = readNextWord(client);
    Serial.println("WebService - HTTP request path: " + path);
    
    findBody(client); 
    findNextNonWhitespaceCharacter(client);
    
    String body = readNextWord(client);
    Serial.println("WebService - HTTP body content: " + body);    
    
    char pathChar[BUFSIZE];
    path.toCharArray(pathChar, BUFSIZE);
    
    char *adress = strtok(pathChar,"/");
    int servo = atoi(adress);
    Serial.print("WebService - Parsed servoNo: "); Serial.println(servo);
    
    char bodyChar[BUFSIZE];
    body.toCharArray(bodyChar, BUFSIZE);
    int angle = atoi(bodyChar);
    Serial.print("WebService - Parsed angle: "); Serial.println(angle);
    
    if(verb.equals("GET")){
      if (path.equals("/")) {
        Serial.println("WebService - get - Dashboard");
        sendHttpResponseHeaderOk(client);
        printServoPositionsToClient(client);
        break;
      }
      
      if (path.equals("/json")) {
        Serial.println("WebService - get - json overview");
        sendHttpResponseJson(client);
        break;
      }
      
      if(servo > 0){
        Serial.println("WebService - get - servo");
        sendHttpResponseHeaderOk(client);
        client.println(servoAngleToDegreeAngle(angles[servo]));
        break;
      }
    }
    
    if(verb.equals("PUT")){
      if(servo <= 0){
        if(body.equals("resetAll")){
          Serial.println("WebService - put - resetAll");
          resetAllServos();
          sendHttpResponseHeaderOk(client);
          printServoPositions();
          break;
        }
        
        if(angle >= 0 && angle <=120){
          Serial.println("WebService - put - turnAllToAngle");
          setAllServos(degreeAngleToServoAngle(angle));
          sendHttpResponseHeaderOk(client);
          printServoPositions();
          break;  
        } 
      }
      else{
        if (body.equals("portrait")){
          Serial.println("WebService - put - portrait");
          turnToPortrait(servo-1);
          sendHttpResponseHeaderOk(client);
          printServoPositions();
          break;  
        }
        
        if (body.equals("landscape")){
          Serial.println("WebService - put - landscape");
          turnToLandscape(servo-1);
          sendHttpResponseHeaderOk(client);
          printServoPositions();
          break;  
        }
        
        if (verb.equals("PUT") && body.equals("reset")){
          Serial.println("WebService - put - reset");
          turnToPortrait(servo-1);
          sendHttpResponseHeaderOk(client);
          printServoPositions();
          break;
        } 
        
        if (angle >= 0 && angle <=120){
          Serial.println("WebService - put - angle");
          turnServoTo(servo-1, degreeAngleToServoAngle(angle));
          sendHttpResponseHeaderOk(client);
          printServoPositions();
          break;  
        }
      }
    }
    
    Serial.println("WebService - Unknown Action");
    sendHttpResponseHeaderBadRequest(client);
    findEnd(client);
  }
  delay(1);
  client.stop();
}

String readNextWord(EthernetClient client) {
  String buffer = "";
  byte cursor = 0;
  while (client.available() && !isWhiteSpaceCharacter(currentChar)) {
    buffer+= currentChar;
    currentChar = client.read();
  }
  if (!client.available() &&  !isWhiteSpaceCharacter(currentChar)) {
    buffer+= currentChar;
  }
  return buffer;
}

void findNextNonWhitespaceCharacter(EthernetClient client) {
  while (client.available() && isWhiteSpaceCharacter(currentChar)) {
    currentChar = client.read();
  }
}

void findBody(EthernetClient client) {
  boolean lineBreakFound = false;

  while (client.available() && !lineBreakFound) {
    currentChar = client.read();
    lineBreakFound = (currentChar == '\n');
    if (lineBreakFound) {
      currentChar = client.read();
      if (!isWhiteSpaceCharacter(currentChar)) {
        lineBreakFound = false;
      } else if (currentChar = '\n') {
        return;
      }
    }
  }
}

void findEnd(EthernetClient client) {
  while(client.available()) {
    client.read();
  }
}

boolean isWhiteSpaceCharacter(char c) {
  return c == ' ' || c == '\n' || c == '\r';
}

void sendHttpResponseHeaderOk(EthernetClient client) {
  // send a standard http response header
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println();
}

void sendHttpResponseHeaderBadRequest(EthernetClient client) {
  // send a standard http response header
  client.println("HTTP/1.1 400 BAD REQUEST");
  client.println("Content-Type: text/html");
  client.println();
}

void sendHttpResponseJson(EthernetClient client) {
  // send a json
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: application/json");
  client.println();
  client.println("{\"Servos\": [");
  for(int i=0; i< (sizeof(servos)/sizeof(servos[0])); i++){
    client.print("\{\"Servo"); 
    client.print(i+1); 
    client.print("\": "); 
    client.print(servoAngleToDegreeAngle(angles[i]));
    client.println("}");
    if(i <  (sizeof(servos)/sizeof(servos[0])-1)){
      client.println(",");
    }
  }
  client.println("]}");
}

void printServoPositionsToClient(EthernetClient client){
  client.println("<h1>Welcome to the great Mobile Teststand!</h1>");
  client.println("<p>These are the current angles of my servos:</p>");
  client.println("<ul>");
  for(int i=0; i< (sizeof(servos)/sizeof(servos[0])); i++){
    client.print("<li>Servo"); 
    client.print(i+1); 
    client.print(": "); 
    client.print(servoAngleToDegreeAngle(angles[i]));
    client.println("</li>");
  }
  client.println("</ul>");
}
