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
    
    //printArray(distances[0]);
    
    //delay(10000);
    // Algorithm to calculate the rest of the numbers in the nested array using the filled-in values for the top row and leftmost column
    for (int row_num = 1; row_num <= string2.length(); row_num++) {
      for (int col_num = 1; col_num <= string1.length(); col_num++) {
        if (string2.charAt(row_num-1) == string1.charAt(col_num-1)) { 
          //println("entered");
          distances[row_num][col_num] = min(distances[row_num-1][col_num-1], distances[row_num-1][col_num]+1, distances[row_num][col_num-1]+1);
          if (distances[row_num][col_num] == 1) {
            //println("this is row_num: ", row_num);
            //println("this is col_num: ", col_num);
            //delay(1000000000);
          }
        }
        else {
          //println("this is row_num: ", row_num);
          //println("this is col_num: ", col_num);
          //println("character at 1st string: ", string2.charAt(row_num-1));
          //println("character at 2nd string: ", string1.charAt(col_num-1));
          //println("above: ", distances[row_num-1][col_num]);
          //println("side: ", distances[row_num][col_num-1]);
          //println("diagonal", distances[row_num-1][col_num-1]);
          distances[row_num][col_num] = min(distances[row_num-1][col_num], distances[row_num][col_num-1], distances[row_num-1][col_num-1]) + 1;
        }
      }
      //printArray(distances[row_num]);
    }
    
    int alignment_amount = (distances[string2.length()][string1.length()]);
    //println("this is alignment_amount: ", alignment_amount);
    return alignment_amount;
  }
  
  ArrayList<String[]> align_list(int row, int col) {
    ArrayList<String[]> all_align = new ArrayList<String[]>();
    if (row == 0 || col == 0) {
      String first_input_string = str(input1.charAt(col));
      String second_input_string = str(input2.charAt(row));
      String[] position_letters = {first_input_string, second_input_string};
      all_align.add(position_letters);
      if (row == 0 && col == 0) {}
      else if (row == 0 && col > 0) {
        // using a for-loop to get all of the "insertion's" in input2
        for (int column = col; column >= 0; column--) {
          first_input_string = str(input1.charAt(column));
          second_input_string = str(input2.charAt(row));
          String[] nucleotide_pos = {first_input_string, second_input_string};
          all_align.add(nucleotide_pos);
        }
      }
      else if (row > 0 && col == 0) {
        // using a for-loop to get all of the "insertion's" in input1
        for (int input1_row = row; input1_row >= 0; input1_row--) {
          first_input_string = str(input1.charAt(col));
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
        all_align = align_list(row-1, col-1); 
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
          all_align = align_list(row-1, col-1); 
          String first_input_string = str(input1.charAt(col));
          String second_input_string = str(input2.charAt(row));
          String[] position_letters = {first_input_string, second_input_string};
          all_align.add(position_letters);
        }
        else if (minimum_case == distances[row-1][col]) {
          // this is the case for a "insertion" mutation for input2
          // otherwise known as a "deletion" mutation for input1
          all_align = align_list(row-1, col); 
          String first_input_string = "-";
          String second_input_string = str(input2.charAt(row));
          String[] position_letters = {first_input_string, second_input_string};
          all_align.add(position_letters);
        }
        else if (minimum_case == distances[row][col-1]) {
          // this is the case for a "deletion" mutation for input2
          // otherwise known as an "insertion" mutation for input1
          all_align = align_list(row, col-1); 
          String first_input_string = str(input1.charAt(col));
          String second_input_string = "-";
          String[] position_letters = {first_input_string, second_input_string};
          all_align.add(position_letters);
        }        
      }
    }
    return all_align;
  }
}
