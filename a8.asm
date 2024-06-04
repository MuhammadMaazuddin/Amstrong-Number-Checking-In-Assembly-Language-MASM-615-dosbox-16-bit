.model small
.stack 100h
.data
    print db 'Enter the number and then press / : $'
    amstrong db 'The number is amstrong$'
    namstrong db 'The number is not amstrong$'
    digit_size db ?
    number db 10 DUP(0)
    numberInHexa dw 0
    new dw 0
.code
takeInput proc
    mov dx,offset print
    mov ah,9
    int 21h
    mov si,offset number
    mov ch,0
    mov cl,0
    INPUT_B:
    mov ah,1
    int 21h
    cmp al,2fh
    je L1
    cmp cl,0
    je LL1
    mov numberInHexa,dx
    LL1:
    mov ah,0
    push ax
    sub al,30h
    mov [si],al
    add numberInHexa,ax
    mov ax,numberInHexa
    mov bx,10
    mul bx
    mov dx,ax
    pop ax
    inc si
    inc ch
    inc cl
    jmp INPUT_B
     L1:
    mov digit_size,ch
    ret
takeInput endp
AMSTRONGcHECKER proc
    mov si,offset number
    mov bl,digit_size
    OUTER:
    cmp bl,0
    je L2
    mov dl,[si]
    mov dh,0
    mov al,[si]
    mov ah,0
    push dx
    mov cl,digit_size
    dec cl
    INNER:
    cmp cl,0
    je L3
    mov al,[si]
    pop dx
    mul dx
    push ax
    dec cl
    jmp INNER
    L3:
    pop ax
    add [new],ax
    inc si
    dec bl
    jmp OUTER
    L2:
    mov dl,10
    mov ah,2
    int 21h
    mov ax,new
    cmp numberInHexa,ax
    je EQUAL
    mov dx,offset namstrong
    mov ah,9
    int 21h
    jmp exit
    EQUAL:
    mov dx,offset amstrong
    mov ah,9
    int 21h
    exit:
    ret
AMSTRONGcHECKER endp
main proc
    mov ax,@data
    mov ds,ax
    call takeInput
    call AMSTRONGcHECKER
    mov ah,4ch
    int 21h
main endp
end main


