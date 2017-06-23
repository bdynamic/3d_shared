This directory containes various gcode snippels

they can be added within Slic3r at Printer Settings -> Custom G-Code

Content
=======
* after_level_change_bib.gcode: The gcode of slicer to be inserted after a
level change - useful for various other scripts e.g. the level change plugin
in octoprint
* end_gcode_bib.gcode: My G-code to be executed when printing finished
* start_gcode_bib.gcode: My G-code to be executed before printing starts. It
homes first and then goes up (before heating) so you can clean the bed -
before printing starts a warning beep is issued
* imperial_march.gcode: This Gcode plays the imperial march from star wars --- well at least kind of... but only you have a beeper at your printer (works with a Prusa MK2)

