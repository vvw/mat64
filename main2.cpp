
#include "stdio.h"
#include "libmcadd.h"

#pragma comment(lib, "mclmcr.lib")
#pragma comment(lib, "mclmcrrt.lib")
#pragma comment(lib, "libmcadd.lib")

// G:\Program Files\MATLAB\R2014a\extern\include

// 函数的返回是变相的放到形参中的，依次是输出参数个数，输出参数，输入参数。
// mcadd 内部调用imread 和size 读取当前止录下的 head.jpg ，返回宽和高
// void MW_CALL_CONV mcadd(int nargout, mwArray& w, mwArray& h, const mwArray& u, const mwArray& v);

/*
mcadd.m
function [w, h] = mcadd (u, v) %#codegen
image = imread('head.jpg');
[rows, cols] = size(image);
w = cols;
h = rows;
end

% mcc -W cpplib:libmcadd -T link:lib mcadd.m
% 以上命令直接在matlab 的命令窗口执行
*/

int main() {
	
	bool successQ = libmcaddInitialize();

	int a = 3;
	int b = 4;

	mwArray w(1, 1, mxINT32_CLASS);
	mwArray h(1, 1, mxINT32_CLASS);
	mwArray u(1, 1, mxINT32_CLASS);
	mwArray v(1, 1, mxINT32_CLASS);

	//u.SetData(&a, 1);
	//v.SetData(&b, 1);

	u (1, 1) = 3;
	v (1, 1) = 4;

	mcadd(2, w, h, u, v);

	int p1;
	int p2;
	w.GetData(&p1, 1);
	h.GetData(&p2, 1);

	printf("ok? %d\nimage's width,hight = %d,%d\n", successQ, p1, p2);

	getchar();
	return 0;
}

