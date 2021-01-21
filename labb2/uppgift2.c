#include <stdio.h>
#include <stdlib.h>

void insert_in_sorted(int x, int * xs, int n)
{

  int i = n - 1;

  // här ska ni skriva kod
  while (0 <= i && *(xs + i) > x) {
    //xs + i + i motsvarar xs[i + 1]
    *(xs + i + 1) = *(xs + i);
    i--;
  }

  *(xs + i + 1) = x;
}

int * insertion_sort(int * xs, int n)
{
  // här ska ni också skriva kod
  int* out = malloc(n * sizeof(int));

  for (int i = 0; i < n; i++) {
    insert_in_sorted(*(xs + i), out, i);
  }

  return out;
}

int main () {
  int list[] = { 12, -3, 27, 2, 3, 1, 9 };

  // beräkna längden på list
  int n = sizeof(list) / sizeof(int);

  int* xs = insertion_sort(list,n);

  for (int i = 0; i < n; i++)
    printf("%d ",*(xs + i));

  printf("\n");
  return 0;
}