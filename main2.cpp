
#include "stdio.h"
//#include "mcadd.h"
#include "libmcadd.h"

//#pragma comment(lib, "../bin/matlib.lib")
//#pragma comment(lib, "mcadd.lib")

#pragma comment(lib, "mclmcr.lib")
#pragma comment(lib, "mclmcrrt.lib")
#pragma comment(lib, "libmcadd.lib")

// G:\Program Files\MATLAB\R2014a\extern\include

//函数的返回是变相的放到形参中的，依次是输出参数个数，输出参数，输入参数。
//extern LIB_my_CPP_API void MW_CALL_CONV mcadd(int nargout, mwArray& y, const mwArray& u, const mwArray& v);

//extern "C" int mcadd(int, int);

//int add(int a, int b);

/*
mcadd.m
function y = mcadd(u, v) % #codegen
%image = imread('head.jpg');
%[rows, cols] = size(image);
%y = rows;
y = 7;
end

% mcc -W cpplib:libmcadd -T link:lib mcadd.m
*/

int main() {
	
	bool successQ = libmcaddInitialize();

	int a = 3;
	int b = 4;

	mwArray y(1, 1, mxINT32_CLASS);
	mwArray u(1, 1, mxINT32_CLASS);
	mwArray v(1, 1, mxINT32_CLASS);

	//u.SetData(&a, 1);
	//v.SetData(&b, 1);

	u (1, 1) = 3;
	v (1, 1) = 4;

	mcadd(1, y, u, v);

	int p;
	y.GetData(&p, 1);

	printf("ok? %d\nresults: %d", successQ, p);

	getchar();
	return 0;
}

