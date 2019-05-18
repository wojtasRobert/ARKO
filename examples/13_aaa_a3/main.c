#include <stdio.h>
#ifdef __cplusplus
extern "C" {
#endif
 char output_str[256];
 int func(char *a, char* b);
#ifdef __cplusplus
}
#endif

int main(int argc, char** argv)
{ 
  printf("Input string: %s\n", argv[1]);
  func(argv[1], output_str);
  printf("Output string: %s\n", output_str);
  
  return 0;
}
