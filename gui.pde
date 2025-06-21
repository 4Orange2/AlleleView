/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:Gene_Builder:993507:
  appc.background(230);
} //_CODE_:Gene_Builder:993507:

public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:dropList1:269991:
  // this is the code for the "Inherited Disorders" dropList
  
  
  // cool logic used to navigate between the fact that there are two dropLists
  // one of which can have a value that is not "None" at a time
  if (cancer_selected) {
    dropList1.setItems(loadStrings("list_269991"), 0);
  }
  else {
    disease_preference = dropList1.getSelectedText();
    if (disease_preference.equals("None") == false) {
      id_selected = true;
      if (disease_preference.equals("Sickle Cell Disease")) {
        String[] output_var = loadStrings("Human_Sickle_Cell.txt");
        String output_var_str = to_String(output_var);
        textarea1.setText(output_var_str);
        String[] second_output_var = loadStrings("Human_Beta_Globin.txt");
        String second_output_var_str = to_String(second_output_var);
        textarea2.setText(second_output_var_str);
        //println("this is Sickle_Cell_Length: ", output_var_str.length());
        //delay(10000);
      }
      else if (disease_preference.equals("Beta-Thalassemia")) {
        String[] output_var = loadStrings("Beta_Thalassemia.txt");
        String output_var_str = to_String(output_var);
        textarea1.setText(output_var_str);
        String[] second_output_var = loadStrings("No_Thalassemia.txt");
        String second_output_var_str = to_String(second_output_var);
        textarea2.setText(second_output_var_str);
      }
    }
    else {
      id_selected = false;
    }
  }
} //_CODE_:dropList1:269991:

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:910330:
  // this is the code for the "Generate Alignments" button 
  
  page_num = 1;
  alignment_amnt = 0;
  error_message = false;
  alignment_display = false;
  first_alignment_string = "";
  second_alignment_string = "";
  
  input_txt1 = "";
  input_txt2 = "";
  input_txt1 = textarea1.getText();
  input_txt2 = textarea2.getText();
  
  println("this is: ", input_txt1);
  println("this is 2: ", input_txt2);
  
  if (input_txt1.equals("") || input_txt2.equals("")) {
    error_message = true;
  }
  else {
    String[] input_list_1 = split(input_txt1, " ");
    String[] input_list_2 = split(input_txt2," ");
    for (int index = 0; index < input_list_1.length; index++) {
      String string_considered = input_list_1[index].toUpperCase();
      if (string_considered.equals("")) {}
      else {
        for (int i = 0; i < string_considered.length(); i++) {
          int unicode_value = int(string_considered.charAt(i));
          if (unicode_value == 65 || unicode_value == 67 || unicode_value == 71 || unicode_value == 84) {
            //println("1");
            first_alignment_string += string_considered.charAt(i); 
          }
          else {}
        }
      }
    }
    
    // Unicode is being used to only accept the nucleotides A, C, G, and T
    for (int index = 0; index < input_list_2.length; index++) {
    String string_consider = input_list_2[index].toUpperCase();   
    if (string_consider.equals("")) {}
      else {
        for (int i = 0; i < string_consider.length(); i++) {
          int unicode_value = int(string_consider.charAt(i));
          if (unicode_value == 65 || unicode_value == 67 || unicode_value == 71 || unicode_value == 84) {
            //println("2");
            second_alignment_string += string_consider.charAt(i);
          }
          else {}
        }
      }
    }
    
    // this is where functions from the "Gene" class are called
    alignment_amnt = Nucleotides.amount_of_alignments(first_alignment_string, second_alignment_string);
    ArrayList<String[]> all_align = Nucleotides.align_list_non_rec(second_alignment_string.length()-1, first_alignment_string.length()-1);

    gene_pair = Nucleotides.account_fillers(all_align);
    
    if (gene_pair.length >= 1) {
      Gene1 = gene_pair[0];
      Gene2 = gene_pair[1];
      prev_nucleotide_width = (prev_zoom*float(width-2*margin))/((max(Gene1.length(), Gene2.length())));
    }
    
    compare_display = true;
    alignment_display = true;
    
  }
} //_CODE_:button1:910330:

