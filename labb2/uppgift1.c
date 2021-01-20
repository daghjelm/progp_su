#include <stdio.h>

int main() 
{
  printf("Printable ASCII characters: \n\n");

  //loop all printable ascii decimal numbers (33 - 126)
  for (int i = 33; i < 127; i++) {
    printf("%c ", i);
    //new line every 12th character printed
    if ((i - 32) % 12 == 0)
      printf("\n");
  }

  printf("\n");

  return 0;
}