#include <stdio.h>
#include <stdlib.h>



extern long long unsigned  * calc_func(long long *x, int numOfRounds); /*change ret value type*/



int main(int argc, char** argv)
{

 
  
  long long unsigned  * x = (long long unsigned  *) (malloc(8));
  scanf("%016llX",x);

    
  int numOfRounds = 0;
  scanf("%d",&numOfRounds);
  
  
  long long unsigned  * y = calc_func(x, numOfRounds);
  
 /*printf ("%llX\n", (*y));*/
 
 free(x);

  
  
  return 0;
}



int compare (long long * x, long long * y){
  /*printf ("%llX\n", (*y));
  printf ("%llX\n", (*x));*/
  
  if ((((*y)-(*x))==0) || (((*x)-(*y))==0) ) { return 1;}
  else  { return 0;} 
  
  
}
