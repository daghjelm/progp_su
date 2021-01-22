#include <stdio.h>

//sort function with gotos instead of loops
int sort(int xs[], int n) {
  int i, j, tmp;

  i = 1;
  //instead of for-loop
  first: 
    tmp = xs[i];
    j = i;

    //instead of while-loop
    snd:
      if (j > 0 && tmp < xs[j - 1]) {
        xs[j] = xs[j - 1];
        j--;

        goto snd;
      }

    xs[j] = tmp;

    i++;

    if (i < n) {
      goto first;
    }
  
  return 0;
}

int main()
{
  int xs[] = { 12, -3, 27, 2, 3, 1, 9 };

  //for easier testing
  int n = sizeof(xs)/sizeof(int);

  sort(xs, n);

  for (int i = 0; i < n; i++)
    printf("%d ", xs[i]);

  printf("\n");
  return 0;
}
