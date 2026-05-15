#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define VERSION "1.0.0"

void print_help() {
    printf("boilerplate-cli - A CLI tool for testing binary sizes\n");
    printf("\n");
    printf("Usage:\n");
    printf("  boilerplate-cli <command> [options]\n");
    printf("\n");
    printf("Commands:\n");
    printf("  greet      Greet someone by name\n");
    printf("  version    Show version information\n");
    printf("  help       Show this help message\n");
    printf("\n");
    printf("Greet Options:\n");
    printf("  --name string   Name to greet (default \"World\")\n");
    printf("  --upper         Uppercase the greeting\n");
    printf("  --excited       Add exclamation marks\n");
    printf("\n");
    printf("Examples:\n");
    printf("  boilerplate-cli greet\n");
    printf("  boilerplate-cli greet --name Alice\n");
    printf("  boilerplate-cli greet --name Bob --upper --excited\n");
    printf("  boilerplate-cli version\n");
}

void handle_version() {
    printf("boilerplate-cli v%s\n", VERSION);
}

void handle_greet(int argc, char *argv[]) {
    char *name = "World";
    int uppercase = 0;
    int excited = 0;

    for (int i = 0; i < argc; i++) {
        if (strcmp(argv[i], "--name") == 0 || strcmp(argv[i], "-name") == 0) {
            if (i + 1 < argc) {
                name = argv[i + 1];
                i++;
            } else {
                fprintf(stderr, "--name requires a value\n");
                exit(1);
            }
        } else if (strcmp(argv[i], "--upper") == 0 || strcmp(argv[i], "-upper") == 0) {
            uppercase = 1;
        } else if (strcmp(argv[i], "--excited") == 0 || strcmp(argv[i], "-excited") == 0) {
            excited = 1;
        } else if (strncmp(argv[i], "--name=", 7) == 0 || strncmp(argv[i], "-name=", 6) == 0) {
            char *eq = strchr(argv[i], '=');
            if (eq != NULL) {
                name = eq + 1;
            }
        }
    }

    char greeting[256];
    snprintf(greeting, sizeof(greeting), "Hello, %s", name);

    if (uppercase) {
        for (int i = 0; greeting[i]; i++) {
            greeting[i] = toupper(greeting[i]);
        }
    }

    if (excited) {
        strcat(greeting, "!");
    }

    printf("%s\n", greeting);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        print_help();
        return 1;
    }

    const char *command = argv[1];

    if (strcmp(command, "greet") == 0) {
        handle_greet(argc - 2, argv + 2);
    } else if (strcmp(command, "version") == 0) {
        handle_version();
    } else if (strcmp(command, "help") == 0 || strcmp(command, "--help") == 0 || strcmp(command, "-h") == 0) {
        print_help();
    } else {
        fprintf(stderr, "Unknown command: %s\n", command);
        print_help();
        return 1;
    }

    return 0;
}
