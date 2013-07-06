/// IP terminal, by deadman
//  ecpobox.blogspot.com

import controlP5.*;
import processing.net.*;

Client cc;
ControlP5 cp5;
Textfield c_target_ip;
Textfield c_target_port;
Textfield c_binary_input;
Textfield c_send_buffer;
Textfield c_source_char;
Textfield c_source_int;
Textarea c_send_log;
Textarea c_input_pool;

PFont font_text;
PFont font_tiny_text;

String input_string;
String status_string;

boolean connected = false;

// there are about 6,000 people trying to control you...
void setup () {
  size (480, 550);

  /// UI
  font_text = createFont ("Balker-13.vlw", 13);
  font_tiny_text = createFont ("DialogInput.plain-11.vlw", 11);
  
  cp5 = new ControlP5 (this);
  
  c_target_ip = cp5.addTextfield ("target_ip")
     .setValue ("www.google.com")
  
     .setPosition (5, 5)
     .setSize (380, 17)
     .setFont (font_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  c_target_port = cp5.addTextfield ("target_port")
     .setValue ("80")
  
     .setPosition (390, 5)
     .setSize (50, 17)
     .setFont (font_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_connect")
     .setCaptionLabel ("plug")
  
     .setPosition (445, 5)
     .setSize (30, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  c_binary_input = cp5.addTextfield ("binary_input")
     .setAutoClear (false)
     .setPosition (5, 45)
     .setSize (325, 17)
     .setFont (font_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  c_source_int = cp5.addTextfield ("source_int")
     .setAutoClear (false)
     .setCaptionLabel ("int")
     .setPosition (335, 45)
     .setSize (50, 17)
     .setFont (font_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  c_source_char = cp5.addTextfield ("source_char")
     .setAutoClear (false)
     .setCaptionLabel ("chr")
     .setPosition (390, 45)
     .setSize (50, 17)
     .setFont (font_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
  
  cp5.addButton ("action_add_binary")
     .setCaptionLabel ("add")
  
     .setPosition (445, 45)
     .setSize (30, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
  
  c_send_buffer = cp5.addTextfield ("send_buffer")
     .setText ("GET / HTTP/1.0\r\n")
    
     .setPosition (5, 85)
     .setSize (310, 17)
     .setFont (font_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
  
  c_send_log = cp5.addTextarea ("send_log")
     .setPosition (5, 125)
     .setSize (310, 77)
     .setFont (font_tiny_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_line_feed")
     .setCaptionLabel ("line break")
     
     .setPosition (320, 85)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_show_ip")
     .setCaptionLabel ("[SHOW IP]")
     
     .setPosition (400, 85)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
     
     
  // You can customize these:   
  cp5.addButton ("action_1")
     .setCaptionLabel ("GET/HTTP/1.0")
     .setPosition (320, 105)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_2")
     .setPosition (400, 105)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_3")
     .setPosition (320, 125)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_4")
     .setPosition (400, 125)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_5")
     .setPosition (320, 145)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_6")
     .setPosition (400, 145)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_7")
     .setPosition (320, 165)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_8")
     .setPosition (400, 165)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_9")
     .setPosition (320, 185)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
     
  cp5.addButton ("action_10")
     .setPosition (400, 185)
     .setSize (75, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
  /*
  // maybe someday...
  cp5.addButton ("action_send_binary")
     .setCaptionLabel ("send")
  
     .setPosition (60, 250)
     .setSize (30, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
  
  cp5.addButton ("action_send_buffer")
     .setCaptionLabel ("send")
  
     .setPosition (100, 250)
     .setSize (30, 17)
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));  
  */ 
  c_input_pool = cp5.addTextarea ("input_pool")
     .setPosition (5, 225)
     .setSize (470, 295)
     .setFont (font_tiny_text)
     .setColor (color (255))
     .setColorActive (color (0, 255, 0))
     .setColorForeground (color (0, 64, 0))
     .setColorBackground (color (0));
  
  cp5.addButton ("action_save_pool")
    .setCaptionLabel ("save")
    .setPosition (410, 525)
    .setSize (30, 17)
    .setColorActive (color (0, 255, 0))
    .setColorForeground (color (0, 64, 0))
    .setColorBackground (color (0));
  
  cp5.addButton ("action_clear_pool")
    .setCaptionLabel ("clear")
    .setPosition (445, 525)
    .setSize (30, 17)
    .setColorActive (color (0, 255, 0))
    .setColorForeground (color (0, 64, 0))
    .setColorBackground (color (0));

  sendToLog ("100 OK\r\n");
  
  /// COMMS
  connect ();
  
  status_string = "100 OK. Waiting for orders.";
}
// ...and there are about 6,000 people trying to free you...
void draw () {
  background (0, 12, 0);
  fill (255);
  stroke (255, 0, 0);
  
  textFont (font_text, 13);
  textAlign (LEFT);
  text (status_string, 5, 535);
  
  fill (0, 255, 0);
  textFont (font_tiny_text, 11);
  textAlign (RIGHT);
  text ("ip_terminal, by deadman", 470, 217);

  String is = c_input_pool.getText ();
  String s;
  char c;
  
  if (connected) {
    while (cc.available ()>0) {
      status_string = "Receiving data...";
      s = cc.readString ();
      s = s.replaceAll ("\r", "\n");
      c_input_pool.append (s);
      sendToLog ("Got data back.");      
    }
  }  
}
// there's no good or evil, just slavery and freedom
void connect () {
  String loc = c_target_ip.getText ();
  int port = int (c_target_port.getText ());
  String s = "Connecting to "+loc+": "+str (port)+"...";  
  sendToLog (s);
  cc = new Client (this, loc, port);
 
  s = "Connected to "+cc.ip()+"!";
  sendToLog (s);
 
  connected = true;
}

void controlEvent(ControlEvent theEvent) {
  String n;
  String sv;
  int iv;
  
  n = theEvent.getName ();
  if(theEvent.isAssignableFrom(Textfield.class)) {
    sv = theEvent.getStringValue ();
    
    if (n.equals ("source_char")) {
      iv = int (sv.charAt (0));
      sv = binary (iv, 8);
      c_binary_input.setValue (sv);
      c_source_int.setValue (str (iv));
    } else
    if (n.equals ("source_int")) {
      iv = int (sv);
      sv = binary (iv, 8);
      c_binary_input.setValue (sv);
      c_source_char.setValue (str (char (iv)));
    } else
    if (n.equals ("binary_input")) {
      iv = unbinary (sv);
      c_source_int.setValue (str (iv));
      c_source_char.setValue (str (char (iv)));
    } else
    if (n.equals ("send_buffer")) {      
      if (connected) {
        String s = c_send_buffer.getText ();
        sendToBuffer (s);
        
      } else println ("not connected!");
    }    
  } else 
  if(theEvent.isAssignableFrom(Button.class)) {
    if (n.equals ("action_connect")) {
      connect ();
    } else
    if (n.equals ("action_clear_pool")) {
      c_input_pool.setText ("");
    } else
    if (n.equals ("action_save_pool")) {
      selectOutput ("Save file: ", "fileSelected");
    } else
    if (n.equals ("action_add_binary")) {
      String s = c_send_buffer.getText ();
      s+= c_source_char.getText ();
      c_send_buffer.setText (s);
    } else
    if (n.equals ("action_line_feed")) {
      String s = "\r\n";
      c_send_buffer.setText (s);
    } else
    if (n.equals ("action_show_ip")) {
      c_input_pool.append (cc.ip ());
    }
   
     else
     if (n.equals ("action_1")) {
       c_send_buffer.setText ("GET / HTTP/1.0\r\n");
     } else
     if (n.equals ("action_2")) {
     }
   
      
         
    
  }
}

// don't pull back. you are not alone. together, we could be 6,001...
void sendToBuffer (String s) {
  cc.write (s);
  cc.write ("\r\n");
  
  sendToLog (s);
}
void sendToLog (String s) {
  s+="\n";
  status_string = s;
  println (s);
  
  s=c_send_log.getText()+s;
  c_send_log.setText (s);
}
void fileSelected (File selection) {
  if (selection!=null) {
    PrintWriter o_file;
 
    String s = "Writing to file "+selection+"...";
    sendToLog (s);
    o_file = createWriter (selection);
    s = c_input_pool.getText ();
    //s.replaceAll ("\n", "\r\n");
    o_file.println (s);
    o_file.flush ();
    o_file.close ();
    
    s = "Wrote input pool to file "+selection+".";
    sendToLog (s);
    
  }
  
  
}
// fight the system back! buy organic food from your local markets even if it's more expensive.
