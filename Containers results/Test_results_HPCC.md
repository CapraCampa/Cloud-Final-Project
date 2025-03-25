########################################################################
This is the DARPA/DOE HPC Challenge Benchmark version 1.5.0 October 2012
Produced by Jack Dongarra and Piotr Luszczek
Innovative Computing Laboratory
University of Tennessee Knoxville and Oak Ridge National Laboratory

See the source files for authors of specific codes.
Compiled on Apr  1 2024 at 06:02:28
Current time (1742646406) is Sat Mar 22 12:26:46 2025

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
Number of updates EXECUTED = 74776404 (for a TIME BOUND of 60.00 secs)
CPU time used = 9.738363 seconds
Real time used = 30.836662 seconds
0.002424919 Billion(10^9) Updates    per second [GUP/s]
0.001212459 Billion(10^9) Updates/PE per second [GUP/s]
Verification:  CPU time used = 1.258686 seconds
Verification:  Real time used = 1.856979 seconds
Found 0 errors in 268435456 locations (passed).
Current time (1742646449) is Sat Mar 22 12:27:29 2025

End of MPIRandomAccess section.
Begin of StarRandomAccess section.
Main table size   = 2^27 = 134217728 words
Number of updates = 536870912
CPU time used  = 14.899106 seconds
Real time used = 14.904067 seconds
0.036021772 Billion(10^9) Updates    per second [GUP/s]
Found 0 errors in 134217728 locations (passed).
Node(s) with error 0
Minimum GUP/s 0.035972
Average GUP/s 0.035997
Maximum GUP/s 0.036022
Current time (1742646480) is Sat Mar 22 12:28:00 2025

End of StarRandomAccess section.
Begin of SingleRandomAccess section.
Node(s) with error 0
Node selected 1
Single GUP/s 0.063812
Current time (1742646497) is Sat Mar 22 12:28:17 2025

End of SingleRandomAccess section.
Begin of MPIRandomAccess_LCG section.
Running on 2 processors (PowerofTwo)
Total Main table size = 2^28 = 268435456 words
PE Main table size = 2^27 = 134217728 words/PE
Default number of updates (RECOMMENDED) = 1073741824
Number of updates EXECUTED = 146992504 (for a TIME BOUND of 60.00 secs)
CPU time used = 19.281667 seconds
Real time used = 59.881424 seconds
0.002454726 Billion(10^9) Updates    per second [GUP/s]
0.001227363 Billion(10^9) Updates/PE per second [GUP/s]
Verification:  CPU time used = 2.162518 seconds
Verification:  Real time used = 3.356864 seconds
Found 0 errors in 268435456 locations (passed).
Current time (1742646566) is Sat Mar 22 12:29:26 2025

End of MPIRandomAccess_LCG section.
Begin of StarRandomAccess_LCG section.
Main table size   = 2^27 = 134217728 words
Number of updates = 536870912
CPU time used  = 15.052453 seconds
Real time used = 15.053452 seconds
0.035664305 Billion(10^9) Updates    per second [GUP/s]
Found 0 errors in 134217728 locations (passed).
Node(s) with error 0
Minimum GUP/s 0.035634
Average GUP/s 0.035649
Maximum GUP/s 0.035664
Current time (1742646596) is Sat Mar 22 12:29:56 2025

End of StarRandomAccess_LCG section.
Begin of SingleRandomAccess_LCG section.
Node(s) with error 0
Node selected 1
Single GUP/s 0.061224
Current time (1742646613) is Sat Mar 22 12:30:13 2025

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
WALL 10176 10176 192 192   1   2     0.63 PASSED    1.311  0.00
CPU  10176 10176 192 192   1   2     0.50 PASSED    1.664  0.00
WALL 10176 10176 192 192   1   2     0.61 PASSED    1.311  0.00
CPU  10176 10176 192 192   1   2     0.45 PASSED    1.845  0.00
WALL 10176 10176 192 192   1   2     0.65 PASSED    1.284  0.00
CPU  10176 10176 192 192   1   2     0.47 PASSED    1.772  0.00
WALL 10176 10176 192 192   1   2     0.63 PASSED    1.284  0.00
CPU  10176 10176 192 192   1   2     0.48 PASSED    1.713  0.00
WALL 10176 10176 192 192   1   2     0.64 PASSED    1.284  0.00
CPU  10176 10176 192 192   1   2     0.48 PASSED    1.740  0.00

Finished    5 tests, with the following results:
    5 tests completed and passed residual checks.
    0 tests completed and failed residual checks.
    0 tests skipped because of illegal input values.

END OF TESTS.
Current time (1742646626) is Sat Mar 22 12:30:26 2025

