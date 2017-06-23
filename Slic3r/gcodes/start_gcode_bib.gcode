;start Code for Prusa MK2
M115 U3.0.8 ; tell printer latest fw version
G28 W ; home
G90 ;absolut coordinates
G1 X2.00 Y200.00 Z70 F6000   ;position for heating up

M83  ; extruder relative mode
M140 S[first_layer_bed_temperature] ; set bed temp
M104 S[first_layer_temperature] ; set extruder temp
M190 S[first_layer_bed_temperature] ; wait for bed temp
M109 S[first_layer_temperature] ; wait for extruder temp
M300 S520 P100 ;warn beep print is ghoing to start

;G28 W ; home all without mesh bed level
G80 ; mesh bed leveling
G1 Y-3.0 F1000.0 ; go outside pritn area
G1 X60.0 E9.0  F1000.0 ; intro line
G1 X100.0 E12.5  F1000.0 ; intro line
