> Vemos la salida del commando `qhost` para obtener un pantallaso general de las características de cada uno de los nodos.

### qhost command
####  qhost -q command
```

[mmendez@bandurria ~]$ qhost -q
HOSTNAME                ARCH         NCPU NSOC NCOR NTHR  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
----------------------------------------------------------------------------------------------
global                  -               -    -    -    -     -       -       -       -       -
compute-0-0             lx-amd64        4    1    4    4     -    5.7G       - 1000.0M       -
   famaf                BIPC  0/0/1         au
   long                 BPC   0/0/4         u
   short                BPC   0/0/1         u
compute-0-10            lx-amd64        6    1    6    6  3.02    5.7G  449.3M 1000.0M    2.5M
   famaf                BIPC  0/0/4         
   long                 BPC   0/3/6         
   short                BPC   0/0/1         
compute-0-11            lx-amd64       12    1    6   12  5.99    5.7G  636.7M 1024.0M    4.8M
   famaf                BIPC  0/0/4         S
   long                 BPC   0/6/6         
   short                BPC   0/0/1         
compute-0-12            lx-amd64        6    1    6    6  2.01    7.6G  362.2M 1024.0M     0.0
   famaf                BIPC  0/0/4         
   long                 BPC   0/2/6         
   short                BPC   0/0/1         
compute-0-13            lx-amd64       12    1    6   12  5.02    7.6G  504.7M 1000.0M   58.5M
   famaf                BIPC  0/0/8         
   long                 BPC   0/5/6         
   short                BPC   0/0/1         
compute-0-14            lx-amd64        8    1    4    8  1.01   19.3G  412.4M 1024.0M     0.0
   famaf                BIPC  0/0/4         
   long                 BPC   0/1/4         
   short                BPC   0/0/1         
compute-0-16            lx-amd64       20    1   10   20  8.04   15.2G 1009.9M 1024.0M     0.0
   famaf                BIPC  0/0/10        
   long                 BPC   0/8/10        
   short                BPC   0/0/1         
compute-0-17            lx-amd64       10    1   10   10  5.87   15.2G  758.0M 1024.0M     0.0
   famaf                BIPC  0/0/10        
   long                 BPC   0/6/10        
   short                BPC   0/0/1         
compute-0-18            lx-amd64       16    1    8   16  3.01   31.1G  625.9M   11.2G     0.0 <---------
   famaf                BIPC  0/0/8         
   long                 BPC   0/3/8         
   short                BPC   0/0/1         
compute-0-19            lx-amd64       12    1    6   12  2.01   15.4G  528.4M    7.8G    9.5M
   famaf                BIPC  0/0/1         
   long                 BPC   0/2/6         
   short                BPC   0/0/1         
compute-0-2             lx-amd64        4    1    4    4     -    5.7G       - 1000.0M       -
   famaf                BIPC  0/0/1         auS
   long                 BPC   0/4/4         u
   short                BPC   0/0/1         u
compute-0-20            lx-amd64        8    1    8    8  1.01   15.4G  361.9M    7.8G     0.0
   famaf                BIPC  0/0/1         
   long                 BPC   0/1/8         
   short                BPC   0/0/1         
compute-0-21            lx-amd64       16    1    8   16  1.09   15.4G  322.1M 1024.0M   50.2M <---------
   famaf                BIPC  0/0/10        
   long                 BPC   0/1/8         
   short                BPC   0/0/1         
compute-0-22            lx-amd64       16    1    8   16  3.01   62.6G  814.7M 1024.0M     0.0 <---------
   famaf                BIPC  0/0/1         
   long                 BPC   0/3/8         
   short                BPC   0/0/1         
compute-0-23            lx-amd64       20    1   10   20  9.99   31.1G    1.2G 1024.0M     0.0
   famaf                BIPC  0/0/1         S
   long                 BPC   0/10/10       
   short                BPC   0/0/1         
compute-0-24            lx-amd64       16    1    8   16  1.01   38.9G  556.4M 1024.0M   36.0M <---------
   famaf                BIPC  0/0/1         
   long                 BPC   0/1/8         
   short                BPC   0/0/1         
compute-0-3             lx-amd64        4    1    4    4     -    5.7G       -  996.2M       -
   famaf                BIPC  0/0/1         au
   long                 BPC   0/0/4         u
   short                BPC   0/0/1         u
compute-0-4             lx-amd64        4    1    4    4     -    5.7G       - 1000.0M       -
   famaf                BIPC  0/0/1         au
   long                 BPC   0/0/8         u
   short                BPC   0/0/1         u
compute-0-5             lx-amd64        4    1    4    4  3.02    5.7G  374.0M 1024.0M     0.0
   famaf                BIPC  0/0/4         S
   long                 BPC   0/3/3         
   short                BPC   0/0/1         
compute-0-7             lx-amd64        4    1    4    4  3.01    5.7G  390.5M  996.2M     0.0
   famaf                BIPC  0/0/8         
   long                 BPC   0/3/4         
   short                BPC   0/0/1         
compute-0-8             lx-amd64        8    2    8    8  0.01   23.3G  337.5M 1000.0M     0.0
   famaf                BIPC  0/0/4         E
   long                 BPC   0/0/8         E
   short                BPC   0/0/1         E
compute-0-9             lx-amd64        4    1    4    4  2.01    5.7G  359.1M 1000.0M     0.0
   famaf                BIPC  0/0/4         
   long                 BPC   0/2/4         
   short                BPC   0/0/1         
gpu-compute-0-0         lx-amd64        8    1    4    8     -    5.7G       - 1000.0M       -
   famaf                BIPC  0/0/1         auS
   long                 BPC   0/4/4         u
   short                BPC   0/0/1         u
gpu-compute-0-1         lx-amd64        4    1    4    4     -    5.7G       - 1000.0M       -
   famaf                BIPC  0/0/1         au
   long                 BPC   0/0/4         u
   short                BPC   0/0/1         u
gpu-compute-0-2         lx-amd64        4    1    4    4  3.01    5.7G  382.9M 1000.0M     0.0
   famaf                BIPC  0/0/1         
   long                 BPC   0/3/4         
   short                BPC   0/0/1         
```

