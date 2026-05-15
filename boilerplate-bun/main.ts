const VERSION = "1.0.0";

function printHelp(): void {
    console.log("boilerplate-cli - A CLI tool for testing binary sizes");
    console.log("");
    console.log("Usage:");
    console.log("  boilerplate-cli <command> [options]");
    console.log("");
    console.log("Commands:");
    console.log("  greet      Greet someone by name");
    console.log("  version    Show version information");
    console.log("  help       Show this help message");
    console.log("");
    console.log("Greet Options:");
    console.log("  --name string   Name to greet (default \"World\")");
    console.log("  --upper         Uppercase the greeting");
    console.log("  --excited       Add exclamation marks");
    console.log("");
    console.log("Examples:");
    console.log("  boilerplate-cli greet");
    console.log("  boilerplate-cli greet --name Alice");
    console.log("  boilerplate-cli greet --name Bob --upper --excited");
    console.log("  boilerplate-cli version");
}

function handleVersion(): void {
    console.log(`boilerplate-cli v${VERSION}`);
}

function handleGreet(args: string[]): void {
    let name = "World";
    let uppercase = false;
    let excited = false;

    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        if (arg === "--name" || arg === "-name") {
            if (i + 1 < args.length) {
                name = args[i + 1];
                i++;
            } else {
                console.error("--name requires a value");
                process.exit(1);
            }
        } else if (arg === "--upper" || arg === "-upper") {
            uppercase = true;
        } else if (arg === "--excited" || arg === "-excited") {
            excited = true;
        } else if (arg.startsWith("--name=") || arg.startsWith("-name=")) {
            const parts = arg.split("=");
            if (parts.length === 2) {
                name = parts[1];
            }
        }
    }

    let greeting = `Hello, ${name}`;
    if (uppercase) {
        greeting = greeting.toUpperCase();
    }
    if (excited) {
        greeting += "!";
    }

    console.log(greeting);
}

function main(): void {
    const args = process.argv.slice(2);

    if (args.length < 1) {
        printHelp();
        process.exit(1);
    }

    const command = args[0];

    switch (command) {
        case "greet":
            handleGreet(args.slice(1));
            break;
        case "version":
            handleVersion();
            break;
        case "help":
        case "--help":
        case "-h":
            printHelp();
            break;
        default:
            console.error(`Unknown command: ${command}`);
            printHelp();
            process.exit(1);
    }
}

main();
