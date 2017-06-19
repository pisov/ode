1. Compile

gfortran -O3 fw_numerov.f90 fw.x

2. Execute the compiled code and produce wafefunction data and print out the energy levels 

./fw.x

3. Plot the data (press any key in terminal windows in order to quit the gnuplot)

gnuplot wfplot.gnu 

[Remark:]

Plot will be saved into PNG file as wfNNN.png

[Exersize:]
Modify the source code in order to calculate the energy levels and wave functions in case of harmonic potential V(x) = x^2/2. The energy elevels are E_n = n + 1/2.
