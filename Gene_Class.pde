class Gene {
  
  String input1;
  String input2;
  
  Gene() {}
  
  int amount_of_alignments(String first_input, String second_input) {
    // Levenstein distance - Program 
    // Input: two strings
    // Output: integer that represents the degree of similarity
    input1 = first_input;
    input2 = second_input;
    
    String string1 = first_input;
    String string2 = second_input;
    
    distances = new int[string2.length()+1][string1.length()+1];
    
    for (int top_of_column = 0; top_of_column < (string1.length() + 1); top_of_column++) {
      distances[0][top_of_column] = top_of_column;
    }
    
    for (int first_of_row = 0; first_of_row < (string2.length() + 1); first_of_row++) {
      distances[first_of_row][0] = first_of_row;
    }
    
    
    // Algorithm to calculate the rest of the numbers in the nested array using the filled-in values for the top row and leftmost column
    for (int row_num = 1; row_num <= string2.length(); row_num++) {
      for (int col_num = 1; col_num <= string1.length(); col_num++) {
        if (string2.charAt(row_num-1) == string1.charAt(col_num-1)) { 
          distances[row_num][col_num] = min(distances[row_num-1][col_num-1], distances[row_num-1][col_num]+1, distances[row_num][col_num-1]+1);
          if (distances[row_num][col_num] == 1) {
            //println("this is row_num: ", row_num);
            //println("this is col_num: ", col_num);
            //delay(1000000000);
          }
        }
        else {
          distances[row_num][col_num] = min(distances[row_num-1][col_num], distances[row_num][col_num-1], distances[row_num-1][col_num-1]) + 1;
        }
      }
    }
    
    int alignment_amount = (distances[string2.length()][string1.length()]);
    return alignment_amount;
  }
  
  
  // this is one of the highlight algorithms in my program!
  
  // I use recursion in order to make conclusions about whether or not a mutation is an insertion, deletion, or base pair substitution
  // By looking back at the grid creating by the Levenshtein Distance calculation, for as many times as it takes to reach my base case, 
  // when row == 0 or col == 0.
  // Once I reach my base case, I then pass on the value of the whether or not the pair at that given index in the align_list to be returned should be an insertion, deletion, or substituion
  // in order for the minimum amount of misalignments that have been calculated to be presented in the sequence comparison outputted to the screen
  
  ArrayList<String[]> align_list_rec(int row, int col) {
    ArrayList<String[]> all_align = new ArrayList<String[]>();
    if (row == 0 || col == 0) {
      // this is the base case for my recursion!
      String first_input_string = str(input1.charAt(col));
      String second_input_string = str(input2.charAt(row));
      String[] position_letters = {first_input_string, second_input_string};
      all_align.add(position_letters);
      if (row == 0 && col == 0) {
        // this if-statement has nothing in it since all of the letter alignment pairs for UI creation have been added to all_align
        // the last addition to all_align is on line 67 (right above)
      }
      else if (row == 0 && col > 0) {
        // using a for-loop to get all of the "insertion's" in input2
        for (int column = col; column >= 0; column--) {
          // take all of the remaining letters in the column and pair them with a dash
          // which represents a deletion/mutation
          first_input_string = str(input1.charAt(column));
          second_input_string = "-";
          String[] nucleotide_pos = {first_input_string, second_input_string};
          all_align.add(nucleotide_pos);
        }
      }
      else if (row > 0 && col == 0) {
        // take all of the remaining letters in the row and pair them with a dash
        // which represents a deletion/mutation
        // using a for-loop to get all of the "insertion's" in input1
        for (int input1_row = row; input1_row >= 0; input1_row--) {
          first_input_string = "-";
          second_input_string = str(input2.charAt(input1_row));
          String[] new_nucleotide_pos = {first_input_string, second_input_string};
          all_align.add(new_nucleotide_pos);
        }
      }
      // it is like a free ride situation in merge sort of insertion sort! (wanted this point to stand out!)
      // all of the rest of the nucleotides left over in one string
      // are either insertions to one string or deletions to the other
    }
    else {
      if ((input1.charAt(col))== input2.charAt(row)) {
        // the means that there is an alignment between these two bases, it needs to be preserved
        all_align = align_list_rec(row-1, col-1); 
        String first_input_string = str(input1.charAt(col));
        String second_input_string = str(input2.charAt(row));
        String[] position_letters = {first_input_string, second_input_string};
        all_align.add(position_letters);
      }
      else {
        int minimum_case = min(distances[row-1][col], distances[row][col-1], distances[row-1][col-1]);
        // NOTE: in the case where two or more of these values are the same, it has been proven that it does not matter which one of these that is chosen,
        // The amount_of_alignments is the same, it just means that the alignment combination is a little bit different
        
        // As a matter of preference, I have chosen to make a swap (respresenting a base pair substitution mutation in the DNA) the case that is chosen
        // when there are more than one possibilties. 
        // The is a matter of preference, since a base pair substituion looks better on the UI than a deletion or insertion
        
        if (minimum_case == distances[row-1][col-1]) {
          // this is the case for a "swap" mutation
          all_align = align_list_rec(row-1, col-1); 
          String first_input_string = str(input1.charAt(col));
          String second_input_string = str(input2.charAt(row));
          String[] position_letters = {first_input_string, second_input_string};
          all_align.add(position_letters);
        }
        else if (minimum_case == distances[row-1][col]) {
          // this is the case for a "insertion" mutation for input2
          // otherwise known as a "deletion" mutation for input1
          all_align = align_list_rec(row-1, col); 
          String first_input_string = "-";
          String second_input_string = str(input2.charAt(row));
          String[] position_letters = {first_input_string, second_input_string};
          all_align.add(position_letters);
        }
        else if (minimum_case == distances[row][col-1]) {
          // this is the case for a "deletion" mutation for input2
          // otherwise known as an "insertion" mutation for input1
          all_align = align_list_rec(row, col-1); 
          String first_input_string = str(input1.charAt(col));
          String second_input_string = "-";
          String[] position_letters = {first_input_string, second_input_string};
          all_align.add(position_letters);
        }        
      }
    }
    return all_align;
  }
  
  // a new function very similar to the recursive one was coded due to the fact that it is more efficient than the recursive function and can deal with File Sizes
  // of 3 KB and up
  
  // if a user, for example, was to enter a file size around 5 KB, which is pretty reasonable for an allele of a gene, the program would still give them a good answer
  
  // the recursive algorithm could only deal with text file sizes of around 1.5 KB at its best
  
  // recursive algorithms rely on Stack Memory which tends to be a fraction of what the entire memory of the computer is
  // this can lead to what appeared to be a StackOverflowError() in the debugging process
  
  // to prevent the use of Stack Memory, not using recursion, but rather using a for-loop is the solution
  // the for-loop iterates through every index pair of the two strings to determine an alignment outcome (either same base, base pair substitution, deletion, or insertion)
  
  ArrayList<String[]> align_list_non_rec(int row, int col) {
    ArrayList<String[]> all_align = new ArrayList<String[]>();
    while (row >= 0 || col >= 0) {
            //println("entered align_list for row " + row + " and col " + col);
            //delay(5000);
      if (row < 0 || col < 0) {
        if (row < 0) {
          // using a for-loop to get all of the "insertion's" in input2
          for (int column = col; column >= 0; column--) {
            String first_input_string = str(input1.charAt(column));
            String second_input_string = "-";
            String[] nucleotide_pos = {first_input_string, second_input_string};
            all_align.add(nucleotide_pos);
          }
        }
        else { // col < 0
          // using a for-loop to get all of the "insertion's" in input1
          for (int input1_row = row; input1_row >= 0; input1_row--) {
            String first_input_string = "-";
            String second_input_string = str(input2.charAt(input1_row));
            String[] new_nucleotide_pos = {first_input_string, second_input_string};
            all_align.add(new_nucleotide_pos);
          }
        }
        // it is like a free ride situation in merge sort of insertion sort! (wanted this point to stand out!)
        // all of the rest of the nucleotides left over in one string
        // are either insertions to one string or deletions to the other
        row = -1;
        col = -1;
      }
      else {
        if ((input1.charAt(col))== input2.charAt(row)) {
          String first_input_string = str(input1.charAt(col));
          String second_input_string = str(input2.charAt(row));
          String[] position_letters = {first_input_string, second_input_string};
          all_align.add(position_letters);
          row--;
          col--;
        }
        else {
          int a = MAX_INT;
          int b = MAX_INT;
          int c = MAX_INT;
          if (row > 0 && col > 0) { a = distances[row-1][col-1]; }
          if (row > 0) { b = distances[row-1][col]; }
          if (col > 0) { c = distances[row][col-1]; }
          int minimum_case = min(a, b, c);
          // NOTE: in the case where two or more of these values are the same, it has been proven that it does not matter which one of these that is chosen,
          // The amount_of_alignments is the same, it just means that the alignment combination is a little bit different
          
          // As a matter of preference, I have chosen to make a swap (respresenting a base pair substitution mutation in the DNA) the case that is chosen
          // when there are more than one possibilties. 
          // The is a matter of preference, since a base pair substituion looks better on the UI than a deletion or insertion
          
          if (minimum_case == MAX_INT || (row > 0 && col > 0 && minimum_case == distances[row-1][col-1])) {
            // this is the case for a "swap" mutation
            String first_input_string = str(input1.charAt(col));
            String second_input_string = str(input2.charAt(row));
            String[] position_letters = {first_input_string, second_input_string};
            all_align.add(position_letters);
            row--;
            col--;
          }
          else if (row > 0 && minimum_case == distances[row-1][col]) {
            // this is the case for a "insertion" mutation for input2
            // otherwise known as a "deletion" mutation for input1
            String first_input_string = "-";
            String second_input_string = str(input2.charAt(row));
            String[] position_letters = {first_input_string, second_input_string};
            all_align.add(position_letters);
            row--;
          }
          else if (col > 0 && minimum_case == distances[row][col-1]) {
            // this is the case for a "deletion" mutation for input2
            // otherwise known as an "insertion" mutation for input1
            String first_input_string = str(input1.charAt(col));
            String second_input_string = "-";
            String[] position_letters = {first_input_string, second_input_string};
            all_align.add(position_letters);
            col--;
          }        
        }
      }
    }
    ArrayList<String[]> all_align_rev = new ArrayList<String[]>();
    for (int ind = all_align.size() - 1; ind >= 0; ind--) {
      all_align_rev.add(all_align.get(ind));
    }
    return all_align_rev; // the "rev" stands for reversed
    // the alignment that is meant to be last is actually at the start since the loop process began from the lastmost index of the Levenshtein grid
    // this means that this alignment would be the first in the UI alignment list that the function creates
    // getting the exact reverse order of the alignment of this function fixes the problem
  }
  
  
  String[] account_fillers(ArrayList<String[]> pair_alignments) {
    // this function has the goal of modifying hte two original gene strings
    // to make them in accordance with the pair_alignments that have been derived using the algorithm above (i.e. backtracking from the lastmost to the firstmost element of the Levenshtein grid)
    String string1return = "";
    String string2return = "";
    
    for (String[] pair_aligned: pair_alignments) {
      string1return += pair_aligned[0];
      string2return += pair_aligned[1];
    }
    
    String[] gene_pair = {string1return, string2return};
    return gene_pair;
  }
  
  boolean isEqual(float a, float b) {
    // this is useful in float comparisons
    if (Math.abs(a - b) < 0.001) {
      return true;
    }
    return false;
  }
  
  void display_alignment(String[] gene_pair) {
    // this forms the bulk of the Gene class
    // it is the function that displays the visuals and codes for the zoom of the gene alignment
    
    int margin = 20; // this is the margin for the gene alignment
    // adding margins allows for better UI
    
    
    String Gene1 = gene_pair[0];
    String Gene2 = gene_pair[1];
    
    // this is the width of every nucleotide
    nucleotide_width = (zoomFactor*float(width-2*margin))/((max(Gene1.length(), Gene2.length())));
    
    float prev_nucleotide_width = (prev_zoom*float(width-2*margin))/((max(Gene1.length(), Gene2.length())));
    
    // the two following if-statements are for making ensuring easy zooming on the endings of the DNA sequences:
    if ((X_of_mouse < float(margin)) && (isEqual(shiftFactor+margin+x_translate, margin) )) {
      X_of_mouse = 0;
    }
    
    if ((X_of_mouse > float(width - margin)) && (isEqual(shiftFactor+margin+(Gene2.length())*prev_nucleotide_width+x_translate, width-margin) )) {
      // this is to detect a special case where the mouse is in a white space to the right of the sequence
      // this prevents the white space from being zoomed in on by manually adjusting the mouse coordinates to prevent the shift to the left happening 
      // (when the user already has access to the leftmost point of the sequence, why should they need to shift left anymore)
      X_of_mouse = width;
      right_outside = true;
    }
    
    // these three calculations are done to determine how much the alignment needs to be translated in order for the mouse to stay zoomed in on the desired point of the user
    float orig_x = (X_of_mouse - x_translate) / prev_zoom;
    if (right_outside) {
      orig_x = width;
    }
    float new_x = orig_x * zoomFactor;
    x_translate = X_of_mouse - new_x; 
    
    
    // this chunk of code is for calculating the GUI slider limits
    // and x_translate special cases
    //println("this is shiftFactor: ", shiftFactor);
    //println("this is x_translate: ", x_translate);
    float x_end_strip = (shiftFactor+margin+(Gene2.length())*nucleotide_width+x_translate);
    float x_beg_strip = (shiftFactor+margin+x_translate);
    
    if (x_beg_strip > 0 && x_beg_strip <= margin) {
      // the lower_limit is zero using the following equation
      lower_limit = 0;
    }
    if (x_end_strip >= width-margin && x_end_strip < width) {
      //upper_limit is the distance between the x_end_strip and the end wall of the canvas
      upper_limit = 0; 
    }
    if (shiftFactor+margin+(Gene2.length())*nucleotide_width+x_translate <= width-margin) {
      //println("Hello");
      
      x_translate = (width-margin)-(shiftFactor+margin+(Gene2.length())*nucleotide_width);
    }
    
    if (shiftFactor+margin+(0)*nucleotide_width+x_translate >= margin) {
      x_translate = margin-(shiftFactor+margin+0*nucleotide_width);
    }
    
    x_end_strip = (shiftFactor+margin+(Gene2.length())*nucleotide_width+x_translate);
    x_beg_strip = (shiftFactor+margin+x_translate);
    
    if (x_beg_strip <= margin && x_end_strip >= width-margin) {
      // if you cannot explore the entire left side of the gene due to the fact that -300.0 will cause x_beg_strip to pass the margin,  
      // then compute the difference between the margin and x_beg_strip
      lower_limit = (-(margin-x_beg_strip))/zoomFactor;
      upper_limit = (-((width-margin) - x_end_strip))/zoomFactor;
    }
    
    
  
    
    // if the zoomFactor has changed, then the slider in the GUI for shifting the alignment left and right, also needs to change
    if (prev_zoom!=zoomFactor) {
      float start_val = 0;
      cool_zoomFactor.setLimits(start_val, lower_limit, upper_limit);
    }
    
    if (zoomFactor == 1) {
      // when zoomFactor == 1, the alignment is in its most zoomed out state
      cool_zoomFactor.setValue(0);
      zoomFactor = 1;
      x_translate = 0;
      upper_limit = 0;
      lower_limit = 0;
      cool_zoomFactor.setLimits(0.0, 0.0, 0.0);
    }
    
    
    
    // Red identifies a mutation
    // Blue is for matches in the DNA Sequence
    
    // initially starts at the maximum zoomed out state
    
    stroke(0);
    strokeWeight(0); 
    // it does not matter which gene I choose since they both have the same length
    
    
    
    //dividing line between the two genes
    strokeWeight(2);
    line(0+margin, height/2, width-margin, height/2);
    strokeWeight(0);
    
    
    // for loop to draw the rectangles for the second gene
    for (int base_num = 0; base_num < Gene2.length(); base_num++) {
      // if-statement to determine the appropriate fill based on the alignment of the two characters at the given base number in the two genes (
      // these strings are of equal length now, since the program has aligned them properly
      if (Gene2.charAt(base_num) == (Gene1.charAt(base_num))) {
        fill(0, 100, 100);
      }
      else {
        fill(255, 0, 0);
      }
      
      // drawing the rectangles at the top and bottom of every point needed along the dividing line
      float x_top_rect = shiftFactor+margin+base_num*nucleotide_width;
      x_top_rect += x_translate;
      float x_bottom_rect = shiftFactor+margin+base_num*nucleotide_width;
      x_bottom_rect += x_translate;
      rect(x_top_rect, height/2-50, nucleotide_width, 50);
      rect(x_bottom_rect, height/2, nucleotide_width, 50);
      textSize(25);
      fill(0, 0, 0);
      if (int(nucleotide_width) >= 35) {
        // if the alignment has been zoomed enough (the degree of zooms obviously varies depending on how many bases the alignment has,)
        // letters are drawn representing the status of every cell in the alignment grid
        String other_base_letter = str(Gene1.charAt(base_num));
        float x_top_base = shiftFactor+margin+nucleotide_width*(float(base_num)+0.35);
        x_top_base += x_translate;
        text(other_base_letter, x_top_base, height/2 - 15);
        String base_letter = str(Gene2.charAt(base_num));
        float x_bottom_base = shiftFactor+margin+nucleotide_width*(float(base_num)+0.35);
        x_bottom_base += x_translate;
        text(base_letter, x_bottom_base, height/2 + 35);
      }
    }
    prev_zoom = zoomFactor;
    resolved = true;
    right_outside = false;
  }
}
