#include <stdio.h>
#include "f.h"

int main(int argc, char * argv[])
{	
	int len = 0;

        if (argc < 2)
        {
                printf("Arg missing\n");
                return 0;
        }

	printf("Input: %s\n", argv[1]);
	len = f(argv[1]);
        printf("Length: %d\n", len);
        
        return 0;
}