> Luego de ver la salida de este comando elegimos los nodos 18, 21, 22 y 24 para analizar. Para ello realizamos un script en cluster bandurria para ejecutar en cada nodo (de forma excluyente) y ver la salida de los comandos `cpuinfo` y `lscpu`.

### cpuinfo command
#### long@compute-0-18
```
Intel(R) processor family information utility, Version 2021.1 Build 20201112 (id: b9c9d2fc5)
Copyright (C) 2005-2020 Intel Corporation.  All rights reserved.

=====  Processor composition  =====
Processor name    : Intel(R) Core(TM) i9-9900K  
Packages(sockets) : 1
Cores             : 8
Processors(CPUs)  : 16
Cores per package : 8
Threads per core  : 2

=====  Processor identification  =====
Processor	Thread Id.	Core Id.	Package Id.
0       	0   		0   		0   
1       	0   		1   		0   
2       	0   		2   		0   
3       	0   		3   		0   
4       	0   		4   		0   
5       	0   		5   		0   
6       	0   		6   		0   
7       	0   		7   		0   
8       	1   		0   		0   
9       	1   		1   		0   
10      	1   		2   		0   
11      	1   		3   		0   
12      	1   		4   		0   
13      	1   		5   		0   
14      	1   		6   		0   
15      	1   		7   		0   
=====  Placement on packages  =====
Package Id.	Core Id.	Processors
0   		0,1,2,3,4,5,6,7		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)

=====  Cache sharing  =====
Cache	Size		Processors
L1	32  KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L2	256 KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L3	16  MB		(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
```
#### long@compute-0-21
```
Intel(R) processor family information utility, Version 2021.1 Build 20201112 (id: b9c9d2fc5)
Copyright (C) 2005-2020 Intel Corporation.  All rights reserved.

=====  Processor composition  =====
Processor name    : Intel(R) Core(TM) i7-10700  
Packages(sockets) : 1
Cores             : 8
Processors(CPUs)  : 16
Cores per package : 8
Threads per core  : 2

=====  Processor identification  =====
Processor	Thread Id.	Core Id.	Package Id.
0       	0   		0   		0   
1       	0   		1   		0   
2       	0   		2   		0   
3       	0   		3   		0   
4       	0   		4   		0   
5       	0   		5   		0   
6       	0   		6   		0   
7       	0   		7   		0   
8       	1   		0   		0   
9       	1   		1   		0   
10      	1   		2   		0   
11      	1   		3   		0   
12      	1   		4   		0   
13      	1   		5   		0   
14      	1   		6   		0   
15      	1   		7   		0   
=====  Placement on packages  =====
Package Id.	Core Id.	Processors
0   		0,1,2,3,4,5,6,7		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)

=====  Cache sharing  =====
Cache	Size		Processors
L1	32  KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L2	256 KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L3	16  MB		(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
```
#### long@compute-0-22
```
Intel(R) processor family information utility, Version 2021.1 Build 20201112 (id: b9c9d2fc5)
Copyright (C) 2005-2020 Intel Corporation.  All rights reserved.

=====  Processor composition  =====
Processor name    : Intel(R) Core(TM) i7-10700K  
Packages(sockets) : 1
Cores             : 8
Processors(CPUs)  : 16
Cores per package : 8
Threads per core  : 2

=====  Processor identification  =====
Processor	Thread Id.	Core Id.	Package Id.
0       	0   		0   		0   
1       	0   		1   		0   
2       	0   		2   		0   
3       	0   		3   		0   
4       	0   		4   		0   
5       	0   		5   		0   
6       	0   		6   		0   
7       	0   		7   		0   
8       	1   		0   		0   
9       	1   		1   		0   
10      	1   		2   		0   
11      	1   		3   		0   
12      	1   		4   		0   
13      	1   		5   		0   
14      	1   		6   		0   
15      	1   		7   		0   
=====  Placement on packages  =====
Package Id.	Core Id.	Processors
0   		0,1,2,3,4,5,6,7		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)

=====  Cache sharing  =====
Cache	Size		Processors
L1	32  KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L2	256 KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L3	16  MB		(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
```
#### long@compute-0-24
```
Intel(R) processor family information utility, Version 2021.1 Build 20201112 (id: b9c9d2fc5)
Copyright (C) 2005-2020 Intel Corporation.  All rights reserved.

=====  Processor composition  =====
Processor name    : 11th Gen Intel(R) Core(TM) i9-11900K @ 3.50GHz  
Packages(sockets) : 1
Cores             : 8
Processors(CPUs)  : 16
Cores per package : 8
Threads per core  : 2

=====  Processor identification  =====
Processor	Thread Id.	Core Id.	Package Id.
0       	0   		0   		0   
1       	0   		1   		0   
2       	0   		2   		0   
3       	0   		3   		0   
4       	0   		4   		0   
5       	0   		5   		0   
6       	0   		6   		0   
7       	0   		7   		0   
8       	1   		0   		0   
9       	1   		1   		0   
10      	1   		2   		0   
11      	1   		3   		0   
12      	1   		4   		0   
13      	1   		5   		0   
14      	1   		6   		0   
15      	1   		7   		0   
=====  Placement on packages  =====
Package Id.	Core Id.	Processors
0   		0,1,2,3,4,5,6,7		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)

=====  Cache sharing  =====
Cache	Size		Processors
L1	48  KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L2	512 KB		(0,8)(1,9)(2,10)(3,11)(4,12)(5,13)(6,14)(7,15)
L3	16  MB		(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
```
### lscpu command
#### long@compute-0-18
```
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 158
Model name:            Intel(R) Core(TM) i9-9900K CPU @ 3.60GHz
Stepping:              12
CPU MHz:               4594.262
CPU max MHz:           5000.0000
CPU min MHz:           800.0000
BogoMIPS:              7200.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              16384K
NUMA node0 CPU(s):     0-15
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch invpcid_single intel_pt ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
command: cpuinfo
```
#### long@compute-0-21
```
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 165
Model name:            Intel(R) Core(TM) i7-10700 CPU @ 2.90GHz
Stepping:              5
CPU MHz:               4692.498
CPU max MHz:           4800.0000
CPU min MHz:           800.0000
BogoMIPS:              5800.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              16384K
NUMA node0 CPU(s):     0-15
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch invpcid_single intel_pt ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp pku ospke md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
```
#### long@compute-0-22
```
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 165
Model name:            Intel(R) Core(TM) i7-10700K CPU @ 3.80GHz
Stepping:              5
CPU MHz:               4857.385
CPU max MHz:           5100.0000
CPU min MHz:           800.0000
BogoMIPS:              7600.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              16384K
NUMA node0 CPU(s):     0-15
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch invpcid_single intel_pt ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp pku ospke md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
```
#### long@compute-0-24
```
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 167
Model name:            11th Gen Intel(R) Core(TM) i9-11900K @ 3.50GHz
Stepping:              1
CPU MHz:               4861.633
CPU max MHz:           5300.0000
CPU min MHz:           800.0000
BogoMIPS:              7008.00
Virtualization:        VT-x
L1d cache:             48K
L1i cache:             32K
L2 cache:              512K
L3 cache:              16384K
NUMA node0 CPU(s):     0-15
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch invpcid_single intel_pt ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx avx512f avx512dq rdseed adx smap avx512ifma clflushopt avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp hwp_pkg_req avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq md_clear spec_ctrl intel_stibp flush_l1d arch_capabilities
```

