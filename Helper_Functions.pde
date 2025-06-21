String to_String(String[] String_Array) {
  // this function is useful for when converting the String array loaded from textfiles into Strings that can be used in other parts of the program
  String return_str = "";
  for (int index = 0; index < String_Array.length; index++) {
      return_str += String_Array[index].trim();
    }
  
  return return_str;
}
