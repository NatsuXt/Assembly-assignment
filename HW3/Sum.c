#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    int sum = 0;
    int length = atoi(argv[1]);
    for (int i = 0; i <= length; i++) {
        sum += i;
    }
    printf("%d", sum);
    return 0;
}
