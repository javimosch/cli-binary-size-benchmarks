package main

import (
	"flag"
	"fmt"
	"os"
	"strings"
)

const Version = "1.0.0"

func main() {
	if len(os.Args) < 2 {
		printHelp()
		os.Exit(1)
	}

	command := os.Args[1]

	switch command {
	case "greet":
		handleGreet()
	case "version":
		handleVersion()
	case "help", "--help", "-h":
		printHelp()
	default:
		fmt.Fprintf(os.Stderr, "Unknown command: %s\n", command)
		printHelp()
		os.Exit(1)
	}
}

func handleGreet() {
	greetCmd := flag.NewFlagSet("greet", flag.ExitOnError)
	name := greetCmd.String("name", "World", "Name to greet")
	uppercase := greetCmd.Bool("upper", false, "Uppercase the greeting")
	excited := greetCmd.Bool("excited", false, "Add exclamation marks")

	greetCmd.Parse(os.Args[2:])

	greeting := fmt.Sprintf("Hello, %s", *name)
	if *uppercase {
		greeting = strings.ToUpper(greeting)
	}
	if *excited {
		greeting += "!"
	}

	fmt.Println(greeting)
}

func handleVersion() {
	fmt.Printf("boilerplate-cli v%s\n", Version)
}

func printHelp() {
	fmt.Println("boilerplate-cli - A CLI tool for testing binary sizes")
	fmt.Println()
	fmt.Println("Usage:")
	fmt.Println("  boilerplate-cli <command> [options]")
	fmt.Println()
	fmt.Println("Commands:")
	fmt.Println("  greet      Greet someone by name")
	fmt.Println("  version    Show version information")
	fmt.Println("  help       Show this help message")
	fmt.Println()
	fmt.Println("Greet Options:")
	fmt.Println("  -name string   Name to greet (default \"World\")")
	fmt.Println("  -upper         Uppercase the greeting")
	fmt.Println("  -excited       Add exclamation marks")
	fmt.Println()
	fmt.Println("Examples:")
	fmt.Println("  boilerplate-cli greet")
	fmt.Println("  boilerplate-cli greet -name Alice")
	fmt.Println("  boilerplate-cli greet -name Bob -upper -excited")
	fmt.Println("  boilerplate-cli version")
}
