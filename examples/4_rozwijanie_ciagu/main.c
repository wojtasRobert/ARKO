#include <stdio.h>
#include "f.h"

int main(int argc, char * argv[])
{
	char output_str[256];
        printf("Input string: %s\n", argv[1]);
	f(argv[1],output_str);
  	printf("Output string: %s\n", output_str);
        return 0;
}

