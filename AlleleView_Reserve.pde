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
String input_txt1 = "";
String input_txt2 = "";
Gene Nucleotides = new Gene();
int alignment_amnt = 0; 
String first_alignment_string = "";
String second_alignment_string = "";
int[][] distances;

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
      //println(first_alignment_string);
      //println(second_alignment_string);
    }
  }
}
