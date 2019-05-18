#include <stdio.h>
#include "f.h"

int main(int argc, char * argv[])
{
        if (argc < 2)
        {
                printf("Arg missing\n");
                return 0;
        }

	f(argv[1]);
        printf(argv[1]);
        printf("\n");
        return 0;
}

