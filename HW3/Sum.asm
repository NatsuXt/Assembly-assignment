.LC0:
        .string "%d"
        ; 常量字符串：printf 的格式 "%d"

main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        ; 标准函数前序：保存栈帧基址，分配32字节栈空间

        mov     DWORD PTR [rbp-20], edi
        mov     QWORD PTR [rbp-32], rsi
        ; 保存 main(int argc, char* argv[]) 的参数：
        ; edi = argc, rsi = argv

        mov     DWORD PTR [rbp-4], 0
        ; int sum = 0;

        mov     rax, QWORD PTR [rbp-32]
        add     rax, 8
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    atoi
        ; 取出 argv[1]（字符串参数），传给 atoi() 转成整数
        ; 即：length = atoi(argv[1]);

        mov     DWORD PTR [rbp-12], eax
        ; 保存返回值（length）

        mov     DWORD PTR [rbp-8], 0
        ; i = 0;

        jmp     .L2
        ; 跳转到循环条件检查部分

; ------------------- 循环体 -------------------
.L3:
        mov     eax, DWORD PTR [rbp-8]
        add     DWORD PTR [rbp-4], eax
        ; sum += i;

        add     DWORD PTR [rbp-8], 1
        ; i++;

; ------------------- 循环条件 -------------------
.L2:
        mov     eax, DWORD PTR [rbp-8]
        cmp     eax, DWORD PTR [rbp-12]
        jle     .L3
        ; if (i <= length) 继续循环
        ; 否则跳出循环

        mov     eax, DWORD PTR [rbp-4]
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    printf
        ; printf("%d", sum);

        mov     eax, 0
        leave
        ret
        ; return 0;