> Para completar el analisis corremos los comandos `lsb_release` y `lsblk` para obtener alguna información extra del cluster. Estos commando se ejectutaron en el nodo global, es decir, los resultados son comunes a todos los nodos.

### lsb_release -a command
> Distribution-specific information such as, description of the currently installed distribution, release number and code name
```
[mmendez@bandurria ~]$ lsb_release -a
LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
Distributor ID:	CentOS
Description:	CentOS Linux release 7.8.2003 (Core)
Release:	7.8.2003
Codename:	Core
```
### lsblk command
> List block storage devices
```
[mmendez@bandurria ~]$ lsblk
NAME      MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda         8:0    0 931,5G  0 disk  
├─sda1      8:1    0  78,1G  0 part  
│ └─md127   9:127  0  78,1G  0 raid1 /
├─sda2      8:2    0   3,9G  0 part  
│ └─md126   9:126  0   3,9G  0 raid1 [SWAP]
└─sda3      8:3    0 849,5G  0 part  
  └─md2     9:2    0 849,5G  0 raid1 /export
sdb         8:16   0 931,5G  0 disk  
├─sdb1      8:17   0  78,1G  0 part  
│ └─md127   9:127  0  78,1G  0 raid1 /
├─sdb2      8:18   0   3,9G  0 part  
│ └─md126   9:126  0   3,9G  0 raid1 [SWAP]
└─sdb3      8:19   0 849,5G  0 part  
  └─md2     9:2    0 849,5G  0 raid1 /export
```

> Con estos resultados vemos que hay diferencias significativas entre los diferentes nodos.
> Todos los nodos tienen 8 cores físicos y 2 cores lógicos, haciendo un total de 16 threads.
> Todos los nodos tienen la misma arquitectura de `x86_64`.
> Los nodos 18 y 24, si bien son chips i9, laburan a diferente frecuencia de procesamiento y la distribución de memoria en los niveles de cache son distintos.
> Los nodos 21 y 22 son iguales. Mismo chip i7, mismo rango de frecuencias y misma distribución de moemoria.

> Estrictamente deberiamos usar sólo los nodos 21 y 22 ya que presentan diferencias despreciables (diferencias de fabricación), pero para realizar las simulaciones más rápido necesitamos utilizar más de dos nodos, por ello utilizaremos también los nodos 18 y 24 pero deberemos tener en cuenta las diferencias sustanciales qu existen entre todos los nodos.




