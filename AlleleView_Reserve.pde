/*
- List of conditions being displayed with good inheritance

Inherited disorders:
- Thalassemia
- Sickle Cell Anemia
- Acute Myeloid Leukemia

Non-inherited disorders (caused by somatic cell mutations):
- 

*/

import g4p_controls.*;
boolean error_message = false;
boolean alignment_display = false;
boolean compare_display = false;
String input_txt1 = "";
String input_txt2 = "";
Gene Nucleotides = new Gene();
int alignment_amnt = 0; 
String first_alignment_string = "";
String second_alignment_string = "";
int[][] distances;
String[] gene_pair;
float zoomFactor = 1;
float prev_zoom = 1;

float X_of_mouse = 0;
float Y_of_mouse = 0;
float x_translate = 0;
float y_translate = 0;



void setup() {
  size(1000, 550);
  createGUI();
}

void draw() {
  background(255);
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
      rect(160, 260, 550, 100);
      fill(0);
      textSize(30);
      text("The amount of misalignments are: " + alignment_amnt, 210, 325);
      if (compare_display == true) {
        Nucleotides.display_alignment(gene_pair);
      }
      //println(first_alignment_string);
      //println(second_alignment_string);q
    }
  }
}

void mouseWheel(MouseEvent event) {
  // this handles the zoom
  // which is solely important for the map
  // one needs to zoom in and out like how they would on a regular webpage
  // i.e. with two finders on touchpad or scrolling with the mouse
  int delta = event.getCount();  // Get the scroll amount (delta)
  if (compare_display == true) {
    println("HELLO");
    if (delta > 0) {
      // Zoom out (positive delta)
      if (zoomFactor - 1.4 >= 1) {
        zoomFactor -= 1.4; // Adjust zoom level (example: +0.1)
        X_of_mouse = mouseX;
        Y_of_mouse = mouseY;
      }
      else {
        zoomFactor = 1;
      }
    }
    else if (delta < 0) {
      // Zoom in (negative delta)
      println("entered");
      if ((zoomFactor+1.4) > 30) {
        prev_zoom = zoomFactor;
        zoomFactor = 30;
      }
      else {
        prev_zoom = zoomFactor;
        zoomFactor += 1.4; // Adjust zoom level (example: -0.1)
      }
      X_of_mouse = mouseX;
      Y_of_mouse = mouseY;
    }
  }
}
