U0 Main() {
  U8 *filename = "red-nosed-reports-input.txt";
  U8 *buffer;
  I64 file_size;

  // Read the entire file into a buffer
  buffer = FileRead(filename, &file_size);
  if (!buffer) {
    Print("Error: Could not open file %s\n", filename);
    return;
  }

  // Print the file contents
  Print("File contents:\n%s\n", buffer);

  // Simple parsing: count lines
  I64 line_count = 0;
  U8 *ptr = buffer;
  while (*ptr) {
    if (*ptr == '\n') {
      line_count++;
    }
    ptr++;
  }
  Print("Number of lines: %d\n", line_count);

  // Free the buffer
  Free(buffer);
}

// Invoke Main function
Main;