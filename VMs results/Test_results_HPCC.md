########################################################################
This is the DARPA/DOE HPC Challenge Benchmark version 1.5.0 October 2012
Produced by Jack Dongarra and Piotr Luszczek
Innovative Computing Laboratory
University of Tennessee Knoxville and Oak Ridge National Laboratory

See the source files for authors of specific codes.
Compiled on Apr  1 2024 at 06:02:28
Current time (1742733134) is Sun Mar 23 12:32:14 2025

Hostname: 'Node01'
########################################################################
================================================================================
HPLinpack 2.0  --  High-Performance Linpack benchmark  --   September 10, 2008
Written by A. Petitet and R. Clint Whaley,  Innovative Computing Laboratory, UTK
Modified by Piotr Luszczek, Innovative Computing Laboratory, UTK
Modified by Julien Langou, University of Colorado Denver
================================================================================

An explanation of the input/output parameters follows:
T/V    : Wall time / encoded variant.
N      : The order of the coefficient matrix A.
NB     : The partitioning blocking factor.
P      : The number of process rows.
Q      : The number of process columns.
Time   : Time in seconds to solve the linear system.
Gflops : Rate of execution for solving the linear system.

The following parameter values will be used:

N      :   20352
NB     :     192
PMAP   : Row-major process mapping
P      :       1
Q      :       2
PFACT  :   Right
NBMIN  :       4
NDIV   :       2
RFACT  :   Crout
BCAST  :  1ringM
DEPTH  :       1
SWAP   : Mix (threshold = 64)
L1     : transposed form
U      : transposed form
EQUIL  : yes
ALIGN  : 8 double precision words

--------------------------------------------------------------------------------

- The matrix A is randomly generated for each test.
- The following scaled residual check will be computed:
      ||Ax-b||_oo / ( eps * ( || x ||_oo * || A ||_oo + || b ||_oo ) * N )
- The relative machine precision (eps) is taken to be               1.110223e-16
- Computational tests pass if scaled residuals are less than                16.0

Begin of MPIRandomAccess section.
Running on 2 processors (PowerofTwo)
Total Main table size = 2^28 = 268435456 words
PE Main table size = 2^27 = 134217728 words/PE
Default number of updates (RECOMMENDED) = 1073741824
Number of updates EXECUTED = 71999506 (for a TIME BOUND of 60.00 secs)
CPU time used = 10.527859 seconds
Real time used = 58.753345 seconds
0.001225454 Billion(10^9) Updates    per second [GUP/s]
0.000612727 Billion(10^9) Updates/PE per second [GUP/s]
Verification:  CPU time used = 3.370183 seconds
Verification:  Real time used = 27.464053 seconds
Found 0 errors in 268435456 locations (passed).
Current time (1742733230) is Sun Mar 23 12:33:50 2025

End of MPIRandomAccess section.
Begin of StarRandomAccess section.
Main table size   = 2^27 = 134217728 words
Number of updates = 536870912
CPU time used  = 19.306689 seconds
Real time used = 19.365286 seconds
0.027723366 Billion(10^9) Updates    per second [GUP/s]
Found 0 errors in 134217728 locations (passed).
Node(s) with error 0
Minimum GUP/s 0.024688
Average GUP/s 0.026206
Maximum GUP/s 0.027723
Current time (1742733272) is Sun Mar 23 12:34:32 2025

End of StarRandomAccess section.
Begin of SingleRandomAccess section.
Node(s) with error 0
Node selected 1
Single GUP/s 0.045834
Current time (1742733296) is Sun Mar 23 12:34:56 2025

End of SingleRandomAccess section.
Begin of MPIRandomAccess_LCG section.
Running on 2 processors (PowerofTwo)
Total Main table size = 2^28 = 268435456 words
PE Main table size = 2^27 = 134217728 words/PE
Default number of updates (RECOMMENDED) = 1073741824
Number of updates EXECUTED = 64199438 (for a TIME BOUND of 60.00 secs)
CPU time used = 8.403120 seconds
Real time used = 54.316146 seconds
0.001181959 Billion(10^9) Updates    per second [GUP/s]
0.000590979 Billion(10^9) Updates/PE per second [GUP/s]
Verification:  CPU time used = 4.420146 seconds
Verification:  Real time used = 26.035004 seconds
Found 0 errors in 268435456 locations (passed).
Current time (1742733387) is Sun Mar 23 12:36:27 2025

