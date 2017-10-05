#include <stdlib.h>
#include <stdio.h>

typedef unsigned char byte;

int parse(char* s);
void write(int v);

int main()
{
	char s[32];
	int v = 0;
	while (true)
	{
		printf("Which page will the pipes be on? (e.g. 2, 5, A, 1f)\n");
		gets(s);
		v = parse(s);
		if (v == -1)
			printf("\nInvalid input given. Please do not provide any formatting (e.g. $04, 0x04)\n");
		else if (v < 2)
			printf("\nPage value must be at least 2. First two pages reserved by game.\n");
		else
			break;
	}

	write(v);

	return 0;
}

int parse(char* s)
{
	register int r, x;

	for (r = 0; x = *s; ++s)
	{
		r <<= 4;
		if (x >= '0' && x <= '9')
			r |= x - '0';
		else if (x >= 'A' && x <= 'F')
			r |= x - 'A' + 0x0a;
		else if (x >= 'a' && x <= 'f')
			r |= x - 'a' + 0x0a;
		else
			return -1;
	}
	return r;
}

void write(int v)
{
	FILE *fn = fopen("..\\pipes.map16", "rb+");
	if (!fn)
	{
		printf("Could not open pipes.map16\n");
		return;
	}

	fseek(fn, 0, SEEK_END);
	int size = ftell(fn);
	rewind(fn);
	byte* data = (byte*)malloc(size);
	fread(data, 1, size, fn);
	rewind(fn);
	for (int i = 0x8B1; i < size; i += 2)
		if (data[i] >= 2)
			data[i] = v;
	fwrite(data, 1, size, fn);
	fclose(fn);
	free(data);

	fn = fopen("..\\pipes.dsc", "rb+");
	if (!fn)
	{
		printf("Could not open pipes.dsc\n");
		return;
	}

	fseek(fn, 0, SEEK_END);
	size = ftell(fn);
	rewind(fn);
	data = (byte*)malloc(size);
	fread(data, 1, size, fn);
	rewind(fn);
	for (int i = 0; true; ++i)
	{
		data[i] = v + '0';
		while (data[i] && data[i] != '\n')
			++i;
		if (!data[i])
			break;
	}
	fwrite(data, 1, size, fn);
	fclose(fn);
	free(data);

	printf("Files converted successfully!\n");
}