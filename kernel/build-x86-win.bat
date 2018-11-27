
:SetUp
@echo off

rem 
rem Compiling a kernel base for x86 processors.
rem The binary format is PE. $.
rem This script generate the file KERNEL.BIN.
rem 
rem  gcc 3.4.2 mingw-special
rem  nasm 2.05.01
rem  ld 2.19
rem
rem (c) Copyright 2005-2018 Fred Nora.
rem

    set GramadoDrive=c:
   
    set GramadoRoot=%GramadoDrive%\gramado

    rem cd c:\sdk\bin
    cd %GramadoDrive%\sdk\bin
	
echo ~{ ...
echo ~{ Gramado 0.4 Love and Forgiveness

:Start_Job0
rem Main.
echo ~{ ...
echo ~{ Compiling KERNEL.BIN ...

rem echo ~{ ...
echo ~{ /3rdparty
    gcc -c c:/gramado/kernel/3rdparty/kernel/disk/disk1.c   -I c:/gramado/include -o disk1.o
	
rem echo ~{ ...
echo ~{ /entry

	rem head.s
	nasm  -I  c:/gramado/kernel/entry/x86/head/  c:/gramado/kernel/entry/x86/head/head.s  -f elf -o head.o
	
	rem x86main.o
	gcc -c c:/gramado/kernel/entry/x86/x86main.c -I c:/gramado/include -o x86main.o 
	
:Hal_Job1	
rem hal	
rem echo ~{ ...
echo ~{ ux4 /hal	
	gcc -c c:/gramado/kernel/hal/hal.c -I c:/gramado/include -o hal.o	
	
	gcc -c c:/gramado/kernel/hal/arch/x86/syscall.c  -I c:/gramado/include -o syscall.o		
	gcc -c c:/gramado/kernel/hal/arch/x86/cpux86.c   -I c:/gramado/include -o cpux86.o 
    gcc -c c:/gramado/kernel/hal/arch/x86/x86.c      -I c:/gramado/include -o x86.o	
	gcc -c c:/gramado/kernel/hal/arch/x86/ports.c    -I c:/gramado/include -o ports.o 	
	gcc -c c:/gramado/kernel/hal/arch/amd/cpuamd.c   -I c:/gramado/include -o cpuamd.o 	    	
	
	
:Microkernel_Job2	
rem echo ~{ ...
echo ~{ ux3 /mk
	
    rem c. 
    gcc -c  c:/gramado/kernel/mk/mk.c -I c:/gramado/include  -o mk.o
	
	rem cpu
	gcc -c  c:/gramado/kernel/mk/cpu/context.c  -I c:/gramado/include  -o context.o
	gcc -c  c:/gramado/kernel/mk/cpu/start.c    -I c:/gramado/include  -o start.o
	
	rem
	rem /pc process control ( ipc, sched, mm )
	rem
	
	gcc -c  c:/gramado/kernel/mk/pc/action/ts.c        -I c:/gramado/include  -o ts.o	
    gcc -c  c:/gramado/kernel/mk/pc/action/dispatch.c  -I c:/gramado/include  -o dispatch.o	
	gcc -c  c:/gramado/kernel/mk/pc/action/queue.c     -I c:/gramado/include  -o queue.o
	gcc -c  c:/gramado/kernel/mk/pc/action/process.c   -I c:/gramado/include  -o process.o
    gcc -c  c:/gramado/kernel/mk/pc/action/pheap.c     -I c:/gramado/include  -o pheap.o	
    gcc -c  c:/gramado/kernel/mk/pc/action/thread.c    -I c:/gramado/include  -o thread.o		
    gcc -c  c:/gramado/kernel/mk/pc/action/threadi.c   -I c:/gramado/include  -o threadi.o
    gcc -c  c:/gramado/kernel/mk/pc/action/theap.c     -I c:/gramado/include  -o theap.o
    gcc -c  c:/gramado/kernel/mk/pc/action/tstack.c    -I c:/gramado/include  -o tstack.o	
    gcc -c  c:/gramado/kernel/mk/pc/action/tasks.c     -I c:/gramado/include  -o tasks.o	
	gcc -c  c:/gramado/kernel/mk/pc/action/create.c    -I c:/gramado/include  -o create.o
	gcc -c  c:/gramado/kernel/mk/pc/action/spawn.c     -I c:/gramado/include  -o spawn.o
	
	rem mk/pc/ipc 
	gcc -c  c:/gramado/kernel/mk/pc/ipc/callout.c  -I c:/gramado/include  -o callout.o
	gcc -c  c:/gramado/kernel/mk/pc/ipc/callfar.c  -I c:/gramado/include  -o callfar.o
    gcc -c  c:/gramado/kernel/mk/pc/ipc/ipc.c      -I c:/gramado/include  -o ipc.o	
    gcc -c  c:/gramado/kernel/mk/pc/ipc/sem.c      -I c:/gramado/include  -o sem.o
	rem ...
	
	rem mk/pc/sched
    gcc -c  c:/gramado/kernel/mk/pc/sched/sched.c  -I c:/gramado/include -o sched.o
    gcc -c  c:/gramado/kernel/mk/pc/sched/schedi.c -I c:/gramado/include -o schedi.o    	
	
	rem /mk/pc/mm (memory manager)
    gcc -c  c:/gramado/kernel/mk/pc/mm/memory.c  -I c:/gramado/include -o memory.o    
    gcc -c  c:/gramado/kernel/mk/pc/mm/pages.c   -I c:/gramado/include -o pages.o 	
	
	gcc -c  c:/gramado/kernel/mk/request.c -I c:/gramado/include -o request.o	
	gcc -c  c:/gramado/kernel/mk/faults.c  -I c:/gramado/include -o faults.o		
	
	
:Executive_Job3	
rem echo ~{ ...
echo ~{ ux2 /execve
	
	rem /execve
	gcc -c c:/gramado/kernel/execve/execve.c  -I c:/gramado/include -o execve.o	
	
	rem /crts
    gcc -c c:/gramado/kernel/execve/crts/libc/cedge.c  -I c:/gramado/include -o cedge.o	
	gcc -c c:/gramado/kernel/execve/crts/libc/ctype.c  -I c:/gramado/include -o ctype.o	
	gcc -c c:/gramado/kernel/execve/crts/libc/stdlib.c -I c:/gramado/include -o stdlib.o
	gcc -c c:/gramado/kernel/execve/crts/libc/stdio.c  -I c:/gramado/include -o stdio.o
    gcc -c c:/gramado/kernel/execve/crts/libc/string.c -I c:/gramado/include -o string.o	
	
    rem /dd
	gcc -c c:/gramado/kernel/execve/dd/apic.c      -I c:/gramado/include -o apic.o 	
	gcc -c c:/gramado/kernel/execve/dd/hdd.c       -I c:/gramado/include -o hdd.o	
	gcc -c c:/gramado/kernel/execve/dd/pic.c       -I c:/gramado/include -o pic.o 
	gcc -c c:/gramado/kernel/execve/dd/rtc.c       -I c:/gramado/include -o rtc.o	
	gcc -c c:/gramado/kernel/execve/dd/screen.c    -I c:/gramado/include -o screen.o 	
    gcc -c c:/gramado/kernel/execve/dd/timer.c     -I c:/gramado/include -o timer.o		
	gcc -c c:/gramado/kernel/execve/dd/video.c     -I c:/gramado/include -o video.o  
	gcc -c c:/gramado/kernel/execve/dd/vsync.c     -I c:/gramado/include -o vsync.o 


    rem dd/devmgr
	gcc -c c:/gramado/kernel/execve/dd/devmgr/devmgr.c  -I c:/gramado/include -o devmgr.o

	rem dd/i8042
	gcc -c c:/gramado/kernel/execve/dd/i8042/i8042.c     -I c:/gramado/include -o i8042.o
    gcc -c c:/gramado/kernel/execve/dd/i8042/ps2mouse.c  -I c:/gramado/include -o ps2mouse.o
    gcc -c c:/gramado/kernel/execve/dd/i8042/ps2kbd.c    -I c:/gramado/include -o ps2kbd.o  	
	gcc -c c:/gramado/kernel/execve/dd/i8042/keyboard.c  -I c:/gramado/include -o keyboard.o
    gcc -c c:/gramado/kernel/execve/dd/i8042/mouse.c     -I c:/gramado/include -o mouse.o  		
	
	rem dd/ldisc
	gcc -c c:/gramado/kernel/execve/dd/ldisc/ldisc.c     -I c:/gramado/include -o ldisc.o 
		
	rem dd/pci
	gcc -c c:/gramado/kernel/execve/dd/pci/pci.c       -I c:/gramado/include -o pci.o  

	
	
	rem dd/network
	gcc -c c:/gramado/kernel/execve/dd/network/intel.c    -I c:/gramado/include -o nicintel.o
	gcc -c c:/gramado/kernel/execve/dd/network/network.c  -I c:/gramado/include -o network.o
	gcc -c c:/gramado/kernel/execve/dd/network/socket.c   -I c:/gramado/include -o socket.o
	
	rem dd/tty
    gcc -c c:/gramado/kernel/execve/dd/tty/tty.c         -I c:/gramado/include -o tty.o		
	
	rem dd/usb
	gcc -c c:/gramado/kernel/execve/dd/usb/usb.c       -I c:/gramado/include -o usb.o		
	
	rem execve/fs
    gcc -c c:/gramado/kernel/execve/fs/fs.c     -I c:/gramado/include -o fs.o						
    gcc -c c:/gramado/kernel/execve/fs/read.c   -I c:/gramado/include -o read.o			
    gcc -c c:/gramado/kernel/execve/fs/write.c  -I c:/gramado/include -o write.o			
    gcc -c c:/gramado/kernel/execve/fs/cf.c     -I c:/gramado/include -o cf.o			
    gcc -c c:/gramado/kernel/execve/fs/search.c -I c:/gramado/include -o search.o			
    gcc -c c:/gramado/kernel/execve/fs/format.c -I c:/gramado/include -o format.o	
    gcc -c c:/gramado/kernel/execve/fs/vfs.c    -I c:/gramado/include -o vfs.o			
	
	rem execve/sci
    gcc -c c:/gramado/kernel/execve/sci/services.c  -I c:/gramado/include -o services.o			
	
 
 	rem execve/sm
    gcc -c c:/gramado/kernel/execve/sm/init/init.c -I c:/gramado/include -o init.o
	gcc -c c:/gramado/kernel/execve/sm/ob/object.c -I c:/gramado/include -o object.o		    
	gcc -c c:/gramado/kernel/execve/sm/sys/modules.c  -I c:/gramado/include -o modules.o
    gcc -c c:/gramado/kernel/execve/sm/sys/proc.c     -I c:/gramado/include -o proc.o	
    gcc -c c:/gramado/kernel/execve/sm/sys/abort.c    -I c:/gramado/include -o abort.o		
    gcc -c c:/gramado/kernel/execve/sm/sys/info.c     -I c:/gramado/include -o info.o	
    gcc -c c:/gramado/kernel/execve/sm/sys/sm.c       -I c:/gramado/include -o sm.o
    gcc -c c:/gramado/kernel/execve/sm/sys/channel.c  -I c:/gramado/include -o channel.o	
    gcc -c c:/gramado/kernel/execve/sm/sys/signal.c   -I c:/gramado/include -o signal.o	
    gcc -c c:/gramado/kernel/execve/sm/sys/system.c   -I c:/gramado/include -o system.o
	gcc -c c:/gramado/kernel/execve/sm/sys/io.c       -I c:/gramado/include -o io.o	
	gcc -c c:/gramado/kernel/execve/sm/rt/runtime.c   -I c:/gramado/include -o runtime.o
	gcc -c c:/gramado/kernel/execve/sm/disk/diskvol.c -I c:/gramado/include -o diskvol.o
    gcc -c c:/gramado/kernel/execve/sm/install/install.c -I c:/gramado/include -o install.o    
	gcc -c c:/gramado/kernel/execve/sm/debug/debug.c -I c:/gramado/include -o debug.o	

	
rem echo ~{ ...
echo ~{ ux1 /gws \o/
    	
    
	rem k\gws\gws	
    rem Gramado Window Server.
    gcc -c c:/gramado/kernel/gws/gws/char.c     -I c:/gramado/include -o char.o
    gcc -c c:/gramado/kernel/gws/gws/pixel.c    -I c:/gramado/include -o pixel.o 
    gcc -c c:/gramado/kernel/gws/gws/line.c     -I c:/gramado/include -o line.o	
    gcc -c c:/gramado/kernel/gws/gws/rect.c     -I c:/gramado/include -o rect.o 
    gcc -c c:/gramado/kernel/gws/gws/dtext.c    -I c:/gramado/include -o dtext.o
    gcc -c c:/gramado/kernel/gws/gws/font.c     -I c:/gramado/include -o font.o	
    gcc -c c:/gramado/kernel/gws/gws/createw.c  -I c:/gramado/include -o createw.o    
    gcc -c c:/gramado/kernel/gws/gws/grid.c     -I c:/gramado/include -o grid.o 
    gcc -c c:/gramado/kernel/gws/gws/sbar.c     -I c:/gramado/include -o sbar.o 
    gcc -c c:/gramado/kernel/gws/gws/menubar.c   -I c:/gramado/include -o menubar.o 
    gcc -c c:/gramado/kernel/gws/gws/menu.c      -I c:/gramado/include -o menu.o 
    gcc -c c:/gramado/kernel/gws/gws/bmp.c       -I c:/gramado/include -o bmp.o 
    gcc -c c:/gramado/kernel/gws/gws/button.c    -I c:/gramado/include -o button.o 
	gcc -c c:/gramado/kernel/gws/gws/bg.c        -I c:/gramado/include -o bg.o  
    gcc -c c:/gramado/kernel/gws/gws/window.c    -I c:/gramado/include -o window.o  
    
	rem gramado logon e logoff
    gcc -c c:/gramado/kernel/gws/logon/logon.c    -I c:/gramado/include -o logon.o 
    gcc -c c:/gramado/kernel/gws/logoff/logoff.c  -I c:/gramado/include -o logoff.o 

	rem gramado/user
	gcc -c c:/gramado/kernel/gws/user/userenv.c   -I c:/gramado/include -o userenv.o 	
    gcc -c c:/gramado/kernel/gws/user/desktop.c   -I c:/gramado/include -o desktop.o  
    gcc -c c:/gramado/kernel/gws/user/room.c      -I c:/gramado/include -o room.o    
    gcc -c c:/gramado/kernel/gws/user/usession.c  -I c:/gramado/include -o usession.o   
	
	rem *gui (GRAMADO)
    gcc -c c:/gramado/kernel/gws/gws.c   -I c:/gramado/include -o gws.o    	
	

rem 
rem ## Objects ##
rem 
	
:Objects	
set myObjects=head.o ^
x86main.o ^
io.o ^
hal.o ^
mk.o ^
execve.o ^
video.o ^
screen.o ^
runtime.o ^
ports.o ^
x86.o ^
stdio.o ^
stdlib.o ^
string.o ^
tty.o ^
init.o ^
logon.o ^
logoff.o ^
cpux86.o ^
cpuamd.o ^
memory.o ^
pages.o ^
apic.o ^
pic.o ^
timer.o ^
rtc.o ^
keyboard.o ^
mouse.o ^
ldisc.o ^
hdd.o ^
pci.o ^
usb.o ^
devmgr.o ^
spawn.o ^
callout.o ^
callfar.o ^
process.o ^
pheap.o ^
thread.o ^
threadi.o ^
theap.o ^
tstack.o ^
create.o ^
start.o ^
context.o ^
tasks.o ^
ts.o ^
queue.o ^
sched.o ^
schedi.o ^
dispatch.o ^
sem.o ^
modules.o ^
nicintel.o ^
network.o ^
socket.o ^
sm.o ^
channel.o ^
ipc.o ^
read.o ^
write.o ^
cf.o ^
search.o ^
format.o ^
disk1.o ^
diskvol.o ^
fs.o ^
vfs.o ^
cedge.o ^
ctype.o ^
request.o ^
info.o ^
signal.o ^
system.o ^
bg.o ^
grid.o ^
sbar.o ^
menubar.o ^
menu.o ^
i8042.o ^
ps2mouse.o ^
ps2kbd.o ^
button.o ^
char.o ^
pixel.o ^
line.o ^
rect.o ^
dtext.o ^
font.o ^
vsync.o ^
bmp.o ^
createw.o ^
window.o ^
desktop.o ^
room.o ^
usession.o ^
gws.o ^
object.o ^
userenv.o ^
proc.o ^
syscall.o ^
install.o ^
debug.o ^
abort.o ^
faults.o ^
services.o  



:Linking_Job4 
echo ~{ ...
echo ~{ Linking objects ...
   ld -T c:/gramado/kernel/link.ld -o KERNEL.BIN %myObjects% 
   
:Moving_Job5  
echo ~{ ...
echo ~{ Moving ...   
    move KERNEL.BIN c:\gramado\bin\KERNEL.BIN
	
:Clean_Job6	
rem echo ~{ ...
echo ~{ Clean.
    del *.o
 
:End 
echo End!
	pause
	