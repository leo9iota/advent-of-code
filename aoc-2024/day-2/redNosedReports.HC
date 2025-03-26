U0 ParseFile(U8 *filename, U0 (*process_line)(U8 *line))
{
  I64 file_size = 0;
  U8 *buffer = FileRead(filename, &file_size);
  
  if (!buffer) {
    "Error: Failed to read file %s\n", filename;
    return;
  }
  
  // Parse file line by line
  U8 *line_start = buffer;
  U8 *line_end;
  U8 temp_char;
  
  while (line_start < buffer + file_size) {
    // Find end of line
    line_end = StrFirstOcc(line_start, "\n");
    if (!line_end) 
      line_end = buffer + file_size; // Last line might not have newline
    
    // Temporarily null-terminate this line
    temp_char = *line_end;
    *line_end = 0;
    
    // Process the line using the callback function
    process_line(line_start);
    
    // Restore character and move to next line
    *line_end = temp_char;
    line_start = line_end + 1;
  }
  
  Free(buffer);
}

// Example usage with a callback function
U0 PrintLine(U8 *line)
{
  "%s\n", line;
}

U0 CountNumbers(U8 *line)
{
  I64 count = 0;
  I64 i = 0;
  
  while (line[i]) {
    if ('0' <= line[i] && line[i] <= '9')
      count++;
    i++;
  }
  
  "Line contains %d numbers\n", count;
}

U0 Main() 
{
  "Parsing file and printing lines:\n";
  ParseFile("./input.txt", &PrintLine);
  
  "Parsing file and counting numbers in each line:\n";
  ParseFile("./input.txt", &CountNumbers);
}