End of MPIRandomAccess_LCG section.
Begin of StarRandomAccess_LCG section.
Main table size   = 2^27 = 134217728 words
Number of updates = 536870912
CPU time used  = 18.289397 seconds
Real time used = 18.966012 seconds
0.028307000 Billion(10^9) Updates    per second [GUP/s]
Found 0 errors in 134217728 locations (passed).
Node(s) with error 0
Minimum GUP/s 0.023141
Average GUP/s 0.025724
Maximum GUP/s 0.028307
Current time (1742733429) is Sun Mar 23 12:37:09 2025

End of StarRandomAccess_LCG section.
Begin of SingleRandomAccess_LCG section.
Node(s) with error 0
Node selected 1
Single GUP/s 0.047815
Current time (1742733453) is Sun Mar 23 12:37:33 2025

End of SingleRandomAccess_LCG section.
Begin of PTRANS section.
M: 10176
N: 10176
MB: 192
NB: 192
P: 1
Q: 2
TIME   M     N    MB  NB  P   Q     TIME   CHECK   GB/s   RESID
---- ----- ----- --- --- --- --- -------- ------ -------- -----
WALL 10176 10176 192 192   1   2     2.71 PASSED    0.305  0.00
CPU  10176 10176 192 192   1   2     0.88 PASSED    0.947  0.00
WALL 10176 10176 192 192   1   2     2.76 PASSED    0.300  0.00
CPU  10176 10176 192 192   1   2     0.92 PASSED    0.898  0.00
WALL 10176 10176 192 192   1   2     2.54 PASSED    0.300  0.00
CPU  10176 10176 192 192   1   2     0.89 PASSED    0.931  0.00
WALL 10176 10176 192 192   1   2     2.59 PASSED    0.300  0.00
CPU  10176 10176 192 192   1   2     0.75 PASSED    1.108  0.00
WALL 10176 10176 192 192   1   2     2.72 PASSED    0.300  0.00
CPU  10176 10176 192 192   1   2     0.96 PASSED    0.866  0.00

Finished    5 tests, with the following results:
    5 tests completed and passed residual checks.
    0 tests completed and failed residual checks.
    0 tests skipped because of illegal input values.

END OF TESTS.
Current time (1742733482) is Sun Mar 23 12:38:02 2025

End of PTRANS section.
Begin of StarDGEMM section.
Scaled residual: 0.00666563
Node(s) with error 0
Minimum Gflop/s 1.712545
Average Gflop/s 1.765695
Maximum Gflop/s 1.818844
Current time (1742734158) is Sun Mar 23 12:49:18 2025

End of StarDGEMM section.
Begin of SingleDGEMM section.
Node(s) with error 0
Node selected 1
Single DGEMM Gflop/s 1.694688
Current time (1742734839) is Sun Mar 23 13:00:39 2025

