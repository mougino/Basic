% This is a minimalist example of creating a GUI with the GW lib %
INCLUDE "GW.bas"
page = GW_NEW_PAGE()
GW_ADD_TITLEBAR(page, "Welcome to GW")
GW_ADD_TEXT(page, "Here are some controls:")
GW_ADD_BUTTON(page, "Test button", "")
GW_ADD_INPUTLINE(page, "", "This is an input line, modify me!")
GW_ADD_CHECKBOX(page, ">Checkbox")
GW_ADD_FLIPSWITCH(page, "Flip switch:", "Off", "On")
GW_RENDER(page)
DO
  r$ = GW_WAIT_ACTION$()
UNTIL r$ = "BACK"
