#include <stdlib.h>
#include <iostream>
#include <nvboard.h>
#include "Vtop.h"




static TOP_NAME dut;
void nvboard_bind_all_pins(Vtop* top);
#define LOOP 1000000
static void single_cycle() {
  dut.clk = 0; dut.eval();
  dut.clk = 1; dut.eval();
}

static void reset(int n) {
  dut.rst = 1;
  while (n -- > 0) single_cycle();
  dut.rst = 0;
}

int main() {
  nvboard_bind_all_pins(&dut);
  nvboard_init();

  reset(10);
  int i=0;

  while( i < LOOP) {
    nvboard_update();
    single_cycle();
    i++;
  }

  nvboard_quit();
}
