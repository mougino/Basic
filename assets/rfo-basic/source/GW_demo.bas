INCLUDE "GW.bas"
demover$ = "v5.2"
ShowCodePanels = 1

GOSUB DemoInit

%==========================================================================================================
MainPage:
IF !main THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("MainPage:")
  GW_DEFAULT_TRANSITIONS ("page=pop, panel=push, dialog=pop") % by default is: none/push/pop
  ARRAY.LOAD barmenu$[], "#Jump to", "Basic", "Input", "Advanced", "Themes", "Third-party", "Exit demo"
  barmenu$ = GW_ADD_BAR_RMENU$ (barmenu$[]) % will also be used in all following pages
  main = GW_NEW_PAGE()
  cartman = GW_ADD_ICON (main, "cartman.png", 24, 24) % 24 x 24 pixels
  mainttb = GW_ADD_TITLEBAR (main, GW_ADD_BAR_LBUTTON$ (GW_ICON$(cartman)) + GW_ADD_BAR_TITLE$ ("GW demo " + demover$) + barmenu$)
  GW_ADD_LISTENER (main, mainttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN
    GW_USE_THEME_CUSTO_ONCE ("position=right")
    maincode = GW_ADD_PANEL (main, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
    GW_SET_TRANSITION (maincode, "overlay")
  END IF
  GW_ADD_TEXT (main, "Choose a category:")
  GW_ADD_BUTTON (main, "GW basic controls", "BAS")
  GW_ADD_BUTTON (main, "GW user input controls", "INP")
  GW_ADD_BUTTON (main, "GW advanced controls", "ADV")
  GW_ADD_BUTTON (main, "GW themes", "THM")
  GW_ADD_BUTTON (main, "Third party GW libs", "LIB")
  GW_ADD_TEXT (main, "")
  IF ShowCodePanels THEN GW_ADD_LINK (main, "See the code of this page", GW_SHOW_PANEL$ (maincode))
  GW_ADD_TEXT (main, "&copy; Nicolas MOUGIN, 2014-2019")
  GW_ADD_BUTTON (main, "Exit demo", "BYE")
  GW_PREVENT_LANDSCAPE (main, "This page only works in portrait.\nPlease turn your screen")
END IF
GW_RENDER (main)
r$ = GW_WAIT_ACTION$()
IF IS_IN ("JUMP:", r$) = 1 THEN
  ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
  TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
END IF
IF r$ = "BAS" THEN GOTO BasicPage
IF r$ = "INP" THEN GOTO InputPage
IF r$ = "ADV" THEN GOTO AdvancedPage
IF r$ = "THM" THEN GOTO ThemePage
IF r$ = "LIB" THEN GOTO LibsPage
GOTO Bye % r$="BACK" | r$="BYE"

Bye:
IF IS_APK THEN EXIT ELSE END "Bye!"

%==========================================================================================================
BasicPage:
IF !basic THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("BasicPage:")
  basic = GW_NEW_PAGE()
  GW_SET_TRANSITION (basic, "slide")
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  basicttb = GW_ADD_TITLEBAR (basic, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW basic controls") + barmenu$)
  GW_ADD_LISTENER (basic, basicttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN
    GW_USE_THEME_CUSTO_ONCE ("position=right")
    basiccode = GW_ADD_PANEL (basic, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  END IF
  GW_ADD_TEXT (basic, "Choose one of the following demos:")
  GW_ADD_BUTTON (basic, "Button", "BUTTON")
  GW_ADD_BUTTON (basic, "Collapsible / Shelf", "COLLAPS")
  GW_ADD_BUTTON (basic, "Slider", "SLIDER")
  GW_ADD_BUTTON (basic, "Checkbox / Radio", "CHECK")
  GW_ADD_BUTTON (basic, "Flip switch", "FLIP")
  GW_ADD_BUTTON (basic, "Listview", "LISTVIEW")
  GW_ADD_BUTTON (basic, "Table / Image", "TABLE")
  GW_ADD_TEXT (basic, "")
  IF ShowCodePanels THEN GW_ADD_LINK (basic, "See the code of this page", GW_SHOW_PANEL$ (basiccode))
  GW_ADD_BUTTON (basic, "Back", "BACK")
END IF
GW_RENDER (basic)
r$ = GW_WAIT_ACTION$()
IF IS_IN ("JUMP:", r$) = 1 THEN
  ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
  TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
END IF
IF r$ = "BUTTON" THEN GOTO BtnPage
IF r$ = "COLLAPS" THEN GOTO CollapsPage
IF r$ = "SLIDER" THEN GOTO SliderPage
IF r$ = "CHECK" THEN GOTO CheckPage
IF r$ = "FLIP" THEN GOTO FlipPage
IF r$ = "LISTVIEW" THEN GOTO LvPage
IF r$ = "TABLE" THEN GOTO TablePage
GOTO MainPage

%==========================================================================================================
AdvancedPage:
IF !advanced THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("AdvancedPage:")
  advanced = GW_NEW_PAGE()
  GW_SET_TRANSITION (advanced, "flip")
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  advancedttb = GW_ADD_TITLEBAR (advanced, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW advanced controls") + barmenu$)
  GW_ADD_LISTENER (advanced, advancedttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN
    GW_USE_THEME_CUSTO_ONCE ("position=right")
    advancedcode = GW_ADD_PANEL (advanced, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  END IF
  GW_ADD_TEXT (advanced, "Choose one of the following demos:")
  GW_ADD_BUTTON (advanced, "Colorpicker + Class", "CPCLASS")
  GW_ADD_BUTTON (advanced, "Listeners", "LISTEN")
  GW_ADD_BUTTON (advanced, "Progressbar / Spinner", "PGBAR")
  GW_ADD_BUTTON (advanced, "Dialog Message", "DLGMSG")
  GW_ADD_BUTTON (advanced, "Dialog Input", "DLGINP")
  GW_ADD_BUTTON (advanced, "Lock Pattern", "LOCK")
  GW_ADD_BUTTON (advanced, "Audio / Video", "VIDEO")
  GW_ADD_TEXT (advanced, "")
  IF ShowCodePanels THEN GW_ADD_LINK (advanced, "See the code of this page", GW_SHOW_PANEL$ (advancedcode))
  GW_ADD_BUTTON (advanced, "Back", "BACK")
  btnclass = GW_NEW_CLASS ("ui-btn")
  GW_ADD_LISTENER (advanced, 0, "longpress", "COLORS")
END IF
GW_RENDER (advanced)
DO
  r$ = GW_WAIT_ACTION$()
  IF r$ = "COLORS" THEN
    GW_MODIFY (btnclass, "style:color", RandCol$())
  END IF
UNTIL r$ <> "COLORS"
IF IS_IN ("JUMP:", r$) = 1 THEN
  ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
  TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
END IF
IF r$ = "CPCLASS" THEN GOTO ColpikPage
IF r$ = "PGBAR" THEN GOTO PgPage
IF r$ = "DLGMSG" THEN GOTO DlgMsgPage
IF r$ = "DLGINP" THEN GOTO DlgInpPage
IF r$ = "LOCK" THEN GOTO LockPage
IF r$ = "LISTEN" THEN GOTO ListenPage
IF r$ = "VIDEO" THEN GOTO VideoPage
GOTO MainPage

%==========================================================================================================
LibsPage:
IF !libs THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("LibsPage:")
  libs = GW_NEW_PAGE()
  GW_SET_TRANSITION (libs, "flow")
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  libsttb = GW_ADD_TITLEBAR (libs, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("3rd party GW libs") + barmenu$)
  GW_ADD_LISTENER (libs, libsttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN libscode = GW_ADD_PANEL (libs, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (libs, "Third party libs rely on <b>GW.bas</b> but are more complex (they need several other user functions to work) or very specific. Users can contribute on <a href=javascript:RFO('SPL')>laughton.com FTP</a> &gt; html &gt; GW (GUI-Web lib) &gt; third-party-libs\n\n<b>Here is a list of third party libs:</b>")
  ARRAY.LOAD lib$[], "GW_GALLERY.bas", "GW_PICK_FILE.bas", "GW_ALIASES_SHORTCUTS.bas", "GW_UTILS.bas"
  ARRAY.LENGTH nlib, lib$[]
  DIM lib[nlib], libbtn[nlib]
  FOR i=1 TO nlib
    BYTE.OPEN r, lib[i], "../source/" + lib$[i]
    IF lib[i]<0 THEN
      missinglib = 1
      GW_USE_THEME_CUSTO_ONCE ("style='background:red; color:white'")
      IF IS_APK()
        libbtn[i] = GW_ADD_BUTTON (libs, "Missing " + lib$[i] + " *", "")
      ELSE
        libbtn[i] = GW_ADD_BUTTON (libs, "Download " + lib$[i] + " *", "DL_LIB" + INT$(i))
      END IF
    ELSE
      BYTE.CLOSE lib[i]
      GW_USE_THEME_CUSTO_ONCE ("style='background:green; color:white'")
      GW_ADD_BUTTON (libs, "Test " + lib$[i], "RUN_LIB" + INT$(i))
    END IF
  NEXT
  IF missinglib THEN
    GW_USE_THEME_CUSTO_ONCE ("style='color:red'")
    IF IS_APK()
      GW_ADD_TEXT (libs, "* Demo was compiled without them. Make sure to include them in the Compiler next time.")
    ELSE
      GW_ADD_TEXT (libs, "* After download you will have to restart GW demo for it to include the lib.")
    END IF
  END IF
  GW_ADD_TEXT (libs, "")
  IF ShowCodePanels THEN GW_ADD_LINK (libs, "See the code of this page", GW_SHOW_PANEL$ (libscode))
  GW_ADD_BUTTON (libs, "Back", "BACK")
END IF
GW_RENDER (libs)
IF IS_APK()
  FOR i=1 TO nlib
    IF lib[i]<0 THEN GW_DISABLE (libbtn[i])
  NEXT
END IF
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "SPL" THEN % Share Program Link
    BROWSE "http://rfobasic.freeforums.org/shared-program-instructions-8-3-12-t125.html"
  ELSEIF IS_IN ("DL_LIB", r$) = 1 THEN
    i = VAL (MID$ (r$, 7))
    GW_DISABLE (libbtn[i])
    GW_DOWNLOAD_THIRD_PARTY (lib$[i])
    POPUP "Download successful\nYou can restart GW demo"
  ELSEIF IS_IN ("RUN_LIB", r$) = 1 THEN
    i = VAL (MID$ (r$, 8))
    GOTO i, GalPage, GW_PICK_FILE, GW_ALIASES_SHORTCUTS, GW_UTILS
  END IF
UNTIL r$ = "BACK"
GOTO MainPage

%==========================================================================================================
GW_PICK_FILE:
IF !gwpf THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("GW_PICK_FILE:")
  INCLUDE "GW_PICK_FILE.bas"
  gwpf = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  gwpfttb = GW_ADD_TITLEBAR (gwpf, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Pick File/Folder") + barmenu$)
  GW_ADD_LISTENER (gwpf, gwpfttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN gwpfcode = GW_ADD_PANEL (gwpf, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  gwpfit = GW_ADD_TEXTBOX (gwpf, "File:")
  gwpfil = GW_ADD_INPUTLINE (gwpf, "Filter on file extensions:", "*.bas, *.txt")
  GW_ADD_BUTTON (gwpf, "PICK A FILE", "PFI")
  GW_ADD_TEXT (gwpf, "")
  gwpfot = GW_ADD_TEXTBOX (gwpf, "Folder:")
  GW_ADD_BUTTON (gwpf, "PICK A FOLDER", "PFO")
  IF ShowCodePanels THEN GW_ADD_LINK (gwpf, "See the code of this page", GW_SHOW_PANEL$ (gwpfcode))
  GW_ADD_BUTTON (gwpf, "Back", "BACK")
END IF
GW_RENDER (gwpf)
DO
  r$ = GW_WAIT_ACTION$ ()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "PFI" THEN
    filter$ = GW_GET_VALUE$ (gwpfil)
    e$ = GW_PICK_FILE$ (filter$)
    GW_RENDER (gwpf)
    IF e$ = "" THEN
      e$ = "[cancelled by user]"
    ELSE
      WHILE LEFT$ (e$, 3) = "../" : e$ = MID$ (e$, 4) : REPEAT
      e$ = CHR$ (34, 47) + e$ + CHR$ (34)
    END IF
    GW_MODIFY (gwpfit, "text", "File: " + e$)
  ELSEIF r$ = "PFO" THEN
    e$ = GW_PICK_FOLDER$ ()
    GW_RENDER (gwpf)
    IF e$ = "" THEN
      e$ = "[cancelled by user]"
    ELSE
      WHILE LEFT$ (e$, 3) = "../" : e$ = MID$ (e$, 4) : REPEAT
      e$ = CHR$ (34, 47) + e$ + CHR$ (34)
    END IF
    GW_MODIFY (gwpfot, "text", "Folder: " + e$)
  END IF
UNTIL r$ = "BACK"
GOTO LibsPage

%==========================================================================================================
GW_ALIASES_SHORTCUTS:
IF !gwasp THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("GW_ALIASES_SHORTCUTS:")
  INCLUDE "GW_ALIASES_SHORTCUTS.bas"
  gwasp = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  gwaspttb = GW_ADD_TITLEBAR (gwasp, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Aliases &amp; Shortcuts") + barmenu$)
  GW_ADD_LISTENER (gwasp, gwaspttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN gwaspcode = GW_ADD_PANEL (gwasp, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GwAddText (gwasp, "These are GW controls written with their alias form:")
  GwAddLink (gwasp, "GW_ADD_LINK &rarr; GwAddLink", "")
  GwAddButton (gwasp, "GW_ADD_BUTTON &rarr; GwAddButton", "")
  GwAddSlider (gwasp, "GW_ADD_SLIDER &rarr; GwAddSlider", 0, 10, 1, 5)
  GwAddFlipSwitch (gwasp, "GW_ADD_FLIPSWITCH &rarr; GwAddFlipSwitch", "on", "off")
  gwate (gwasp, "And these are the same written with their shortcut form:")
  gwalnk (gwasp, "GW_ADD_LINK &rarr; gwalnk", "")
  gwab (gwasp, "GW_ADD_BUTTON &rarr; gwab", "")
  gwasl (gwasp, "GW_ADD_SLIDER &rarr; gwasl", 0, 10, 1, 5)
  gwafs (gwasp, "GW_ADD_FLIPSWITCH &rarr; gwafs", "on", "off")
  GW_ADD_TEXT (gwasp, "")
  GW_ADD_LINK (gwasp, "Click this line to see the differences in the code.", GW_SHOW_PANEL$ (gwaspcode))
  GW_ADD_BUTTON (gwasp, "Back", "BACK")
END IF
GW_RENDER (gwasp)
DO
  r$ = GW_WAIT_ACTION$ ()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  END IF
UNTIL r$ = "BACK"
GOTO LibsPage

%==========================================================================================================
GW_UTILS:
IF !utils THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("GW_UTILS:")
  INCLUDE "GW_UTILS.bas"
  utils = GW_NEW_PAGE()
  GW_PAGE_SCALE (utils, 0.7)
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  utilsttb = GW_ADD_TITLEBAR (utils, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Utils") + barmenu$)
  GW_ADD_LISTENER (utils, utilsttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN
    GW_USE_THEME_CUSTO_ONCE ("position=right")
    utilscode = GW_ADD_PANEL (utils, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  END IF
  GW_ADD_TEXT (utils, "GW_UTILS.bas includes utility functions for the GW library.")
  GW_USE_THEME_CUSTO_ONCE ("style='text-align:center'")
  GW_ADD_TITLE (utils, "This page has been scaled with GW_PAGE_SCALE(page, 0.7)")
  GW_USE_THEME_CUSTO_ONCE ("style='background:#eebfff'")
  GW_ADD_BUTTON (utils, "[Native] Show screen 'real' dimensions in pixels", "SCR")
  GW_USE_THEME_CUSTO_ONCE ("style='background:#bfffc4'")
  GW_ADD_BUTTON (utils, "[Gw_Utils] Show HTML window 'usable' dimensions", "WND")
  GW_ADD_TEXT (utils, "You can also use GW_MODIFY_VIEWPORT() to allow pinching the page to zoom it in/out, but it is incompatible with GW_PAGE_SCALE().")
  GW_ADD_INPUTLINE (utils, "", "Input Line")
  GW_ADD_SLIDER (utils, "Slider:", 0, 100, 1, 50)
  GW_ADD_CHECKBOX (utils, ">Check box")
  GW_ADD_RADIO (utils, 0, ">Radio button")
  GW_USE_THEME_CUSTO_ONCE ("color=a icon=arrow-l iconpos=left")
  GW_ADD_BUTTON (utils, "color=a icon=arrow-l iconpos=left", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b icon=arrow-r iconpos=right")
  GW_ADD_BUTTON (utils, "color=b icon=arrow-r iconpos=right", "")
  GW_ADD_FLIPSWITCH (utils, "Flipswitch initially 'on'", "Off", ">On")
  GW_ADD_TEXT (utils, "")
  IF ShowCodePanels THEN GW_ADD_LINK (utils, "See the code of this page", GW_SHOW_PANEL$ (utilscode))
  GW_ADD_BUTTON (utils, "Back", "BACK")
END IF
GW_RENDER (utils)
DO
  r$ = GW_WAIT_ACTION$ ()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "SCR" THEN
    SCREEN.SIZE wh[]
    POPUP INT$(wh[1]) + "x" + INT$(wh[2]) + "\nby Screen.Size"
  ELSEIF r$ = "WND" THEN
    w = GW_GET_WINDOW_WIDTH()
    h = GW_GET_WINDOW_HEIGHT()
    POPUP INT$(w) + "x" + INT$(h) + "\nby Gw_Get_Window_Width\n& Gw_Get_Window_Height"
  END IF
UNTIL r$ = "BACK"
GOTO LibsPage

%==========================================================================================================
BtnPage:
IF !btn THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("BtnPage:")
  btn = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  btnttb = GW_ADD_TITLEBAR (btn, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Button") + barmenu$)
  GW_ADD_LISTENER (btn, btnttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN btncode = GW_ADD_PANEL (btn, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (btn, "Click this button to change its label:")
  btnBtn = GW_ADD_BUTTON (btn, "I count to " + INT$(i), "COUNT")
  GW_ADD_TEXT (btn, "And click this other button to show or hide the 'title' control next to it:")
  GW_ADD_BUTTON (btn, "Click me!", "TITLE")
  btnTitle = GW_ADD_TITLE (btn, "I'm alive!")
  GW_ADD_TEXT (btn, "")
  IF ShowCodePanels THEN GW_ADD_LINK (btn, "See the code of this page", GW_SHOW_PANEL$ (btncode))
  GW_ADD_BUTTON (btn, "Back", "BACK")
  GW_USE_THEME_CUSTO_ONCE ("big hover=N notext alpha=50% icon=arrow-u style='background:#b342ff'")
  GW_ADD_BUTTON (btn, "", "N")
  GW_USE_THEME_CUSTO_ONCE ("big hover=S notext alpha=50% icon=arrow-d style='background:#4fff9e'")
  GW_ADD_BUTTON (btn, "", "S")
  GW_USE_THEME_CUSTO_ONCE ("big hover=W notext alpha=50% icon=arrow-l style='background:#f4ff68'")
  GW_ADD_BUTTON (btn, "", "W")
  GW_USE_THEME_CUSTO_ONCE ("big hover=E notext alpha=50% icon=arrow-r style='background:#77f1ff'")
  GW_ADD_BUTTON (btn, "", "E")
  GW_USE_THEME_CUSTO_ONCE ("hover=NW notext alpha=50% icon=arrow-u-l style='background:#ffc277'")
  GW_ADD_BUTTON (btn, "", "NW")
  GW_USE_THEME_CUSTO_ONCE ("hover=NE notext alpha=50% icon=arrow-u-r style='background:#ff7777'")
  GW_ADD_BUTTON (btn, "", "NE")
  GW_USE_THEME_CUSTO_ONCE ("hover=SW notext alpha=50% icon=arrow-d-l style='background:#8377ff'")
  GW_ADD_BUTTON (btn, "", "SW")
  GW_USE_THEME_CUSTO_ONCE ("hover=SE notext alpha=50% icon=arrow-d-r style='background:#ff77d8'")
  GW_ADD_BUTTON (btn, "", "SE")
END IF
i = 0
t = 0
GW_RENDER (btn)
GW_HIDE (btnTitle)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), j : j-- % ignore first array index (menu title)
    GOTO j, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage
  ELSEIF r$ = "COUNT" THEN
    i++
    GW_MODIFY (btnBtn, "text", "I count to " + INT$(i))
  ELSEIF r$ = "TITLE" THEN
    t=1-t
    IF t THEN GW_SHOW (btnTitle) ELSE GW_HIDE (btnTitle)
  ELSEIF r$ = "N" THEN
    POPUP "Button with custo\n'hover=N alpha=50% notext big'"
  ELSEIF r$ = "S" THEN
    POPUP "Button with custo\n'hover=S alpha=50% notext big'"
  ELSEIF r$ = "W" THEN
    POPUP "Button with custo\n'hover=W alpha=50% notext big'"
  ELSEIF r$ = "E" THEN
    POPUP "Button with custo\n'hover=E alpha=50% notext big'"
  ELSEIF r$ = "NW" THEN
    POPUP "Button with custo\n'hover=NW alpha=50% notext'"
  ELSEIF r$ = "NE" THEN
    POPUP "Button with custo\n'hover=NE alpha=50% notext'"
  ELSEIF r$ = "SW" THEN
    POPUP "Button with custo\n'hover=SW alpha=50% notext'"
  ELSEIF r$ = "SE" THEN
    POPUP "Button with custo\n'hover=SE alpha=50% notext'"
  END IF
UNTIL r$ = "BACK"
GOTO BasicPage

%==========================================================================================================
CollapsPage:
IF !clps THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("CollapsPage:")
  clps = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  clpsttb = GW_ADD_TITLEBAR (clps, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Collapsible / Shelf") + barmenu$)
  GW_ADD_LISTENER (clps, clpsttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN clpscode = GW_ADD_PANEL (clps, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (clps, "Collapsibles are used to expand / collapse a group of controls:")
  GW_OPEN_COLLAPSIBLE (clps, "Tap this line to show or hide the controls")
  GW_ADD_BUTTON (clps, "I'm a simple button", "")
  GW_ADD_TEXTBOX (clps, "I'm a textbox")
  GW_ADD_SLIDER (clps, "I'm a slider", 0, 10, 1, 5)
  GW_CLOSE_COLLAPSIBLE (clps)
  GW_ADD_TEXT (clps, "A shelf is an invisible structure that allows to place different controls on the same line:")

  GW_SHELF_OPEN (clps)
  GW_ADD_BUTTON (clps, "Button #1", "")
  GW_SHELF_NEWCELL (clps)
  GW_ADD_BUTTON (clps, "Button #2", "")
  GW_SHELF_NEWCELL (clps)
  GW_ADD_BUTTON (clps, "Button #3", "")
  GW_SHELF_CLOSE (clps)

  GW_ADD_TEXT (clps, "By default a shelf fits all the controls equally on the screen width, but you can change that with a simple CUSTO:")

  GW_USE_THEME_CUSTO_ONCE ("style='width:200px'")
  GW_SHELF_OPEN (clps)
  GW_ADD_BUTTON (clps, "#1", "")
  GW_SHELF_NEWCELL (clps)
  GW_ADD_BUTTON (clps, "#2", "")
  GW_SHELF_NEWCELL (clps)
  GW_ADD_BUTTON (clps, "#3", "")
  GW_SHELF_CLOSE (clps)

  GW_SHELF_OPEN (clps)
  GW_ADD_BUTTON (clps, "#4", "")
  GW_USE_THEME_CUSTO_ONCE ("style='width:200px'")
  GW_SHELF_NEWCELL (clps)
  GW_ADD_BUTTON (clps, "#5", "")
  GW_SHELF_NEWCELL (clps)
  GW_ADD_BUTTON (clps, "#6", "")
  GW_SHELF_CLOSE (clps)

  GW_ADD_TEXT (clps, "")
  IF ShowCodePanels THEN GW_ADD_LINK (clps, "See the code of this page", GW_SHOW_PANEL$ (clpscode))
  GW_ADD_BUTTON (clps, "Back", "BACK")
END IF
GW_RENDER (clps)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  END IF
UNTIL r$ = "BACK"
GOTO BasicPage

%==========================================================================================================
SliderPage:
IF !sli THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("SliderPage:")
  sli = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  slittb = GW_ADD_TITLEBAR (sli, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Slider") + barmenu$)
  GW_ADD_LISTENER (sli, slittb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN slicode = GW_ADD_PANEL (sli, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (sli, "Sliders are used to enter numeric values along a numeric continuum by dragging a handle or entering in a value.")
  ctl_slider1 = GW_ADD_SLIDER (sli, "Simple integer slider:", 0, 100, 1, 50)
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  ctl_slider2 = GW_ADD_SLIDER (sli, "Integer slider with a step of 20:", 0, 100, 20, 40)
  GW_USE_THEME_CUSTO_ONCE ("color=e")
  ctl_slider3 = GW_ADD_SLIDER (sli, "Decimal slider:", 0.2, 0.5, 0.01, 0.2)
  GW_ADD_TEXT (sli, "Sliders are user input controls, as such they need a 'submit' control to pass their values to BASIC!\nSubmit controls physically look like a button:")
  GW_ADD_SUBMIT (sli, "Copy values below:")
  sliTxt = GW_ADD_TEXTBOX (sli, "")
  GW_USE_THEME_CUSTO_ONCE ("style='background:red; color:white'")
  GW_ADD_BUTTON (sli, "Reset the sliders", "RESET")
  GW_ADD_TEXT (sli, "")
  IF ShowCodePanels THEN GW_ADD_LINK (sli, "See the code of this page", GW_SHOW_PANEL$ (slicode))
  GW_ADD_BUTTON (sli, "Back", "BACK")
END IF
GW_RENDER (sli)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF IS_IN ("SUBMIT", r$) = 1 THEN
    e$ = "First slider value is " + GW_GET_VALUE$ (ctl_slider1) + "\n"
    e$ += "Second slider value is " + GW_GET_VALUE$ (ctl_slider2) + "\n"
    e$ += "Third slider value is " + GW_GET_VALUE$ (ctl_slider3)
    GW_MODIFY (sliTxt, "text", e$)
  ELSEIF r$ = "RESET" THEN
    GW_MODIFY (ctl_slider1, "val", "0")
    GW_MODIFY (ctl_slider2, "val", "0")
    GW_MODIFY (ctl_slider3, "val", "0.2")
  END IF
UNTIL r$ = "BACK"
GOTO BasicPage

%==========================================================================================================
InputPage:
IF !inp THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("InputPage:")
  inp = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  inpttb = GW_ADD_TITLEBAR (inp, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Input controls") + barmenu$)
  GW_ADD_LISTENER (inp, inpttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN inpcode = GW_ADD_PANEL (inp, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (inp, "Text input lines and boxes are two of the most common user input controls.")
  inpl = GW_ADD_INPUTLINE (inp, "This is an input line:", "Change me!")
  inpaxn1 = GW_ADD_SUBMIT (inp, "Make a BASIC! popup from input line")
  GW_ADD_TEXT (inp, "")
  e$ = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pretium, purus vitae fermentum "
  e$ += "pharetra, nulla nisi pretium nisi, vitae laoreet arcu nisi elementum turpis. Fusce ac facilisis "
  e$ += "est. Praesent sodales sagittis odio, et maximus tortor elementum at. Duis ullamcorper est justo, "
  e$ += "et viverra justo dictum id. Morbi aliquam turpis vel lorem sollicitudin, nec porta lacus aliquam. "
  e$ += "Nunc quis vehicula odio. Praesent a vehicula magna, non rhoncus risus. Fusce at eros id quam "
  e$ += "rhoncus sagittis et vel tortor. In et nulla congue ligula auctor posuere non sit amet ante. "
  e$ += "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae."
  inpb = GW_ADD_INPUTBOX (inp, "And this is an input box:", e$)
  inpaxn2 = GW_ADD_SUBMIT (inp, "Shuffle the text in the box")
  GW_ADD_TEXT (inp, "Here is an input list = an autocomplete input line with pre-defined values and actions:")
  ARRAY.LOAD os$[], "Android>IL_1", "iOS>IL_2", "Linux>IL_3", "Mac OS>IL_4", "Windows>IL_5"
  oses = GW_ADD_INPUTLIST (inp, "Type an OS name...", os$[])
  GW_ADD_LISTENER (inp, oses, "clear", "IL_RESET")
  GW_ADD_TEXT (inp, "Here are input mini controls = small inline number input fields:")
  GW_INJECT_HTML (inp, "Coordinates: ")
  GW_ADD_INPUTMINI (inp, "10")
  GW_INJECT_HTML (inp, " , ")
  GW_ADD_INPUTMINI (inp, "20")
  GW_INJECT_HTML (inp, " & value: ")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  GW_ADD_INPUTMINI (inp, "33")
  GW_ADD_TEXT (inp, "And here is a select box to pick a value from a list:")
  ARRAY.LOAD fruit$[], "Apple", "Banana", "Cherry", "Cranberry", ">Grape", "Orange"
  fruitbox = GW_ADD_SELECTBOX (inp, "Pick a fruit:", fruit$[])
  GW_ADD_LISTENER (inp, fruitbox, "change", "SB_CHANGED")
  inpaxn3 = GW_ADD_SUBMIT (inp, "What fruit did you pick?")
  GW_ADD_TEXT (inp, "And finally here are miscellaneous input controls:")
  GW_ADD_INPUTDATE (inp, "Input Date", "")
  GW_ADD_INPUTTIME (inp, "Input Time", "")
  GW_ADD_INPUTMONTH (inp, "Input Month", "")
  GW_ADD_INPUTWEEK (inp, "Input Week", "")
  GW_ADD_INPUTURL (inp, "Input URL", "")
  GW_ADD_INPUTEMAIL (inp, "Input eMail", "")
  GW_ADD_INPUTCOLOR (inp, "Input Color", "")
  GW_ADD_INPUTNUMBER (inp, "Input Number", "")
  GW_ADD_INPUTTEL (inp, "Input Tel", "")
  GW_ADD_INPUTPASSWORD (inp, "Input Password", "")
  GW_ADD_SUBMIT (inp, "Submit")
  GW_ADD_TEXT (inp, "")
  IF ShowCodePanels THEN GW_ADD_LINK (inp, "See the code of this page", GW_SHOW_PANEL$ (inpcode))
  GW_ADD_BUTTON (inp, "Back", "BACK")
END IF
GW_RENDER (inp)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF LEFT$ (r$, 3) = "IL_" THEN % INPUTLIST events
    GW_CLOSE_INPUTLIST(oses)
    r$ = MID$ (r$, 4)
    IF r$ = "RESET" THEN
      POPUP "Listener triggered:\ninput list was reset"
    ELSEIF LEN (r$) = 1 THEN
      os$ = os$ [VAL (r$)]
      os$ = LEFT$ (os$, IS_IN (">", os$) - 1)
      GW_MODIFY (oses, "text", os$)
      POPUP "You chose " + os$
    END IF
  END IF
  IF r$ = "SB_CHANGED" THEN POPUP "Listener triggered:\nselect box was changed"
  IF IS_IN ("SUBMIT", r$) = 1 THEN
    IF IS_IN (GW_ID$(inpaxn1), r$) THEN % 'submit' after input line
      POPUP GW_GET_VALUE$ (inpl),0,0,0
    ELSEIF IS_IN (GW_ID$(inpaxn2), r$) THEN % 'submit' after box
      e$ = GW_GET_VALUE$ (inpb)
      SPLIT r$[], e$, " "
      ARRAY.SHUFFLE r$[]
      ARRAY.LENGTH al, r$[]
      e$ = ""
      FOR i=1 TO al
        e$ += r$[i] + " "
      NEXT
      ARRAY.DELETE r$[]
      GW_MODIFY (inpb, "input", e$)
    ELSEIF IS_IN (GW_ID$(inpaxn3), r$) THEN % 'submit' after fruit select box
      f = GW_GET_VALUE (fruitbox)
      e$ = "You picked a"
      r$ = LEFT$ (fruit$[f], 1)
      IF r$ = "A" | r$ = "O" THEN e$ += "n"
      e$ += " " + LOWER$(fruit$[f])
      POPUP e$,0,0,0
    END IF
  END IF
UNTIL r$ = "BACK"
GOTO MainPage

%==========================================================================================================
FlipPage:
IF !flip THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("FlipPage:")
  flip = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  flipttb = GW_ADD_TITLEBAR (flip, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Flip switch") + barmenu$)
  GW_ADD_LISTENER (flip, flipttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN flipcode = GW_ADD_PANEL (flip, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (flip, "Flip switches are used for boolean style inputs like true/false or on/off in a compact UI element.")
  ctl_flip1 = GW_ADD_FLIPSWITCH (flip, "BASIC! vibrate", "off", "on")
  ctl_flip2 = GW_ADD_FLIPSWITCH (flip, "BASIC! beep", "0", "1")
  GW_ADD_BUTTON (flip, "Change 1st flip switch", "CHFLIP")
  GW_ADD_TEXT (flip, "")
  IF ShowCodePanels THEN GW_ADD_LINK (flip, "See the code of this page", GW_SHOW_PANEL$ (flipcode))
  GW_ADD_BUTTON (flip, "Back", "BACK")
END IF
GW_RENDER (flip)
TIMER.SET 1000
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "CHFLIP" THEN
    vibr=1-vibr
    IF vibr THEN GW_MODIFY (ctl_flip1, "selected", "on")
    IF !vibr THEN GW_MODIFY (ctl_flip1, "selected", "off")
  END IF
  IF GW_FLIPSWITCH_CHANGED (ctl_flip1, "on") THEN vibr=1
  IF GW_FLIPSWITCH_CHANGED (ctl_flip1, "off") THEN vibr=0
  IF GW_FLIPSWITCH_CHANGED (ctl_flip2, "1") THEN beep=1
  IF GW_FLIPSWITCH_CHANGED (ctl_flip2, "0") THEN beep=0
UNTIL r$ = "BACK"
TIMER.CLEAR
vibr=0
beep=0
GOTO BasicPage

ONTIMER:
IF vibr THEN VIBRATE buzz[], -1
IF beep THEN TONE 300, 300
TIMER.RESUME

%==========================================================================================================
CheckPage:
IF !check THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("CheckPage:")
  check = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  checkttb = GW_ADD_TITLEBAR (check, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Checkbox + Radio") + barmenu$)
  GW_ADD_LISTENER (check, checkttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN checkcode = GW_ADD_PANEL (check, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))

  GW_ADD_TEXT (check, "Checkboxes are used to provide a list of options where more than one can be selected.")
  GW_OPEN_GROUP (check)
  ctl_check1 = GW_ADD_CHECKBOX (check, "I like red")
  ctl_check2 = GW_ADD_CHECKBOX (check, ">I like green")
  ctl_check3 = GW_ADD_CHECKBOX (check, "I like black")
  ctl_check4 = GW_ADD_CHECKBOX (check, ">I like blue")
  ctl_check5 = GW_ADD_CHECKBOX (check, "I like yellow")
  GW_CLOSE_GROUP (check)
  GW_ADD_TEXT (check, "You can retrieve checkbox values with a 'submit' control:")
  checkaxn1 = GW_ADD_SUBMIT (check, "Show the world what you like")
  GW_ADD_TEXT (check, "Or reset checkboxes with gw_modify:")
  GW_USE_THEME_CUSTO_ONCE ("style='background:red; color:white'")
  GW_ADD_BUTTON (check, "Reset all checkboxes", "RAZCB")

  GW_ADD_TEXT (check, "You can group checkboxes horizontally by using a GROUP with a CUSTO 'inline':")
  GW_USE_THEME_CUSTO_ONCE ("inline")
  GW_OPEN_GROUP (check)
  GW_ADD_CHECKBOX (check, "<span style='font-weight:bold'>b</span>")
  GW_ADD_CHECKBOX (check, "<span style='font-style:italic'>i</span>")
  GW_ADD_CHECKBOX (check, "<span style='text-decoration:underline'>u</span>")
  GW_CLOSE_GROUP (check)
  GW_ADD_TEXT (check, "")

  GW_ADD_TEXT (check, "Radio buttons are used to provide a list of options where only a single option can be selected.")
  GW_OPEN_GROUP (check)
  ctl_parent = GW_ADD_RADIO (check, 0, "I am a toddler")
  ctl_child1 = GW_ADD_RADIO (check, ctl_parent, "I am a boy")
  ctl_child2 = GW_ADD_RADIO (check, ctl_parent, ">I am a man")
  ctl_child3 = GW_ADD_RADIO (check, ctl_parent, "I am your father")
  GW_CLOSE_GROUP (check)
  GW_ADD_TEXT (check, "You can retrieve radio values with a 'submit' control:")
  checkaxn2 = GW_ADD_SUBMIT (check, "What are you?")
  GW_ADD_TEXT (check, "Or unselect a group of radio buttons with gw_modify:")
  GW_USE_THEME_CUSTO_ONCE ("style='background:red; color:white'")
  GW_ADD_BUTTON (check, "Reset radio group", "RAZRB")

  GW_ADD_TEXT (check, "You can group radio buttons horizontally by using a GROUP with a CUSTO 'inline':")
  GW_USE_THEME_CUSTO_ONCE ("inline")
  GW_OPEN_GROUP (check)
  r = GW_ADD_RADIO (check, 0, ">red")
  GW_ADD_RADIO (check, r, "green")
  GW_ADD_RADIO (check, r, "blue")
  GW_ADD_RADIO (check, r, "yellow")
  GW_ADD_RADIO (check, r, "orange")
  GW_ADD_RADIO (check, r, "purple")
  GW_ADD_RADIO (check, r, "black")
  GW_ADD_RADIO (check, r, "white")
  GW_CLOSE_GROUP (check)
  GW_ADD_TEXT (check, "")

  IF ShowCodePanels THEN GW_ADD_LINK (check, "See the code of this page", GW_SHOW_PANEL$ (checkcode))
  GW_ADD_BUTTON (check, "Back", "BACK")
END IF
GW_RENDER (check)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "RAZRB" THEN
    GW_MODIFY (ctl_parent, "selected", "0")
  ELSEIF r$ = "RAZCB" THEN
    GW_MODIFY (ctl_check1, "checked", "0")
    GW_MODIFY (ctl_check2, "checked", "0")
    GW_MODIFY (ctl_check3, "checked", "0")
    GW_MODIFY (ctl_check4, "checked", "0")
    GW_MODIFY (ctl_check5, "checked", "0")
  ELSEIF IS_IN ("SUBMIT", r$) = 1 THEN
    IF IS_IN (GW_ID$(checkaxn1), r$) THEN
      e$ = ""
      IF GW_CHECKBOX_CHECKED (ctl_check1) THEN e$ += "You like red like strawberries\n"
      IF GW_CHECKBOX_CHECKED (ctl_check2) THEN e$ += "You like green like the grass\n"
      IF GW_CHECKBOX_CHECKED (ctl_check3) THEN e$ += "You like black like the sky at night\n"
      IF GW_CHECKBOX_CHECKED (ctl_check4) THEN e$ += "You like blue like a calm sea\n"
      IF GW_CHECKBOX_CHECKED (ctl_check5) THEN e$ += "You like yellow like the sun\n"
      IF LEN (e$) THEN e$ = LEFT$ (e$, LEN (e$)-1) ELSE e$ = "You like nothing!"
      POPUP e$,0,0,0
    ELSEIF IS_IN (GW_ID$(checkaxn2), r$) THEN
      IF GW_RADIO_SELECTED (ctl_parent) THEN POPUP "A baby"
      IF GW_RADIO_SELECTED (ctl_child1) THEN POPUP "A preteen"
      IF GW_RADIO_SELECTED (ctl_child2) THEN POPUP "A grown up"
      IF GW_RADIO_SELECTED (ctl_child3) THEN POPUP "Darth Vader"
    END IF
  END IF
UNTIL r$ = "BACK"
GOTO BasicPage

%==========================================================================================================
ThemePage:
IF !thm THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage:")
  thm = GW_NEW_PAGE()
  ARRAY.LOAD thmbna$[], "Yes>DLT", "Cancel>NO"
  thmdm = GW_ADD_DIALOG_MESSAGE (thm, "Download theme", "This theme is not on your device. Do you want to download it now?", thmbna$[])
  GW_CUSTO_DLGBTN (thm, thmdm, thmbna$[1], "style='background:green;color:white'")
  GW_CUSTO_DLGBTN (thm, thmdm, thmbna$[2], "style='background:red;color:white'")
  ARRAY.DELETE thmbna$[]
  ARRAY.LOAD thmbna$[], "OK"
  thmpb = GW_ADD_DIALOG_MESSAGE (thm, "Error", "There was a problem during download!\nTry again later.", thmbna$[])
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  thmttb = GW_ADD_TITLEBAR (thm, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Themes") + barmenu$)
  GW_ADD_LISTENER (thm, thmttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN thmcode = GW_ADD_PANEL (thm, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (thm, "You can totally change the look and feel of your GW pages thanks to themes.\nChoose a theme below (*ls means limited support):")
  GW_ADD_BUTTON (thm, "native-droid-*", "8")
  GW_ADD_BUTTON (thm, "flat-ui", "1")
  GW_ADD_BUTTON (thm, "bootstrap", "4")
  GW_ADD_BUTTON (thm, "square-ui", "6")
  GW_ADD_BUTTON (thm, "android-holo\t<small>(ls*)</small>", "5")
  GW_ADD_BUTTON (thm, "iOS\t<small>(ls*)</small>", "3")
  GW_ADD_BUTTON (thm, "classic\t<small>(ls*)</small>", "2")
  GW_ADD_BUTTON (thm, "metro\t<small>(ls*)</small>", "7")
  GW_ADD_TEXT (thm, "")
  IF ShowCodePanels THEN GW_ADD_LINK (thm, "See the code of this page", GW_SHOW_PANEL$ (thmcode))
  GW_ADD_BUTTON (thm, "Back", "BACK")
END IF
GW_RENDER (thm)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "DLT" THEN % "DownLoad Theme" tapped in Dialog Message
    POPUP "Starting download..."
    GW_DOWNLOAD_THEME (GW_THEME$[n+1])
    IF GW_THEME_EXISTS (GW_THEME$[n+1]) THEN % Theme downloaded successfully
      POPUP "Download complete!"
      GOTO n, ThemePage1, ThemePage2, ThemePage3, ThemePage4, ThemePage5, ThemePage6, ThemePage7, ThemePage8
    ELSE
      GW_SHOW_DIALOG (thmpb) % Theme download problem
      PRINT GETERROR$()
    END IF
  ELSEIF LEN(r$) = 1
    n = ASCII(r$) - ASCII("1") + 1
    IF n >= 1 & n <= 8 THEN
      IF GW_THEME_EXISTS (GW_THEME$[n+1]) THEN
        GOTO n, ThemePage1, ThemePage2, ThemePage3, ThemePage4, ThemePage5, ThemePage6, ThemePage7, ThemePage8
      ELSE
        GW_SHOW_DIALOG (thmdm) % DownLoad Theme ? Y/N
      END IF
    END IF
  END IF
UNTIL r$ = "BACK"
GOTO MainPage

%==========================================================================================================
ThemePage1:
IF !thm1 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage1:")
  GW_LOAD_THEME ("flat-ui")
  thm1 = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  GW_ADD_TITLEBAR (thm1, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'flat-ui'"))
  IF ShowCodePanels THEN thm1code = GW_ADD_PANEL (thm1, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))

  GW_ADD_TEXT (thm1, "Some customized buttons:")
  GW_USE_THEME_CUSTO_ONCE ("color=a icon=flat-settings")
  GW_ADD_BUTTON (thm1, "color=a\t icon=flat-settings", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b icon=flat-new")
  GW_ADD_BUTTON (thm1, "color=b\t icon=flat-new", "")
  GW_USE_THEME_CUSTO_ONCE ("color=c icon=flat-man")
  GW_ADD_BUTTON (thm1, "color=c\t icon=flat-man", "")
  GW_USE_THEME_CUSTO_ONCE ("color=d icon=flat-mail")
  GW_ADD_BUTTON (thm1, "color=d\t icon=flat-mail", "")
  GW_USE_THEME_CUSTO_ONCE ("color=e icon=flat-lock")
  GW_ADD_BUTTON (thm1, "color=e\t icon=flat-lock", "")
  GW_USE_THEME_CUSTO_ONCE ("color=f icon=flat-menu")
  GW_ADD_BUTTON (thm1, "color=f\t icon=flat-menu", "")
  GW_USE_THEME_CUSTO_ONCE ("color=g icon=flat-heart")
  GW_ADD_BUTTON (thm1, "color=g\t icon=flat-heart", "")

  GW_ADD_TEXT (thm1, "Buttons with 'inline notext' custo:")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=home")
  GW_ADD_BUTTON (thm1, "", "1")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-video")
  GW_ADD_BUTTON (thm1, "", "2")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-time")
  GW_ADD_BUTTON (thm1, "", "3")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-eye")
  GW_ADD_BUTTON (thm1, "", "4")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-plus")
  GW_ADD_BUTTON (thm1, "", "5")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-location")
  GW_ADD_BUTTON (thm1, "", "6")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-cmd")
  GW_ADD_BUTTON (thm1, "", "7")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-cross")
  GW_ADD_BUTTON (thm1, "", "8")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-checkround")
  GW_ADD_BUTTON (thm1, "", "9")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-calendar")
  GW_ADD_BUTTON (thm1, "", "10")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-bubble")
  GW_ADD_BUTTON (thm1, "", "11")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-volume")
  GW_ADD_BUTTON (thm1, "", "12")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=flat-camera")
  GW_ADD_BUTTON (thm1, "", "13")
  GW_USE_THEME_CUSTO_ONCE ("color=g")
  GW_ADD_CHECKBOX (thm1, ">Check box 1")
  GW_USE_THEME_CUSTO_ONCE ("color=g")
  GW_ADD_CHECKBOX (thm1, "Check box 2")
  GW_ADD_INPUTLINE (thm1, "", "Input Line")
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  r = GW_ADD_RADIO (thm1, 0, ">Radio button 1")
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  GW_ADD_RADIO (thm1, r, "Radio button 2")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  thm1flip1 = GW_ADD_FLIPSWITCH (thm1, "", "Off", ">On")
  thm1flip2 = GW_ADD_FLIPSWITCH (thm1, "", "Off", "On")
  GW_USE_THEME_CUSTO_ONCE ("color=e")
  GW_ADD_SLIDER (thm1, "", 0, 100, 1, 50)

  GW_ADD_TEXT (thm1, "")
  IF ShowCodePanels THEN GW_ADD_LINK (thm1, "See the code of this page", GW_SHOW_PANEL$ (thm1code))
  GW_ADD_BUTTON (thm1, "Back", "BACK")
END IF
GW_RENDER (thm1)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF r$ = "1" THEN POPUP "color=f inline notext icon=home"
  IF r$ = "2" THEN POPUP "color=f inline notext icon=flat-video"
  IF r$ = "3" THEN POPUP "color=f inline notext icon=flat-time"
  IF r$ = "4" THEN POPUP "color=f inline notext icon=flat-eye"
  IF r$ = "5" THEN POPUP "color=f inline notext icon=flat-plus"
  IF r$ = "6" THEN POPUP "color=f inline notext icon=flat-location"
  IF r$ = "7" THEN POPUP "color=f inline notext icon=flat-cmd"
  IF r$ = "8" THEN POPUP "color=f inline notext icon=flat-cross"
  IF r$ = "9" THEN POPUP "color=f inline notext icon=flat-checkround"
  IF r$ = "10" THEN POPUP "color=f inline notext icon=flat-calendar"
  IF r$ = "11" THEN POPUP "color=f inline notext icon=flat-bubble"
  IF r$ = "12" THEN POPUP "color=f inline notext icon=flat-volume"
  IF r$ = "13" THEN POPUP "color=f inline notext icon=flat-camera"
  IF GW_FLIPSWITCH_CHANGED (thm1flip1, "Off") THEN POPUP "Switched off"
  IF GW_FLIPSWITCH_CHANGED (thm1flip2, "On") THEN POPUP "Switched on"
UNTIL r$ = "BACK"
GOTO ThemePage

%==========================================================================================================
ThemePage2:
IF !thm2 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage2:")
  GW_LOAD_THEME ("classic")
  thm2 = GW_NEW_PAGE()
  thm2cust = GW_NEW_THEME_CUSTO ("color=b")
  GW_USE_THEME_CUSTO(thm2cust)
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  GW_ADD_TITLEBAR (thm2, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'classic'"))
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  GW_ADD_TEXT (thm2, "The jQM 'classic' is an old theme: panels are not supported...")
  GW_USE_THEME_CUSTO_ONCE ("color=a")
  GW_ADD_BUTTON (thm2, "I am a 'color=a' button", "")
  GW_USE_THEME_CUSTO_ONCE ("color=c")
  GW_ADD_BUTTON (thm2, "I am a 'color=c' button", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  GW_ADD_BUTTON (thm2, "I am a 'color=b' button", "")
  GW_USE_THEME_CUSTO_ONCE ("color=e")
  GW_ADD_BUTTON (thm2, "I am a 'color=e' button", "")
  GW_ADD_CHECKBOX (thm2, ">Check box 1")
  GW_ADD_CHECKBOX (thm2, "Check box 2")
  GW_ADD_INPUTLINE (thm2, "", "Input Line")
  r = GW_ADD_RADIO (thm2, 0, ">Radio button 1")
  GW_ADD_RADIO (thm2, r, "Radio button 2")
  GW_USE_THEME_CUSTO_ONCE ("color=e")
  thm2flip1 = GW_ADD_FLIPSWITCH (thm2, "", "Off", ">On")
  thm2flip2 = GW_ADD_FLIPSWITCH (thm2, "", "Off", "On")
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  GW_ADD_SLIDER (thm2, "", 0, 100, 1, 50)
  IF ShowCodePanels THEN
    GW_USE_THEME_CUSTO_ONCE ("color=d")
    GW_ADD_TEXT (thm2, "The code of this page:")
    GW_USE_THEME_CUSTO_ONCE ("color=d")
    GW_ADD_TEXT (thm2, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  END IF
  GW_ADD_BUTTON (thm2, "Back", "BACK")
END IF
GW_RENDER (thm2)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF GW_FLIPSWITCH_CHANGED (thm2flip1, "Off") THEN POPUP "Switched off"
  IF GW_FLIPSWITCH_CHANGED (thm2flip2, "On") THEN POPUP "Switched on"
UNTIL r$ = "BACK"
GOTO ThemePage

%==========================================================================================================
ThemePage3:
IF !thm3 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage3:")
  GW_LOAD_THEME ("iOS")
  thm3 = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("data-rel='back'")
  GW_ADD_TITLEBAR (thm3, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'iOS'"))
  ARRAY.LOAD bna_thm3$[], "Button style E", "Button style D", "Button style C", "Button style B", "Button style A"
  dm_thm3 = GW_ADD_DIALOG_MESSAGE (thm3, "Hello, world!", "This is a dialog message in old themes.", bna_thm3$[])
  FOR i=1 TO 5
    GW_CUSTO_DLGBTN (thm3, dm_thm3, bna_thm3$[i], "color=" + LOWER$ (RIGHT$ (bna_thm3$[i], 1)))
  NEXT
  GW_ADD_TEXT (thm3, "The 'iOS' theme is an old theme: panels are not supported...")
  GW_ADD_LINK (thm3, "Show a Dialog Message", GW_SHOW_DIALOG$ (dm_thm3))
  GW_USE_THEME_CUSTO_ONCE ("color=a icon=arrow-l iconpos=left")
  GW_ADD_BUTTON (thm3, "color=a icon=arrow-l iconpos=left", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b icon=arrow-r iconpos=right")
  GW_ADD_BUTTON (thm3, "color=b icon=arrow-r iconpos=right", "")
  GW_USE_THEME_CUSTO_ONCE ("color=c icon=arrow-u iconpos=left")
  GW_ADD_BUTTON (thm3, "color=c icon=arrow-u iconpos=left", "")
  GW_USE_THEME_CUSTO_ONCE ("color=e icon=arrow-d iconpos=right")
  GW_ADD_BUTTON (thm3, "color=e icon=arrow-d iconpos=right", "")
  GW_ADD_SLIDER (thm3, "Slider:", 0, 100, 1, 50)
  GW_ADD_CHECKBOX (thm3, ">Check box")
  GW_ADD_RADIO (thm3, 0, ">Radio button")
  GW_ADD_FLIPSWITCH (thm3, "Flipswitch initially 'on'", "Off", ">On")
  GW_ADD_INPUTLINE (thm3, "", "Input Line")
  IF ShowCodePanels THEN
    GW_ADD_TEXT (thm3, "The code of this page:")
    GW_ADD_TEXT (thm3, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  END IF
  GW_ADD_BUTTON (thm3, "Back", "BACK")
  GW_ADD_LISTENER (thm3, 0, "longpress", "DUMP")
END IF
GW_RENDER (thm3)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF r$ = "DUMP" THEN POPUP "Page dumped" : GW_DUMP_TO_FILE (thm3, "ios.html")
UNTIL r$ = "BACK"
GOTO ThemePage

%==========================================================================================================
ThemePage4:
IF !thm4 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage4:")
  GW_LOAD_THEME ("bootstrap")
  thm4 = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("color=f icon=back iconpos=left")
  GW_ADD_TITLEBAR (thm4, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'bootstrap'"))
  IF ShowCodePanels THEN thm4code = GW_ADD_PANEL (thm4, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))

  GW_ADD_TEXT (thm4, "Some customized buttons:")
  GW_USE_THEME_CUSTO_ONCE ("color=a iconpos=right icon=alert")
  GW_ADD_BUTTON (thm4, "color=a\t icon=alert", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b iconpos=right icon=audio")
  GW_ADD_BUTTON (thm4, "color=b\t icon=audio", "")
  GW_USE_THEME_CUSTO_ONCE ("color=c iconpos=right icon=camera")
  GW_ADD_BUTTON (thm4, "color=c\t icon=camera", "")
  GW_USE_THEME_CUSTO_ONCE ("color=d iconpos=right icon=cloud")
  GW_ADD_BUTTON (thm4, "color=d\t icon=cloud", "")
  GW_USE_THEME_CUSTO_ONCE ("color=e iconpos=right icon=forbidden")
  GW_ADD_BUTTON (thm4, "color=e\t icon=forbidden", "")
  GW_USE_THEME_CUSTO_ONCE ("color=f iconpos=right icon=info")
  GW_ADD_BUTTON (thm4, "color=f\t icon=info", "")

  GW_ADD_TEXT (thm4, "Buttons with 'inline notext' custo:")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=video")
  GW_ADD_BUTTON (thm4, "", "1")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=recycle")
  GW_ADD_BUTTON (thm4, "", "2")
  GW_USE_THEME_CUSTO_ONCE ("color=e inline notext icon=navigation")
  GW_ADD_BUTTON (thm4, "", "3")
  GW_USE_THEME_CUSTO_ONCE ("color=a inline notext icon=search")
  GW_ADD_BUTTON (thm4, "", "4")
  GW_USE_THEME_CUSTO_ONCE ("color=c inline notext icon=shop")
  GW_ADD_BUTTON (thm4, "", "5")
  GW_USE_THEME_CUSTO_ONCE ("color=d inline notext icon=tag")
  GW_ADD_BUTTON (thm4, "", "6")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=user")
  GW_ADD_BUTTON (thm4, "", "7")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=phone")
  GW_ADD_BUTTON (thm4, "", "8")
  GW_ADD_CHECKBOX (thm4, ">Check box 1")
  GW_ADD_CHECKBOX (thm4, "Check box 2")
  GW_ADD_INPUTLINE (thm4, "", "Input Line")
  r = GW_ADD_RADIO (thm4, 0, ">Radio button 1")
  GW_ADD_RADIO (thm4, r, "Radio button 2")
  GW_USE_THEME_CUSTO_ONCE ("color=c")
  thm4flip1 = GW_ADD_FLIPSWITCH (thm4, "", "Off", ">On")
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  thm4flip2 = GW_ADD_FLIPSWITCH (thm4, "", "Off", "On")
  GW_USE_THEME_CUSTO_ONCE ("color=f")
  GW_ADD_SLIDER (thm4, "", 0, 100, 1, 50)

  GW_ADD_TEXT (thm4, "")
  IF ShowCodePanels THEN GW_ADD_LINK (thm4, "See the code of this page", GW_SHOW_PANEL$ (thm4code))
  GW_ADD_BUTTON (thm4, "Back", "BACK")
END IF
GW_RENDER (thm4)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF r$ = "1" THEN POPUP "color=b inline notext icon=video"
  IF r$ = "2" THEN POPUP "color=f inline notext icon=recycle"
  IF r$ = "3" THEN POPUP "color=e inline notext icon=navigation"
  IF r$ = "4" THEN POPUP "color=a inline notext icon=search"
  IF r$ = "5" THEN POPUP "color=c inline notext icon=shop"
  IF r$ = "6" THEN POPUP "color=d inline notext icon=tag"
  IF r$ = "7" THEN POPUP "color=b inline notext icon=user"
  IF r$ = "8" THEN POPUP "color=f inline notext icon=phone"
  IF GW_FLIPSWITCH_CHANGED (thm4flip1, "Off") THEN POPUP "Switched off"
  IF GW_FLIPSWITCH_CHANGED (thm4flip2, "On") THEN POPUP "Switched on"
UNTIL r$ = "BACK"
GOTO ThemePage

%==========================================================================================================
ThemePage5:
IF !thm5 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage5:")
  GW_LOAD_THEME ("android-holo")
  thm5 = GW_NEW_PAGE()
  GW_ADD_TITLEBAR (thm5, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'android-holo'"))
  GW_ADD_TEXT (thm5, "The 'android-holo' theme is an old theme: panels are not supported...")
  GW_ADD_TEXT (thm5, "Some customized buttons:")
  GW_USE_THEME_CUSTO_ONCE ("color=a icon=back")
  GW_ADD_BUTTON (thm5, "color=a icon=back", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b icon=menu")
  GW_ADD_BUTTON (thm5, "color=b icon=menu", "")
  GW_USE_THEME_CUSTO_ONCE ("color=c icon=home")
  GW_ADD_BUTTON (thm5, "color=c icon=home", "")
  GW_ADD_CHECKBOX (thm5, ">Check box 1")
  GW_ADD_CHECKBOX (thm5, "Check box 2")
  GW_ADD_INPUTLINE (thm5, "", "Input Line")
  r = GW_ADD_RADIO (thm5, 0, ">Radio button 1")
  GW_ADD_RADIO (thm5, r, "Radio button 2")
  thm5flip1 = GW_ADD_FLIPSWITCH (thm5, "Flipswitch initially 'on'", "Off", ">On")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  thm5flip2 = GW_ADD_FLIPSWITCH (thm5, "Flipswitch color=b initially 'off'", "Off", "On")
  GW_ADD_SLIDER (thm5, "Slider:", 0, 100, 1, 50)
  IF ShowCodePanels THEN
    GW_ADD_TEXT (thm5, "The code of this page:")
    GW_ADD_TEXT (thm5, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  END IF
  GW_ADD_BUTTON (thm5, "Back", "BACK")
END IF
GW_RENDER (thm5)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF GW_FLIPSWITCH_CHANGED (thm5flip1, "Off") THEN POPUP "Switched off"
  IF GW_FLIPSWITCH_CHANGED (thm5flip2, "On") THEN POPUP "Switched on"
UNTIL r$ = "BACK"
GOTO ThemePage

%==========================================================================================================
ThemePage6:
IF !thm6 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage6:")
  GW_LOAD_THEME ("square-ui")
  thm6 = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  GW_ADD_TITLEBAR (thm6, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'square-ui'"))
  IF ShowCodePanels THEN thm6code = GW_ADD_PANEL (thm6, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))

  GW_ADD_TEXT (thm6, "Some customized buttons:")
  GW_USE_THEME_CUSTO_ONCE ("color=a icon=action")
  GW_ADD_BUTTON (thm6, "color=a\t icon=action", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b icon=arrow-d-l")
  GW_ADD_BUTTON (thm6, "color=b\t icon=arrow-d-l", "")
  GW_USE_THEME_CUSTO_ONCE ("color=c icon=audio")
  GW_ADD_BUTTON (thm6, "color=c\t icon=audio", "")
  GW_USE_THEME_CUSTO_ONCE ("color=d icon=camera")
  GW_ADD_BUTTON (thm6, "color=d\t icon=camera", "")
  GW_USE_THEME_CUSTO_ONCE ("color=e icon=check")
  GW_ADD_BUTTON (thm6, "color=e\t icon=check", "")
  GW_USE_THEME_CUSTO_ONCE ("color=f icon=clock")
  GW_ADD_BUTTON (thm6, "color=f\t icon=clock", "")
  GW_USE_THEME_CUSTO_ONCE ("color=g icon=comment")
  GW_ADD_BUTTON (thm6, "color=g\t icon=comment", "")

  GW_ADD_TEXT (thm6, "Buttons with 'inline notext' custo:")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=video")
  GW_ADD_BUTTON (thm6, "", "1")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=recycle")
  GW_ADD_BUTTON (thm6, "", "2")
  GW_USE_THEME_CUSTO_ONCE ("color=e inline notext icon=navigation")
  GW_ADD_BUTTON (thm6, "", "3")
  GW_USE_THEME_CUSTO_ONCE ("color=a inline notext icon=search")
  GW_ADD_BUTTON (thm6, "", "4")
  GW_USE_THEME_CUSTO_ONCE ("color=c inline notext icon=shop")
  GW_ADD_BUTTON (thm6, "", "5")
  GW_USE_THEME_CUSTO_ONCE ("color=d inline notext icon=tag")
  GW_ADD_BUTTON (thm6, "", "6")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=user")
  GW_ADD_BUTTON (thm6, "", "7")
  GW_USE_THEME_CUSTO_ONCE ("color=f inline notext icon=phone")
  GW_ADD_BUTTON (thm6, "", "8")
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  GW_ADD_CHECKBOX (thm6, ">Check box 1")
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  GW_ADD_CHECKBOX (thm6, "Check box 2")
  GW_ADD_INPUTLINE (thm6, "", "Input Line")
  GW_USE_THEME_CUSTO_ONCE ("color=e")
  r = GW_ADD_RADIO (thm6, 0, ">Radio button 1")
  GW_USE_THEME_CUSTO_ONCE ("color=e")
  GW_ADD_RADIO (thm6, r, "Radio button 2")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  thm6flip1 = GW_ADD_FLIPSWITCH (thm6, "", "Off", ">On")
  thm6flip2 = GW_ADD_FLIPSWITCH (thm6, "", "Off", "On")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  GW_ADD_SLIDER (thm6, "", 0, 100, 1, 50)

  GW_ADD_TEXT (thm6, "")
  IF ShowCodePanels THEN GW_ADD_LINK (thm6, "See the code of this page", GW_SHOW_PANEL$ (thm6code))
  GW_ADD_BUTTON (thm6, "Back", "BACK")
END IF
GW_RENDER (thm6)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF r$ = "1" THEN POPUP "color=b inline notext icon=video"
  IF r$ = "2" THEN POPUP "color=f inline notext icon=recycle"
  IF r$ = "3" THEN POPUP "color=e inline notext icon=navigation"
  IF r$ = "4" THEN POPUP "color=a inline notext icon=search"
  IF r$ = "5" THEN POPUP "color=c inline notext icon=shop"
  IF r$ = "6" THEN POPUP "color=d inline notext icon=tag"
  IF r$ = "7" THEN POPUP "color=b inline notext icon=user"
  IF r$ = "8" THEN POPUP "color=f inline notext icon=phone"
  IF GW_FLIPSWITCH_CHANGED (thm6flip1, "Off") THEN POPUP "Switched off"
  IF GW_FLIPSWITCH_CHANGED (thm6flip2, "On") THEN POPUP "Switched on"
UNTIL r$ = "BACK"
GOTO ThemePage

%==========================================================================================================
ThemePage7:
IF !thm7 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage7:")
  GW_LOAD_THEME ("metro")
  thm7 = GW_NEW_PAGE()
  GW_ADD_TITLEBAR (thm7, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'metro'"))
  GW_ADD_TEXT (thm7, "The 'metro' theme is an old theme: panels are not supported...")
  GW_ADD_TEXT (thm7, "Some customized buttons:")
  GW_USE_THEME_CUSTO_ONCE ("color=a icon=back")
  GW_ADD_BUTTON (thm7, "color=a icon=back", "")
  GW_USE_THEME_CUSTO_ONCE ("color=b icon=menu")
  GW_ADD_BUTTON (thm7, "color=b icon=menu", "")
  GW_ADD_CHECKBOX (thm7, ">Check box 1")
  GW_ADD_CHECKBOX (thm7, "Check box 2")
  GW_ADD_INPUTLINE (thm7, "", "Input Line")
  r = GW_ADD_RADIO (thm7, 0, ">Radio button 1")
  GW_ADD_RADIO (thm7, r, "Radio button 2")
  thm7flip1 = GW_ADD_FLIPSWITCH (thm7, "Flipswitch initially 'on'", "Off", ">On")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  thm7flip2 = GW_ADD_FLIPSWITCH (thm7, "Flipswitch color=b initially 'off'", "Off", "On")
  GW_ADD_SLIDER (thm7, "Slider:", 0, 100, 1, 50)
  IF ShowCodePanels THEN
    GW_ADD_TEXT (thm7, "The code of this page:")
    GW_ADD_TEXT (thm7, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  END IF
  GW_ADD_BUTTON (thm7, "Back", "BACK")
END IF
GW_RENDER (thm7)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF GW_FLIPSWITCH_CHANGED (thm7flip1, "Off") THEN POPUP "Switched off"
  IF GW_FLIPSWITCH_CHANGED (thm7flip2, "On") THEN POPUP "Switched on"
UNTIL r$ = "BACK"
GOTO ThemePage

%==========================================================================================================
ThemePage8:
IF !tp8 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage8:")
  tp8 = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  GW_ADD_TITLEBAR (tp8, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Theme 'native-droid-*'"))
  IF ShowCodePanels THEN tp8code = GW_ADD_PANEL (tp8, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (tp8, "The 'native-droid' theme family is recommended to give your app a nice Android look.\nYou can decline the theme in light/dark and several colors: blue/green/purple/red/yellow")
  GW_ADD_BUTTON (tp8, "native-droid-light-blue", "1")
  GW_ADD_BUTTON (tp8, "native-droid-light-green", "2")
  GW_ADD_BUTTON (tp8, "native-droid-light-purple", "3")
  GW_ADD_BUTTON (tp8, "native-droid-light-red", "4")
  GW_ADD_BUTTON (tp8, "native-droid-light-yellow", "5")
  GW_ADD_BUTTON (tp8, "native-droid-dark-blue", "6")
  GW_ADD_BUTTON (tp8, "native-droid-dark-green", "7")
  GW_ADD_BUTTON (tp8, "native-droid-dark-purple", "8")
  GW_ADD_BUTTON (tp8, "native-droid-dark-red", "9")
  GW_ADD_BUTTON (tp8, "native-droid-dark-yellow", "10")
  GW_ADD_TEXT (tp8, "")
  IF ShowCodePanels THEN GW_ADD_LINK (tp8, "See the code of this page", GW_SHOW_PANEL$ (tp8code))
  GW_ADD_BUTTON (tp8, "Back", "BACK")
END IF
GW_RENDER (tp8)
r$ = GW_WAIT_ACTION$()
IF r$ = "BACK" THEN GOTO ThemePage
IF r$ = "1" THEN nativeandro$ = "native-droid-light-blue"
IF r$ = "2" THEN nativeandro$ = "native-droid-light-green"
IF r$ = "3" THEN nativeandro$ = "native-droid-light-purple"
IF r$ = "4" THEN nativeandro$ = "native-droid-light-red"
IF r$ = "5" THEN nativeandro$ = "native-droid-light-yellow"
IF r$ = "6" THEN nativeandro$ = "native-droid-dark-blue"
IF r$ = "7" THEN nativeandro$ = "native-droid-dark-green"
IF r$ = "8" THEN nativeandro$ = "native-droid-dark-purple"
IF r$ = "9" THEN nativeandro$ = "native-droid-dark-red"
IF r$ = "10" THEN nativeandro$ = "native-droid-dark-yellow"
GOTO ThemePage8bis

%==========================================================================================================
ThemePage8bis:
IF !thm8 THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ThemePage8bis:")
  GW_LOAD_THEME (nativeandro$)
  thm8 = GW_NEW_PAGE()
  IF ShowCodePanels THEN thm8code = GW_ADD_PANEL (thm8, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  GW_ADD_TITLEBAR (thm8, GW_ADD_BAR_LBUTTON$ ("&nbsp;>BACK") + GW_ADD_BAR_TITLE$ (nativeandro$))

  GW_ADD_BUTTON (thm8, "First button", "")
  GW_ADD_BUTTON (thm8, "Second button", "")

  GW_ADD_TEXT (thm8, "Buttons with 'inline notext' custo:")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=video")
  GW_ADD_BUTTON (thm8, "", "1")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=recycle")
  GW_ADD_BUTTON (thm8, "", "2")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=navigation")
  GW_ADD_BUTTON (thm8, "", "3")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=search")
  GW_ADD_BUTTON (thm8, "", "4")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=shop")
  GW_ADD_BUTTON (thm8, "", "5")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=tag")
  GW_ADD_BUTTON (thm8, "", "6")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=user")
  GW_ADD_BUTTON (thm8, "", "7")
  GW_USE_THEME_CUSTO_ONCE ("color=b inline notext icon=phone")
  GW_ADD_BUTTON (thm8, "", "8")
  GW_OPEN_GROUP (thm8)
  GW_ADD_CHECKBOX (thm8, ">Check box 1")
  GW_ADD_CHECKBOX (thm8, "Check box 2")
  GW_CLOSE_GROUP (thm8)
  GW_ADD_SLIDER (thm8, "", 0, 100, 1, 50)
  GW_ADD_INPUTLINE (thm8, "", "Input Line")
  GW_OPEN_GROUP (thm8)
  r = GW_ADD_RADIO (thm8, 0, ">Radio button 1")
  GW_ADD_RADIO (thm8, r, "Radio button 2")
  GW_CLOSE_GROUP (thm8)
  thm8flip1 = GW_ADD_FLIPSWITCH (thm8, "", "Off", ">On")
  thm8flip2 = GW_ADD_FLIPSWITCH (thm8, "", "Off", "On")

  GW_ADD_TEXT (thm8, "")
  IF ShowCodePanels THEN GW_ADD_LINK (thm8, "See the code of this page", GW_SHOW_PANEL$ (thm8code))
  GW_ADD_BUTTON (thm8, "Back", "BACK")

  oldnativeandro$ = nativeandro$
ELSE % page already made: we do a guru trick to replace the theme
  e$ = GW_GET_SKEY$("page", thm8) % content of page 'thm8'
  e$ = REPLACE$ (e$, oldnativeandro$, nativeandro$)
  IF IS_IN ("-dark-", nativeandro$) & !IS_IN ("-dark-", oldnativeandro$) THEN
    e$ = REPLACE$ (e$, "jquerymobile.nativedroid.light.css", "jquerymobile.nativedroid.dark.css")
  ELSEIF IS_IN ("-light-", nativeandro$) & !IS_IN ("-light-", oldnativeandro$) THEN
    e$ = REPLACE$ (e$, "jquerymobile.nativedroid.dark.css", "jquerymobile.nativedroid.light.css")
  END IF
  IF RIGHT$ (nativeandro$, 3) <> RIGHT$ (oldnativeandro$, 3) THEN
    i = IS_IN ("-", oldnativeandro$, 16)
    ona_col$ = MID$ (oldnativeandro$, i+1)
    i = IS_IN ("-", nativeandro$, 16)
    na_col$ = MID$ (nativeandro$, i+1)
    e$ = REPLACE$ (e$, "jquerymobile.nativedroid.color."+ona_col$, "jquerymobile.nativedroid.color."+na_col$)
  END IF
  GW_SET_SKEY("page", thm8, e$)
  oldnativeandro$ = nativeandro$
END IF
GW_RENDER (thm8)
GW_UNLOAD_THEME() % to avoid future pages to inherit this theme
DO
  r$ = GW_WAIT_ACTION$()
  IF r$ = "1" THEN POPUP "color=b inline notext icon=video"
  IF r$ = "2" THEN POPUP "color=b inline notext icon=recycle"
  IF r$ = "3" THEN POPUP "color=b inline notext icon=navigation"
  IF r$ = "4" THEN POPUP "color=b inline notext icon=search"
  IF r$ = "5" THEN POPUP "color=b inline notext icon=shop"
  IF r$ = "6" THEN POPUP "color=b inline notext icon=tag"
  IF r$ = "7" THEN POPUP "color=b inline notext icon=user"
  IF r$ = "8" THEN POPUP "color=b inline notext icon=phone"
  IF GW_FLIPSWITCH_CHANGED (thm8flip1, "Off") THEN POPUP "Switched off"
  IF GW_FLIPSWITCH_CHANGED (thm8flip2, "On") THEN POPUP "Switched on"
UNTIL r$ = "BACK"
GOTO ThemePage8

%==========================================================================================================
DlgMsgPage:
IF !dlm THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("DlgMsgPage:")
  dlm = GW_NEW_PAGE()
  ARRAY.LOAD bna1$[], "OK"
  GW_USE_THEME_CUSTO_ONCE ("inline") % horizontal buttons
  dmt = GW_ADD_DIALOG_MESSAGE (dlm, "I'm a timer Dialog Message", "I will close in 5 seconds", bna1$[])
  GW_USE_THEME_CUSTO_ONCE ("inline") % horizontal buttons
  dm0 = GW_ADD_DIALOG_MESSAGE (dlm, "", "You can trigger a dialog message manually, for example after rendering a page...", bna1$[])
  ARRAY.LOAD bna1b$[], "OK>CLOSED"
  GW_USE_THEME_CUSTO_ONCE ("inline") % horizontal buttons
  dc0 = GW_ADD_DIALOG_CHECKBOX (dlm, "DIALOG CHECKBOX", "I am a dialog checkbox = a normal dialog message with an additional checkbox.", "Do not show again", bna1b$[])
  GW_USE_THEME_CUSTO_ONCE ("inline") % horizontal buttons
  dm1 = GW_ADD_DIALOG_MESSAGE (dlm, "", "This is a dialog message without title with a single button with the default transition 'pop'", bna1$[])
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  dlmttb = GW_ADD_TITLEBAR (dlm, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Dialog Message") + barmenu$)
  GW_ADD_LISTENER (dlm, dlmttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN dlmcode = GW_ADD_PANEL (dlm, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (dlm, "Dialog Messages are used to display a popup window and get the user feedback via 1 or more buttons.\nDialog Messages can be opened (triggered) via links or via buttons:")
  GW_ADD_LINK (dlm, "Click here for a simple dialog message<br><br>", GW_SHOW_DIALOG$ (dm1))
  GW_ADD_LINK (dlm, "Click here for a dialog checkbox<br><br>", GW_SHOW_DIALOG$ (dc0))
  GW_ADD_BUTTON (dlm, "Show a dialog message with a timer", "DMT")
  GW_ADD_TEXT (dlm, "Or specify following features for more complex dialog messages:")
  ARRAY.LOAD bna2$[], "Nice>Y", "Ugly>N"
  dm2 = GW_ADD_DIALOG_MESSAGE (dlm, "Now I have a title...", "...and 2 buttons.\nNice?", bna2$[])
  GW_CUSTO_DLGBTN (dlm, dm2, bna2$[1], "icon=check")
  GW_CUSTO_DLGBTN (dlm, dm2, bna2$[2], "icon=delete")
  ARRAY.LOAD bna3$[], "Vibrate>VIBR", "Other popup>" + GW_SHOW_DIALOG$ (dm1), "Cancel>0"
  dm3 = GW_ADD_DIALOG_MESSAGE (dlm, "Vibrate or Beep", "What do you want to do?", bna3$[])
  GW_CUSTO_DLGBTN (dlm, dm3, bna3$[1], "icon=audio")
  GW_CUSTO_DLGBTN (dlm, dm3, bna3$[2], "icon=comment")
  GW_CUSTO_DLGBTN (dlm, dm3, bna3$[3], "style='color:blue'")
  dmti = GW_ADD_CHECKBOX (dlm, ">Have a title")
  GW_ADD_LISTENER (dlm, dmti, "change", "TITLE_CHANGE")
  dmte = GW_ADD_CHECKBOX (dlm, ">Have some text")
  GW_ADD_LISTENER (dlm, dmte, "change", "TEXT_CHANGE")
  dmib = GW_ADD_CHECKBOX (dlm, "Inline buttons")
  GW_ADD_LISTENER (dlm, dmib, "change", "ALIGNMENT_CHANGE")
  ARRAY.LOAD transition$[], ">Pop", "Fade", "Flip", "Turn", "Flow" ~
    "Slidefade", "Slide", "Slideup", "Slidedown", "None"
  GW_USE_THEME_CUSTO_ONCE ("inline")
  dmtr = GW_ADD_SELECTBOX (dlm, "Transition type:", transition$[])
  GW_ADD_LISTENER (dlm, dmtr, "change", "TRANSITION_CHANGE")
  GW_START_CENTER (dlm)
  GW_USE_THEME_CUSTO_ONCE ("inline icon=info")
  GW_ADD_BUTTON (dlm, "Question", GW_SHOW_DIALOG$ (dm2))
  GW_USE_THEME_CUSTO_ONCE ("inline icon=grid")
  GW_ADD_BUTTON (dlm, "3 buttons", GW_SHOW_DIALOG$ (dm3))
  GW_STOP_CENTER (dlm)
  GW_ADD_TEXT (dlm, "")
  IF ShowCodePanels THEN GW_ADD_LINK (dlm, "See the code of this page", GW_SHOW_PANEL$ (dlmcode))
  GW_ADD_BUTTON (dlm, "Back", "BACK")
  GW_ADD_LISTENER (dlm, 0, "longpress", "DUMP")
END IF
GW_RENDER (dlm)
PAUSE 1000
GW_SET_TRANSITION (dm0, "none")
GW_SHOW_DIALOG (dm0)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "DUMP" THEN
    POPUP "Page dumped" : GW_DUMP_TO_FILE (dlm, "dlgmsg.html")
  ELSEIF r$ = "DMT" THEN % Dialog Message with a Timer
    GW_SHOW_DIALOG (dmt)
    FOR i = 5 TO 1 STEP -1
      GW_MODIFY (dmt, "text", "I will close in " + INT$(i) + " seconds")
      IF GW_ACTION$() <> "" THEN F_N.BREAK
      PAUSE 1000
    NEXT
    GW_CLOSE_DIALOG (dmt)
  ELSEIF r$ = "CLOSED" THEN
    IF GW_CHECKBOX_CHECKED(dc0) THEN POPUP "Checked" ELSE POPUP "Unchecked"
  ELSEIF r$ = "TITLE_CHANGE" | r$ = "TEXT_CHANGE" THEN
    IF GW_GET_VALUE (dmti) % have title
      GW_MODIFY (dm2, "title", "Now I have a title...")
      GW_MODIFY (dm3, "title", "Vibrate or beep?")
      IF GW_GET_VALUE (dmte) THEN % title and text
        GW_MODIFY (dm2, "text", "...and 2 buttons.\nNice?")
        GW_MODIFY (dm3, "text", "What do you want to do?")
      ELSE % title and no text
        GW_MODIFY (dm2, "text", "")
        GW_MODIFY (dm3, "text", "")
      END IF
    ELSE % no title
      GW_MODIFY (dm2, "title", "")
      GW_MODIFY (dm3, "title", "")
      IF GW_GET_VALUE (dmte) THEN % no title but text
        GW_MODIFY (dm2, "text", "I have 2 buttons.\nNice?")
        GW_MODIFY (dm3, "text", "What do you want to do?")
      ELSE % no title nor text
        GW_MODIFY (dm2, "text", "")
        GW_MODIFY (dm3, "text", "")
      END IF
    END IF
  ELSEIF r$ = "ALIGNMENT_CHANGE"
    horizontal = GW_GET_VALUE (dmib)
    IF horizontal THEN GW_USE_THEME_CUSTO_ONCE("inline")
    GW_AMODIFY (dm2, "buttons", bna2$[])
    IF horizontal THEN GW_USE_THEME_CUSTO_ONCE("inline")
    GW_AMODIFY (dm3, "buttons", bna3$[])
  ELSEIF r$="TRANSITION_CHANGE"
    i = GW_GET_VALUE (dmtr)
    e$ = LOWER$ (transition$[i])
    GW_SET_TRANSITION (dm2, e$)
    GW_SET_TRANSITION (dm3, e$)
  END IF 
  IF r$ = "Y" THEN POPUP "You clicked 'Nice'"
  IF r$ = "N" THEN POPUP "You clicked 'Ugly'"
  IF r$ = "VIBR" THEN VIBRATE buzz[], -1
UNTIL r$ = "BACK"
GOTO AdvancedPage

%==========================================================================================================
DlgInpPage:
IF !dli THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("DlgInpPage:")
  dli = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  dlittb = GW_ADD_TITLEBAR (dli, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Dialog Input") + barmenu$)
  GW_ADD_LISTENER (dli, dlittb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN dlicode = GW_ADD_PANEL (dli, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (dli, "Dialog Inputs are used to display a popup and get the user feedback via an input field, and 1 or more buttons.\nThey are heavily customizable:")
  ARRAY.LOAD dlib$[], "Btn1>1"
  LIST.CREATE s, dlib % dialog input buttons
  LIST.ADD.ARRAY dlib, dlib$[]
  di1 = GW_ADD_DIALOG_INPUT (dli, "This is a title", "This is a message.\nAnd this is an input field:", "Azerty", dlib$[])
  diti = GW_ADD_CHECKBOX (dli, ">Have a title")
  GW_ADD_LISTENER (dli, diti, "change", "TITLE_CHANGE")
  dite = GW_ADD_CHECKBOX (dli, ">Have some text")
  GW_ADD_LISTENER (dli, dite, "change", "TEXT_CHANGE")
  diib = GW_ADD_CHECKBOX (dli, "Inline buttons")
  GW_ADD_LISTENER (dli, diib, "change", "ALIGNMENT_CHANGE")
  dlisli = GW_ADD_SLIDER (dli, "Number of buttons:", 1, 5, 1, 1)
  GW_ADD_LISTENER (dli, dlisli, "change", "NBOFBTN_CHANGE")
  ARRAY.LOAD typofinput$[], ">Text", "Number", "Password", "Email", "URL"
  ARRAY.LOAD txtofinput$[], "Azerty", "0>123.456", "*>password", "@>mougino@free.fr", "<>http://mougino.free.fr"
  GW_SHELF_OPEN (dli) % align 2 SELECTBOX
  diit = GW_ADD_SELECTBOX (dli, "Type of input:", typofinput$[])
  GW_ADD_LISTENER (dli, diit, "change", "TYPOFINPUT_CHANGE")
  ARRAY.LOAD transition$[], ">Pop", "Fade", "Flip", "Turn", "Flow" ~
    "Slidefade", "Slide", "Slideup", "Slidedown", "None"
  GW_USE_THEME_CUSTO_ONCE ("style='width:20px'")
  GW_SHELF_NEWCELL (dli) % empty cell of 20 pixel
  GW_SHELF_NEWCELL (dli) % to contain 2nd SELECTBOX
  ditr = GW_ADD_SELECTBOX (dli, "Transition type:", transition$[])
  GW_ADD_LISTENER (dli, ditr, "change", "TRANSITION_CHANGE")
  GW_SHELF_CLOSE (dli)
  GW_ADD_BUTTON (dli, "TEST ME!", GW_SHOW_DIALOG$ (di1))
  GW_ADD_TEXT (dli, "")
  IF ShowCodePanels THEN GW_ADD_LINK (dli, "See the code of this page", GW_SHOW_PANEL$ (dlicode))
  GW_ADD_BUTTON (dli, "Back", "BACK")
END IF
GW_RENDER (dli)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "TITLE_CHANGE"
    IF GW_GET_VALUE (diti) % have title
      GW_MODIFY (di1, "title", "This is a title")
    ELSE
      GW_MODIFY (di1, "title", "")
    END IF
  ELSEIF r$ = "TEXT_CHANGE"
    IF GW_GET_VALUE (dite) % have text
      GW_MODIFY (di1, "text", "This is a message.\nAnd this is an input field:")
    ELSE
      GW_MODIFY (di1, "text", "")
    END IF
  ELSEIF r$ = "NBOFBTN_CHANGE"
    nbtn = GW_GET_VALUE(dlisli)
    IF nbtn
      LIST.CLEAR dlib
      FOR i=1 TO nbtn
        LIST.ADD dlib, "Btn" + INT$(i) + ">" + INT$(i)
      NEXT
      ARRAY.DELETE dlib$[]
      LIST.TOARRAY dlib, dlib$[]
      horizontal = GW_GET_VALUE (diib)
      IF horizontal THEN GW_USE_THEME_CUSTO_ONCE("inline")
      GW_AMODIFY (di1, "buttons", dlib$[])
    END IF
  ELSEIF r$ = "TYPOFINPUT_CHANGE"
    i = GW_GET_VALUE (diit)
    GW_MODIFY (di1, "input", txtofinput$[i])
  ELSEIF r$ = "ALIGNMENT_CHANGE"
    horizontal = GW_GET_VALUE (diib)
    IF horizontal THEN GW_USE_THEME_CUSTO_ONCE("inline")
    GW_AMODIFY (di1, "buttons", dlib$[])
  ELSEIF r$="TRANSITION_CHANGE"
    i = GW_GET_VALUE (ditr)
    e$ = LOWER$ (transition$[i])
    GW_SET_TRANSITION (di1, e$)
  ELSEIF LEN(r$)=1
    e$ = "User clicked Btn" + r$
    e$ += "\nContent of input field is:\n"
    e$ += CHR$(34) + GW_GET_VALUE$ (di1) + CHR$(34)
    POPUP e$
  END IF
UNTIL r$ = "BACK"
GOTO AdvancedPage

%==========================================================================================================
VideoPage:
IF !vid THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("VideoPage:")
  vid = GW_NEW_PAGE()
  ARRAY.LOAD bna$[], "OK>NEWAUDIO", "Cancel"
  GW_USE_THEME_CUSTO_ONCE ("inline")
  audiodlg = GW_ADD_DIALOG_INPUT (vid, "AUDIO PLAYER SOURCE", "Url of new webradio:", "<>http://amp1.cesnet.cz:8000/cro1.ogg", bna$[])
  GW_CUSTO_DLGBTN (vid, audiodlg, bna$[1], "style='background:green;color:white'")
  GW_CUSTO_DLGBTN (vid, audiodlg, bna$[2], "style='background:red;color:white'")
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  vidttb = GW_ADD_TITLEBAR (vid, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Audio/Video") + barmenu$)
  GW_ADD_LISTENER (vid, vidttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN vidcode = GW_ADD_PANEL (vid, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_SHELF_OPEN (vid)
    GW_ADD_TEXT (vid, "This is an audio player:")
  GW_SHELF_NEWCELL (vid)
    GW_ADD_BUTTON (vid, "Change webradio", GW_SHOW_DIALOG$ (audiodlg))
  GW_SHELF_CLOSE (vid)
  webradio = GW_ADD_AUDIO (vid, "http://amp1.cesnet.cz:8000/cro1.ogg")
  GW_ADD_TEXT (vid, "This is a local 3gp video:")
  GW_USE_THEME_CUSTO_ONCE ("style='background:red; color:white'")
  viddl = GW_ADD_BUTTON (vid, "Download 100kB 3gp video to SD", "DL3GP")
  localvid = GW_ADD_VIDEO (vid, "small.3gp" + ">http://mougino.free.fr/tmp/small.3gp.png")
  GW_ADD_TEXT (vid, "And this is an online mp4 video:")
  GW_ADD_VIDEO (vid, "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" ~
                   + ">http://camendesign.com/code/video_for_everybody/poster.jpg")
  GW_ADD_TEXT (vid, "")
  IF ShowCodePanels THEN GW_ADD_LINK (vid, "See the code of this page", GW_SHOW_PANEL$ (vidcode))
  GW_ADD_BUTTON (vid, "Back", "BACK")
END IF
GW_RENDER (vid)
FILE.EXISTS fe, "small.3gp"
IF fe THEN GW_HIDE (viddl) ELSE GW_MODIFY (localvid, "content", ">http://mougino.free.fr/tmp/missing-video.jpg")
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "NEWAUDIO" THEN
    newradio$ = GW_GET_VALUE$ (audiodlg)
    GW_MODIFY (webradio, "content", newradio$)
    POPUP "Webradio changed to\n" + newradio$ + "\nYou can now play it!"
  ELSEIF r$ = "DL3GP" THEN
    POPUP "Initializing connection to ftp.laughton.com..."
    FTP.OPEN "ftp.laughton.com", 21, "basic", "basic"
    FTP.GET "/html/GW (GUI-Web lib)/small.3gp", "small.3gp"
    FTP.CLOSE
    POPUP "Video downloaded locally !"
    GW_RENDER (vid)
    GW_HIDE (viddl)
  END IF
UNTIL r$ = "BACK"
GOTO AdvancedPage

%==========================================================================================================
TablePage:
IF !tbl THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("TablePage:")
  tbl = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  tblttb = GW_ADD_TITLEBAR (tbl, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Table") + barmenu$)
  GW_ADD_LISTENER (tbl, tblttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN tblcode = GW_ADD_PANEL (tbl, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  tbim1$ = GW_ADD_IMAGE$ ("cartman.png>IMG1")
  tbimg1 = GW_LAST_ID()
  tbim2$ = GW_ADD_IMAGE$ ("cartman.png>IMG2")
  tbimg2 = GW_LAST_ID()
  ARRAY.LOAD myTbl0$[], tbim1$, "< click image", "click image > ", tbim2$
  GW_ADD_TEXT (tbl, "This is a table containing local, clickable images:")
  GW_ADD_TABLE (tbl, 2, myTbl0$[]) % n_cols = 2
  ARRAY.LOAD myTbl1$[], ~
    ">Animal", "Food", "Nemesis" ~
    "Dog", "Bone", "Cat" ~
    "Cat", "Mouse", "Dog" ~
    "Mouse", "Cheese", "Cat" ~
    "Fish", "Worm", "Cat" ~
    "Worm", "Dirt", "Fishing rod"
  GW_ADD_TEXT (tbl, "This is a 1-dimension BASIC! array, statically loaded, with a title line, rendered as a table:")
  GW_ADD_TABLE (tbl, 3, myTbl1$[]) % n_cols = 3
  LIST.CREATE s, RndList
  FOR col=1 TO 6
    FOR row=1 TO 8
      LIST.ADD RndList, INT$(col * 100 * RND() + 0.5)
    NEXT
  NEXT
  LIST.TOARRAY RndList, myTbl2$[]
  GW_ADD_TEXT (tbl, "Now this is a 1-dimension BASIC! array of 6x8 dynamic elements (without title line) created from a LIST.TOARRAY, rendered as a table:")
  tbl_ctl2 = GW_ADD_TABLE (tbl, 6, myTbl2$[]) % n_cols = 6
  GW_START_CENTER (tbl)
  GW_USE_THEME_CUSTO_ONCE ("inline color=b icon=plus")
  GW_ADD_BUTTON (tbl, "Add row", "ADD")
  GW_USE_THEME_CUSTO_ONCE ("inline color=b icon=minus")
  GW_ADD_BUTTON (tbl, "Remove row", "DEL")
  GW_STOP_CENTER (tbl)
  GW_ADD_TEXT (tbl, "")
  IF ShowCodePanels THEN GW_ADD_LINK (tbl, "See the code of this page", GW_SHOW_PANEL$ (tblcode))
  GW_ADD_BUTTON (tbl, "Back", "BACK")
END IF
tbimsel1=0
tbimsel2=0
GW_RENDER (tbl)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "IMG1" THEN
    tbimsel1=1-tbimsel1
    IF tbimsel1 THEN
      GW_MODIFY (tbimg1, "content", "fly.gif")
    ELSE
      GW_MODIFY (tbimg1, "content", "cartman.png")
    END IF
  ELSEIF r$ = "IMG2" THEN
    tbimsel2=1-tbimsel2
    IF tbimsel2 THEN
      GW_MODIFY (tbimg2, "content", "fly.gif")
    ELSE
      GW_MODIFY (tbimg2, "content", "cartman.png")
    END IF
  ELSEIF r$ = "ADD" THEN
    FOR col=1 TO 6
      LIST.ADD RndList, INT$(col * 100 * RND() + 0.5)
    NEXT
    ARRAY.DELETE myTbl2$[]
    LIST.TOARRAY RndList, myTbl2$[]
    GW_AMODIFY (tbl_ctl2, "content", myTbl2$[])
  ELSEIF r$ = "DEL" THEN
    LIST.SIZE RndList, ls
    IF !ls THEN % already empty table
      POPUP "Empty table!"
    ELSEIF ls=6 THEN % remove the last line => empty table
      LIST.CLEAR RndList
      GW_MODIFY (tbl_ctl2, "content", "")
    ELSE
      FOR col=1 TO 6
        LIST.REMOVE RndList, ls
        LIST.SIZE RndList, ls
      NEXT
      ARRAY.DELETE myTbl2$[]
      LIST.TOARRAY RndList, myTbl2$[]
      GW_AMODIFY (tbl_ctl2, "content", myTbl2$[])
    END IF
  END IF
UNTIL r$ = "BACK"
GOTO BasicPage

%==========================================================================================================
LvPage:
IF !lvp THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("LvPage:")
  ARRAY.LOAD lv_typ$[], ">Cars", "Fruits", "Languages"
  act=1 % 1st array is selected
  ARRAY.LOAD lv_car$[], "Acura ($36 945)", "Audi ($73 532)", "BMW ($58 300)", "Cadillac ($70 533)", "Ferrari ($243 090)"
  ARRAY.LOAD lv_fruit$[], "Apple", "Banana", "Cherry", "Cranberry", "Grape", "Orange"
  ARRAY.LOAD lv_lang$[], "Hungarian", "English", "Spanish", "French", "Dutch", "Deutsch", "Russian", "Turkish", "Latin"

  lvp = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  lvpttb = GW_ADD_TITLEBAR (lvp, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Listview") + barmenu$)
  GW_ADD_LISTENER (lvp, lvpttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN lvcode = GW_ADD_PANEL (lvp, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_USE_THEME_CUSTO_ONCE ("inline")
  lv_typ_chosen = GW_ADD_SELECTBOX (lvp, "1. Choose a type of listview:", lv_typ$[])
  GW_ADD_LISTENER (lvp, lv_typ_chosen, "change", "SELECTBOX_CHANGED")
  GW_ADD_TEXT (lvp, "2. Then select the listview settings:")
  GW_USE_THEME_CUSTO_ONCE ("inline")
  GW_OPEN_GROUP (lvp)
  ordered_chk = GW_ADD_CHECKBOX (lvp, "Ordered")
  title_chk = GW_ADD_CHECKBOX (lvp, "Title")
  linked_chk = GW_ADD_CHECKBOX (lvp, "Link")
  thumb_chk = GW_ADD_CHECKBOX (lvp, "Thumbs")
  twoline_chk = GW_ADD_CHECKBOX (lvp, "2-line")
  GW_CLOSE_GROUP (lvp)
  GW_ADD_LISTENER (lvp, ordered_chk, "change", "ORDERED_CHANGED")
  GW_ADD_LISTENER (lvp, title_chk, "change", "TITLE_CHANGED")
  GW_ADD_LISTENER (lvp, linked_chk, "change", "LINKED_CHANGED")
  GW_ADD_LISTENER (lvp, thumb_chk, "change", "THUMB_CHANGED")
  GW_ADD_LISTENER (lvp, twoline_chk, "change", "TWOLINE_CHANGED")
  lv = GW_ADD_LISTVIEW (lvp, lv_car$[])

  FN.DEF DumpArray$(a$[])
    ARRAY.LENGTH n, a$[]
    FOR i=1 TO n
      r$ += "\"" + a$[i] + "\", "
    NEXT
    FN.RTN LEFT$(r$, -2)
  FN.END
  
  GW_ADD_TEXT (lvp, "This is a sortable listview, sort it by drag & drop, then click on the Update button to get user changes:")
  ARRAY.LOAD veggies$[], "~Salad", "Broccoli", "Tomatoes", "Carrots", "Beans", "Eggplant"
  lv2 = GW_ADD_LISTVIEW (lvp, veggies$[])
  vg$ = "Last sortable state: "
  vg_tx = GW_ADD_TEXTBOX (lvp, vg$ + DumpArray$(veggies$[]))
  GW_ADD_BUTTON (lvp, "UPDATE SORTABLE STATE", "SORT_UPDATE")

  GW_ADD_TEXT (lvp, "This is a swipeable listview, swipe any element left and/or right to show options:")
  ARRAY.LOAD files$[], "Edit|File #1|Delete", "Edit|File #2|Delete", "Folder #1|Delete", "View|Total Size"
  lv3 = GW_ADD_LISTVIEW (lvp, files$[])

  GW_ADD_TEXT (lvp, "")
  IF ShowCodePanels THEN GW_ADD_LINK (lvp, "See the code of this page", GW_SHOW_PANEL$ (lvcode))
  GW_ADD_BUTTON (lvp, "Back", "BACK")

  FN.DEF MakeTwoLine (arr$[])
    ARRAY.LENGTH al, arr$[]
    FOR i=1 to al
      linked = IS_IN (">", arr$[i], 3) : IF 0 = linked THEN linked = LEN (arr$[i]) + 1
      thumbd = IS_IN ("@", arr$[i], 3) : IF 0 = thumbd THEN thumbd = LEN (arr$[i]) + 1
      eot = MIN (linked, thumbd)
      arr$[i] = LEFT$ (arr$[i], eot - 1) +"\nSecond line" + MID$ (arr$[i], eot)
    NEXT
  FN.END
END IF

GW_RENDER (lvp)
GW_DUMP_TO_FILE (lvp, "GW_demo_listview.html")
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "SORT_UPDATE"
    IF !GW_LISTVIEW_CHANGED(lv2)
      POPUP "No change!"
    ELSE
      order$ = GW_GET_LISTVIEW_ORDER$ (lv2)
      GW_REORDER_ARRAY (veggies$[], order$)
      GW_MODIFY (vg_tx, "text", vg$ + DumpArray$(veggies$[]))
    ENDIF
  ELSEIF r$ = "SELECTBOX_CHANGED"
    act = GW_GET_VALUE (lv_typ_chosen)
    IF act <> sb THEN GOSUB RefreshListview
  ELSEIF r$ = "ORDERED_CHANGED"
    ordered = GW_GET_VALUE (ordered_chk)
    IF ordered % Switch to ordered listview
      lv_car$[1] = "#" + lv_car$[1] % '#' = marker for ordered list
      lv_fruit$[1] = "#" + lv_fruit$[1]
      lv_lang$[1] = "#" + lv_lang$[1]
    ELSE % Switch to unordered listview
      lv_car$[1] = MID$ (lv_car$[1], 2)
      lv_fruit$[1] = MID$ (lv_fruit$[1], 2)
      lv_lang$[1] = MID$ (lv_lang$[1], 2)
    END IF
    GOSUB RefreshListview
  ELSEIF r$ = "THUMB_CHANGED"
    thumbnail = GW_GET_VALUE (thumb_chk)
    IF thumbnail % Switch to thumbnailed listview
      ARRAY.LENGTH al, lv_car$[]
      FOR i=1 to al : lv_car$[i] += "@galaxy.png" : NEXT
      ARRAY.LENGTH al, lv_fruit$[]
      FOR i=1 to al : lv_fruit$[i] += "@galaxy.png" : NEXT
      ARRAY.LENGTH al, lv_lang$[]
      FOR i=1 to al : lv_lang$[i] += "@galaxy.png" : NEXT
    ELSE % Switch to unthumbnailed listview
      ARRAY.LENGTH al, lv_car$[]
      FOR i=1 to al : lv_car$[i] = REPLACE$(lv_car$[i], "@galaxy.png", "") : NEXT
      ARRAY.LENGTH al, lv_fruit$[]
      FOR i=1 to al : lv_fruit$[i] = REPLACE$(lv_fruit$[i], "@galaxy.png", "") : NEXT
      ARRAY.LENGTH al, lv_lang$[]
      FOR i=1 to al : lv_lang$[i] = REPLACE$(lv_lang$[i], "@galaxy.png", "") : NEXT
    END IF
    GOSUB RefreshListview
  ELSEIF r$ = "TWOLINE_CHANGED"
    twoline = GW_GET_VALUE (twoline_chk)
    IF twoline % Switch to 2-line listview cells
      MakeTwoLine (lv_car$[])
      MakeTwoLine (lv_fruit$[])
      MakeTwoLine (lv_lang$[])
    ELSE % Switch to 1-line listview cells
      ARRAY.LENGTH al, lv_car$[]
      FOR i=1 to al : lv_car$[i] = REPLACE$(lv_car$[i], "\nSecond line", "") : NEXT
      ARRAY.LENGTH al, lv_fruit$[]
      FOR i=1 to al : lv_fruit$[i] = REPLACE$(lv_fruit$[i], "\nSecond line", "") : NEXT
      ARRAY.LENGTH al, lv_lang$[]
      FOR i=1 to al : lv_lang$[i] = REPLACE$(lv_lang$[i], "\nSecond line", "") : NEXT
    END IF
    GOSUB RefreshListview
  ELSEIF r$ = "TITLE_CHANGED"
    titled = GW_GET_VALUE (title_chk)
    IF titled % Turn 1st and 3rd elements to titles
      lv_car$[1] = ">Title" % leading '>' = marker for title
      lv_car$[3] = ">Separator"
      lv_fruit$[1] = ">Title"
      lv_fruit$[3] = ">Separator"
      lv_lang$[1] = ">Title"
      lv_lang$[3] = ">Separator"
    ELSE % Remove title marks
      lv_car$[1] = "Acura ($36 945)"
      lv_car$[3] = "BMW ($58 300)"
      lv_fruit$[1] = "Apple"
      lv_fruit$[3] = "Cherry"
      lv_lang$[1] = "Hungarian"
      lv_lang$[3] = "Spanish"
    END IF
    IF ordered
      lv_car$[1] = "#" + lv_car$[1]
      lv_fruit$[1] = "#" + lv_fruit$[1]
      lv_lang$[1] = "#" + lv_lang$[1]
    END IF
    IF linked
      lv_car$[1] += ">LV1"
      lv_car$[3] += ">LV3"
      lv_fruit$[1] += ">LV1"
      lv_fruit$[3] += ">LV3"
      lv_lang$[1] += ">LV1"
      lv_lang$[3] += ">LV3"
    END IF
    GOSUB RefreshListview
  ELSEIF r$ = "LINKED_CHANGED"
    linked = GW_GET_VALUE (linked_chk)
    IF linked % Add a link to all elements
      ARRAY.LENGTH al, lv_car$[]
      FOR i=1 to al : lv_car$[i] += ">LV" + INT$(i) : NEXT
      ARRAY.LENGTH al, lv_fruit$[]
      FOR i=1 to al : lv_fruit$[i] += ">LV" + INT$(i) : NEXT
      ARRAY.LENGTH al, lv_lang$[]
      FOR i=1 to al : lv_lang$[i] += ">LV" + INT$(i) : NEXT
    ELSE % Remove links
      ARRAY.LENGTH al, lv_car$[]
      FOR i=1 to al : lv_car$[i] = LEFT$ (lv_car$[i], LEN (lv_car$[i]) - 4) : NEXT
      ARRAY.LENGTH al, lv_fruit$[]
      FOR i=1 to al : lv_fruit$[i] = LEFT$ (lv_fruit$[i], LEN (lv_fruit$[i]) - 4) : NEXT
      ARRAY.LENGTH al, lv_lang$[]
      FOR i=1 to al : lv_lang$[i] = LEFT$ (lv_lang$[i], LEN (lv_lang$[i]) - 4) : NEXT
    END IF
    GOSUB RefreshListview
  ELSEIF IS_IN (GW_ID$ (lv3), r$) = 1 % swipe LV -> r$ = 'Listview3>OPTION#row'
    opt$ = MID$ (r$, LEN (GW_ID$ (lv3)) + 2) % Remove listview identifier + '>'
    IF IS_IN ("Delete", opt$) = 1
      row = VAL (MID$ (opt$, LEN ("Delete") + 2)) % Remove option + '#'
      GW_HIDE_LISTVIEW_ROW(lv3, row)
    ELSE
      POPUP opt$
    END IF
  ELSEIF LEFT$ (r$, 2) = "LV"
    IF act=1
      e$ = lv_car$[ VAL (MID$ (r$,3)) ]
    ELSEIF act=2
      e$ = lv_fruit$[ VAL (MID$ (r$,3)) ]
    ELSE
      e$ = lv_lang$[ VAL (MID$ (r$,3)) ]
    END IF
    e$ = LEFT$ (e$, IS_IN (">", e$) - 1)
    IF  IS_IN ("#", e$) = 1 THEN e$ = MID$ (e$, 2)
    e$ = "You picked " + e$
    POPUP e$
  ELSEIF r$ = "BACK" % reset the arrays for next time
    act = 1 : sb = act : ordered = 0 : titled = 0 : linked = 0 : thumbnail = 0 : twoline = 0
    ARRAY.DELETE lv_car$[]
    ARRAY.LOAD lv_car$[], "Acura ($36 945)", "Audi ($73 532)", "BMW ($58 300)", "Cadillac ($70 533)", "Ferrari ($243 090)"
    ARRAY.DELETE lv_fruit$[]
    ARRAY.LOAD lv_fruit$[], "Apple", "Banana", "Cherry", "Cranberry", "Grape", "Orange"
    ARRAY.DELETE lv_lang$[]
    ARRAY.LOAD lv_lang$[], "Hungarian", "English", "Spanish", "French", "Dutch", "Deutsch", "Russian", "Turkish", "Latin"
  END IF
UNTIL r$ = "BACK"
GOTO BasicPage

RefreshListview:
sb = act
IF sb=1
  GW_AMODIFY (lv, "content", lv_car$[])
ELSEIF sb=2 
  GW_AMODIFY (lv, "content", lv_fruit$[])
ELSEIF sb=3 
  GW_AMODIFY (lv, "content", lv_lang$[])
END IF
RETURN

%==========================================================================================================
PgPage:
IF !pgb THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("PgPage:")
  pgb = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  pgbttb = GW_ADD_TITLEBAR (pgb, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Progress") + barmenu$)
  GW_ADD_LISTENER (pgb, pgbttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN pgbcode = GW_ADD_PANEL (pgb, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))

  pbar = GW_ADD_PROGRESSBAR (pgb, "Progress bars are used to show a progress in a known definite scope (typically 0-100):")
  pbstart = GW_ADD_BUTTON (pgb, "Fill progressbar", "START")

  GW_ADD_TEXT (pgb, "Progress bars background color can be changed with a CUSTO &quot;color=a..f&quot;:")
  GW_USE_THEME_CUSTO_ONCE ("style='width:50%'")
  GW_SHELF_OPEN (pgb)
  pgblue = GW_ADD_PROGRESSBAR (pgb, "a = blue")
  GW_SHELF_NEWCELL (pgb)
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  pggreen = GW_ADD_PROGRESSBAR (pgb, "b = green")
  GW_SHELF_NEWROW (pgb)
  GW_USE_THEME_CUSTO_ONCE ("color=c")
  pgred = GW_ADD_PROGRESSBAR (pgb, "c = red")
  GW_SHELF_NEWCELL (pgb)
  GW_USE_THEME_CUSTO_ONCE ("color=d")
  pgorange = GW_ADD_PROGRESSBAR (pgb, "d = orange")
  GW_SHELF_NEWROW (pgb)
  GW_USE_THEME_CUSTO_ONCE ("color=e")
  pgpink = GW_ADD_PROGRESSBAR (pgb, "e = pink")
  GW_SHELF_NEWCELL (pgb)
  GW_USE_THEME_CUSTO_ONCE ("color=f")
  pgdarkblue = GW_ADD_PROGRESSBAR (pgb, "f = dark blue")
  GW_SHELF_CLOSE (pgb)

  GW_ADD_TEXT (pgb, "Spinners are used to show a work in progress during an unknown amount of time:")
  spin1 = GW_ADD_SPINNER (pgb, "")
  GW_USE_THEME_CUSTO_ONCE ("color=a")
  spin2 = GW_ADD_SPINNER (pgb, "Loading...")
  GW_USE_THEME_CUSTO_ONCE ("color=b")
  spin3 = GW_ADD_SPINNER (pgb, "Building database")
  GW_ADD_BUTTON (pgb, "Default empty spinner", "SPIN1")
  GW_ADD_BUTTON (pgb, "Spinner, some text, color 'A'", "SPIN2")
  GW_ADD_BUTTON (pgb, "Spinner, other text, color 'B'", "SPIN3")
  GW_USE_THEME_CUSTO_ONCE ("style='background:blue; color:white'")
  GW_ADD_BUTTON (pgb, "Change spinner text", "RND")
  GW_USE_THEME_CUSTO_ONCE ("style='background:red; color:white'")
  GW_ADD_BUTTON (pgb, "Hide spinner", "HIDE")

  GW_ADD_TEXT (pgb, "")
  IF ShowCodePanels THEN GW_ADD_LINK (pgb, "See the code of this page", GW_SHOW_PANEL$ (pgbcode))
  GW_ADD_BUTTON (pgb, "Back", "BACK")
END IF
GW_RENDER (pgb)
GW_SET_PROGRESSBAR (pgblue, 70)
GW_SET_PROGRESSBAR (pggreen, 90)
GW_SET_PROGRESSBAR (pgred, 90)
GW_SET_PROGRESSBAR (pgorange, 70)
GW_SET_PROGRESSBAR (pgpink, 80)
GW_SET_PROGRESSBAR (pgdarkblue, 100)
spindisplayed = 0
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "START" THEN
    GW_DISABLE (pbstart)
    FOR i = 1 TO 100
      GW_SET_PROGRESSBAR (pbar, i)
      PAUSE 5
    NEXT
    GW_ENABLE (pbstart)
  ELSEIF r$ = "SPIN1" THEN
    spindisplayed = 1
    GW_SHOW_SPINNER (spin1)
  ELSEIF r$ = "SPIN2" THEN
    spindisplayed = 2
    GW_SHOW_SPINNER (spin2)
  ELSEIF r$ = "SPIN3" THEN
    spindisplayed = 3
    GW_SHOW_SPINNER (spin3)
  ELSEIF r$ = "HIDE" THEN
    spindisplayed = 0
    GW_HIDE_SPINNER ()
  ELSEIF r$ = "RND" THEN
    IF spindisplayed = 2 THEN
      FOR i=1 TO 5
        GW_MODIFY (spin2, "text", "Loading file #" + INT$ (i))
        PAUSE 500
      NEXT
      GW_MODIFY (spin2, "text", "Loading...")
    ELSEIF spindisplayed = 3 THEN
      FOR i=1 TO 5
        GW_MODIFY (spin3, "text", "Checking DB record #" + INT$ (1 + RND() * 256))
        PAUSE 500
      NEXT
      GW_MODIFY (spin3, "text", "Building database")
    END IF
  END IF
UNTIL r$ = "BACK"
GOTO AdvancedPage

%==========================================================================================================
LockPage:
IF !locktest THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("LockPage:")
  locktest = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  GW_ADD_TITLEBAR (locktest, ~
    GW_ADD_BAR_LBUTTON$ ("Back>BACK") + ~
    GW_ADD_BAR_TITLE$ ("GW Lock Pattern") + ~
    GW_ADD_BAR_RBUTTON$ ("Options>OPT"))
  IF ShowCodePanels THEN lockcode = GW_ADD_PANEL (locktest, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  locktxt1 = GW_ADD_TEXT (locktest, "Set your reference pattern:")
  mylock = GW_ADD_LOCK_PATTERN (locktest, "")
  locktxt2 = GW_ADD_TEXT (locktest, "Pattern value: ")
  GW_ADD_TEXT (locktest, "")
  IF ShowCodePanels THEN GW_ADD_LINK (locktest, "See the code of this page", GW_SHOW_PANEL$ (lockcode))
  GW_ADD_BUTTON (locktest, "Back", "BACK")
END IF

IF !lockopt THEN
  lockopt = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  GW_ADD_TITLEBAR (lockopt, ~
    GW_ADD_BAR_LBUTTON$ ("Cancel>BACK") + ~
    GW_ADD_BAR_TITLE$ ("GW Lock Pattern"))
  GW_ADD_TEXTBOX (lockopt, "Lock Patterns simulate Android-like pattern lock mechanism.\n\nSpecify the lock options below (matrix size, show or hide pattern) then hit TEST")
  GW_ADD_TEXT (lockopt, "")
  lockslideW = GW_ADD_SLIDER (lockopt, "Pattern width:", 3, 9, 1, 3)
  lockslideH = GW_ADD_SLIDER (lockopt, "Pattern height:", 3, 9, 1, 3)
  lockcheck = GW_ADD_CHECKBOX (lockopt, "Keep pattern hidden while drawing")
  GW_ADD_TEXT (lockopt, "")
  GW_ADD_SUBMIT (lockopt, "TEST")
END IF

GW_RENDER (locktest)
locktesting = 1
lockHide = 0
lockW = 3
lockH = 3
DO
  r$ = GW_WAIT_ACTION$()
  IF r$ = "OPT" THEN
    locktesting = 0
    GW_RENDER (lockopt)
    GW_MODIFY (lockcheck, "checked", INT$(lockHide))
    GW_MODIFY (lockslideW, "val", INT$(lockW))
    GW_MODIFY (lockslideH, "val", INT$(lockH))
  ELSEIF IS_IN ("SUBMIT", r$) = 1 THEN % Validate options and back to Lock testing
    lockHide = GW_GET_VALUE (lockcheck)
    lockW = GW_GET_VALUE (lockslideW)
    lockH = GW_GET_VALUE (lockslideH)
    GOSUB LockUpdate
  ELSEIF r$ = "BACK" THEN
    IF locktesting = 0 THEN % Cancel options and back to Lock testing
      GOSUB LockUpdate
    ELSE
      GOTO AdvancedPage
    END IF
  ELSEIF IS_IN ("pattern:", r$) = 1 THEN % User drew a pattern
    IF lockpattern$ = "" THEN % First pattern: define reference
      lockpattern$ = r$
      r$ = ""
      GW_MODIFY (locktxt1, "text", "Now draw either a different pattern or your reference pattern again:")
      e$ = "Reference value: " + MID$(lockpattern$, 9)
      GW_MODIFY (locktxt2, "text", e$)
    ELSE % Second pattern and after: compare to reference
      e$ = "Reference value: " + MID$(lockpattern$, 9) + "\n"
      e$ += "Pattern value: " + MID$(r$, 9) + "\n"
      IF r$ = lockpattern$ THEN % Matching pattern
        e$ += "<span style='color:green'>Pattern matches reference</span>"
      ELSE % Pattern mismatch
        e$ += "<span style='color:red'>Patterns mismatch!</span>"
        GW_SHOW_WRONG_PATTERN (mylock)
      END IF
      GW_MODIFY (locktxt2, "text", e$)
    END IF
    PAUSE 1500
    GW_CLEAR_LOCK_PATTERN (mylock)
  END IF
UNTIL 0

LockUpdate:
locktesting = 1
lockpattern$ = ""
GW_RENDER (locktest)
IF lockHide THEN JS(GW_ID$(mylock) + ".option('patternVisible',false)")
JS(GW_ID$(mylock) + ".option('matrix',[" + INT$(lockH) + "," + INT$(lockW) + "])")
JS("resizeLock(" + GW_ID$(mylock) + ")")
RETURN

%==========================================================================================================
GalPage:
IF !galp THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("GalPage:")
  INCLUDE "GW_GALLERY.bas"
  galp = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  galpttb = GW_ADD_TITLEBAR (galp, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Gallery") + barmenu$)
  GW_ADD_LISTENER (galp, galpttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN galcode = GW_ADD_PANEL (galp, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  GW_ADD_TEXT (galp, "GW Gallery is composed of a fully responsive + adaptive image grid, associated with a powerful built-in viewer.")
  GOSUB GalListFiles
  IF canceled THEN GOTO AdvancedPage
  GW_ADD_TEXTBOX (galp, "<b>Source:</b> " + RTRIM$ (galpath$, "/"))
  galslide = GW_ADD_SLIDER (galp, "Thumbnails height: (pixel)", 60, 140, 20, 80)
  GW_ADD_LISTENER (galp, galslide, "change", "RESIZE")
  galctl = GW_ADD_GALLERY (galp, 80, cgal$[])
  GW_START_CENTER (galp)
  GW_OPEN_GROUP (galp)
  GW_USE_THEME_CUSTO_ONCE ("inline icon=arrow-l mini")
  galpv = GW_ADD_BUTTON (galp, "Prev", "PREV")
  GW_USE_THEME_CUSTO_ONCE ("inline mini")
  galtx = GW_ADD_BUTTON (galp, "Images " + INT$ (cgalidx) + "-" + INT$ (MIN (cgalidx+7, cgalmax)) + "/" + INT$ (cgalmax), "")
  GW_USE_THEME_CUSTO_ONCE ("inline icon=arrow-r iconpos=right mini")
  galnx = GW_ADD_BUTTON (galp, "Next", "NEXT")
  GW_CLOSE_GROUP (galp)
  GW_STOP_CENTER (galp)
  GW_ADD_TEXT (galp, "")
  IF ShowCodePanels THEN GW_ADD_LINK (galp, "See the code of this page", GW_SHOW_PANEL$ (galcode))
  GW_ADD_BUTTON (galp, "Back", "BACK")
END IF
cgalidx = 1
GW_RENDER (galp)
GOSUB GalUpdate
IF cgalidx = 1 THEN GW_DISABLE (galpv)
GW_DISABLE (galtx)
IF cgalidx + 7 >= cgalmax THEN GW_DISABLE (galnx)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "RESIZE" THEN
    GOSUB GalRefresh
  ELSEIF r$ = "NEXT" THEN
    cgalidx += 8
    IF cgalidx = 9 THEN GW_ENABLE (galpv)
    IF cgalidx + 7 >= cgalmax THEN GW_DISABLE (galnx)
    GOSUB GalUpdate
  ELSEIF r$ = "PREV" THEN
    IF cgalidx + 7 >= cgalmax THEN GW_ENABLE (galnx)
    cgalidx -= 8
    IF cgalidx = 1 THEN GW_DISABLE (galpv)
    GOSUB GalUpdate
  ELSEIF r$ = "BACK" & GW_GALLERY_IS_OPEN (galctl) THEN
    GW_CLOSE_GALLERY (galctl)
    r$ = ""
  END IF
UNTIL r$ = "BACK"
GOTO LibsPage

GalListFiles:
cgalmax = 1
DIM gal$[1] % full list of files
DIM cgal$[1] % sub-list of files
IF galpath$ = "" THEN galpath$ = "/DCIM/100ANDRO"
galpath$ = "/" + TRIM$ (galpath$, "/") + "/"
% Check existence of image folder
FILE.EXISTS fe, "../.." + galpath$
canceled = 0
WHILE !fe & !canceled
  POPUP "Folder " + galpath$ + " does not exist!"
  PAUSE 2000
  INPUT "Select image folder", galpath$, galpath$, canceled
  galpath$ = "/" + TRIM$ (galpath$, "/") + "/"
  FILE.EXISTS fe, "../.." + galpath$
REPEAT
IF canceled THEN RETURN
% Build original list of files
FILE.DIR "../.." + galpath$, ogal$[], "/"
LIST.CREATE s, ogal
LIST.ADD.ARRAY ogal, ogal$[]
ARRAY.LENGTH al, ogal$[]
% Only keep JPG and PNG images
FOR i = al TO 1 STEP -1
  e$ = RIGHT$ (LOWER$ (ogal$[i]), 4)
  IF e$ <> ".jpg" & e$ <> ".png" THEN
    LIST.REMOVE ogal, i
    al--
  ELSE
    LIST.REPLACE ogal, i, "../.." + galpath$ + ogal$[i]
  END IF
NEXT
UNDIM ogal$[]
% Create smaller array of 8 images for the gallery
IF al = 0 THEN
  LIST.CLEAR ogal
  POPUP galpath$ + " does not contain any jpg nor png image"
  PAUSE 2000
  galpath$ = ""
  GOTO GalListFiles
ELSE
  LIST.TOARRAY ogal, gal$[]
  LIST.CLEAR ogal
  ARRAY.LENGTH cgalmax, gal$[]
  DIM cgal$[MIN (cgalmax, 8)]
END IF
RETURN

GalUpdate:
GW_MODIFY (galtx, "text", "Images " + INT$ (cgalidx) + "-" + INT$ (MIN (cgalidx+7, cgalmax)) + "/" + INT$ (cgalmax))
ARRAY.COPY gal$[ cgalidx, MIN (cgalidx+7, cgalmax) ], cgal$[]
cgal$[MIN (cgalmax - cgalidx + 1, 8)] += ">BACK"
GW_AMODIFY (galctl, "content", cgal$[])

GalRefresh:
e$ = "$('#" + GW_ID$ (galctl) + "').justifiedGallery("
e$ += "{rowHeight:" + GW_GET_VALUE$ (galslide) + ",lastRow:'justify'})"
JS(e$)
RETURN

%==========================================================================================================
ColpikPage:
IF !cpp THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ColpikPage:")
  cpp = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  cppttb = GW_ADD_TITLEBAR (cpp, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Colorpicker + Class") + barmenu$)
  GW_ADD_LISTENER (cpp, cppttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN cppcode = GW_ADD_PANEL (cpp, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
  class$ = GW_CODE_HIGHLIGHT$ ("myclass = GW_NEW_CLASS (\"myclass\")", BLA$[], BLU$[], RED$[])
  GW_ADD_TEXT (cpp, "First let's create a class: " + class$)
  myclass = GW_NEW_CLASS ("myclass")
  GW_INJECT_HTML(cpp, "<style>.myclass {text-overflow:initial; width:0.5em; height:0.9em; ")
  GW_INJECT_HTML(cpp, "margin-right:0.2em; margin-top:0.2em; margin-bottom:0.2em; padding-left:8px; ")
  GW_INJECT_HTML(cpp, "padding-top:8px; border-radius:25px !important; font-size:2em !important}</style>")
  col0$ = RandCol$()
  colpik = GW_ADD_COLORPICKER (cpp, "Then add a Colorpicker control:", MID$(col0$, 2))
  GW_ADD_TEXT (cpp, "Finally add 20 buttons sharing the same custo <b>class='myclass'</b>")
  btncusto = GW_NEW_THEME_CUSTO ("inline color=a class='myclass'")
  GW_USE_THEME_CUSTO (btncusto)
  READ.DATA "&#x1f42d;", "&#x1f42e;", "&#x1f430;", "&#x1f40a;", "&#x1f40b;" % unicode characters for animal emojis
  READ.DATA "&#x1f40c;", "&#x1f40d;", "&#x1f40e;", "&#x1f411;", "&#x1f412;"
  READ.DATA "&#x1f413;", "&#x1f416;", "&#x1f417;", "&#x1f419;", "&#x1f41d;"
  READ.DATA "&#x1f41e;", "&#x1f41f;", "&#x1f422;", "&#x1f425;", "&#x1f427;"
  FOR i=1 TO 20
    READ.NEXT char$
    GW_ADD_BUTTON(cpp, char$, "")
  NEXT
  GW_RESET_THEME_CUSTO ()
  GW_ADD_TEXT (cpp, "Every time the user changes the color, the Colorpicker will send a notification, we'll get the color from it and change the background color of the class 'myclass' which will have an impact on the 20 buttons at once!")
  GW_ADD_TEXT (cpp, "")
  IF ShowCodePanels THEN GW_ADD_LINK (cpp, "See the code of this page", GW_SHOW_PANEL$ (cppcode))
  GW_ADD_BUTTON (cpp, "Back", "BACK")
END IF
GW_RENDER (cpp)
GW_MODIFY (myclass, "style:background", col0$)
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF IS_IN (GW_ID$(colpik), r$) = 1 THEN % color picker change
    ncol$ = MID$ (r$, IS_IN(":", r$)+1) % extract '#rrggbb' out of 'CtlId:#rrggbb'
    GW_MODIFY (myclass, "style:background", ncol$)
  END IF
UNTIL r$ = "BACK"
GOTO AdvancedPage

%==========================================================================================================
ListenPage:
IF !lsp THEN
  IF ShowCodePanels THEN code$ = SelfExtract$ ("ListenPage:")
  lsp = GW_NEW_PAGE()
  GW_USE_THEME_CUSTO_ONCE ("icon=back iconpos=left")
  lspttb = GW_ADD_TITLEBAR (lsp, GW_ADD_BAR_LBUTTON$ ("Back>BACK") + GW_ADD_BAR_TITLE$ ("GW Listeners") + barmenu$)
  GW_ADD_LISTENER (lsp, lspttb, "rmenuchange", "JUMP") % event will be of the form "JUMP:value_selected$"
  IF ShowCodePanels THEN
    lspcode = GW_ADD_PANEL (lsp, GW_CODE_HIGHLIGHT$ (code$, BLA$[], BLU$[], RED$[]))
    GW_ADD_LISTENER (lsp, lspcode, "close", "PANEL")
    href$ = GW_SHOW_PANEL$ (lspcode)
  ELSE
    href$ = "#"
  END IF
  GW_ADD_TEXTBOX (lsp, "A LISTENER allows to send a message when a certain event is triggered on a control:")
  e$ = GW_CODE_HIGHLIGHT$ ("GW_ADD_LISTENER (page, panel_ctl, \"close\", action$)", BLA$[], BLU$[], RED$[])
  e$ += "&#x21B3; Touch <a href='" + href$ + "'>here</a> to open "
  e$ += "the left panel, then touch anywhere on the right to close it."
  GW_ADD_TEXT (lsp, e$)
  e$ = GW_CODE_HIGHLIGHT$ ("GW_ADD_LISTENER (page, input_ctl, \"keydown|clear\", action$)", BLA$[], BLU$[], RED$[])
  linp = GW_ADD_INPUTLINE (lsp, e$, "Change me!")
  GW_ADD_LISTENER (lsp, linp, "keydown", "INPCHG")
  GW_ADD_LISTENER (lsp, linp, "clear", "INPCLR")
  linpt = GW_ADD_TEXT (lsp, "")
  e$ = GW_CODE_HIGHLIGHT$ ("GW_ADD_LISTENER (page, radio_ctl|checkbox|flipswitch |slider|selectbox|colorpicker, \"change\", action$)", BLA$[], BLU$[], RED$[])
  lflip = GW_ADD_FLIPSWITCH (lsp, e$, "on", "off")
  GW_ADD_LISTENER (lsp, lflip, "change", "FLIP")
  e$ = GW_CODE_HIGHLIGHT$ ("GW_ADD_LISTENER (page, any_ctl, \"swipeleft|swiperight\", action$)", BLA$[], BLU$[], RED$[])
  GW_ADD_TEXT (lsp, e$)
  lspbtn1 = GW_ADD_BUTTON (lsp, "I count to 5. Swipe me left or right", "COUNT")
  ARRAY.LOAD lspnul$[], "OK"
  lspdm1 = GW_ADD_DIALOG_MESSAGE (lsp, "", "No, you need to SWIPE me left or right...", lspnul$[])
  e$ = GW_CODE_HIGHLIGHT$ ("GW_ADD_LISTENER (page, any_ctl, \"longpress\", action$)", BLA$[], BLU$[], RED$[])
  GW_ADD_TEXT (lsp, e$)
  lspbtn2 = GW_ADD_BUTTON (lsp, "Long press me!", "PRESS")
  lspdm2 = GW_ADD_DIALOG_MESSAGE (lsp, "", "No, you need to LONG press me!", lspnul$[])
  e$ = "You can detect swipe or long press anywhere in a page by passing a control id of '0' to the listener.\n"
  e$ += "Now try to go back to the previous page and do a long press anywhere in it for a surprise &#x1f609;"
  GW_ADD_TEXT (lsp, e$)
  e$ = GW_CODE_HIGHLIGHT$ ("GW_ADD_LISTENER (page, 0, \"idle30\", action$)", BLA$[], BLU$[], RED$[])
  e$ += "&#x21B3; Finally stay idle in the page for 30 seconds to disable this button:"
  GW_ADD_TEXT (lsp, e$)
  lspbtn3 = GW_ADD_BUTTON (lsp, "I'm enabled", "")
  GW_ADD_TEXT (lsp, "")
  IF ShowCodePanels THEN GW_ADD_LINK (lsp, "See the code of this page", GW_SHOW_PANEL$ (lspcode))
  GW_ADD_BUTTON (lsp, "Back", "BACK")
  GW_ADD_LISTENER(lsp, lspbtn1, "swiperight", "SWIPR")
  GW_ADD_LISTENER(lsp, lspbtn1, "swipeleft", "SWIPL")
  GW_ADD_LISTENER(lsp, lspbtn2, "longpress", "HOLD")
  GW_ADD_LISTENER(lsp, 0, "idle30", "SLEEP") % idle for 30 seconds
END IF
GW_RENDER (lsp)
i = 5
IF ShowCodePanels & once = 0 THEN
  once = 1
  PAUSE 1000
  GW_SHOW_PANEL (lspcode)
  PAUSE 1000
  GW_CLOSE_PANEL (lspcode)
END IF
DO
  r$ = GW_WAIT_ACTION$()
  IF IS_IN ("JUMP:", r$) = 1 THEN
    ARRAY.SEARCH barmenu$[], MID$ (r$, 6), i : i-- % ignore first array index (menu title)
    TIMER.CLEAR : GOTO i, BasicPage, InputPage, AdvancedPage, ThemePage, LibsPage, Bye
  ELSEIF r$ = "PANEL" THEN
    POPUP "Event \"close\" was triggered on the panel"
  ELSEIF r$ = "FLIP" THEN
    POPUP "Event \"change\" was triggered on the flipswitch"
  ELSEIF r$ = "INPCHG" THEN
    GW_MODIFY (linpt, "text", "<i><b>Event \"keydown\" was triggered</b></i>")
  ELSEIF r$ = "INPCLR" THEN
    GW_MODIFY (linpt, "text", "<i><b>Event \"clear\" was triggered</b></i>")
  ELSEIF r$ = "COUNT" THEN
    GW_SHOW_DIALOG (lspdm1)
  ELSEIF r$ = "SWIPR" THEN
    i = MIN(10, i+1)
    GW_MODIFY (lspbtn1, "text", "I count to " + INT$(i) + ". Swipe me left or right")
  ELSEIF r$ = "SWIPL" THEN
    i = MAX(0, i-1)
    GW_MODIFY (lspbtn1, "text", "I count to " + INT$(i) + ". Swipe me left or right")
  ELSEIF r$ = "PRESS" THEN
    GW_MODIFY (lspbtn2, "text", "Long press me!")
    GW_SHOW_DIALOG (lspdm2)
  ELSEIF r$ = "HOLD" THEN
    GW_MODIFY (lspbtn2, "text", "Yes! You got it &#x1f609;")
  ELSEIF r$ = "SLEEP" THEN
    GW_MODIFY (lspbtn3, "text", "I'm disabled")
    GW_DISABLE (lspbtn3)
  END IF
UNTIL r$ = "BACK"
GOTO AdvancedPage

%==========================================================================================================
DemoInit:
IF demover$<>GW_VER$ THEN END "Mismatched versions: GW demo "+demover$+" Vs GW lib "+GW_VER$+"\nPlease update your files..."
ARRAY.LOAD buzz[], 1, 100

% Used for code syntax highlighting, see GW_CODE_HIGHLIGHT$ ()
ARRAY.LOAD BLA$[], "~", "INCLUDE", "END IF", "IF", "THEN", "ELSE", "GOTO", "GOSUB", "INT$" ~
  "LEFT$", "IS_IN", "POPUP", "ARRAY.LOAD", "ARRAY.DELETE", "ARRAY.SHUFFLE", "ARRAY.LENGTH" ~
  "PAUSE", "PRINT", "END", "DO", "UNTIL", "WHILE", "REPEAT", "RETURN", "SPLIT", "FOR", "NEXT" ~
  "LOWER$", "CHR$", "TIMER.SET", "TIMER.CLEAR", "TIMER.RESUME", "ONTIMER:", "VIBRATE", "TONE" ~
  "FTP.OPEN", "FTP.GET", "FTP.CLOSE", "LIST.CREATE", "LIST.ADD", "LIST.TOARRAY", "LIST.SIZE" ~
  "LIST.REMOVE"
ARRAY.LOAD RED$[], "+", ",", "(", ")", "!", "& ", "|", "%", "[", "]"
DIM BLU$[GW_KEYWORD_NB()]
GW_POPULATE_KEYWORD_ARRAY(BLU$[])

FN.DEF SelfExtract$ (label$)
  LF$ = CHR$(10) % Line Feed
  DQ$ = CHR$(34) % Double Quote
  BS$ = CHR$(92) % Back Slash
  GRABFILE buf$, "../source/GW_demo.bas"
  IF buf$=""
    POPUP "Warning: misplaced demo\nCannot find \"source/GW_demo.bas\"\nCode panels will be empty"
    FN.RTN ""
  END IF
  i = IS_IN (LF$ + label$ + LF$, buf$)
  IF !i THEN FN.RTN ""
  i += LEN (LF$ + label$ + LF$)
  buf$ = MID$ (buf$, i)
  i = IS_IN (LF$ + "%========", buf$)
  IF !i THEN FN.RTN ""
  buf$ = LEFT$ (buf$, i-1)
  SPLIT line$[], buf$, LF$
  ARRAY.LENGTH n, line$[]
  r$ = "INCLUDE " + DQ$ + "GW.bas" + DQ$ + "\n"
  i=3 % Start after "IF !page THEN" and the call to SelfExtract$ ()
  WHILE line$[i] <> "END IF" & IS_IN ("ELSE % ", line$[i]) <> 1
    line$[i] = REPLACE$ (line$[i], "<", "&lt;") % do not interpret html
    line$[i] = REPLACE$ (line$[i], "&#", "&amp;#")
    line$[i] = REPLACE$ (line$[i], BS$ + "n", " ") % do not display \n
    line$[i] = REPLACE$ (line$[i], "<p style='color:red'>", "")
    line$[i] = REPLACE$ (line$[i], "</p>", "")
    IF REPLACE$(line$[i], " ", "") <> "" THEN r$ += line$[i] + "\n"
    i++
  REPEAT
  IF IS_IN ("ELSE % ", line$[i]) = 1 THEN
    DO
      i++
    UNTIL line$[i] = "END IF"
  END IF
  FOR i=i+1 TO n
    line$[i] = REPLACE$ (line$[i], BS$ + "n", " ") % do not display \n
    IF REPLACE$(line$[i], " ", "") <> "" THEN r$ += line$[i] + "\n"
  NEXT
  FN.RTN "<small>"+r$+"</small>"
FN.END

FN.DEF RandCol$()
  e$="#"
  FOR i=1 TO 3
    e$+=RIGHT$("0"+HEX$(256*RND()), 2)
  NEXT
  FN.RTN e$
FN.END

RETURN

%-- END OF GW DEMO --%
