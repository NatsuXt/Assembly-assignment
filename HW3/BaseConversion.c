#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int choice;
    unsigned int num; 
    unsigned int hexvalue; 

    printf("=== 进制转换程序 ===\n");
    printf("1. 16进制 → 10进制\n");
    printf("2. 10进制 → 16进制\n");
    printf("请选择功能(1/2): \n");
    scanf("%d", &choice);

    if (choice == 1) {
        char hex[5];
        printf("请输入1~2位16进制数（如 1A 或 ff）：\n");
        scanf("%2s", hex);

        sscanf(hex, "%x", &hexvalue);
        printf("对应的十进制数是：%u\n", hexvalue);
    } 
    else if (choice == 2) {
        printf("请输入十进制数（0~255）：\n");
        scanf("%u", &num);
        if (num > 255) {
            printf("输入超出范围！\n");
            return 1;
        }
        printf("对应的16进制数是：%X\n", num);
    } 
    else {
        printf("输入错误！\n");
    }

    return 0;
}