public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:753770:
  // the "reset" button resets all of the program's variables and initializes them just like how they are initialized in "AlleleView.pde" at the start of the program
  page_num = 0;
  alignment_amnt = 0;
  error_message = false;
  alignment_display = false;
  first_alignment_string = "";
  second_alignment_string = "";
  textarea1.setText("");
  textarea2.setText("");
  dropList1.setItems(loadStrings("list_269991"), 0);
  dropList2.setItems(loadStrings("list_658136"), 0);
  id_selected = false;
  cancer_selected = false;
  
    error_message = false;
  alignment_display = false;
  compare_display = false;
  input_txt1 = "";
  input_txt2 = "";
  Gene Nucleotides = new Gene();
  alignment_amnt = 0; 
  first_alignment_string = "";
  second_alignment_string = "";
  gene_pair = new String[0];
  zoomFactor = 1;
  prev_zoom = 1;
  
  X_of_mouse = 0;
  Y_of_mouse = 0;
  x_translate = 0;
  y_translate = 0;
  shiftFactor = 0;
  right_outside = false;
  outside_right = new ArrayList<float[]>();
  copy_x_translate = 0;
  
  
 resolved = true;
 slider_stop = false;
 
 delta = 0;
  
  limit_detected = false;
  
  lower_limit = -300.0;
   upper_limit = 300.0;
   margin = 20;
  Gene1 = "";
  Gene2 = "";
  disease_preference = "None";
  cancer_selected = false;
  id_selected = false; 
  
  distances = new int[0][0];
  nucleotide_width = 0;
  
} //_CODE_:button2:753770:

public void textarea1_change1(GTextArea source, GEvent event) { //_CODE_:textarea1:845802:
} //_CODE_:textarea1:845802:

public void textarea2_change1(GTextArea source, GEvent event) { //_CODE_:textarea2:774808:
} //_CODE_:textarea2:774808:

public void button3_click1(GButton source, GEvent event) { //_CODE_:button3:512677:
  shiftFactor = 0;
  cool_zoomFactor.setValue(0);
  zoomFactor = 1;
  x_translate = 0;
  upper_limit = 0;
  lower_limit = 0;
  cool_zoomFactor.setLimits(0.0, 0.0, 0.0);
} //_CODE_:button3:512677:

public void shift_alignment_gene(GCustomSlider source, GEvent event) { //_CODE_:cool_zoomFactor:855943:
  if (upper_limit == 0 && lower_limit == 0) {}
  else {
    shiftFactor = -(cool_zoomFactor.getValueF())*zoomFactor;
  }
} //_CODE_:cool_zoomFactor:855943:

