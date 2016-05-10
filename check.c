#include <stdio.h>
#include <stdlib.h>
#define STR_LEN 80

int main(int argc, const char *argv[])
{
  int c;
  char* first[STR_LEN];
  char temp[255];
  char head[20] = "E";
  char tail[20] = "A.DAT";

  FILE* fp = fopen(argv[1], "r");
  FILE* test;

  if(!fp) {
    perror("File opening failed");
    return EXIT_FAILURE;
  }

  while(fscanf(fp,"%s",first)!=EOF){
    strcpy(temp,head);
    strcat(temp,first);
    strcat(temp,tail);
    
    test = fopen(temp,"r");

    if (test==NULL) {
      printf("%s is not openable.\n",temp);
    }
  }

  fclose(fp);
  return 0;
}
