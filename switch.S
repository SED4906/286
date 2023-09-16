load_user_gdt: ; limit in cx, base in al:di
    mov [GDT.user_cs], cx
    mov [GDT.user_ds], cx
    mov [GDT.user_cs+2], di
    mov [GDT.user_ds+2], di
    mov [GDT.user_cs+4], al
    mov [GDT.user_ds+4], al
ret