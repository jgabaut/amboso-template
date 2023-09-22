#include <stdio.h>
#include "anvil__hello_world.h"

int main(void) {
  printf("Hello, World!\n");
  printf("\nAmboso template project, using lvl [%s]\n",get_ANVIL__API__LEVEL__());
  printf("\nTemplate version: [%s]\n",get_ANVIL__VERSION__());
  printf("\nTemplate version desc: [%s]\n",get_ANVIL__VERSION__DESC__());
  printf("\nTemplate version date: [%s]\n",get_ANVIL__VERSION__DATE__());
  printf("\nTemplate version author: [%s]\n",get_ANVIL__VERSION__AUTHOR__());
  return 0;
}
