#include "taulib/globals.h"
#include "taulib/memorymap.h"
#include "taulib/tilegpu.h"

int main(void) {
    // Bootloader will jump here and set up stack for you
    // and you can use the available libaries from taulib
    // There is also a assets folder where you can put game assets
    // but if you don't need assets remove the assets target
    // in the Makefile

    // You can structure your src folder as you like
    // the makefile will automatically find your .c files
    // make them .o and link everything
    
 
    // Remember to modify the linker script if you need to modify sections or
    // add sections.
}