End of PTRANS section.
Begin of StarDGEMM section.
Scaled residual: 0.00711957
Node(s) with error 0
Minimum Gflop/s 2.479895
Average Gflop/s 2.480541
Maximum Gflop/s 2.481187
Current time (1742647091) is Sat Mar 22 12:38:11 2025

End of StarDGEMM section.
Begin of SingleDGEMM section.
Node(s) with error 0
Node selected 1
Single DGEMM Gflop/s 3.185382
Current time (1742647453) is Sat Mar 22 12:44:13 2025

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
Each test below will take on the order of 190950 microseconds.
   (= 190950 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
VERBOSE: total setup time for rank 0 = 1.043599 seconds
-------------------------------------------------------------
Function      Rate (GB/s)   Avg time     Min time     Max time
Copy:           8.5584       0.1371       0.1291       0.1727
Scale:          5.3231       0.2298       0.2075       0.2767
Add:            6.1122       0.2962       0.2711       0.3920
Triad:          6.1341       0.2833       0.2701       0.2909
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Node(s) with error 0
Minimum Copy GB/s 8.558368
Average Copy GB/s 8.558368
Maximum Copy GB/s 8.558368
Minimum Scale GB/s 5.323124
Average Scale GB/s 5.323124
Maximum Scale GB/s 5.323124
Minimum Add GB/s 6.112172
Average Add GB/s 6.112172
Maximum Add GB/s 6.112172
Minimum Triad GB/s 6.134084
Average Triad GB/s 6.134084
Maximum Triad GB/s 6.134084
Current time (1742647464) is Sat Mar 22 12:44:24 2025

End of StarSTREAM section.
Begin of SingleSTREAM section.
Node(s) with error 0
Node selected 1
Single STREAM Copy GB/s 17.636391
Single STREAM Scale GB/s 11.302955
Single STREAM Add GB/s 13.091152
Single STREAM Triad GB/s 13.209959
Current time (1742647469) is Sat Mar 22 12:44:29 2025

End of SingleSTREAM section.
Begin of MPIFFT section.
Number of nodes: 2
Vector size:             33554432
Generation time:     0.529
Tuning:     0.264
Computing:     1.613
Inverse FFT:     1.743
max(|x-x0|): 2.121e-15
Gflop/s:     2.600
Current time (1742647474) is Sat Mar 22 12:44:34 2025

End of MPIFFT section.
Begin of StarFFT section.
Vector size: 33554432
Generation time:     1.088
Tuning:     0.001
Computing:     1.525
Inverse FFT:     1.718
max(|x-x0|): 2.248e-15
Node(s) with error 0
Minimum Gflop/s 2.504200
Average Gflop/s 2.627447
Maximum Gflop/s 2.750694
Current time (1742647479) is Sat Mar 22 12:44:39 2025

End of StarFFT section.
Begin of SingleFFT section.
Node(s) with error 0
Node selected 1
Single FFT Gflop/s 3.794961
Current time (1742647484) is Sat Mar 22 12:44:44 2025

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
Latency   min / avg / max:   0.007983 /   0.007983 /   0.007983 msecs
Bandwidth min / avg / max:      1.002 /      1.002 /      1.002 MByte/s

MPI_Wtime granularity is ok.
message size:                                  8
max time :                             10.000000 secs
latency for msg:                        0.007983 msecs
estimation for ping pong:               0.718464 msecs
max number of ping pong pairs       =      13918
max client pings = max server pongs =        117
stride for latency                  =          1
Message Length: 8
Latency   min / avg / max:   0.007886 /   0.007928 /   0.007969 msecs
Bandwidth min / avg / max:      1.004 /      1.009 /      1.014 MByte/s

Message Length: 2000000
Latency   min / avg / max:   0.534542 /   0.534542 /   0.534542 msecs
Bandwidth min / avg / max:   3741.517 /   3741.517 /   3741.517 MByte/s

MPI_Wtime granularity is ok.
message size:                            2000000
max time :                             30.000000 secs
latency for msg:                        0.534542 msecs
estimation for ping pong:               4.276340 msecs
max number of ping pong pairs       =       7015
max client pings = max server pongs =         83
stride for latency                  =          1
Message Length: 2000000
Latency   min / avg / max:   0.384942 /   0.386943 /   0.388945 msecs
Bandwidth min / avg / max:   5142.122 /   5168.855 /   5195.588 MByte/s

Message Size:                           8 Byte
Natural Order Latency:           0.009652 msec
Natural Order Bandwidth:         0.828861 MB/s
Avg Random Order Latency:        0.009591 msec
Avg Random Order Bandwidth:      0.834095 MB/s

Message Size:                     2000000 Byte
Natural Order Latency:           0.588747 msec
Natural Order Bandwidth:      3397.042026 MB/s
Avg Random Order Latency:        0.639890 msec
Avg Random Order Bandwidth:   3125.539506 MB/s

Execution time (wall clock)      =     0.409 sec on 2 processes
 - for cross ping_pong latency   =     0.003 sec
 - for cross ping_pong bandwidth =     0.013 sec
 - for ring latency              =     0.071 sec
 - for ring bandwidth            =     0.321 sec

------------------------------------------------------------------
Latency-Bandwidth-Benchmark R1.5.1 (c) HLRS, University of Stuttgart
Written by Rolf Rabenseifner, Gerrit Schulz, and Michael Speck, Germany

Major Benchmark results:
------------------------

Max Ping Pong Latency:                 0.007969 msecs
Randomly Ordered Ring Latency:         0.009591 msecs
Min Ping Pong Bandwidth:            5142.121819 MB/s
Naturally Ordered Ring Bandwidth:   3397.042026 MB/s
Randomly  Ordered Ring Bandwidth:   3125.539506 MB/s

------------------------------------------------------------------

Detailed benchmark results:
Ping Pong:
Latency   min / avg / max:   0.007886 /   0.007928 /   0.007969 msecs
Bandwidth min / avg / max:   5142.122 /   5168.855 /   5195.588 MByte/s
Ring:
On naturally ordered ring: latency=      0.009652 msec, bandwidth=   3397.042026 MB/s
On randomly  ordered ring: latency=      0.009591 msec, bandwidth=   3125.539506 MB/s

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
Current time (1742647484) is Sat Mar 22 12:44:44 2025

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
WR11C2R4       20352   192     1     2            1013.07              5.548e+00
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
Current time (1742648505) is Sat Mar 22 13:01:45 2025

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
HPL_Tflops=0.00554804
HPL_time=1013.07
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
StarDGEMM_Gflops=2.48054
SingleDGEMM_Gflops=3.18538
PTRANS_GBs=1.28364
PTRANS_time=0.643997
PTRANS_residual=0
PTRANS_n=10176
PTRANS_nb=192
PTRANS_nprow=1
PTRANS_npcol=2
MPIRandomAccess_LCG_N=268435456
MPIRandomAccess_LCG_time=59.8814
MPIRandomAccess_LCG_CheckTime=3.35686
MPIRandomAccess_LCG_Errors=0
MPIRandomAccess_LCG_ErrorsFraction=0
MPIRandomAccess_LCG_ExeUpdates=146992504
MPIRandomAccess_LCG_GUPs=0.00245473
MPIRandomAccess_LCG_TimeBound=60
MPIRandomAccess_LCG_Algorithm=0
MPIRandomAccess_N=268435456
MPIRandomAccess_time=30.8367
MPIRandomAccess_CheckTime=1.85698
MPIRandomAccess_Errors=0
MPIRandomAccess_ErrorsFraction=0
MPIRandomAccess_ExeUpdates=74776404
MPIRandomAccess_GUPs=0.00242492
MPIRandomAccess_TimeBound=60
MPIRandomAccess_Algorithm=0
RandomAccess_LCG_N=134217728
StarRandomAccess_LCG_GUPs=0.0356492
SingleRandomAccess_LCG_GUPs=0.0612242
RandomAccess_N=134217728
StarRandomAccess_GUPs=0.0359971
SingleRandomAccess_GUPs=0.0638123
STREAM_VectorSize=69033984
STREAM_Threads=1
StarSTREAM_Copy=8.55837
StarSTREAM_Scale=5.32312
StarSTREAM_Add=6.11217
StarSTREAM_Triad=6.13408
SingleSTREAM_Copy=17.6364
SingleSTREAM_Scale=11.303
SingleSTREAM_Add=13.0912
SingleSTREAM_Triad=13.21
FFT_N=33554432
StarFFT_Gflops=2.62745
SingleFFT_Gflops=3.79496
MPIFFT_N=33554432
MPIFFT_Gflops=2.59986
MPIFFT_maxErr=2.12072e-15
MPIFFT_Procs=2
MaxPingPongLatency_usec=7.96919
RandomlyOrderedRingLatency_usec=9.59124
MinPingPongBandwidth_GBytes=5.14212
NaturallyOrderedRingBandwidth_GBytes=3.39704
RandomlyOrderedRingBandwidth_GBytes=3.12554
MinPingPongLatency_usec=7.88594
AvgPingPongLatency_usec=7.92756
MaxPingPongBandwidth_GBytes=5.19559
AvgPingPongBandwidth_GBytes=5.16885
NaturallyOrderedRingLatency_usec=9.6518
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
MPIFFT_time0=1.383e-06
MPIFFT_time1=0.380576
MPIFFT_time2=0.147006
MPIFFT_time3=0.154289
MPIFFT_time4=0.562161
MPIFFT_time5=0.261505
MPIFFT_time6=1.022e-06
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
Current time (1742648505) is Sat Mar 22 13:01:45 2025

########################################################################