class Gene {
  
  String input1;
  String input2;
  
  Gene() {}
  
  int amount_of_alignments(String input1, String input2) {
    // Levenstein distance - Program 
    // Input: two strings
    // Output: integer that represents the degree of similarity
    String string1 = input1;
    String string2 = input2;
    
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
  
  ArrayList<String> align_list(int row, int col) {
  if (row == 0 || col == 0) {
  
  }  
  String[] genes_aligned = {};
    
    genes_aligned = append(genes_aligned, );
    return genes_aligned
  
  }
}
