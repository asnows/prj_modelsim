
�
mXILINX_TCLAPP_REPO is set to '%s'. Refresh XilinxTclStore catalog is disabled when XILINX_TCLAPP_REPO is set.501*common2?
+D:/Xilinx/Vivado/2018.1/data/XilinxTclStore2default:defaultZ17-748h px� 
�
Command: %s
53*	vivadotcl2l
Xsynth_design -top top -part xc7z020clg400-1 -flatten_hierarchy full -mode out_of_context2default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7z0202default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7z0202default:defaultZ17-349h px� 
�
%s*synth2�
wStarting RTL Elaboration : Time (s): cpu = 00:00:02 ; elapsed = 00:00:02 . Memory (MB): peak = 417.047 ; gain = 96.762
2default:defaulth px� 
�
synthesizing module '%s'%s4497*oasys2
top2default:default2
 2default:default2k
UE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.srcs/sources_1/new/top.v2default:default2
232default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
lvds2default:default2
 2default:default2P
:E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.v2default:default2
152default:default8@Z8-6157h px� 
�
5ignoring illegal expression in output port connection2900*oasys2k
UE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.srcs/sources_1/new/top.v2default:default2
502default:default8@Z8-2900h px� 
�
Ginstance '%s' of module '%s' requires %s connections, but only %s given350*oasys2
lvds_i2default:default2
lvds2default:default2
172default:default2
132default:default2k
UE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.srcs/sources_1/new/top.v2default:default2
422default:default8@Z8-350h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
top2default:default2
 2default:default2
