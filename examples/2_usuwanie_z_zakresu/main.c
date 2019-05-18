#include <stdio.h>
#include "f.h"

int main(int argc, char * argv[])
{
	if(argc != 4)
	{
		printf("argument error!\n");
		return 0;
	}
		
	f(argv[1], argv[2][0], argv[3][0]);
	printf(argv[1]);
        printf("\n");	
       
        return 0;
}

