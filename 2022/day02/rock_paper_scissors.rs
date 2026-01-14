use std::{env, fs, process};

fn main() {
    let path = env::args()
        .nth(1)
        .unwrap_or_else(|| "input.txt".to_string());

    match fs::read_to_string(&path) {
        Ok(contents) => print!("{}", contents),
        Err(e) => {
            eprint!("Failed to read {}: {}", path, e);
            process::exit(1);
        }
    }
}
