!! gw_gui.bas
This program lists resources for the
GW lib, which allows to produce apps
with nice graphical user interfaces
!!

ARRAY.LOAD options$[], "GW Lib on the Basic Forum", ~
"GW keywords reference", "GW minimalist program", "GW Full Demo"

gw_choice:

DIALOG.SELECT choice, options$[], "GW library - Links"

IF choice = 1
  BROWSE "https://www.tapatalk.com/groups/rfobasic/gw-lib-f27/"
ELSEIF choice = 2
  BROWSE "http://mougino.free.fr/tmp/GW/cheatsheet.html"
ELSEIF choice = 3
  RUN "GW_sample.bas"
ELSEIF choice = 4
  RUN "GW_demo.bas"
ELSE % User hit the Back key
  END
END IF

GOTO gw_choice
