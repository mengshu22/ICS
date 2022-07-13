#include <stdio.h>

int main()
{
  int a, b;
  int i = 0;
  for (i = 0; i < 10; ++i) {
    scanf("%x%x", &a, &b);
    a = a << 4;
    a = a + b;
    printf("%c", a);
  }
  return 0;
}