public void dropList2_click1(GDropList source, GEvent event) { //_CODE_:dropList2:658136:
  // the "Cancers" dropDownList
  
  // cool logic for selecting the cancer only when the "Inherited Disorders" list value is none
  if (id_selected) {
    dropList2.setItems(loadStrings("list_658136"), 0);
  }
  else {
    disease_preference = dropList2.getSelectedText();
    println("in dropList2_click1 ", disease_preference);
    if (disease_preference.equals("None") == false) {
      cancer_selected = true;
      if (disease_preference.equals("Acute Myeloid Leukemia")) {
        String[] output_var = loadStrings("Yes_Myeloid_Leukemia - Copy.txt");
        String output_var_str = to_String(output_var);
        textarea1.setText(output_var_str);
        String[] second_output_var = loadStrings("No_Myeloid_Leukemia - Copy.txt");
        String second_output_var_str = to_String(second_output_var);
        textarea2.setText(second_output_var_str);          
      }
      
      // reading gene sequence data from textfiles uses the to_String() method in the "Helper Functions" tab
      else if (disease_preference.equals("Melanoma (A111V Protein)")) {
        String[] output_var = loadStrings("Yes_Melanoma_A11V.txt");
        String output_var_str = to_String(output_var);
        textarea1.setText(output_var_str);
        String[] second_output_var = loadStrings("No_Melanoma_A11V.txt");
        String second_output_var_str = to_String(second_output_var);
        textarea2.setText(second_output_var_str);
      }
      else if (disease_preference.equals("Melanoma (C315R Protein)")) {
        String[] output_var = loadStrings("Yes_Melanoma_C315R.txt");
        String output_var_str = to_String(output_var);
        textarea1.setText(output_var_str);
        String[] second_output_var = loadStrings("No_Melanoma_C315R.txt");
        String second_output_var_str = to_String(second_output_var);
        textarea2.setText(second_output_var_str);
      }
    }
    else {
      cancer_selected = false;
    }
  }
} //_CODE_:dropList2:658136:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  Gene_Builder = GWindow.getWindow(this, "Window title", 0, 0, 700, 750, JAVA2D);
  Gene_Builder.noLoop();
  Gene_Builder.setActionOnClose(G4P.KEEP_OPEN);
  Gene_Builder.addDrawHandler(this, "win_draw1");
  label1 = new GLabel(Gene_Builder, 40, 200, 270, 40);
  label1.setText("Enter first gene sequence here:");
  label1.setOpaque(false);
  label2 = new GLabel(Gene_Builder, 11, 527, 467, 64);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Is there a disease you would like to compare?");
  label2.setOpaque(false);
  dropList1 = new GDropList(Gene_Builder, 20, 637, 168, 100, 4, 10);
  dropList1.setItems(loadStrings("list_269991"), 0);
  dropList1.addEventHandler(this, "dropList1_click1");
  button1 = new GButton(Gene_Builder, 475, 628, 216, 110);
  button1.setText("Generate Alignments");
  button1.addEventHandler(this, "button1_click1");
  label3 = new GLabel(Gene_Builder, 390, 200, 2755, 40);
  label3.setText("Enter second gene sequence here:");
  label3.setOpaque(false);
  button2 = new GButton(Gene_Builder, 535, 570, 108, 52);
  button2.setText("Reset All");
  button2.setLocalColorScheme(GCScheme.RED_SCHEME);
  button2.addEventHandler(this, "button2_click1");
  textarea1 = new GTextArea(Gene_Builder, 35, 238, 278, 170, G4P.SCROLLBARS_NONE);
  textarea1.setOpaque(true);
  textarea1.addEventHandler(this, "textarea1_change1");
  textarea2 = new GTextArea(Gene_Builder, 393, 238, 277, 170, G4P.SCROLLBARS_NONE);
  textarea2.setOpaque(true);
  textarea2.addEventHandler(this, "textarea2_change1");
  button3 = new GButton(Gene_Builder, 519, 415, 169, 60);
  button3.setText("Re-centre Alignment");
  button3.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  button3.addEventHandler(this, "button3_click1");
  cool_zoomFactor = new GCustomSlider(Gene_Builder, 13, 480, 676, 40, "grey_blue");
  cool_zoomFactor.setShowValue(true);
  cool_zoomFactor.setShowLimits(true);
  cool_zoomFactor.setLimits(0.0, -300.0, 300.0);
  cool_zoomFactor.setNbrTicks(5);
  cool_zoomFactor.setNumberFormat(G4P.DECIMAL, 2);
  cool_zoomFactor.setOpaque(false);
  cool_zoomFactor.addEventHandler(this, "shift_alignment_gene");
  label4 = new GLabel(Gene_Builder, 9, 415, 452, 58);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("The left and right sides of the slider respresent the ends of the DNA Alignment.");
  label4.setOpaque(false);
  label6 = new GLabel(Gene_Builder, 300, 600, 80, 23);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Cancers");
  label6.setOpaque(false);
  dropList2 = new GDropList(Gene_Builder, 234, 628, 197, 100, 4, 10);
  dropList2.setItems(loadStrings("list_658136"), 0);
  dropList2.addEventHandler(this, "dropList2_click1");
  label7 = new GLabel(Gene_Builder, 9, 600, 176, 27);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Inherited Disorders");
  label7.setOpaque(false);
  label5 = new GLabel(Gene_Builder, 10, 10, 670, 60);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Input your FASTA gene sequences below. FASTA sequences can be derived from NCBI's RefSeq Database. The project, GenBank, is an initiative led by the United States Government in order to make genomic data accessible to all!");
  label5.setOpaque(false);
  label8 = new GLabel(Gene_Builder, 10, 80, 670, 115);
  label8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label8.setText("To compare a specific disease, look at the options in the two drop-down menus below. To get an interactive visual alignment model of two sequences, input each sequence into the two different text areas. Note: this program performs alignments of A's, T's, C's, and G'; since these are the nucleotides that the human body is composed of. Any other character inputted is ignored.");
  label8.setOpaque(false);
  Gene_Builder.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow Gene_Builder;
GLabel label1; 
GLabel label2; 
GDropList dropList1; 
GButton button1; 
GLabel label3; 
GButton button2; 
GTextArea textarea1; 
GTextArea textarea2; 
GButton button3; 
GCustomSlider cool_zoomFactor; 
GLabel label4; 
GLabel label6; 
GDropList dropList2; 
GLabel label7; 
GLabel label5; 
GLabel label8; 
