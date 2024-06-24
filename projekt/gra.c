#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ROCK 1
#define PAPER 2
#define SCISSORS 3

int main() {
    int user_choice, computer_choice;

    printf("1. Kamien\n");
    printf("2. Papier\n");
    printf("3. Scyzoryk\n");
    printf("Wybierz przedmiot: ");

    
    if (scanf("%d", &user_choice) != 1 || user_choice < 1 || user_choice > 3) {
        printf("\nWybierz kamien, papier lub scyzoryk.\n");
        return 1;
    }

    srand(time(NULL));
    computer_choice = rand() % 3 + 1;

    if (user_choice == computer_choice) {
        printf("\nRemis, komputer wylosowal to samo.\n");
    } else {
        switch (user_choice) {
            case ROCK:
                if (computer_choice == PAPER) {
                    printf("\nKomputer wylosowal papier i wygral.\n");
                } else {
                    printf("\nKomputer wylosowal scyzoryk i przegral.\n");
                }
                break;
            case PAPER:
                if (computer_choice == SCISSORS) {
                    printf("\nKomputer wylosowal scyzoryk i wygral.\n");
                } else {
                    printf("\nKomputer wylosowal kamien i przegral.\n");
                }
                break;
            case SCISSORS:
                if (computer_choice == ROCK) {
                    printf("\nKomputer wylosowal kamien i wygral.\n");
                } else {
                    printf("\nKomputer wylosowal papier i przegral.\n");
                }
                break;
        }
    }

    return 0;
}
