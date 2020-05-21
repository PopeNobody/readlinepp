#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#if defined(READLINE_LIBRARY)
#include "history.hh"
#include "readline.hh"
#else
#include <readline/history.hh>
#include <readline/readline.hh>
#endif

int main(int c, char** v)
{
  char* input;

  for (;;)
  {
    input= readline((char*)NULL);
    if (input == 0)
      break;
    printf("%s\n", input);
    if (strcmp(input, "exit") == 0)
      break;
    free(input);
  }
  exit(0);
}
