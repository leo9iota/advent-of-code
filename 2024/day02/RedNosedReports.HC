U0 ParseTextFile(U8 *filename)
{
  I64 size = 0;
  U8 *buffer = FileRead(filename, &size);
  
  if (!buffer) {
    "Error: Could not read file %s\n", filename;
    return;
  }
  
  U8 *line = buffer;
  U8 *next_line;
  I64 line_num = 0;
  
  while (line && *line) {
    line_num++;
    next_line = StrFirstOcc(line, "\n");
    
    if (next_line) {
      *next_line = 0; // Null-terminate this line
      next_line++; // Move to start of next line
    }
    
    "Line %d: %s\n", line_num, line;
    
    line = next_line;
  }
  
  Free(buffer);
}

U0 Main()
{
  ParseTextFile("./red-nosed-reports-input");
}