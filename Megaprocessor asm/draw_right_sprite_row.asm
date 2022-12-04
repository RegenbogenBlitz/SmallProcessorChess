LD.B R1,#0b00001111;
LD.B R0,(R2);                               //         led_byte = *led_byte_address;
AND R0,R1;                                  //         led_byte &= 0b00001111;         // clear right side of LEDs byte (In the LEDS, the LSBs are on the left)
LD.B R1,(R3++);                             //         piece_sprite_row = *piece_sprite_row_address; piece_sprite_row_address++;
OR R0,R1;                                   //         led_byte |= piece_sprite_row    // draw row of sprite in right of LEDs byte
ST.B (R2),R0;                               //         led_byte_address* = led_byte;   // update LEDs
LD.B R1,#4;
ADD R2,R1;                                  //         led_byte_address += 4;