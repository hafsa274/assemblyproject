; Hafsa Ayesha - Bookie Store
.model small
.stack 100h
.data



welcomeMsg db 0Ah, 0Dh, "=============================================", 0Ah, 0Dh
            db "*   WELCOME TO HAFSA AYESHA BOOKIE STORE    *", 0Ah, 0Dh
            db "=============================================", 0Ah, 0Dh, "$"

categoryMenu db 0Ah, 0Dh, "---------------------------------------------", 0Ah, 0Dh
             db "|         CHOOSE A BOOK CATEGORY             |", 0Ah, 0Dh
             db "---------------------------------------------", 0Ah, 0Dh
             db "1. Islamic Books", 0Ah, 0Dh
             db "2. English Books", 0Ah, 0Dh
             db "3. History Books", 0Ah, 0Dh
             db "4. Science Books", 0Ah, 0Dh
             db "5. Urdu Literature", 0Ah, 0Dh
             db "6. Exit", 0Ah, 0Dh, "$"

chooseCategoryPrompt db 0Ah, 0Dh, ">>> Enter your choice (1-6): $"
invalidChoiceMsg db 0Ah, 0Dh, "!!! Invalid choice! Please try again. !!!", 0Ah, 0Dh, "$"

chooseBookPrompt db 0Ah, 0Dh, "Select a book (1-3): $"
choosePaymentPrompt db 0Ah, 0Dh, "Choose payment method - 1. Cash  2. Card: $"
askAnotherBook db 0Ah, 0Dh, "Would you like to buy another book? (Y/N): $"
thankYouCash db 0Ah, 0Dh, "Payment successful via Cash! Thank you for your purchase!", 0Ah, 0Dh, "$"
thankYouCard db 0Ah, 0Dh, "Payment successful via Card! Thank you for your purchase!", 0Ah, 0Dh, "$"
goodbyeMsg db 0Ah, 0Dh, "*** Thank you for visiting Hafsa Ayesha Bookie Store! ***", 0Ah, 0Dh, "$"
totalBillMsg db 0Ah, 0Dh, "Your total bill is: $"    
cashMsg db 0Ah, 0Dh, "Rs.50 Cash on Delivery fee applied.", 0Ah, 0Dh, "$"

islamicBooks db 0Ah, 0Dh, "--- Islamic Books ---", 0Ah, 0Dh
             db "1. Quran - Rs.500", 0Ah, 0Dh
             db "2. Sahih Bukhari - Rs.600", 0Ah, 0Dh
             db "3. Riyad-us-Saliheen - Rs.550", 0Ah, 0Dh, "$"
englishBooks db 0Ah, 0Dh, "--- English Books ---", 0Ah, 0Dh
             db "1. To Kill a Mockingbird - Rs.400", 0Ah, 0Dh
             db "2. 1984 - Rs.450", 0Ah, 0Dh
             db "3. Pride and Prejudice - Rs.420", 0Ah, 0Dh, "$"
historyBooks db 0Ah, 0Dh, "--- History Books ---", 0Ah, 0Dh
             db "1. A People's History - Rs.480", 0Ah, 0Dh
             db "2. Guns, Germs, and Steel - Rs.500", 0Ah, 0Dh
             db "3. The Silk Roads - Rs.530", 0Ah, 0Dh, "$"
scienceBooks db 0Ah, 0Dh, "--- Science Books ---", 0Ah, 0Dh
             db "1. A Brief History of Time - Rs.470", 0Ah, 0Dh
             db "2. Cosmos - Rs.490", 0Ah, 0Dh
             db "3. The Selfish Gene - Rs.460", 0Ah, 0Dh, "$"
urduBooks db 0Ah, 0Dh, "--- Urdu Literature ---", 0Ah, 0Dh
          db "1. Peer-e-Kamil - Rs.410", 0Ah, 0Dh
          db "2. Aangan - Rs.430", 0Ah, 0Dh
          db "3. Udas Naslain - Rs.440", 0Ah, 0Dh, "$"

bookPrices dw 500,600,550, 400,450,420, 480,500,530, 470,490,460, 410,430,440

.code
main:
    mov ax, @data
    mov ds, ax
    xor cx, cx          ; total bill in CX

start:
    lea dx, welcomeMsg
    mov ah, 09h
    int 21h

repeatMenu:
menu:
    lea dx, categoryMenu
    mov ah, 09h
    int 21h

    lea dx, chooseCategoryPrompt
    mov ah, 09h
    int 21h

    mov ah, 01h ; read category
    int 21h
    sub al, '0'
    mov bl, al

    cmp bl, 1
    je islamic
    cmp bl, 2
    je english
    cmp bl, 3
    je history
    cmp bl, 4
    je science
    cmp bl, 5
    je urdu
    cmp bl, 6
    je exitApp

    lea dx, invalidChoiceMsg
    mov ah, 09h
    int 21h
    jmp menu

islamic:
    lea dx, islamicBooks
    mov si, 0
    call showBook
    jmp askAgain

english:
    lea dx, englishBooks
    mov si, 3
    call showBook
    jmp askAgain

history:
    lea dx, historyBooks
    mov si, 6
    call showBook
    jmp askAgain

science:
    lea dx, scienceBooks
    mov si, 9
    call showBook
    jmp askAgain

urdu:
    lea dx, urduBooks
    mov si, 12
    call showBook
    jmp askAgain

showBook:
    ; Show selected books
    mov ah, 09h
    int 21h

    ; Ask to select book
    lea dx, chooseBookPrompt
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h ; read book number
    sub al, '1'
    cbw
        add si, ax     ; total offset (0–14)
    mov bx, si
    shl bx, 1      ; multiply index by 2 (since each price is 2 bytes)
    mov ax, [bookPrices + bx]

    add cx, ax
    ret

askAgain:
    lea dx, askAnotherBook
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    cmp al, 'Y'
    je repeatMenu
    cmp al, 'y'
    je repeatMenu

    ; Ask payment method once after all books selected
    lea dx, choosePaymentPrompt
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h ; read payment type (1 or 2)
    cmp al, '1'
    je printCash
    cmp al, '2'
    je printCard
    jmp donePay


printCash:
    lea dx, cashMsg
    mov ah, 09h
    int 21h
    add cx, 50

    lea dx, thankYouCash
    mov ah, 09h
    int 21h
    jmp donePay
printCard:
    lea dx, thankYouCard
    mov ah, 09h
    int 21h
    jmp donePay

donePay:
    lea dx, totalBillMsg
    mov ah, 09h
    int 21h

    mov ax, cx
    call PrintNumber

exitApp:
    lea dx, goodbyeMsg
    mov ah, 09h
    int 21h
    mov ah, 4Ch
    int 21h

; PrintNumber: print AX as a number
PrintNumber proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0
    mov bx, 10
nextDigit:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz nextDigit
printLoop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop printLoop

    pop dx
    pop cx
    pop bx
    pop ax
    ret
PrintNumber endp
end main