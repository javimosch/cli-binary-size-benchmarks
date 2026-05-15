use std::env;
use std::io::{self, Write};

const VERSION: &str = "1.0.0";

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        print_help();
        std::process::exit(1);
    }

    let command = &args[1];

    match command.as_str() {
        "greet" => handle_greet(&args[2..]),
        "version" => handle_version(),
        "help" | "--help" | "-h" => print_help(),
        _ => {
            eprintln!("Unknown command: {}", command);
            print_help();
            std::process::exit(1);
        }
    }
}

fn handle_greet(args: &[String]) {
    let mut name = "World".to_string();
    let mut uppercase = false;
    let mut excited = false;

    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--name" | "-name" => {
                if i + 1 < args.len() {
                    name = args[i + 1].clone();
                    i += 2;
                } else {
                    eprintln!("--name requires a value");
                    std::process::exit(1);
                }
            }
            "--upper" | "-upper" => {
                uppercase = true;
                i += 1;
            }
            "--excited" | "-excited" => {
                excited = true;
                i += 1;
            }
            arg => {
                // Try to parse as -name=value format
                if arg.starts_with("--name=") || arg.starts_with("-name=") {
                    let parts: Vec<&str> = arg.splitn(2, '=').collect();
                    if parts.len() == 2 {
                        name = parts[1].to_string();
                    }
                }
                i += 1;
            }
        }
    }

    let mut greeting = format!("Hello, {}", name);
    if uppercase {
        greeting = greeting.to_uppercase();
    }
    if excited {
        greeting.push('!');
    }

    println!("{}", greeting);
}

fn handle_version() {
    println!("boilerplate-cli v{}", VERSION);
}

fn print_help() {
    println!("boilerplate-cli - A CLI tool for testing binary sizes");
    println!();
    println!("Usage:");
    println!("  boilerplate-cli <command> [options]");
    println!();
    println!("Commands:");
    println!("  greet      Greet someone by name");
    println!("  version    Show version information");
    println!("  help       Show this help message");
    println!();
    println!("Greet Options:");
    println!("  --name string   Name to greet (default \"World\")");
    println!("  --upper         Uppercase the greeting");
    println!("  --excited       Add exclamation marks");
    println!();
    println!("Examples:");
    println!("  boilerplate-cli greet");
    println!("  boilerplate-cli greet --name Alice");
    println!("  boilerplate-cli greet --name Bob --upper --excited");
    println!("  boilerplate-cli version");
}
