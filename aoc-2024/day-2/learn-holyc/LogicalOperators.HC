U0 LogicalOperatorDemo() {
    Bool a = TRUE;
    Bool b = FALSE;
    
    if (a && b) {
        // This block will not execute
    }
    
    if (a || b) {
        // This block will execute because 'a' is TRUE
    }
    
    Bool result = !(a && b);  // Negation example
}