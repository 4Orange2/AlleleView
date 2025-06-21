/*
- List of conditions being displayed with good inheritance

Inherited disorders:
- Thalassemia
- Sickle Cell Anemia

Cancers:
- Acute Myeloid Leukemia
- Melanoma (A111V mutation)
- Melanoma (C315R)

*/

import java.awt.*; // Imports the Font class
import g4p_controls.*;
int page_num = 0;

boolean error_message = false;
boolean alignment_display = false;
boolean compare_display = false;
String input_txt1 = "";
String input_txt2 = "";
Gene Nucleotides = new Gene();
int alignment_amnt = 0; 
String first_alignment_string = "";
String second_alignment_string = "";
int[][] distances = new int[0][0];
String[] gene_pair = new String[0];
float zoomFactor = 1;
float prev_zoom = 1;

float X_of_mouse = 0;
float Y_of_mouse = 0;
float x_translate = 0;
float y_translate = 0;
float shiftFactor = 0;
boolean right_outside = false;
ArrayList<float[]> outside_right = new ArrayList<float[]>();
float copy_x_translate = 0;


boolean resolved = true;
boolean slider_stop = false;

int delta = 0;

boolean limit_detected = false;

float lower_limit = -300.0;
float upper_limit = 300.0;

int margin = 20;
String Gene1 = "";
String Gene2 = "";
float prev_nucleotide_width;

String disease_preference = "None";
boolean cancer_selected = false;
boolean id_selected = false;

float nucleotide_width = 0;


void setup() {
  size(1000, 550);
  createGUI();
  Font questionfont = new Font("Serif", Font.PLAIN, 26);
  label2.setFont(questionfont);
  Font plainfont = new Font("Serif", Font.PLAIN, 21);
  label4.setFont(plainfont);
  Font disease_font = new Font("Serif", Font.PLAIN, 21);
  label7.setFont(disease_font);
  label6.setFont(disease_font);
  
  Font Input_font = new Font("Serif", Font.BOLD, 21);
  label3.setFont(Input_font);
  label1.setFont(Input_font);
  
  Font Generate_font = new Font("Serif", Font.BOLD, 23);
  button1.setFont(Generate_font);
  Font Reset_font = new Font("Serif", Font.BOLD, 21);
  button2.setFont(Reset_font);
  Font ReCentre_font = new Font("Serif", Font.BOLD, 21);
  button3.setFont(ReCentre_font);
  
  Font Intro_font = new Font("Serif", Font.BOLD, 17);
  label5.setFont(Intro_font);
  Font Second_Intro_font = new Font("Serif", Font.BOLD, 17);
  label8.setFont(Second_Intro_font);
}

void draw() {
  background(255);
  if (page_num==0) {
    PImage home_background = loadImage("DNA_Home_Page.jpg");
    home_background.resize(1000, 550);
    image(home_background, 0, 0);
    textSize(30);
    fill(100, 200, 0);
    rect(80, 250, 680, 110);
    rect(80, 370, 680, 100);
    fill(0,200,100);
    rect(80,30, 350, 100);
    fill(0,0,0);
    text("This project takes inspiration from the famous", 100, 300);
    text("BLAST Alignment Search Tool!", 100, 300+40);
    text("The aim is to improve on it by providing a", 100, 300+110);
    text("more visual, interactive alignment.", 100, 300+150);
    textSize(70);
    text("AlleleView", 100, 100);
  }
  if (page_num == 1) {
    if (error_message == true) {
      stroke(0);
      fill(160, 90, 0);
      rect(160, 260, 550, 100);
      fill(0);
      text("Sorry, either input a DNA sequence pair to compare", 200, 300); 
      text("or the trait whose genes you want to see.", 200, 330);
    }
    else {
      if (alignment_display == true) {
        stroke(0);
        fill(160, 90, 0);
        rect(0.23*width, 0.63*height, 0.55*width, 100);
        fill(0);
        textSize(30);
        text("The amount of misalignments are: " + alignment_amnt, 0.27*width, 0.75*height);
        if (compare_display == true) {
          Nucleotides.display_alignment(gene_pair);
        }
      }
    }
  }
}

void mouseWheel(MouseEvent event) {
  if (resolved == true) {
    resolved = false;
    // this handles the zoom
    // which is solely important for the map
    // one needs to zoom in and out like how they would on a regular webpage
    // i.e. with two finders on touchpad or scrolling with the mouse
    delta = event.getCount();  // Get the scroll amount (delta)
    if (compare_display == true) {
      //println("HELLO");
      if (delta > 0) {
        // Zoom out (positive delta)
        if (zoomFactor - 1.4 >= 1) {
          zoomFactor -= 1.4; // Adjust zoom level
          X_of_mouse = mouseX;
          Y_of_mouse = mouseY;
        }
        else {
          zoomFactor = 1;
        }
      }
      else if (delta < 0) {
        // Zoom in (negative delta)
        
        if (nucleotide_width < 35) {
          // using a ratio to get the zoomFactor maximum to be reasonable for the sequence
          if ((zoomFactor+1.4) > 30*gene_pair[0].length()/600) {
            zoomFactor = 30*gene_pair[0].length()/600;
          }
        
          else {
              prev_zoom = zoomFactor;
              zoomFactor += 1.4; // Adjust zoom level
          }
        }
        X_of_mouse = mouseX; //recording the X coordinate of the mouse for future calculations in the zoom
        Y_of_mouse = mouseY; //recording the Y coordinate of the mouse for future calculations in the zoom
      }
    }
  }
}
