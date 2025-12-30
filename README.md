This is the miriad script for ATCA data (3cm and 6cm). Following the step written by Jamie Stevens.

1. Calib.csh is for bandpass calibration, flux calibration, and phase calibration. For example, the source 1934-630 is always for bandpass and flux calibration, and the source near the target
2. is for phase calibration. In this script, we should manually flag RFI with blflag task.

3. Calib_9000.csh is for 3cm observation. We should excute this script after calib.csh.

4. figure.csh is to output and clean the figure only by 1 step with the files in 1 observation window. We can check the dirty map.

5. selfcal.csh is not only to output the figure but also to excute selfcal task for 3-5 times.

 
