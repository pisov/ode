#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define	L	1.0
#define	V0	10.0
#define	zero	0.0


float epot(float x) {
	if (fabs(x) <= L)
		return zero;
	else
		return V0;
}

void deriv(float x, float *y, float *dydx, int n, float eref) {
	float epot(float x);
	int i;

	dydx[0] = y[1];
	dydx[1] = 2 * (epot(x) - eref) * y[0];
}

void integ(float x, float *yold, float *ynew, int n, float step, float eref) {
	void deriv(float x, float *y, float *dydx, int n, float eref);

	int i;
	float *dydx;

	dydx = (float *) malloc(n * sizeof(float));
	deriv(x, yold, dydx, n, eref);


	for (i = 0; i < n; i++) {
		ynew[i] = yold[i] + step * dydx[i];
	}

	free(dydx);

}

int main() {
	void integ(float x, float *yold, float *ynew, int n, float step, float eref);
	void deriv(float t, float *y, float *dydx, int n, float eref);

	float *yl, *yl_new, *yr, *yr_new;
	int n = 2;
	int nint = 500;
	float xmin, xmax, xl, xr, h, xmidle;
	float energy;
	int i;

	xmin = - 5 * L;
	xmax = 5 * L;

	xl = xmin;
	xr = xmax;

	h = (xmax - xmin) / nint;

	//energy = 0.81836e0;
	energy = 0.5e0;

	yl = (float *) malloc(n * sizeof(float));
	yl_new = (float *) malloc(n * sizeof(float));
	yr = (float *) malloc(n * sizeof(float));
	yr_new = (float *) malloc(n * sizeof(float));

	yl[0] = 0.e0;
	yl[1] = 1.e-3;

	yr[0] = 0.e0;
	yr[1] = -1.e-3;

	xmidle = 0.e0;

	for (i = 1; i <= nint; i++) {
		xl = xmin + i * h;
		xr = xmax - i * h;
		printf("%15.5f%15.5f%15.5f%15.5f\n",xl,yl[0],xr,yr[0]);
		if (xl <= xmidle) {
			integ(xl, yl, yl_new, n, h, energy);
			integ(xr, yr, yr_new, n, -h, energy);
			yl[0] = yl_new[0];
			yl[1] = yl_new[1];
			yr[0] = yr_new[0];
			yr[1] = yr_new[1];
		}
		
	}

	free(yl);
	free(yl_new);
	free(yr);
	free(yr_new);


	return 0;
}
