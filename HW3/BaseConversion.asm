.LC0:
        .base64 "PT09IOi/m+WItui9rOaNoueoi+W6jyA9PT0A"
        ; "=== 进制转换 ==="

.LC1:
        .base64 "MS4gMTbov5vliLYg4oaSIDEw6L+b5Yi2AA=="
        ; "1. 16进制 转 10进制"

.LC2:
        .base64 "Mi4gMTDov5vliLYg4oaSIDE26L+b5Yi2AA=="
        ; "2. 10进制 转 16进制"

.LC3:
        .base64 "6K+36YCJ5oup5Yqf6IO9KDEvMik6IAA="
        ; "请选择功能(1/2): "

.LC4:
        .string "%d"
        ; scanf 输入整数格式

.LC5:
        .base64 "6K+36L6T5YWlMX4y5L2NMTbov5vliLbmlbDvvIjlpoIgMUEg5oiWIGZm77yJ77yaAA=="
        ; "请输入一个16进制数(以0x开头)："

.LC6:
        .string "%2s"
        ; 输入字符串（两字符）

.LC7:
        .string "%x"
        ; 解析十六进制格式

.LC8:
        .base64 "5a+55bqU55qE5Y2B6L+b5Yi25pWw5piv77yaJXUKAA=="
        ; "该数的十进制为: %d\n"

.LC9:
        .base64 "6K+36L6T5YWl5Y2B6L+b5Yi25pWw77yIMH4yNTXvvInvvJoA"
        ; "请输入一个10进制数(0~255)："

.LC10:
        .string "%u"
        ; 输入无符号整数

.LC11:
        .base64 "6L6T5YWl6LaF5Ye66IyD5Zu077yBAA=="
        ; "输入超出范围！"

.LC12:
        .base64 "5a+55bqU55qEMTbov5vliLbmlbDmmK/vvJolWAoA"
        ; "该数的16进制为: %X\n"

.LC13:
        .base64 "6L6T5YWl6ZSZ6K+v77yBAA=="
        ; "输入错误！"
        
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        ; 建立栈帧，分配32字节局部空间

        ; 打印菜单
        mov     edi, OFFSET FLAT:.LC0
        call    puts
        mov     edi, OFFSET FLAT:.LC1
        call    puts
        mov     edi, OFFSET FLAT:.LC2
        call    puts
        mov     edi, OFFSET FLAT:.LC3
        call    puts

        ; 读取选择
        lea     rax, [rbp-4]        ; 保存用户选择的位置
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC4
        mov     eax, 0
        call    __isoc99_scanf      ; scanf("%d", &choice)

        mov     eax, DWORD PTR [rbp-4]  ; eax = choice
        cmp     eax, 1
        jne     .L2                  ; if(choice != 1) goto L2

        ; ---------- 选择 1：16进制转10进制 ----------
        mov     edi, OFFSET FLAT:.LC5
        call    puts                 ; 提示输入16进制数

        lea     rax, [rbp-17]        ; 保存输入字符串
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC6 ; "%2s"
        mov     eax, 0
        call    __isoc99_scanf       ; scanf("%2s", buf)

        lea     rdx, [rbp-12]        ; 存储解析结果的整数地址
        lea     rax, [rbp-17]
        mov     esi, OFFSET FLAT:.LC7 ; "%x"
        mov     rdi, rax
        mov     eax, 0
        call    __isoc99_sscanf      ; sscanf(buf, "%x", &value)

        mov     eax, DWORD PTR [rbp-12]
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC8 ; "该数的十进制为: %d\n"
        mov     eax, 0
        call    printf
        jmp     .L3

.L2:
        mov     eax, DWORD PTR [rbp-4]
        cmp     eax, 2
        jne     .L4                  ; if(choice != 2) goto L4

        ; ---------- 选择 2：10进制转16进制 ----------
        mov     edi, OFFSET FLAT:.LC9
        call    puts                 ; 提示输入10进制数 (0~255)

        lea     rax, [rbp-8]
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC10 ; "%u"
        mov     eax, 0
        call    __isoc99_scanf       ; scanf("%u", &num)

        mov     eax, DWORD PTR [rbp-8]
        cmp     eax, 255
        jbe     .L5                  ; if(num <= 255) goto L5

        mov     edi, OFFSET FLAT:.LC11
        call    puts                 ; 否则提示超出范围
        mov     eax, 1
        jmp     .L7

.L5:
        mov     eax, DWORD PTR [rbp-8]
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC12 ; "该数的16进制为: %X\n"
        mov     eax, 0
        call    printf
        jmp     .L3

.L4:
        mov     edi, OFFSET FLAT:.LC13
        call    puts                 ; 输入错误！

.L3:
        mov     eax, 0               ; return 0
.L7:
        leave
        ret