End of SingleDGEMM section.
Begin of StarSTREAM section.
-------------------------------------------------------------
This system uses 8 bytes per DOUBLE PRECISION word.
-------------------------------------------------------------
Array size = 69033984, Offset = 0
Total memory required = 1.5430 GiB.
Each test is run 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
The SCALAR value used for this run is 0.420000
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 99016 microseconds.
   (= 99016 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
VERBOSE: total setup time for rank 0 = 1.397716 seconds
-------------------------------------------------------------
Function      Rate (GB/s)   Avg time     Min time     Max time
Copy:           8.7121       0.1280       0.1268       0.1290
Scale:          4.7989       0.2336       0.2302       0.2386
Add:            5.6724       0.2964       0.2921       0.3003
Triad:          5.4813       0.3094       0.3023       0.3178
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Node(s) with error 0
Minimum Copy GB/s 8.712056
Average Copy GB/s 8.712056
Maximum Copy GB/s 8.712056
Minimum Scale GB/s 4.798913
Average Scale GB/s 4.798913
Maximum Scale GB/s 4.798913
Minimum Add GB/s 5.672382
Average Add GB/s 5.672382
Maximum Add GB/s 5.672382
Minimum Triad GB/s 5.481255
Average Triad GB/s 5.481255
Maximum Triad GB/s 5.481255
Current time (1742734850) is Sun Mar 23 13:00:50 2025

End of StarSTREAM section.
Begin of SingleSTREAM section.
Node(s) with error 0
Node selected 1
Single STREAM Copy GB/s 15.437061
Single STREAM Scale GB/s 8.523702
Single STREAM Add GB/s 10.107076
Single STREAM Triad GB/s 10.172983
Current time (1742734857) is Sun Mar 23 13:00:57 2025

End of SingleSTREAM section.
Begin of MPIFFT section.
Number of nodes: 2
Vector size:             33554432
Generation time:     0.624
Tuning:     0.447
Computing:     5.432
Inverse FFT:     5.412
max(|x-x0|): 2.092e-15
Gflop/s:     0.772
Current time (1742734870) is Sun Mar 23 13:01:10 2025

End of MPIFFT section.
Begin of StarFFT section.
Vector size: 33554432
Generation time:     1.267
Tuning:     0.001
Computing:     2.274
Inverse FFT:     2.137
max(|x-x0|): 2.156e-15
Node(s) with error 0
Minimum Gflop/s 1.558463
Average Gflop/s 1.701488
Maximum Gflop/s 1.844514
Current time (1742734878) is Sun Mar 23 13:01:18 2025

End of StarFFT section.
Begin of SingleFFT section.
Node(s) with error 0
Node selected 1
Single FFT Gflop/s 2.287462
Current time (1742734884) is Sun Mar 23 13:01:24 2025

End of SingleFFT section.
Begin of LatencyBandwidth section.

------------------------------------------------------------------
Latency-Bandwidth-Benchmark R1.5.1 (c) HLRS, University of Stuttgart
Written by Rolf Rabenseifner, Gerrit Schulz, and Michael Speck, Germany

Details - level 2
-----------------

MPI_Wtime granularity.
Max. MPI_Wtick is 0.000000 sec
wtick is set to   0.000001 sec

Message Length: 8
Latency   min / avg / max:   0.224780 /   0.224780 /   0.224780 msecs
Bandwidth min / avg / max:      0.036 /      0.036 /      0.036 MByte/s

MPI_Wtime granularity is ok.
message size:                                  8
max time :                             10.000000 secs
latency for msg:                        0.224780 msecs
estimation for ping pong:              20.230172 msecs
max number of ping pong pairs       =        494
max client pings = max server pongs =         22
stride for latency                  =          1
Message Length: 8
Latency   min / avg / max:   0.229384 /   0.233452 /   0.237520 msecs
Bandwidth min / avg / max:      0.034 /      0.034 /      0.035 MByte/s

Message Length: 2000000
Latency   min / avg / max:   8.838569 /   8.838569 /   8.838569 msecs
Bandwidth min / avg / max:    226.281 /    226.281 /    226.281 MByte/s

MPI_Wtime granularity is ok.
message size:                            2000000
max time :                             30.000000 secs
latency for msg:                        8.838569 msecs
estimation for ping pong:              70.708556 msecs
max number of ping pong pairs       =        424
max client pings = max server pongs =         20
stride for latency                  =          1
Message Length: 2000000
Latency   min / avg / max:   8.757767 /   9.738021 /  10.718275 msecs
Bandwidth min / avg / max:    186.597 /    207.483 /    228.369 MByte/s

Message Size:                           8 Byte
Natural Order Latency:           0.391865 msec
Natural Order Bandwidth:         0.020415 MB/s
Avg Random Order Latency:        0.350126 msec
Avg Random Order Bandwidth:      0.022849 MB/s

Message Size:                     2000000 Byte
Natural Order Latency:          17.992648 msec
Natural Order Bandwidth:       111.156511 MB/s
Avg Random Order Latency:       17.786888 msec
Avg Random Order Bandwidth:    112.442380 MB/s

Execution time (wall clock)      =    11.824 sec on 2 processes
 - for cross ping_pong latency   =     0.089 sec
 - for cross ping_pong bandwidth =     0.331 sec
 - for ring latency              =     3.489 sec
 - for ring bandwidth            =     7.916 sec

------------------------------------------------------------------
Latency-Bandwidth-Benchmark R1.5.1 (c) HLRS, University of Stuttgart
Written by Rolf Rabenseifner, Gerrit Schulz, and Michael Speck, Germany

Major Benchmark results:
------------------------

Max Ping Pong Latency:                 0.237520 msecs
Randomly Ordered Ring Latency:         0.350126 msecs
Min Ping Pong Bandwidth:             186.597190 MB/s
Naturally Ordered Ring Bandwidth:    111.156511 MB/s
Randomly  Ordered Ring Bandwidth:    112.442380 MB/s

------------------------------------------------------------------

Detailed benchmark results:
Ping Pong:
Latency   min / avg / max:   0.229384 /   0.233452 /   0.237520 msecs
Bandwidth min / avg / max:    186.597 /    207.483 /    228.369 MByte/s
Ring:
On naturally ordered ring: latency=      0.391865 msec, bandwidth=    111.156511 MB/s
On randomly  ordered ring: latency=      0.350126 msec, bandwidth=    112.442380 MB/s

------------------------------------------------------------------

Benchmark conditions:
 The latency   measurements were done with        8 bytes
 The bandwidth measurements were done with  2000000 bytes
 The ring communication was done in both directions on 2 processes
 The Ping Pong measurements were done on
  -           2 pairs of processes for latency benchmarking, and
  -           2 pairs of processes for bandwidth benchmarking,
 out of 2*(2-1) =          2 possible combinations on 2 processes.
 (1 MB/s = 10**6 byte/sec)

------------------------------------------------------------------
Current time (1742734895) is Sun Mar 23 13:01:35 2025

End of LatencyBandwidth section.
Begin of HPL section.
================================================================================
HPLinpack 2.0  --  High-Performance Linpack benchmark  --   September 10, 2008
Written by A. Petitet and R. Clint Whaley,  Innovative Computing Laboratory, UTK
Modified by Piotr Luszczek, Innovative Computing Laboratory, UTK
Modified by Julien Langou, University of Colorado Denver
================================================================================

An explanation of the input/output parameters follows:
T/V    : Wall time / encoded variant.
N      : The order of the coefficient matrix A.
NB     : The partitioning blocking factor.
P      : The number of process rows.
Q      : The number of process columns.
Time   : Time in seconds to solve the linear system.
Gflops : Rate of execution for solving the linear system.

The following parameter values will be used:

N      :   20352
NB     :     192
PMAP   : Row-major process mapping
P      :       1
Q      :       2
PFACT  :   Right
NBMIN  :       4
NDIV   :       2
RFACT  :   Crout
BCAST  :  1ringM
DEPTH  :       1
SWAP   : Mix (threshold = 64)
L1     : transposed form
U      : transposed form
EQUIL  : yes
ALIGN  : 8 double precision words

--------------------------------------------------------------------------------

- The matrix A is randomly generated for each test.
- The following scaled residual check will be computed:
      ||Ax-b||_oo / ( eps * ( || x ||_oo * || A ||_oo + || b ||_oo ) * N )
- The relative machine precision (eps) is taken to be               1.110223e-16
- Computational tests pass if scaled residuals are less than                16.0

================================================================================
T/V                N    NB     P     Q               Time                 Gflops
--------------------------------------------------------------------------------
WR11C2R4       20352   192     1     2            1693.13              3.320e+00
--------------------------------------------------------------------------------
||Ax-b||_oo/(eps*(||A||_oo*||x||_oo+||b||_oo)*N)=        0.0039858 ...... PASSED
================================================================================

Finished      1 tests with the following results:
              1 tests completed and passed residual checks,
              0 tests completed and failed residual checks,
              0 tests skipped because of illegal input values.
--------------------------------------------------------------------------------

End of Tests.
================================================================================
Current time (1742736598) is Sun Mar 23 13:29:58 2025

End of HPL section.
Begin of Summary section.
VersionMajor=1
VersionMinor=5
VersionMicro=0
VersionRelease=f
LANG=C
Success=1
sizeof_char=1
sizeof_short=2
sizeof_int=4
sizeof_long=8
sizeof_void_ptr=8
sizeof_size_t=8
sizeof_float=4
sizeof_double=8
sizeof_s64Int=8
sizeof_u64Int=8
sizeof_struct_double_double=16
CommWorldProcs=2
MPI_Wtick=1.000000e-09
HPL_Tflops=0.00331961
HPL_time=1693.13
HPL_eps=1.11022e-16
HPL_RnormI=4.67179e-09
HPL_Anorm1=5170.38
HPL_AnormI=5168.82
HPL_Xnorm1=339365
HPL_XnormI=100.359
HPL_BnormI=0.499989
HPL_N=20352
HPL_NB=192
HPL_nprow=1
HPL_npcol=2
HPL_depth=1
HPL_nbdiv=2
HPL_nbmin=4
HPL_cpfact=R
HPL_crfact=C
HPL_ctop=1
HPL_order=R
HPL_dMACH_EPS=1.110223e-16
HPL_dMACH_SFMIN=2.225074e-308
HPL_dMACH_BASE=2.000000e+00
HPL_dMACH_PREC=2.220446e-16
HPL_dMACH_MLEN=5.300000e+01
HPL_dMACH_RND=1.000000e+00
HPL_dMACH_EMIN=-1.021000e+03
HPL_dMACH_RMIN=2.225074e-308
HPL_dMACH_EMAX=1.024000e+03
HPL_dMACH_RMAX=1.797693e+308
HPL_sMACH_EPS=5.960464e-08
HPL_sMACH_SFMIN=1.175494e-38
HPL_sMACH_BASE=2.000000e+00
HPL_sMACH_PREC=1.192093e-07
HPL_sMACH_MLEN=2.400000e+01
HPL_sMACH_RND=1.000000e+00
HPL_sMACH_EMIN=-1.250000e+02
HPL_sMACH_RMIN=1.175494e-38
HPL_sMACH_EMAX=1.280000e+02
HPL_sMACH_RMAX=3.402823e+38
dweps=1.110223e-16
sweps=5.960464e-08
HPLMaxProcs=2
HPLMinProcs=2
DGEMM_N=8308
StarDGEMM_Gflops=1.76569
SingleDGEMM_Gflops=1.69469
PTRANS_GBs=0.299881
PTRANS_time=2.72049
PTRANS_residual=0
PTRANS_n=10176
PTRANS_nb=192
PTRANS_nprow=1
PTRANS_npcol=2
MPIRandomAccess_LCG_N=268435456
MPIRandomAccess_LCG_time=54.3161
MPIRandomAccess_LCG_CheckTime=26.035
MPIRandomAccess_LCG_Errors=0
MPIRandomAccess_LCG_ErrorsFraction=0
MPIRandomAccess_LCG_ExeUpdates=64199438
MPIRandomAccess_LCG_GUPs=0.00118196
MPIRandomAccess_LCG_TimeBound=60
MPIRandomAccess_LCG_Algorithm=0
MPIRandomAccess_N=268435456
MPIRandomAccess_time=58.7533
MPIRandomAccess_CheckTime=27.4641
MPIRandomAccess_Errors=0
MPIRandomAccess_ErrorsFraction=0
MPIRandomAccess_ExeUpdates=71999506
MPIRandomAccess_GUPs=0.00122545
MPIRandomAccess_TimeBound=60
MPIRandomAccess_Algorithm=0
RandomAccess_LCG_N=134217728
StarRandomAccess_LCG_GUPs=0.0257242
SingleRandomAccess_LCG_GUPs=0.047815
RandomAccess_N=134217728
StarRandomAccess_GUPs=0.0262058
SingleRandomAccess_GUPs=0.0458342
STREAM_VectorSize=69033984
STREAM_Threads=1
StarSTREAM_Copy=8.71206
StarSTREAM_Scale=4.79891
StarSTREAM_Add=5.67238
StarSTREAM_Triad=5.48126
SingleSTREAM_Copy=15.4371
SingleSTREAM_Scale=8.5237
SingleSTREAM_Add=10.1071
SingleSTREAM_Triad=10.173
FFT_N=33554432
StarFFT_Gflops=1.70149
SingleFFT_Gflops=2.28746
MPIFFT_N=33554432
MPIFFT_Gflops=0.772139
MPIFFT_maxErr=2.09224e-15
MPIFFT_Procs=2
MaxPingPongLatency_usec=237.52
RandomlyOrderedRingLatency_usec=350.126
MinPingPongBandwidth_GBytes=0.186597
NaturallyOrderedRingBandwidth_GBytes=0.111157
RandomlyOrderedRingBandwidth_GBytes=0.112442
MinPingPongLatency_usec=229.384
AvgPingPongLatency_usec=233.452
MaxPingPongBandwidth_GBytes=0.228369
AvgPingPongBandwidth_GBytes=0.207483
NaturallyOrderedRingLatency_usec=391.865
FFTEnblk=16
FFTEnp=8
FFTEl2size=1048576
M_OPENMP=-1
omp_get_num_threads=0
omp_get_max_threads=0
omp_get_num_procs=0
MemProc=-1
MemSpec=-1
MemVal=-1
MPIFFT_time0=7.62e-07
MPIFFT_time1=1.66193
MPIFFT_time2=0.194845
MPIFFT_time3=1.2808
MPIFFT_time4=0.735731
MPIFFT_time5=1.46364
MPIFFT_time6=1.312e-06
CPS_HPCC_FFT_235=0
CPS_HPCC_FFTW_ESTIMATE=0
CPS_HPCC_MEMALLCTR=0
CPS_HPL_USE_GETPROCESSTIMES=0
CPS_RA_SANDIA_NOPT=0
CPS_RA_SANDIA_OPT2=0
CPS_USING_FFTW=0
End of Summary section.
########################################################################
End of HPC Challenge tests.
Current time (1742736598) is Sun Mar 23 13:29:58 2025

########################################################################