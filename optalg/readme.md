### test machine
System:
  Kernel: 6.1.0-31-amd64 arch: x86_64 bits: 64 compiler: gcc v: 12.2.0 Desktop: Cinnamon v: 6.4.7
    tk: GTK v: 3.24.38 wm: muffin vt: 7 dm: LightDM v: 1.26.0 Distro: LMDE 6 Faye
    base: Debian 12.1 bookworm
Machine:
  Type: Desktop Mobo: ASRock model: B150M Pro4 serial: <superuser required>
    UEFI-[Legacy]: American Megatrends v: P1.20 date: 09/03/2015
CPU:
  Info: quad core model: Intel Core `i5-6500` bits: 64 type: MCP smt: <unsupported> arch: Skylake-S
    rev: 3 cache: L1: 256 KiB L2: 1024 KiB L3: 6 MiB
  Speed (MHz): avg: 3458 high: 3494 min/max: 800/3600 cores: 1: 3422 2: 3467 3: 3494 4: 3449
    bogomips: 25599
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel HD Graphics 530 vendor: ASRock driver: i915 v: kernel arch: Gen-9 ports:
    active: HDMI-A-2 empty: DP-1, DP-2, HDMI-A-1, HDMI-A-3 bus-ID: 00:02.0 chip-ID: 8086:1912
    class-ID: 0300
Info:
  Processes: 363 Uptime: 19d 21h 20m wakeups: 54 Memory: 31.03 GiB used: 20.93 GiB (67.5%)
  Init: systemd v: 252 target: graphical (5) default: graphical Compilers: gcc: 12.2.0 alt: 12
  Client: Cinnamon v: 6.4.7 inxi: 3.3.26


## compare loop and vect
- the vectorized version is 9-10 times faster (can be optimized further)

#### minifel_loop.m

Local minimum possible.

fminunc stopped because the size of the current step is less than
the value of the step size tolerance.

<stopping criteria details>
Elapsed time is 1.273433 seconds.


#### minifel_vect.m

Local minimum possible.

fminunc stopped because the size of the current step is less than
the value of the step size tolerance.

<stopping criteria details>
Elapsed time is 0.181904 seconds.

