#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define G 9.81e0
#define k 4.31e-2
#define Pi  3.1415927
#define mass  0.145e0

void integ(float dt, float t, float *y, float *ynew, int n) {
  void deriv(float t, float *y, float *dydt, int n);
  float *dydt;
  int i;
  
  dydt = (float *) malloc(n * sizeof(float));
  deriv(t, y, dydt, n);
  
  //Euler simple integration scheme
  for (i = 0; i < n; i++) {
    ynew[i] = y[i] + dt * dydt[i];
  }
  
  free(dydt);
}

void deriv(float t, float *y, float *dydt, int n) {
  int i;
  
  dydt[0] = y[2];
  dydt[1] = y[3];
  dydt[2] = - k * y[2] / mass;
  dydt[3] = - G - k * y[3] / mass; 
}

int main () {
  void integ(float dt, float t, float *y, float *ynew, int n);
  void deriv(float t, float *y, float *dydt, int n);

  float *y, *ynew;
  float dt, t, v0, theta;
  int i, n;
  
  //Calculate theta = 45 degreed in radians
  theta = 45 * Pi / 180;
  
  //Initial velocity m/s
  v0 = 44.7e0;
  
  //Allocate working arrays
  n = 4;
  y = (float *) malloc(n * sizeof(float));
  ynew = (float *) malloc(n * sizeof(float));
  
  // y[0] -> x
  // y[1] -> y
  // y[2] -> Vx
  // y[3] -> Vy
  
  y[0] = 0;
  y[1] = 0;
  y[2] = v0*cosf(theta);
  y[3] = v0*sinf(theta);
  
  fprintf(stderr,"Please enter the integration step (0 < dt < 1s) dt = ");
  scanf("%f",&dt);
  
  if (  dt <= 0 || dt > 1 ) {
    fprintf(stderr, "Wrong dt = %.2f\n",dt);
    return 1;
  }	
  
  t = 0;
  while ( y[1] >= 0) {
    fprintf(stdout,"%15.5f%15.5f%15.5f%15.5f%15.5f\n",t,y[0],y[1],y[2],y[3]);
	t = t + dt;
	integ(dt, t, y, ynew, n);
	for (i = 0; i < n; i++) {
	  y[i] = ynew[i];
	}
  }
  
  free(y);
  free(ynew);
 
  
  return 0;

}