12default:default2
12default:default2k
UE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.srcs/sources_1/new/top.v2default:default2
232default:default8@Z8-6155h px� 
{
!design %s has unconnected port %s3331*oasys2
top2default:default2
	tx_clkdiv2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_p[3]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_p[2]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_p[1]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_n[3]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_n[2]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_n[1]2default:defaultZ8-3331h px� 
�
%s*synth2�
xFinished RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 471.625 ; gain = 151.340
2default:defaulth px� 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 471.625 ; gain = 151.340
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 471.625 ; gain = 151.340
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
Loading part %s157*device2#
xc7z020clg400-12default:defaultZ21-403h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2m
WE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.srcs/constrs_1/new/top.xdc2default:default8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2m
WE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.srcs/constrs_1/new/top.xdc2default:default8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2k
WE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.srcs/constrs_1/new/top.xdc2default:default2)
.Xil/top_propImpl.xdc2default:defaultZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0142default:default2
770.1332default:default2
0.0002default:defaultZ17-268h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
~Finished Constraint Validation : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 770.133 ; gain = 449.848
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Loading part: xc7z020clg400-1
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 770.133 ; gain = 449.848
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 770.133 ; gain = 449.848
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:16 ; elapsed = 00:00:16 . Memory (MB): peak = 770.133 ; gain = 449.848
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Y
%s
*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Hierarchical RTL Component report 
2default:defaulth p
x
� 
8
%s
*synth2 
Module top 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
[
%s
*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2k
WPart Resources:
DSPs: 220 (col length:60)
BRAMs: 280 (col length: RAMB18 60 RAMB36 30)
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
]
%s
*synth2E
1Warning: Parallel synthesis criteria is not met 
2default:defaulth p
x
� 
{
!design %s has unconnected port %s3331*oasys2
top2default:default2
	tx_clkdiv2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_p[3]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_p[2]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_p[1]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_n[3]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_n[2]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
top2default:default2
datain_n[1]2default:defaultZ8-3331h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 770.133 ; gain = 449.848
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:25 ; elapsed = 00:00:27 . Memory (MB): peak = 829.691 ; gain = 509.406
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
|Finished Timing Optimization : Time (s): cpu = 00:00:25 ; elapsed = 00:00:27 . Memory (MB): peak = 829.691 ; gain = 509.406
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
{Finished Technology Mapping : Time (s): cpu = 00:00:25 ; elapsed = 00:00:27 . Memory (MB): peak = 839.723 ; gain = 519.438
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[7]2default:defaultZ8-4442h px� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[6]2default:defaultZ8-4442h px� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[5]2default:defaultZ8-4442h px� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[4]2default:defaultZ8-4442h px� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[3]2default:defaultZ8-4442h px� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[2]2default:defaultZ8-4442h px� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[1]2default:defaultZ8-4442h px� 
�
*BlackBox module %s has unconnected pin %s
3599*oasys2
lvds_i2default:default2

pattern[0]2default:defaultZ8-4442h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
uFinished IO Insertion : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 839.723 ; gain = 519.438
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 839.723 ; gain = 519.438
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 839.723 ; gain = 519.438
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
� 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
� 
O
%s
*synth27
#|      |BlackBox name |Instances |
2default:defaulth p
x
� 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
� 
O
%s
*synth27
#|1     |lvds          |         1|
2default:defaulth p
x
� 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
� 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px� 
I
%s*synth21
+------+------------+------+
2default:defaulth px� 
I
%s*synth21
|      |Cell        |Count |
2default:defaulth px� 
I
%s*synth21
+------+------------+------+
2default:defaulth px� 
I
%s*synth21
|1     |lvds_bbox_0 |     1|
2default:defaulth px� 
I
%s*synth21
|2     |LUT4        |     1|
2default:defaulth px� 
I
%s*synth21
|3     |LUT5        |     1|
2default:defaulth px� 
I
%s*synth21
|4     |FDRE        |     1|
2default:defaulth px� 
I
%s*synth21
+------+------------+------+
2default:defaulth px� 
E
%s
*synth2-

Report Instance Areas: 
2default:defaulth p
x
� 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
� 
N
%s
*synth26
"|      |Instance |Module |Cells |
2default:defaulth p
x
� 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
� 
N
%s
*synth26
"|1     |top      |       |    17|
2default:defaulth p
x
� 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 839.723 ; gain = 519.438
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 8 critical warnings and 7 warnings.
2default:defaulth p
x
� 
�
%s
*synth2�
~Synthesis Optimization Runtime : Time (s): cpu = 00:00:13 ; elapsed = 00:00:16 . Memory (MB): peak = 839.723 ; gain = 220.930
2default:defaulth p
x
� 
�
%s
*synth2�
Synthesis Optimization Complete : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 839.723 ; gain = 519.438
2default:defaulth p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
Parsing EDIF File [%s]
106*designutils2P
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:defaultZ20-106h px� 
�
 Finished Parsing EDIF File [%s]
97*designutils2P
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:defaultZ20-97h px� 
e
-Analyzing %s Unisim elements for replacement
17*netlist2
92default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
12default:defaultZ29-28h px� 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2018.22default:defaultZ1-479h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2)
lvds_i/bit_align_en2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
26222default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/bitslip_en2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
26292default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2

IOSTANDARD2default:default2)
lvds_i/dataout_p[0]2default:default2

IOSTANDARD2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
26672default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[0]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27142default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[1]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27212default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[2]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27282default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[3]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27352default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[4]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27422default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[5]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27492default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[6]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27562default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/pattern[7]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
27632default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[0]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28032default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[1]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28102default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[2]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28172default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[3]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28242default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[4]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28312default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[5]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28382default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[6]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28452default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2'
lvds_i/rx_data[7]2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28522default:default8@Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
	DIFF_TERM2default:default2(
lvds_i/rx_data_clk2default:default2
	DIFF_TERM2default:default2R
<E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.edf2default:default2
28622default:default8@Z18-550h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
!Unisim Transformation Summary:
%s111*project2�
n  A total of 2 instances were transformed.
  IBUFDS_DIFF_OUT => IBUFDS_DIFF_OUT (IBUFDS, IBUFDS): 2 instances
2default:defaultZ1-111h px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
162default:default2
362default:default2
82default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:282default:default2
00:00:302default:default2
862.2852default:default2
554.8242default:defaultZ17-268h px� 
K
"No constraint will be written out.1103*constraintsZ18-5210h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2e
QE:/WorkSpace/project/FPGA/prj_modelsim/prj_iptest/prj_iptest.runs/synth_1/top.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2p
\Executing : report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb
2default:defaulth px� 
�
sreport_utilization: Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.036 . Memory (MB): peak = 862.285 ; gain = 0.000
*commonh px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Fri Dec 20 15:54:16 20192default:defaultZ17-206h px� 


End Record