U0 ParseTextFile(U8 *filename)
{
  CDoc *doc = NULL;
  U8 *buf = NULL;
  I64 file_size;

  // Try to open and read the file
  try {
    // Read entire file into a buffer
    buf = FileRead(filename, &file_size);
    if (!buf) {
      Print("Error: Could not read file '%s'\n", filename);
      return;
    }

    // Create a new document to process the file content
    doc = DocNew;
    DocPrint(doc, "%s", buf); // Load buffer into document

    // Process the file line by line
    CDocEntry *doc_e = doc->head.next;
    while (doc_e != doc) {
      if (doc_e->type_u8 == DOCT_TEXT) {
        // Process each line here
        Print("Line: %s\n", doc_e->tag);
        
        // Example: Split by spaces
        U8 *token;
        token = StrFirstOcc(doc_e->tag, " ");
        if (token) {
          *token = 0; // Null terminate at space
          Print("First word: %s\n", doc_e->tag);
          Print("Rest: %s\n", token + 1);
        }
      }
      doc_e = doc_e->next;
    }

  } catch {
    Print("Error occurred: %s\n", Fs->except_callers[0]);
  }

  // Clean up resources
  if (buf) Free(buf);
  if (doc) DocDel(doc);
}

U0 Main()
{
  // Example usage - assuming text file is named "example.txt"
  ParseTextFile("example.txt");
}