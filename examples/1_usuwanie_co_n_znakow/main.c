#include <stdio.h>
#include "f.h"

int main(int argc, char * argv[])
{

        if (argc < 3)
        {
                printf("Arg missing\n");
                return 0;
        }

	printf("Input: %s\n", argv[1]);
	f(argv[1], atoi(argv[2]));
        printf("Output: %s\n", argv[1]);
       
        return 0;
}

