.include 'asap7_TT_slvt.sp'

.global vdd! gnd!

.SUBCKT inv in out
   Npmos  vdd! in out vdd! BSIMCMG_osdi_P
   Nnmos  gnd! in out gnd! BSIMCMG_osdi_N
.ENDS

Vvdd vdd! 0 dc=0.7
Vgnd gnd! 0 dc=0
Vin inv_in 0 pulse (0 0.7 20p 10p 10p 20p 500p 1)

Xinv1 inv_in inv_out inv

.tran 0.1p 100p

.control
    pre_osdi bsimcmg.osdi
    run
    set xbrushwidth=3
    plot inv_in inv_out
.endc

.end
