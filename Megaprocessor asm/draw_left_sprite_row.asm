LD.B R1,#0b11110000;
LD.B R0,(R2);                               //         led_byte = *led_byte_address;
AND R0,R1;                                  //         led_byte &= 0b11110000;         // clear left side of LEDs byte (In the LEDS, the MSBs are on the right)
LD.B R1,(R3++);                             //         piece_sprite_row = *piece_sprite_row_address; piece_sprite_row_address++;
OR R0,R1;                                   //         led_byte |= piece_sprite_row    // draw row of sprite in left of LEDs byte
ST.B (R2),R0;                               //         led_byte_address* = led_byte;   // update LEDs
LD.B R1,#4;
ADD R2,R1;                                  //         led_byte_address += 4;