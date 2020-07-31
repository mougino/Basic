GW_VER$="v5.2"
% This is the 'GW' include file for RFO BASIC! for Android.
% It allows to easily create nice GUIs with Web technologies.
%
% Written by Nicolas MOUGIN mougino@free.fr http://mougino.free.fr
% You can use, modify, and redistribute this file without restriction.
%
% Important notes for the programer:
%      1. You need a theme to render GW apps. Currently available are 9 possible GW themes:
%      "default" (the default one), "flat-ui", "classic", "ios", "bootstrap", "android-holo", "square-ui",
%      "metro", and finally the "native-droid-*" family. See the GW_demo > Themes section for more info.
%
%      Existence or not of theme files on the device can be checked with GW_THEME_EXISTS(). If absent,
%      a theme can be downloaded from laughton or mougino HTTP servers with GW_DOWNLOAD_THEME().
%      You can handle theme check+download in your GW app (like the demo does), or you can let the lib deal
%      with it. In the latter case, theme will be silently downloaded and require no action from the user.
%      If the download fails however the GW lib will throw a runtime error. This can be avoided if you
%      handle theme check + download yourself.
%
%      2. GW_LOAD_THEME() must be called before the page creation with GW_NEW_PAGE(), or else the page
%      will not inherit the theme. It is also good practice to call GW_UNLOAD_THEME() right after
%      the GW_RENDER() of the page, in order for the next created page to not inherit inadvertently
%      the theme of the previous page.
%
%      3. All the GW_ADD_* functions can be invoked as is (inline), or be called prefixed with a
%      variable and the equal sign, in this case the variable will contain a pointer to the newly
%      created control...  So, either use
%              GW_ADD_BUTTON (mypage, "Button 1", "ACTION")
%      or      mybtn=GW_ADD_BUTTON (mypage, "Button 1", "ACTION")
%      It all depends if you want to change the content of the control after creation thanks to
%      GW_MODIFY(), or track the behavior of the control with GW_GET_VALUE(), etc.
%
%      4. Controls (or page elements: titlebar, panel) need to be CUSTOmized *before* being ADDed
%      to the page. Call GW_NEW_THEME_CUSTO() + GW_USE_THEME_CUSTO(), or GW_USE_THEME_CUSTO_ONCE()
%      *before* GW_ADD_CONTROL().
%      THERE IS ONE EXCEPTION: buttons from a DIALOG (MESSAGE/INPUT/CHECKBOX) cannot be customized
%      before being added, since they are provided as an array of labels. In this case, add your
%      DIALOG first, *then* call GW_CUSTO_DLGBTN() for each of the buttons you want CUSTOmized.
%
%      5. The following functions: GW_GET_VALUE() GW_GET_VALUE$() GW_FLIPSWITCH_CHANGED()
%      GW_CHECKBOX_CHECKED() GW_RADIO_SELECTED() can either be used after a GW_WAIT_ACTION$(),
%      to parse and analyze the user interaction with the GW page when the user validates it,
%      or at any other moment if you want the live state of a control (CHECKBOX, RADIO, SLIDER,
%      SELECTBOX, all the INPUT* controls...)
%      If you want to track the change of a control in real-time, use GW_ADD_LISTENER()
%
%      6. To create *related* RADIO buttons, where only one among the buttons can be checked, first
%      create the 'parent' by passing a zero value into the 2nd parameter 'radio_parent':
%          parent=GW_ADD_RADIO (mypage, 0, "My radio button 1")
%      and then ADD the following RADIO buttons with the 'parent' variable as 2nd parameter:
%          child1=GW_ADD_RADIO (mypage, parent, "My radio button 2")
%          child2=GW_ADD_RADIO (mypage, parent, "My radio button 3")   etc.
%
%      7. Use the greater than character ">" in your FLIPSWITCH, CHECKBOX and RADIO option labels
%      in order to select this option by default e.g. GW_ADD_FLIPSWITCH(mypage, "Switch:", "Off", ">On")
%      By default, a FLIPSWITCH has the first option selected, and CHECKBOX and RADIO are unselected.
%
%      8. The functions GW_MODIFY() and GW_AMODIFY() ('A' for Array) need to be called *after* the
%      GW_RENDER() of the page that contains the control to be modified. Because the control does
%      not exist (programmatically) before rendering the page.
%
% Complete list of APIs:
%      ! --> before loading the lib with INCLUDE "GW.bas":
%      GW_COLOR$="black" % to display a dark page at startup
%      GW_SILENT_LOAD=1 % to hide GW lib loading bar
%
%      ! --> specify page settings before page creation:
%      GW_ZOOM_INPUT(0|1) % disable/enable zoom in input controls when being edited (default:1)
%      theme_name$=GW_THEME$[1] ..to GW_THEME$[9] % see list at http://mougino.free.fr/tmp/GW/
%      test=GW_THEME_EXISTS (theme_name$) % return true|false if full set of theme-files are on device
%      GW_DOWNLOAD_THEME (theme_name$) % download all theme files to device
%      GW_LOAD_THEME (theme_name$) % load a theme to be used by all newly created pages
%      GW_UNLOAD_THEME () % equivalent to GW_LOAD_THEME ("default")
%      GW_DEFAULT_TRANSITIONS ("PAGE=fx, PANEL=fx, DIALOG=fx")
%      :ELEMENT   :FX VALUES
%      :PAGE      :fade|pop|flip|turn |flow|slidefade|slide |slideup|slidedown|none
%      :PANEL     :push|reveal|overlay
%      :DIALOG    :fade|pop|flip|turn |flow|slidefade|slide |slideup|slidedown|none
%
%      ! --> create a new page:
%      mypage=GW_NEW_PAGE ()
%
%      ! --> transform the page:
%      GW_ADD_LOADING_IMG (mypage, "local.gif", dark) % display image when page loads
%      GW_USE_FONT (mypage, "font.ttf") % use a default font for the whole page
%      GW_CENTER_PAGE_VER (mypage) % to center vertically the page content
%      GW_SET_TRANSITION (mypage|mypnl|mydlg, fx$) % fx$: see table above
%      GW_PREVENT_SELECT (mypage) % prevent text-selection after a long-press
%      GW_ALLOW_SELECT (mypage) % allow back select after a long-press (default)
%
%      ! --> change layout of controls before adding them:
%      GW_OPEN_COLLAPSIBLE (mypage, "Title") % to expand/collapse a group of controls
%      GW_CLOSE_COLLAPSIBLE (mypage)
%      GW_OPEN_GROUP (mypage) % to visually group checkbox or radio control (custo "inline" possible)
%      GW_CLOSE_GROUP (mypage)
%      GW_START_CENTER (mypage) % to visually center elements
%      GW_STOP_CENTER (mypage)
%      GW_SHELF_OPEN (mypage) % to organize controls on a same line
%      GW_SHELF_NEWCELL (mypage) % next control on the line
%      GW_SHELF_NEWROW (mypage) % go to a new line
%      GW_SHELF_CLOSE (mypage)
%
%      ! --> apply customization to controls:
%      myfont$=GW_ADD_FONT$ (mypage, "font.ttf")
%      class=GW_NEW_CLASS ("myclass") % to apply 1 custo on multiple controls
%      GW_USE_THEME_CUSTO_ONCE ("param1=value1 param2=value2 ...")
%      mycusto=GW_NEW_THEME_CUSTO ("param1=value1 param2=value2 ...")
%      GW_CUSTO_DLGBTN (mypage, mydlg, "Button label", "param1=value1 param2=value2 ...")
%      GW_USE_THEME_CUSTO (mycusto)
%      GW_RESET_THEME_CUSTO ()
%      :PARAM            :VALUES
%      :color            :a|b|c|d|e|f|g (pgbar|slider|button depending on theme)
%      :icon             :see http://demos.jquerymobile.com/1.4.5/icons/#Iconset
%      :iconpos          :left|right|top|bottom
%      :position         :left|right (panel)
%      :notext           :<no value needed> (button)
%      :inline           :<no value needed> (group|button|dialog*|selectbox)
%      :big              :<no value needed> increase size of notext button
%      :mini             :<no value needed> decrease size of text button
%      :hover            :N|S|E|W|NE|NW|SE|SW
%      :alpha            :from 0% to 100%
%      :fit-screen       :<no value needed> forces image width <= screen width
%      :style            :'color:blue' or any other CSS-formatted string
%      :class            :'myclass' as defined in GW_NEW_CLASS ()
%      :font             :myfont$ as returned by GW_ADD_FONT$ ()
%
%      ! --> add page elements:
%      myttl$=GW_ADD_BAR_TITLE$ ("My titlebar / footbar")
%      mylbt$=GW_ADD_BAR_LBUTTON$ ("L-Button>ACTION1")
%      myrbt$=GW_ADD_BAR_RBUTTON$ ("R-Button>ACTION2")
%      mylmnu$=GW_ADD_BAR_LMENU$ (values$[]) % like a SELECTBOX but in the title/footbar
%      myrmnu$=GW_ADD_BAR_RMENU$ (values$[]) % add LISTENER on "l|rmenuchange" to track action
%      mytbar=GW_ADD_TITLEBAR (mypage, mylbt$ + myttl$ + myrmnu$)
%      myfbar=GW_ADD_FOOTBAR (mypage, mylmnu$ + myttl$ + myrbt$)
%      mypanl=GW_ADD_PANEL (mypage, "My panel content")
%      myspin=GW_ADD_SPINNER (mypage, "Message")
%      mydlgm=GW_ADD_DIALOG_MESSAGE (mypage, "Title", "Message", buttons_and_actions$[]) % "Btn 1>ACTION1"
%      mydlgc=GW_ADD_DIALOG_CHECKBOX (mypage, "Title", "Message", "Checkbox label", buttons_and_actions$[])
%      mydlgi=GW_ADD_DIALOG_INPUT (mypage, "Title", "Message", "Default input", buttons_and_actions$[])
%      :DEFAULT INPUT  :INPUT TYPE
%      :".."|"A>.."    :Input Line
%      :"0>.."|"1>.."  :Input Number
%      :"*>.."         :Input Password
%      :"@>.."         :Input E-mail
%      :"<>.."         :Input Url
%
%      ! --> add standard controls:
%      myttl=GW_ADD_TITLE (mypage, "My section title")
%      mytbx=GW_ADD_TEXTBOX (mypage, s_ini$)
%      mytxt=GW_ADD_TEXT (mypage, s_ini$)
%      mylnk=GW_ADD_LINK (mypage, "My link label", "http://www.mylink.com | USER_ACTION")
%      mybtn=GW_ADD_BUTTON (mypage, "My button label", "http://www.mylink.com | USER_ACTION")
%      GW_SHOW_PANEL$ (mypnl) % use it as a link in GW_ADD_LINK() or GW_ADD_BUTTON()
%      GW_SHOW_DIALOG$ (mydlg) % idem for any dialog (message /input /checkbox)
%      myimg=GW_ADD_IMAGE (mypage, "mypicture.png") % use ">"+action$ after pic name e.g. "exit.png>BYE"
%      myico=GW_ADD_ICON (mypage, ico$, width, height)
%      GW_ICON$ (myico) % use it in a titlebar/footbar
%      mypgb=GW_ADD_PROGRESSBAR (mypage, "My progress bar label")
%      mytbl=GW_ADD_TABLE (mypage, n_cols, table$[]) % start first element with ">" to indicate a title line
%      myaud=GW_ADD_AUDIO (mypage, link_to_audio$) % local or webradio
%      myvid=GW_ADD_VIDEO (mypage, link_to_video$) % local or streaming, add ">" + img_url$ for poster image
%      my_lv=GW_ADD_LISTVIEW (mypage, values_and_actions$[])
%      :ARRAY           :LISTVIEW TYPE
%      :"~.." (1st elt) :sortable list
%      :"#.." (1st elt) :ordered list
%      :"Opt1|..|Opt2"  :swipe element (new!)
%      :"..@@ico.png"   :inline icon (new!)
%      :"..@bigpic.jpg" :thumbnail
%      :".. {bbl}"      :count bubble (new!)
%      :">.."           :title|separator
%      :"..\n.."        :2-line cell
%      :"..>AXN"        :action
%
%      ! --> add user input controls:
%      mychk=GW_ADD_CHECKBOX (mypage, "My checkbox") % use ">" to check by default
%      myradio=GW_ADD_RADIO (mypage, radio_parent, "My radio button") % use ">" to select by default
%      myflip=GW_ADD_FLIPSWITCH (mypage, "My flip switch", s_opt1$, s_opt2$) % use ">" to select default option
%      myslid=GW_ADD_SLIDER (mypage, "My slider label", n_min, n_max, n_step, n_ini)
%      myselbx=GW_ADD_SELECTBOX (mypage, "My selectbox", values$[]) % listview-popup, use "#" for title/separator
%      myinpln=GW_ADD_INPUTLINE (mypage, "My input line label", s_ini$)
%      myinpbx=GW_ADD_INPUTBOX (mypage, "My input box label", s_ini$)
%      myinpmi=GW_ADD_INPUTMINI (mypage, "1") % 1=initial value
%      myinpls=GW_ADD_INPUTLIST (mypage, "Hint message", values_and_actions$[]) % use it as a search-bar
%      myinpnb=GW_ADD_INPUTNUMBER (mypage, "Input Number", s_ini$)
%      myinppw=GW_ADD_INPUTPASSWORD (mypage, "Input Password", s_ini$)
%      myinpml=GW_ADD_INPUTEMAIL (mypage, "Input eMail", s_ini$)
%      myinpurl=GW_ADD_INPUTURL (mypage , "Input URL", s_ini$)
%      myinptel=GW_ADD_INPUTTEL (mypage , "Input Tel", s_ini$)
%      myinpdati=GW_ADD_INPUTDATETIME (mypage, "Input Date and Time", s_ini$)
%      myinpdat=GW_ADD_INPUTDATE (mypage, "Input Date", s_ini$)
%      myinptim=GW_ADD_INPUTTIME (mypage, "Input Time", s_ini$)
%      myinpmo=GW_ADD_INPUTMONTH (mypage, "Input Month", s_ini$)
%      myinpwk=GW_ADD_INPUTWEEK (mypage, "Input Week", s_ini$)
%      myinpcol=GW_ADD_INPUTCOLOR (mypage, "Input Color", s_ini$)
%      mysubmit=GW_ADD_SUBMIT (mypage, "My submit button label")
%      mycolpik=GW_ADD_COLORPICKER (mypage, "Hint message", ini_color$) % ini_color$: hexadecimal "RRGGBB"
%      mylock=GW_ADD_LOCK_PATTERN (mypage, "options") % options=hide-pattern|4x4...
%
%      ! --> add advanced stuff (custom control, listener):
%      p_h=GW_ADD_PLACEHOLDER (mypage) % to dynamically change parts of the page
%      GW_FILL_PLACEHOLDER (mypage, p_h, "&lt;some&gt;code&lt;/some&gt;")
%      GW_INJECT_HTML (mypage, "&lt;some&gt;code&lt;/some&gt;") % add custom HTML|CSS|JavaScript code
%      GW_ADD_LISTENER (mypage, ctl_id, event$, action$) % ctl_id=0 listens the whole page
%      :CONTROL                            :EVENT
%      :TITLEBAR                           :"lmenuchange|rmenuchange"
%      :FOOTBAR                            :"lmenuchange|rmenuchange"
%      :PANEL                              :"close"
%      :INPUT*                             :"keydown|clear"
%      :CHECKBOX|FLIPSWITCH|COLORPICKER... :"change"
%      :0|Any control                      :"swipeleft|swiperight|longpress"
%      :0                                  :"idleN" (N in second e.g. idle30)
%
%      ! --> render and interact with the page:
%      GW_RENDER (mypage)
%      GW_CLOSE_PAGE (mypage)
%      r$=GW_WAIT_ACTION$ () % Back-key press is returned as "BACK"
%      r$=GW_ACTION$ () % read input buffer and returns immediately
%      GW_CLOSE_INPUTLIST (myinpls) % close it after user made a selection
%      GW_SHOW_DIALOG (mydlg) % manually display a dialog (message /input /checkbox)
%      GW_CLOSE_DIALOG (mydlg) % manually close a dialog (message /input /checkbox)
%      GW_SHOW_SPINNER (myspin) % display the spinner manually
%      GW_HIDE_SPINNER () % manually hide any spinner currently displayed
%      GW_SHOW_WRONG_PATTERN () % show a wrong lock pattern input
%      GW_CLEAR_LOCK_PATTERN () % clear the lock pattern
%      GW_SET_PROGRESSBAR (mypgb, n) % n between 0 and 100
%      GW_SHOW_PANEL (mypanl) % display the panel manually
%      GW_CLOSE_PANEL (mypanl) % manually close opened panel
%      e$=GW_GET_VALUE$ (ctl_id)
%      n=GW_GET_VALUE (ctl_id)
%      ctl_name$=GW_ID$ (ctl_id)
%      ctl_id=GW_ID (ctl_name$)
%      ctl_id=GW_LAST_ID ()
%      test=GW_CHECKBOX_CHECKED (ctl_id) % to test if a checkbox is checked
%      test=GW_RADIO_SELECTED (ctl_id) % to test if a radio button is selected
%      test=GW_FLIPSWITCH_CHANGED (ctl_id, s_opt1$)
%      test=GW_LISTVIEW_CHANGED (ctl_id) % to test change of sortable listview
%      order$=GW_GET_LISTVIEW_ORDER$ (ctl_id) % get new order of sortable listview
%      GW_HIDE_LISTVIEW_ROW (ctl_id, row) % hide listview row e.g. 'delete' swipe option
%      GW_REORDER_ARRAY (listview_array$[], order$)
%      GW_FOCUS (ctl_id)
%      GW_ENABLE (ctl_id)
%      GW_DISABLE (ctl_id)
%      GW_SHOW (ctl_id)
%      GW_HIDE (ctl_id)
%      GW_MODIFY (ctl_id, key$, "new value") % key$="value"...|"style:subkey"
%      GW_AMODIFY (ctl_id, key$, new_values$[]) % Array-Modify
%      :CONTROL (GW_MODIFY)   :KEYS                   :VALUES
%      :all (inc. CLASS)      :style&#58;subkey       :
%      :TITLEBAR              :title|lbutton|rbutton  :
%      :FOOTBAR               :title|lbutton|rbutton  :
%      :CHECKBOX              :checked|text           :"0"|"1"
%      :FLIPSWITCH            :selected|text          :s_opt1$|s_opt2$
%      :RADIO                 :selected|text          :"0"|"1"
%      :SELECTBOX             :selected|text          :INT$(index)
%      :SLIDER                :val|min|max|step|text  :
%      :TABLE                 :content                :
%      :IMAGE                 :content                :
%      :AUDIO                 :content                :
%      :VIDEO                 :content                :
%      :DIALOG_MESSAGE        :text|title             :
%      :DIALOG_INPUT          :text|title|input       :"A>"|"1>"|"*>"|"@>"|"<>"
%      :DIALOG_CHECKBOX       :text|title|checked     :"0"|"1"
%      :LINK                  :text|link              :
%      :BUTTON                :text|link              :
%      :INPUT*                :text|input             :
%      :COLORPICKER           :text|input             :
%      :TEXT                  :text                   :
%      :TEXTBOX               :text                   :
%      :TITLE                 :text                   :
%      :SUBMIT                :text                   :
%      :SPINNER               :text                   :
%
%      :CONTROL (GW_AMODIFY)   :KEYS                  :VALUES
%      :TITLEBAR               :lmenu|rmenu           :array$[]
%      :FOOTBAR                :lmenu|rmenu           :array$[]
%      :LISTVIEW               :content               :array$[]
%      :TABLE                  :content               :array$[]
%      :SELECTBOX              :content               :array$[]
%      :INPUTLIST              :list                  :array$[]
%      :DIALOG_*               :buttons               :array$[]
%
%      ! --> other special functions:
%      JS ("some java script") % execute a JavaScript snippet on the current page
%      mode=IS_APK () % return 1 if program is running as a user APK, 0 otherwise
%      GW_DUMP_TO_FILE (mypage, "myfile.html")
%      GW_DUMP (mypage) % print page content to console
%      h$=GW_CODE_HIGHLIGHT$ (raw_code$, black$[], blue$[], red$[])
%      wxh$=GW_GET_IMAGE_DIM$ (path_to_img$) % return image dimensions "WxH"
%      l$=GW_LINK$ ("http://mylink.com") % add a final ">" to open link in new tab
%
% TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
% * Adaptive/responsive pages -> function to tell on what the app is run (?) phone, 7" tablet, 10" tablet...
% * GW_CUSTO_DLGBTN() of dialog buttons already on a RENDERed page, or changed with GW_MODIFY()
% * GW App Composer aka GWAC
% * DataTables jQuery plugin
% * Theme nativeDroid2?
% * Better video player: JW Player -> third party lib GW_VIDEO_PLAYER
% TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
%
% Changelog:
% [v5.2] 19-AUG-2019
%      * /!\ Changed count bubble indicator in LISTVIEW from '(bbl)' to '{bbl}' (breaks compatibility)
%        The reason is when listing folders or files, too many had the characters '()' in their name
%      * Added support for *swipe* LISTVIEW with 1 or 2 options at the left (orange) and/or right (red),
%        Use "Opt1|..|Opt2" in your arrays. See the updated demo > GW basic controls > Listview
%      * Added function GW_HIDE_LISTVIEW_ROW() useful with a 'Delete' option from a swipe LISTVIEW typically
%      * Added support for *inline icons* in a LISTVIEW: use "..@@icon.png" in your array
% [v5.1] 11-JUL-2019
%      * Fixed GW_MODIFY() of an INPUTMINI (before you had to use key 'val' instead of 'input')
%      * Listview count bubbles '(bbl)' are now searched from the end of each listview element
%      * Replaced all comments in "GW.bas" and "GW_demo.bas" to use '%' only instead of a '!'/'%' mix
% [v5.0] 25-JUN-2019
%      * Fixed GitHub issue #179 time/date pickers had prehistoric look (available in the BASIC! Compiler)
%      * Fixed sortable listview at first Editor run or in a user APK
%      * Fixed selection of INPUTLIST, broken when compiling against SDK Target 28
%      * Improved listview thumbnails in user APKs (embedded images are now automatically copied to sdcard)
%      * Added debug traces when failing to download a theme or a third party lib
% [v4.9] 17-JUN-2019
%      * Fixed incorrect caching of remote images in APK mode
%      * Added support for *sortable* LISTVIEW and its support functions: GW_LISTVIEW_CHANGED(),
%        GW_GET_LISTVIEW_ORDER$() and GW_REORDER_ARRAY(). See the updated demo > GW basic controls > Listview
% [v4.8] 24-APR-2019
%      * Added support for CUSTO 'color=a..f' for SLIDER controls (same colors as for PROGRESSBAR)
%      * Added new control INPUTMINI which is a small inline INPUTNUMBER
% [v4.7] 08-MAR-2019
%      * /!\ Added a third parameter to GW_ADD_LOADING_IMG(page, img$, dark) (breaks compatibility)
%      * Added new control GW_ADD_PLACEHOLDER and its function GW_FILL_PLACEHOLDER
%      * Fixed update of PROGRESSBAR, broken when compiling against SDK Target 27
%      * Fixed 'content' change of IMAGE controls, broken when compiling against SDK Target 27
%      * Fixed 'input' change of INPUT controls, broken when compiling against SDK Target 27
%      * Fixed modify of DIALOGs (MESSAGE/INPUT/CHECKBOX), broken when compiling against SDK Target 27
%      * Fixed GW_GET_IMAGE_DIM$() function, broken when compiling against SDK Target 27
% [v4.6] 12-DEC-2016
%      * Fixed "Bad control id out of range (last control id: 0)" when using GW_MODIFY() in an ONTIMER: interrupt
%      * Added support for thumbnails and 2-line cells for LISTVIEW control. See cheatsheet + updated demo
%      * Improved adaptiveness of GW pages: INPUT controls act same on small smartphone / bigger tablet screens
% [v4.5] 09-DEC-2016
%      * /!\ Changed architecture of GW lib to get rid of lists. Before, there could be conflicts if user
%        created some lists before calling INCLUDE "GW.bas", now not anymore. Third-party libs, like
%        GW_GALLERY.bas or GW_UTILS.bas have also been changed and need to be updated if you use them.
%      * Fixed GW update system when running from a custom BASIC! Editor (<> com.rfo.basic)
%      * Added support for ">" + img_url$ in a VIDEO to display a poster image. See demo Advanced > Video
%      * Added third-party lib "GW_UTILS.bas" to the GW demo > Third party GW libs
% [v4.4] 03-DEC-2016
%      * Fixed videos
%      * Fixed PANEL transitions
%      * Added 2 new controls GW_ADD_BAR_LMENU$ and GW_ADD_BAR_RMENU$ to be used in a TITLEBAR/FOOTBAR
%      * Added a new control: GW_ADD_AUDIO() see demo > Advanced > Audio/Video for an example with a webradio
%      * Added support of '#' character in SELECTBOX & GW_ADD_BAR_LMENU$/RMENU$ to make a title/separator
%      * Added GW_MODIFY of AUDIO and VIDEO 'content' (local file or internet streaming source)
% [v4.3] 29-NOV-2016
%      * /!\ Changed location of all GW resources: they are now in a data/GW subfolder (existing files are moved)
%      * Fixed GW halt "Divide by zero at: html.load.url javascript.document.getElementById('slider1')..."
%      * Fixed CUSTO of GW_ADD_BAR_LBUTTON and RBUTTON to show their 'icon' when 'iconpos' is not specified
%      * Improved download of GW themes: now silent, with fallback, do not need to restart the GW program
% [v4.2] 18-NOV-2016
%      * /!\ Changed GW_MODIFY keys of INPUTBOX to 'text' (label) and 'input' (now same as all other INPUT* controls)
%      * Fixed GW_CUSTO_DLGBTN of DIALOG* buttons with a CUSTO 'notext'
%      * Fixed SLIDER input hidden by soft keyboard when being edited (especially at the bottom of the page)
%      * Fixed screen scrolling when touching a SUBMIT button (linked to zoom on INPUT*)
%      * Added function GW_ZOOM_INPUT(0|1) to disable/enable zoom in INPUT* controls when being edited, set this
%        setting for a page *before* creating it with GW_NEW_PAGE() (zoom is enabled by default)
%      * Improved the LISTENER to detect a "change" when re-selecting the already active SELECTBOX option
% [v4.1] 10-NOV-2016
%      * /!\ Changed notification of COLORPICKER: v3.9 notification was of the type "COLOR:#rrggbb", forbidding
%        to differentiate between several colorpickers on a same page. Changed notification is now of the type
%        GW_ID$(my_color_picker) + ":#rrggbb"
%      * Fixed input lines/boxes hidden by soft keyboard when being edited (especially at the bottom of the page)
%      * Fixed titles in titled + linked LISTVIEWs
%      * Fixed having a PROGRESSBAR and a SLIDER coexist in a same page + improved stability of PROGRESSBAR control
%      * Improved COLORPICKER control to show a rainbow-wheel (more user friendly than the old hue-picker)
%      * Added CUSTO 'color=a' up to 'color=f' for a PROGRESSBAR to change its background color + updated demo
% [v4.0] 02-NOV-2016
%      * /!\ Changed GW_MODIFY keys for INPUT* and COLORPICKER controls: key 'text' now refers to the label above the
%        control, while new key 'input' refers to the value in the input bar (now in line with DIALOG_INPUT controls),
%        before that change it was simply not possible to change the label of such controls...
%      * Changed the GW lib logo for a material design logo + fixed centering of the logo in the loading page
%      * Fixed GW_SHOW_DIALOG() of a DIALOG MESSAGE in iOS/android-holo/metro themes
%      * Fixed bad RENDER of pages with no page transition containing a DIALOG MESSAGE in iOS/android-holo/metro themes
%      * Fixed GW_HIDE() and GW_SHOW() of all controls with a label (INPUT*, COLORPICKER, RADIO, CHECKBOX, SLIDER...)
%      * Fixed select/unselect of radio buttons via GW_MODIFY(radio, "selected", "0|1") + improved radio/checkbox demo
% [v3.9] 16-OCT-2016
%      * /!\ Changed behavior of COLORPICKER to always send a notification when user changes a color (Vs before
%        tedious code was needed: prepare a LISTENER$, RENDER the page, activate the LISTENER$ after RENDER..)
%        Notifications are of the type "COLOR:#rrggbb", see updated GW demo > Advanced controls > Colorpicker/Class
%      * Fixed HTML.CLOSE bug when juggling between GW programs with GW_SILENT_LOAD set to 1
%      * Fixed CUSTO 'inline' of DIALOGs (MESSAGE/INPUT/CHECKBOX), broken in v3.8
%      * Fixed GW_LOAD_THEME() when specifying a theme in a case other than lower case
%      * Fixed TITLEBAR/FOOTBAR title alignment for themes native-droid-*
%      * Fixed TITLEBAR/FOOTBAR and DIALOGS for themes iOS, android-holo, and metro + vastly improved iOS demo
%      * Improved check of GW update: now limited to 1 per day. Accelerates consecutive startups in Editor mode
%      * Improved GW programs debugging a lot by showing last GW command when throwing an error (bad page/control)
%      * Added new commands GW_PREVENT_SELECT() and GW_ALLOW_SELECT() to handle text-select when long-pressing in a page
%      * Added new commands GW_OPEN_COLLAPSIBLE() and GW_CLOSE_COLLAPSIBLE() to expand/collapse a group of controls
%      * Added new commands GW_SHELF_OPEN() GW_SHELF_NEWCELL() GW_SHELF_NEWROW() and GW_SHELF_CLOSE() to organize
%        several controls on a same line. See the new section of the GW demo > Basic controls > Collapsible/Shelf
%      * Added new command GW_CUSTO_DLGBTN() to customize a button from a DIALOG once it is added to the page
% [v3.8] 05-OCT-2016
%      * Fixed regression in GW_ADD_TEXT() and GW_ADD_TEXTBOX() that would cause weird page truncations
%      * Re-added legacy functions GW_SHOW_DIALOG_MESSAGE$(), GW_SHOW_DIALOG_INPUT$(), GW_SHOW_DIALOG_MESSAGE(),
%        GW_SHOW_DIALOG_INPUT(), GW_CLOSE_DIALOG_MESSAGE() and GW_CLOSE_DIALOG_INPUT(), respective aliases
%        to GW_SHOW_DIALOG$(), GW_SHOW_DIALOG() and GW_CLOSE_DIALOG() (for backward compatibility)
% [v3.7] 28-SEP-2016
%      * /!\ Merged GW_SHOW_DIALOG_MESSAGE$() and GW_SHOW_DIALOG_INPUT$(), merged GW_SHOW_DIALOG_MESSAGE() and
%        GW_SHOW_DIALOG_INPUT(), and merged GW_CLOSE_DIALOG_MESSAGE() and GW_CLOSE_DIALOG_INPUT(), now all DIALOG types
%        (DIALOG_MESSAGE, DIALOG_INPUT, DIALOG_CHECKBOX) share the same commands: GW_SHOW_DIALOG$(), GW_SHOW_DIALOG()
%        and GW_CLOSE_DIALOG()
%      * Added new control GW_ADD_DIALOG_CHECKBOX() + updated demo (advanced controls > Dialog Message)
%      * Fixed GW_MODIFY of key 'style' for TEXT and TEXTBOX
%      * Added new command GW_ADD_FONT$() to be used in a CUSTO with the "font" key
% [v3.6] 23-SEP-2016
%      * Fixed GW loading bar in a user APK + accelerated further the loading of the library!
%      * Replaced third party lib GW_PICK_FOLDER with much improved GW_PICK_FILE (+FOLDER), see updated demo
% [v3.5] 20-SEP-2016
%      * Removed GW splash screen. Added loading bar of GW lib. Use GW_SILENT_LOAD=1 to hide it (old behavior)
%      * Added auto-upgrade mechanism of GW lib and GW demo (in Editor mode only, blocked in user APK)
%      * Fixed GW_AMODIFY() of "content" (array of options) for SELECTBOX and of "list" for INPUTLIST (thanks to Michel)
%      * Fixed GW_AMODIFY() of "content" (array of images) for a GALLERY (broken in v3.3)
%      * Fixed (again) GW_CENTER_PAGE_VER() fixed in v2.0 but broken again in v2.8
%      * Added GW_CLOSE_INPUTLIST() as per discussion at http://rfobasic.freeforums.org/clear-gw-inputlist-t4375.html
%      * Added GW_MODIFY() of key "text" for a SPINNER + updated demo
% [v3.4] 31-AUG-2016
%      * /!\ Removed mention of GW_ADD_INPUTFILE() in the documentation (control does nothing since Android 4.4)
%      * Fixed GW_MODIFY() of key "text" for a COLORPICKER
%      * Fixed GW_ENABLE() and GW_DISABLE() of a class
%      * [APK mode] Enhanced GW_MODIFY() to handle a new IMAGE that is in assets but not on sd-card
%      * [APK mode] Enhanced the following functions to support their js/css files in assets but not on sd:
%        GW_ADD_COLORPICKER(), GW_ADD_LOCK_PATTERN(), GW_ADD_SPINNER()
%      * Added new function GW_ADD_LOADING_IMG() to display an image (animated gif) when the page loads
%      * Added new function GW_FOCUS() to set the focus to a control
% [v3.3] 21-JUL-2016
%      * /!\ (internal) Changed the javascript HTML -> BASIC! link-function from doDataLink() to RFO()
%      * /!\ Re-integrated 2 resources into GW.bas: basic.js, styles.css. No more need to attach them in APK
%      * Fixed GW_SET_PROGRESSBAR() of a non-integer value
%      * Added new function JS(script$) to execute a javascript snippet on the page currently displayed
%      * Added new function IS_APK() to tell if the app runs in APK mode
%      * Added new function GW_GET_IMAGE_DIM$() to get the dimensions of an image in the form "WxH"
%      * Added new functions GW_HIDE() and GW_SHOW() to change visibility of a control
%      * [APK mode] Enhanced the following functions to handle files that are in assets but not on sd-card:
%        GW_LOAD_THEME(), GW_ADD_IMAGE(), GW_ADD_ICON(), GW_ADD_VIDEO(), GW_USE_FONT(),
%        now, when compiling your APK, you don't have to select the files for copy to sd-card at startup,
%        all you have to do is make sure you attach the resources in your APK
% [v3.2] 05-JUL-2016
%      * Added new control GW_ADD_DIALOG_INPUT() very similar to DIALOG_MESSAGE but with an input line:
%        the input line can be text (by default) or number, password, email, or url (see demo)
% [v3.1] 23-JUN-2016
%      * Fixed key "selected" for GW_MODIFY() of RADIO buttons
%      * Fixed key "selected" for GW_MODIFY() of CHECKBOXES
%      * Fixed GW_GET_VALUE$() and GW_RADIO_SELECTED() of RADIO buttons
%      * Added key "text" for GW_MODIFY() of CHECKBOX, FLIPSWITCH, SLIDER, SELECTBOX, and RADIO buttons
%      * Added key "selected" for GW_MODIFY() of SELECTBOX
%      * Added CUSTO property "mini" for BUTTONS
% [v3.0] 29-APR-2016
%      * Added LISTENER event "close" for a PANEL
%      * Added function GW_CLOSE_PANEL() to manually close an opened PANEL
%      * Added function GW_CLOSE_DIALOG_MESSAGE() to manually close an opened DIALOG_MESSAGE (see demo)
%      * Improved GW_AMODIFY() of a GALLERY to make it synchronous
%      * Rewrote (clarified) the list of APIs, cheatsheet, and demo for LISTENERs and for handling of Back key
% [v2.9] 22-APR-2016
%      * Fixed PAGE transition "none"
%      * Added function GW_DEFAULT_TRANSITIONS() e.g. "page=slide, panel=overlay, dialog_message=flip"
% [v2.8] 21-APR-2016
%      * Fixed support for PAGE transitions with GW_SET_TRANSITION()
%      * Added new function GW_CLOSE_PAGE() to manually show a closing transition (e.g. before leaving the app)
% [v2.7] 20-APR-2016
%      * Improved support for chaining a DIALOG_MESSAGE from another DIALOG_MESSAGE
%      * Fixed PANEL transitions in case of several panels in a page
%      * Improved individual transition management for each PANEL and DIALOG_MESSAGE
% [v2.6] 14-APR-2016
%      * Fixed GW_AMODIFY() of "buttons" for DIALOG_MESSAGE controls
%      * Fixed GW_MODIFY() of "title" for DIALOG_MESSAGE controls
%      * Fixed GW_SET_TRANSITION() of PANEL and DIALOG_MESSAGE controls after a page RENDER
%      * Changed DIALOG_MESSAGE to have vertical buttons by default, for horizontal (inline) buttons, use
%        GW_USE_THEME_CUSTO_ONCE("inline") before your GW_ADD_DIALOG_MESSAGE()
%      * Added support for chaining DIALOG_MESSAGEs with a button/action set to "My Button>"+GW_SHOW_DIALOG_MESSAGE$()
% [v2.5] 09-APR-2016
%      * /!\ Exported GW GALLERY to a third party lib, if you use it you now need to do: INCLUDE "GW_GALLERY.bas"
%      * /!\ Exported GW Aliases and Shortcuts to a third party lib. To use them: INCLUDE "GW_ALIASES_SHORTCUTS.bas"
%        To download the lib beforehand: GW_DOWNLOAD_THIRD_PARTY("GW_ALIASES_SHORTCUTS.bas")
%      * Added support for colored page during GW lib loading e.g. use GW_COLOR$="black" before your INCLUDE "GW.bas"
%      * Added new LISTENER events "swipeleft|swiperight|longpress|idleN": use them on a control, or on the page (ctl_id=0)
%      * Added new control GW_ADD_COLORPICKER(), you get color with GW_ADD_LISTENER$("change") or GW_GET_VALUE$()
%      * Added new special key to GW_MODIFY(): "style:subkey" to change the style (CSS) of a control
%      * Added GW_NEW_CLASS(): several controls can share a same class with a CUSTO "class='myclass'"
%      * Added GW_MODIFY() support for a whole class to change multiple controls with only 1 command
%      * Updated demo > Advanced > "Colorpicker + Class" to demonstrate the last 4 new features above
% [v2.4] 06-APR-2016
%      * Removed support for PAGE Transitions, broken (and unrecoverable) with the GW v1.8 "gray circle" fix
%        Calling GW_SET_TRANSITION() on a page will not throw an error but will do nothing (same as before)
%      * Fixed GW_WAIT_ACTION$() broken in v2.1 (and all functions using it e.g. GW_GET_VALUE$())
%      * Fixed URL-encoding of user links in GW elements (buttons, listviews) especially when link contains % or +
%      * Fixed CUSTO of BAR_LBUTTON$() and BAR_RBUTTON$() when said custo contained a style='...'
%      * Added CUSTO "position=right|left", applied to panels in the first screens of the demo
%      * Added support for third party libs via GW_DOWNLOAD_THIRD_PARTY(). First one is "GW_PICK_FOLDER.bas" (see demo)
%        Users can upload their GW third party lib in laughton.com FTP > html > GW (GUI-Web lib) > third-party-libs
%      * Added GW_GALLERY_IS_OPEN() to programmatically know if a gallery is open
%      * Added GW_CLOSE_GALLERY() to programmatically close an opened gallery, demo is updated
% [v2.3] 26-MAR-2016
%      * Fixed customization of IMAGE, SLIDER and PROGRESSBAR controls
%      * Added 4 new customizations: 'hover=N' |S|E|W|NE|NW|SE|SW ; 'alpha=0% to 100% ; 'big' ; and 'fit-screen'
%      * Improved performance of GALLERY control, particularly in case of Base64 images
%      * Re-organized GW demo into 3 categories: basic/input/advanced to simplify navigation
% [v2.2] 22-MAR-2016
%      * Added a new control GW_ADD_GALLERY() taking an array of images as parameter (+demo updated)
%      * Added a new control GW_ADD_LOCK_PATTERN() and its companion functions GW_SHOW_WRONG_PATTERN(), and
%        GW_CLEAR_LOCK_PATTERN() (+demo updated). User pattern is returned as "pattern:NNNN" in GW_WAIT_ACTION$()
%      * Extended GW_MODIFY() to support any kind of key (=HTML attribute) to be modified, even ones unknown to GW
% [v2.1] 13-MAR-2016
%      * Added new function GW_ACTION$() equivalent to GW_WAIT_ACTION$() but asynchronous (non-blocking)
%      * Improved GW-progs debugging by throwing a more convenient error in case of bad control id or bad page id
% [v2.0] 11-MAR-2016
%      * Fixed GW_CENTER_PAGE_VER()
%      * Fixed GW_MODIFY() of slider value (key "val")
%      * Improved GW_RENDER() to be synchronous!
%      * Added a new page element: GW_ADD_SPINNER() and its functions GW_SHOW_SPINNER() and GW_HIDE_SPINNER()
%      * Added a new control GW_ADD_PROGRESSBAR() and its function GW_SET_PROGRESSBAR()
%      * Added 2 new functions: GW_DISABLE() and GW_ENABLE() mainly for use with buttons
% [v1.9] 18-DEC-2015
%      * /!\ Removed the GW_FORCE_MODE() function, now obsolete since the "gray circle" fix in GW lib v1.8
%      * /!\ Added support for Back key: now it doesn't stop the lib anymore but returns "BACK" in GW_WAIT_ACTION$()
%      * Added GW_THEME_EXISTS() and GW_DOWNLOAD_THEME() to allow theme files to be downloaded programmatically
%      * Enhanced low-level handling of missing themes: there is now a popup proposing to automatically download files
%      * Cleaned-up the "Important notes" in the header of the lib
% [v1.8] 14-DEC-2015
%      * Added a script that fix gray circle issue for Android System WebView > 44.0.2403.117
% [v1.7] 29-NOV-2015
%      * Added GW_MODIFY() of the "title" and "text" of a DIALOG_MESSAGE
%      * Added GW_MODIFY() of a "selected" FLIPSWITCH option (s_opt1$ or s_opt2$)
% [v1.6] 13-JUN-2015
%      * /!\ Renamed GW_ADD_TITLE$() to GW_ADD_BAR_TITLE$() ; renamed GW_ADD_LEFT_BUTTON$() to GW_ADD_BAR_LBUTTON$() ;
%        and finally renamed GW_ADD_RIGHT_BUTTON$() to GW_ADD_BAR_RBUTTON$()
%      * Fixed a bug when GW_MODIFYing a new content with double quotes and/or single quotes in it (esp. in a TABLE)
%      * Added a new control: GW_ADD_IMAGE() to display an image (with an hyperlink option)
%      * Added a whole new set of functions for all the GW_ADD_*(page, ...) functions: GW_ADD_*$(...) (1 less parameter)
%        returns the string result of the function without adding it to the page. E.g. GW_ADD_TEXT(p,t$) -> GW_ADD_TEXT$(t$)
%      * Added function GW_LAST_ID() (no argument) to get the Id of the last control created with GW_ADD_*$(...)
%      * Added function GW_ID(ctl_name$) to get the Id of a control known only from its name
%      * Added function GW_USE_FONT() to make use of a local font (TTF or other)
%      * Added GW_ENABLE_LISTENER() to enable listener of dynamically created content, typically after a GW_MODIFY/GW_AMODIFY
%      * Added support of GW_MODIFY for TITLEBARs and FOOTBARs, see the corresponding changeable keys in the cheatsheet
%      * Improved GW_ADD_TITLEBAR/FOOTBAR/DIALOG_MESSAGE/PANEL: they can be added anytime even after creating some controls
% [v1.5] 07-MAY-2015
%      * Fixed creation of *linked* listviews with GW_ADD_LISTVIEW(), the links now work from the start
%      * Added aliases / shortcuts for all GW functions, shorter and easier to write from mobile device
% [v1.4] 21-APR-2015
%      * Added a new control: GW_ADD_LISTVIEW() based on the work from forum user Gyula
%      * Fixed an Android 5.0 bug when setting GW_SET_TRANSITION() of a page without controls
% [v1.3] 12-FEB-2015
%      * Added GW_ADD_FOOTBAR() counterpart of a TITLEBAR but at the bottom of the page
%      * Added 3 new functions to build a TITLEBAR or FOOTBAR: GW_ADD_LEFT_BUTTON$() GW_ADD_TITLE$() GW_ADD_RIGHT_BUTTON$()
%      * Added a new control: GW_ADD_ICON() that allows with GW_ICON$() to add custom icons in TITLEBAR or FOOTBAR
%      * Added function GW_ADD_LISTENER() that triggers an action when a certain event occurs on a control
%      * Improved GW_GET_VALUE() and GW_GET_VALUE$() to retrieve the live content of a control! (without submit)
% [v1.2] 15-JAN-2015
%      * Added new standard control GW_ADD_TABLE() to make tables with (">") or w/o a title line
%      * Added GW_AMODIFY() (ARRAY-MODIFY) for controls taking an array as a parameter: TABLE, INPUTLIST,
%        SELECTBOX and DIALOG_MESSAGE
% [v1.1] 14-JAN-2015
%      * Added GW_SHOW_DIALOG_MESSAGE() to display a dialog message manually
%      * Added GW_SHOW_PANEL() to open a panel manually
%      * Added GW_MODIFY() of the state of a CHECKBOX and of a RADIO button
%      * Added GW_SET_TRANSITION() to change the transition animation of DIALOG_MESSAGE, PAGE, or PANEL
%      * Added GW_ADD_INPUTDATETIME() as a workaround for the INPUTTIME bug on Android Lollipop
%        ( see https://code.google.come/p/chromium/issues/detail?id=434695 )
% [v1.0] 12-JAN-2015
%      * Added support of videos! both local or online with GW_ADD_VIDEO()
%      * Added 2 new user input controls: GW_ADD_INPUTLIST() and GW_ADD_SELECTBOX()
%      * Added GW_MODIFY() to modify properties of already ADDed controls
%      * Removed GW_SET_CONTENT(), the functionality of which is now merged (and extended) in GW_MODIFY()
% [v0.9] 11-JAN-2015
%      * Added a new page element: GW_ADD_DIALOG_MESSAGE() and its 'trigger' link GW_SHOW_DIALOG_MESSAGE$()
%      * Added function GW_CENTER_PAGE_VER() to center vertically the page content
%      * Added GW_PREVENT_LANDSCAPE() and GW_PREVENT_PORTRAIT(), undocumented because HTML.ORIENTATION is prefered
% [v0.8] 08-JAN-2015
%      * Fixed the usage of GW_USE_THEME_CUSTO_ONCE() for a first control in the page
%      * Fixed the possibility to enter a decimal number with GW_ADD_INPUTNUMBER()
%      * Added 2 functions to be used after GW_WAIT_ACTION$(): GW_CHECKBOX_CHECKED() and GW_RADIO_SELECTED()
%      * Added GW_LINK$() to embed a link into a string used in a control (TEXTBOX, TEXT, TITLE, etc.)
%      * Created a GW APis cheat sheet available at http://mougino.free.fr/tmp/GW/cheatsheet.html
% [v0.7] 06-JAN-2015
%      * Fixed GW_GET_VALUE() of an empty control, it now returns 0 (zero)
%      * Added GW_INJECT_HTML() to add custom HTML/CSS/JavaScript code to the page
%      * Added GW_START_CENTER() and GW_STOP_CENTER() to center elements on the page
% [v0.6] 04-JAN-2015
%      * Changed the number of parameters of GW_ADD_INPUTBOX(): n-rows and n-cols are no longer needed
%      * Fixed the rendering of the "native-droid-*" theme family
%      * Fixed inline comments highlighting with GW_CODE_HIGHLIGHT$()
%      * Added GW_OPEN_GROUP() and GW_CLOSE_GROUP() to visually group CHECKBOX or RADIO controls
%      * Added 11 new user input controls: GW_ADD_INPUTDATE(), GW_ADD_INPUTTIME(), GW_ADD_INPUTMONTH(),
%        GW_ADD_INPUTWEEK(), GW_ADD_INPUTURL(), GW_ADD_INPUTEMAIL(), GW_ADD_INPUTCOLOR(), GW_ADD_INPUTNUMBER(),
%        GW_ADD_INPUTTEL(), GW_ADD_INPUTPASSWORD(), GW_ADD_INPUTFILE()
%      * Added a 'reset' button (X) to the input controls that support it=INPUTLINE and the 11 new controls
%      * Added the compatibility mode FORCE_MODE(1) for Android devices that otherwise show empty GW pages
% [v0.5] 31-DEC-2014
%      * Added full support for the "native-droid-*" theme family, composed of
%        10 themes: 5 colors blue/green/purple/red/yellow in 2 flavours light/dark (recommended)
%      * Added full support for the "square-ui" theme (recommended)
%      * Added limited support for the "android-holo" theme (deprecated, not recommended)
%      * Added limited support for the "metro" theme (deprecated, not recommended)
% [v0.4] 30-DEC-2014
%      * Added 2 new input controls: GW_ADD_CHECKBOX() and GW_ADD_RADIO()
%      * Fixed and improved the rendering of the themes
%      * Added full support for the "bootstrap" theme (recommended)
%      * Added limited support for the "iOS" theme (deprecated, not recommended)
% [v0.3] 29-DEC-2014
%      * Added themes and theme-customization! persistent or 1-shot (GW_USE_THEME_CUSTO /.._ONCE)
%      * Added full support for the "flat-ui" theme (recommended)
%      * Added limited support for the "classic" jQuery Mobile theme (deprecated, not recommended)
%      * Added initial selection of FLIPSWITCH second state (s_opt2$) if it begins with ">"
% [v0.2] 28-DEC-2014
%      * Renamed the lib to 'GW' (GUI-Web)
%      * Created GW_demo.bas
%      * Added 3 new standard controls: GW_ADD_BUTTON() GW_ADD_LINK() and GW_ADD_TEXT()
%      * Added 3 new input controls: GW_ADD_FLIPSWITCH(), GW_ADD_INPUTLINE() and GW_ADD_INPUTBOX()
%      * Added a new page element: GW_ADD_PANEL() and its 'trigger' link GW_SHOW_PANEL$()
%      * Added GW_GET_VALUE() -> returns a number (Vs GW_GET_VALUE$() returns a string)
%      * Added GW_CODE_HIGHLIGHT$() for syntax highlighting
%      * Renamed all GW_NEW* control creation functions to GW_ADD_*
%      * Renamed GW_SET_SECTION_TEXT() to GW_SET_CONTENT()
%      * GW_GET_VALUE() GW_GET_VALUE$() and GW_SET_CONTENT() now take only 1 param (ctl_id)
%      * SLIDER control now takes an extra parameter: n_step
% [v0.1] 24-DEC-2014
%      * Initial release

FN.DEF MAKE_SURE_IS_ON_SD(f$) % (internal) make sure file$ is on sd-card, else try to copy it from asset.
  FILE.EXISTS onSd, f$        %            This function is to be used after testing: IF IS_APK() THEN ...
  IF IS_IN("data:", f$)=1 THEN FN.RTN 1 % do not treat base64-encoded media
  IF !onSd
    BYTE.OPEN r, fid, f$      % open from assets
    IF fid<0 THEN FN.RTN 0    % file does not exist
    PRINT "Unpacking " + f$
    j=IS_IN("/", f$)
    WHILE j % create subfolder hierarchy for this file, if any
      FILE.MKDIR LEFT$(f$, j)
      j=IS_IN("/", f$, j+1)
    REPEAT
    BYTE.COPY fid, f$
  ENDIF
  FN.RTN 1
FN.END % FN.END not followed by \n --> do no count this function in GW_NFN

IF GW_SILENT_LOAD=2 THEN GOTO gw_super_silent_load % http://rfobasic.freeforums.org/super-silent-load-t4748.html

GRABFILE gw$, "../source/GW.bas"
IF gw$="" THEN END "Error misplaced or renamed library: cannot find \"source/GW.bas\""

HTML.OPEN 0 % hide status bar, else JQM header is masked (bug)
IF GW_SILENT_LOAD
  GW_LPG$="<html><head><meta charset='ISO-8859-2'><meta name='viewport' content='width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no'><script>function RFO(data){Android.dataLink(data);}</script></head><body><script>window.onload=function(){RFO('ready');}</script></body></html>"
  IF LEN(GW_COLOR$) THEN GW_LPG$=REPLACE$(GW_LPG$, "<style>", "<style>html {background:"+GW_COLOR$+"}")
  HTML.LOAD.STRING GW_LPG$
  DO: HTML.GET.DATALINK data$: PAUSE 1: UNTIL data$="DAT:ready"
ELSE % GW_LPG (LOGO+PROGRESSBAR)
  MAKE_SURE_IS_ON_SD("GW/jquery.mobile-1.4.5.min.css")
  MAKE_SURE_IS_ON_SD("GW/jquery-2.1.1.min.js")
  MAKE_SURE_IS_ON_SD("GW/jquery.mobile-1.4.5.min.js")
  GW_LOGO$="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAAAbCAYAAADMIInqAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAadEVYdFNvZnR3YXJlAFBhaW50Lk5FVCB2My41LjEwMPRyoQAABfVJREFUWEfNmGtMW2UYx7trMjXOGbdo/OCy+MHEeIlxiYl+cp+8fTBm2RxMNsfYgBFXJsitMMZtIyCy6cjUOV3GBuXW0gEFWgqlUFpukg1w0As3GVM0mcwswbDj83bvIafnec5p6yf/yf9Dn1Oet7//eS/noBEEIciRqK99bqut3h/dXu39ylrra2+r8joteh9zLXwuBL/Zb/11Pf/6/0KIFxXCkL1x6jWArWy96rlvrvQIaobv+CGQnI5a36P8zwMqOju881h6j1HJsdou457D1pCOS7Ybq+onjFUNk6TrTB4dHzIgxIsKKrLW+DYAeIH5SmhwuVuveRY66vyxLsvcOtbrYuX4Zq2udwlgBcrxqd0CAIa0rsgtAKiiDS2+hMCP50K8qKCgToN/K0z1nym4SAwhxvOWmuwz/Y0UPHNimkOIiu8goaW+8NMoCc69ZDL7H+fDBYR4UYHQYOf8NriDIxRQJIblMAN7whbeVlNQNvR+YhodAPOh410ktOhYrV24Vj9BgQdc2+gx8aFWhXhRgRDA11FAEfoBbIrRvGVATe1TGm22c5GCZ45PdZDgonNLBkhw0Q1N3t18qFUhXlSQyVLji2E/XgYTsSHEbt4ySFlF/ZcoeNH7E+hlsDfOKnx/ZYwE5150DS5s5sOsCvGigkRdjVMbzVc9HgooQi/DcbmTtw1S6fmRXRS4aDgNyADYJqk2/fVGzw98iCAhXlSQqMswdZCAidgWvfcyb4kEd2lTcrbTS8EzJ3zhCNxteQCFZUMkuOj6Ju8uPkSQEC8qSATndxsFFIlh47sHQT7FW5JKL3CXUPDM7DT4JNEWBM8C+bHqFxKcGe7+7509c5t4+yAhXlTgGnHcXg8//i4FFYnh2EvjLRVVWjHyMgUv+nCyPSiAJKhR4KJrTZ7zvDUS4kUFLluD/wUKSOqzJ9xCXoxD0QWHHEK51rVQrnXPyX0upd8/0DG/jY3V3D69Li3fpbgM2CyQLoPic8MkOPO1+kmh2TL9VgCCEOJFBa7u69PvUNBSFx91Cmkf2hSdd6BbOHOkl3RpUp8waLu9nQ+nySkeyKPgRccce7gMoo52CJer1ab/pI+3JIV4UYHLaZ49QEFLrRZA1p5O4XRcDwnPLA/gzNfD25Myev6h4JnjTjxcBsm6XhJcdE2jJ4+3JIV4UYELHntfpaClVguATX8KXLQ8AKbUU30DFDwzWwYfH7EKX1aMkOCizR3T5HErCvGiAhfMgGcBclkOLbVSADn7ugBS+e4zUwHoTvd/RsGLZrOgsvYWCc4Md3/sxvjiGt6OFOJFBYngzW+GAhdNBZD+kU0oOqwOz0wFABvYjuO63gcUPDO8O0zAw88KBc+sN0xqeStFIV5UkAieAyoocNFUALn77SSw3FQATJ+f7Guh4Jnzy4begzN+nIJnbrFOPcfbKArxooJEnQ3+VwB0RQ4uWh5A5m71jU9qpQAyi9zRFHxKbt9dS9fsY3DGZ1HwNUZPNzxVqk5/JsSLCjLBS4yegmeWB5B/UPnYk1spgOoGz5NanXNZHgBskN+w622dMy9VG3AAjS2+lECDEEK8qCBTT/PM8xDC36EC0O0N/+4zKwXABA9FBnkAsP7fYNdGby2ugQDssgDuN7epP26LQryoQAgeZ/eHCqAwVv3Yk1stgPJvb3wq/UcJTP+5OpN3A7+sgd0+QRoAPPwY+aWQQryooCDYENOUAjgZFd7GJ7VaABcujz2ize79Qwwgs9Bdwi8FBHvB09IADM2+A/xSSCFeVFARvNPvg+WwJA0gI8xjT261AJhgzV/kAaycv3TzdV5eFcwCK4OH5XDPYp99gpdDCvGiQgh1m6Z3tOu9ZjGAUzHhb3xShwoAlsEHbBnAsTjKS0EytfqTWABwKtTwUlhCvKgQhm723Vlr0XvfBojfItn4pA4VgGvozlpY+3+m57vSeSlIrbbpLRDAX7A3vMtLYQnxokIEqkgfrILp7/wvLkl0OuF1+BneilRGobv4uytjL/KPSHXXvRUO1/xG/jEsBfMKmn8BKH/tAtgwDaIAAAAASUVORK5CYII="
  GW_LPG$="<html><head><meta charset='ISO-8859-2'><meta name='viewport' content='width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no'><link rel='stylesheet' href='GW/jquery.mobile-1.4.5.min.css'/><style>html *{font-family:Roboto !important} p{color:#764fbe} progress{width:80%} #content1{position:absolute;margin:auto;top:0;right:0;bottom:0;left:0;width:250px;height:150px}</style><script src='GW/jquery-2.1.1.min.js'></script><script src='GW/jquery.mobile-1.4.5.min.js'></script><script>function RFO(data){Android.dataLink(data);}</script></head><body><div id='page1'><div id='content1'><script>window.onload=function(){RFO('ready');}</script><div style='margin:0 auto;text-align:center;'><div><p id='label1'><b>Loading the <img height='14' src='"+GW_LOGO$+"' /> lib...</b><br/>&nbsp;</p><progress id='slider1' min='0' max='100' step='0.1' value='0'></progress></div><div><p></p></div><p><i>www.rfo-basic.com</i></p></div></div></div></body></html>"
  GW_LOGO$="" % free 2.25KB of memory
  IF LEN(GW_COLOR$)
    GW_LPG$=REPLACE$(GW_LPG$, "html *", "p,a{-webkit-filter:invert(100%)} html {background:"+GW_COLOR$+"} html *")
  ENDIF
  HTML.LOAD.STRING GW_LPG$
  GW_LPG$="" % free 3KB of memory
  DO: HTML.GET.DATALINK data$: PAUSE 1: UNTIL data$="DAT:ready"
  ! (internal) count number of GW functions
  i=IS_IN("FN.END\n", gw$)
  WHILE i
    GW_NFN++ % Number of GW functions
    i=IS_IN("FN.END\n", gw$, i+1)
  REPEAT
ENDIF
gw$="" % free 160KB of memory

gw_super_silent_load:

FN.DEF GW_LOAD_PG(n, tot) % (internal) update GW lib loading progress
  IF tot>0 THEN HTML.LOAD.URL "javascript:$('#slider1').val("+STR$(INT(n/tot*1000)/10)+")"
FN.END % FN.END not followed by \n --> do no count this function in GW_NFN

ARRAY.LOAD GW_THEME$[], "default", "flat-ui", "classic", "ios", ~
  "bootstrap", "android-holo", "square-ui", "metro", "native-droid"

BUNDLE.CREATE gwbundle
BUNDLE.PUT 1, "gw-theme", "default" % <-- change if you want another theme by default
BUNDLE.PUT 1, "gw-last-edited-page", 0
BUNDLE.PUT 1, "gw-last-rendered-page", 0
BUNDLE.PUT 1, "gw-default-page-transition", "none"
BUNDLE.PUT 1, "gw-default-panel-transition", "push"
BUNDLE.PUT 1, "gw-default-dlg-transition", "pop"
BUNDLE.PUT 1, "gw-last-command", ""
BUNDLE.PUT 1, "gw-zoom-input", 1
BUNDLE.PUT 1, "gw-theme-custo", 0
BUNDLE.PUT 1, "gw-theme-custo-token", 0 % zero token=no customization
BUNDLE.PUT 1, "gw-theme-1-files", "jquery-2.1.1.min.js, jquery.mobile-1.4.5.min.css, jquery.mobile-1.4.5.min.js"
BUNDLE.PUT 1, "gw-no-transition-script", "RFO('GwReady')"
BUNDLE.PUT 1, "gw-transition-script", "$(window).load(function(){setTimeout(function(){$('#openthispage').click();},10)}); $('#page0').on('animationend webkitAnimationEnd',function(e){$('#page0').off(e); setTimeout(function(){RFO('open-endanim');},10);});"
BUNDLE.PUT 1, "gw-theme-2-files", "flatui/jquery.mobile.flatui.css, flatui/fonts/Flat-UI-Icons-24.ttf, flatui/fonts/Flat-UI-Icons-24.woff, flatui/fonts/lato-black.ttf, flatui/fonts/lato-black.woff, flatui/fonts/lato-bold.ttf, flatui/fonts/lato-bold.woff, flatui/fonts/lato-italic.ttf, flatui/fonts/lato-italic.woff, flatui/fonts/lato-regular.ttf, flatui/fonts/lato-regular.woff, flatui/images/ajax-loader.gif, flatui/images/icons-18-black.png, flatui/images/icons-18-white.png, flatui/images/icons-36-black.png, flatui/images/icons-36-white.png"
BUNDLE.PUT 1, "gw-theme-3-files", "jquery-2.1.1.min.js, jquery.mobile-1.4.5.min.css, jquery.mobile-1.4.5.min.js, theme-classic.css"
BUNDLE.PUT 1, "gw-theme-4-files", "ios/ios.css, ios/jquery-1.7.1.min.js, ios/jquery.mobile-1.2.0.min.css, ios/jquery.mobile-1.2.0.min.js, ios/images/ajax-loader.gif, ios/images/arrow_right.png, ios/images/arrow_right@2x.png, ios/images/backButtonSprite.png, ios/images/backButtonSprite@2x.png, ios/images/icons-18-black.png, ios/images/icons-18-white.png, ios/images/icons-36-black.png, ios/images/icons-36-white.png, ios/images/iconSprite.png, ios/images/tabSprite.png, ios/images/tick.png, ios/images/tiling_stripes.gif"
BUNDLE.PUT 1, "gw-theme-5-files", "bootstrap/Bootstrap.min.css, bootstrap/images/ajax-loader.gif, bootstrap/images/icons-png/action-black.png, bootstrap/images/icons-png/action-white.png, bootstrap/images/icons-png/alert-black.png, bootstrap/images/icons-png/alert-white.png, bootstrap/images/icons-png/arrow-d-black.png, bootstrap/images/icons-png/arrow-d-l-black.png, bootstrap/images/icons-png/arrow-d-l-white.png, bootstrap/images/icons-png/arrow-d-r-black.png, bootstrap/images/icons-png/arrow-d-r-white.png, bootstrap/images/icons-png/arrow-d-white.png, bootstrap/images/icons-png/arrow-l-black.png, bootstrap/images/icons-png/arrow-l-white.png, bootstrap/images/icons-png/arrow-r-black.png, bootstrap/images/icons-png/arrow-r-white.png, bootstrap/images/icons-png/arrow-u-black.png, bootstrap/images/icons-png/arrow-u-l-black.png, bootstrap/images/icons-png/arrow-u-l-white.png, bootstrap/images/icons-png/arrow-u-r-black.png, bootstrap/images/icons-png/arrow-u-r-white.png, bootstrap/images/icons-png/arrow-u-white.png, bootstrap/images/icons-png/audio-black.png, bootstrap/images/icons-png/audio-white.png, bootstrap/images/icons-png/back-black.png, bootstrap/images/icons-png/back-white.png, bootstrap/images/icons-png/bars-black.png, bootstrap/images/icons-png/bars-white.png, bootstrap/images/icons-png/bullets-black.png, bootstrap/images/icons-png/bullets-white.png, bootstrap/images/icons-png/calendar-black.png, bootstrap/images/icons-png/calendar-white.png, bootstrap/images/icons-png/camera-black.png, bootstrap/images/icons-png/camera-white.png, bootstrap/images/icons-png/carat-d-black.png, bootstrap/images/icons-png/carat-d-white.png, bootstrap/images/icons-png/carat-l-black.png, bootstrap/images/icons-png/carat-l-white.png, bootstrap/images/icons-png/carat-r-black.png, bootstrap/images/icons-png/carat-r-white.png, bootstrap/images/icons-png/carat-u-black.png, bootstrap/images/icons-png/carat-u-white.png, bootstrap/images/icons-png/check-black.png, bootstrap/images/icons-png/check-white.png, bootstrap/images/icons-png/clock-black.png, bootstrap/images/icons-png/clock-white.png, bootstrap/images/icons-png/cloud-black.png, bootstrap/images/icons-png/cloud-white.png, bootstrap/images/icons-png/comment-black.png, bootstrap/images/icons-png/comment-white.png, bootstrap/images/icons-png/delete-black.png, bootstrap/images/icons-png/delete-white.png, bootstrap/images/icons-png/edit-black.png, bootstrap/images/icons-png/edit-white.png, bootstrap/images/icons-png/eye-black.png, bootstrap/images/icons-png/eye-white.png, bootstrap/images/icons-png/forbidden-black.png, bootstrap/images/icons-png/forbidden-white.png, bootstrap/images/icons-png/forward-black.png, bootstrap/images/icons-png/forward-white.png, bootstrap/images/icons-png/gear-black.png, bootstrap/images/icons-png/gear-white.png, bootstrap/images/icons-png/grid-black.png, bootstrap/images/icons-png/grid-white.png, bootstrap/images/icons-png/heart-black.png, bootstrap/images/icons-png/heart-white.png, bootstrap/images/icons-png/home-black.png, bootstrap/images/icons-png/home-white.png, bootstrap/images/icons-png/info-black.png, bootstrap/images/icons-png/info-white.png, bootstrap/images/icons-png/location-black.png, bootstrap/images/icons-png/location-white.png, bootstrap/images/icons-png/lock-black.png, bootstrap/images/icons-png/lock-white.png, bootstrap/images/icons-png/mail-black.png, bootstrap/images/icons-png/mail-white.png, bootstrap/images/icons-png/minus-black.png, bootstrap/images/icons-png/minus-white.png, bootstrap/images/icons-png/navigation-black.png, bootstrap/images/icons-png/navigation-white.png, bootstrap/images/icons-png/phone-black.png, bootstrap/images/icons-png/phone-white.png, bootstrap/images/icons-png/plus-black.png, bootstrap/images/icons-png/plus-white.png, bootstrap/images/icons-png/power-black.png, bootstrap/images/icons-png/power-white.png, bootstrap/images/icons-png/recycle-black.png, bootstrap/images/icons-png/recycle-white.png, bootstrap/images/icons-png/refresh-black.png, bootstrap/images/icons-png/refresh-white.png, bootstrap/images/icons-png/search-black.png, bootstrap/images/icons-png/search-white.png, bootstrap/images/icons-png/shop-black.png, bootstrap/images/icons-png/shop-white.png, bootstrap/images/icons-png/star-black.png, bootstrap/images/icons-png/star-white.png, bootstrap/images/icons-png/tag-black.png, bootstrap/images/icons-png/tag-white.png, bootstrap/images/icons-png/user-black.png, bootstrap/images/icons-png/user-white.png, bootstrap/images/icons-png/video-black.png, bootstrap/images/icons-png/video-white.png"
BUNDLE.PUT 1, "gw-theme-6-files", "android-holo/android-holo-light.min.css, android-holo/jquery-1.7.1.min.js, android-holo/jquery.mobile-1.1.0.min.js, android-holo/jquery.mobile.structure-1.1.0.min.css, android-holo/images/ajax-loader.gif, android-holo/images/icons-18-black.png, android-holo/images/icons-18-white.png, android-holo/images/icons-36-black.png, android-holo/images/icons-36-white.png"
BUNDLE.PUT 1, "gw-theme-7-files", "squareui/jquery.mobile.squareui.min.css, squareui/fonts/Flat-UI-Icons-24.woff, squareui/fonts/lato-black.woff, squareui/fonts/lato-bold.woff, squareui/fonts/lato-italic.woff, squareui/fonts/lato-regular.woff, squareui/images/ajax-loader.gif, squareui/images/icons-18-black.png, squareui/images/icons-18-white.png, squareui/images/icons-36-black.png, squareui/images/icons-36-white.png"
BUNDLE.PUT 1, "gw-theme-8-files", "metro/jquery-1.7.1.min.js, metro/jquery.mobile-1.1.0.min.js, metro/jquery.mobile.metro.theme.css, metro/jquery.mobile.metro.theme.init.js, metro/jquery.mobile.structure-1.1.0.min.css, metro/images/ajax-loader.png, metro/images/checkbox-disabled.png, metro/images/checkbox.png, metro/images/icons-18-black.png, metro/images/icons-18-white.png, metro/images/icons-36-black.png, metro/images/icons-36-white.png, metro/images/radiobtn-disabled.png, metro/images/radiobtn.png, metro/images/wait-indicator.gif"
BUNDLE.PUT 1, "gw-theme-9-files", "nativedroid/font-awesome.min.css, nativedroid/fonts.css, nativedroid/jquery-1.9.1.min.js, nativedroid/jquery.mobile-1.4.2.min.css, nativedroid/jquery.mobile-1.4.2.min.js, nativedroid/jquerymobile.nativedroid.color.blue.css, nativedroid/jquerymobile.nativedroid.color.green.css, nativedroid/jquerymobile.nativedroid.color.purple.css, nativedroid/jquerymobile.nativedroid.color.red.css, nativedroid/jquerymobile.nativedroid.color.yellow.css, nativedroid/jquerymobile.nativedroid.css, nativedroid/jquerymobile.nativedroid.dark.css, nativedroid/jquerymobile.nativedroid.light.css, nativedroid/nativedroid.script.js, nativedroid/fonts/fontawesome-webfont.eot, nativedroid/fonts/fontawesome-webfont.svg, nativedroid/fonts/fontawesome-webfont.ttf, nativedroid/fonts/fontawesome-webfont.woff, nativedroid/fonts/FontAwesome.otf"

%---------------------------------------------------------------------------------------------
% FUNCTIONS TO BE CALLED BEFORE CREATING A PAGE
%---------------------------------------------------------------------------------------------
FN.DEF IS_APK() % (internal) return true (1) if we are in apk mode, false (0) otherwise
  FILE.EXISTS Editor, "../source/GW.bas"
  FN.RTN (!Editor)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF JS(script$) % (internal) execute a javascript code
  HTML.LOAD.URL "javascript:" + script$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ZOOM_INPUT(zoom)
  BUNDLE.PUT 1, "gw-zoom-input", zoom
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF MAKE_FULL_PATH(f$) % create subfolder hierarchy for a file (if any)
  j=IS_IN("/", f$)
  WHILE j
    FILE.MKDIR LEFT$(f$, j)
    j=IS_IN("/", f$, j+1)
  REPEAT
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF DEL_FULL_PATH(f$) % delete subfolder hierarchy (if any)
  j=IS_IN("/", f$, -1)
  WHILE j
    f$=LEFT$(f$, j-1)
    FILE.DELETE deleted, f$
    IF !deleted THEN FN.RTN 0
    j=IS_IN("/", f$, -1)
  REPEAT
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CHECK_AND_DOWNLOAD(f$) % (internal) Download a single file to the device (except if it already exists)
  IF 1=IS_IN("GW/", UPPER$(f$)) THEN f$=MID$(f$, 4)
  lf$="GW/" + f$ % new: put every GW resources inside data/GW subfolder ; lf$=local file
  FILE.EXISTS fe, lf$
  IF fe THEN FN.RTN 1 % already on device!
  FILE.EXISTS fe, f$
  IF fe % already on device but at old place (not in 'GW' subfolder)
    MAKE_FULL_PATH(lf$)
    FILE.RENAME f$, lf$
    IF IS_IN("/", f$) THEN DEL_FULL_PATH(f$) % remove old folder hierarchy if possible (and if it's not the data/ root)
    FN.RTN 1
  ENDIF % else file is not on device -> download it from laughton or mougino servers
  BYTE.OPEN r, fid, "http://laughton.com/basic/programs/html/GW%20(GUI-Web%20lib)/GW/" + f$
  IF fid<0 THEN BYTE.OPEN r, fid, "http://mougino.free.fr/tmp/GW/" + f$ % fallback
  IF fid<0 THEN FN.RTN 0 % could not access file on both laughton & mougino servers
  PRINT "Downloading " + f$
  MAKE_FULL_PATH(lf$)
  BYTE.COPY fid, lf$
  FN.RTN 1
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_DOWNLOAD_THIRD_PARTY(f$) % Download 3rd party lib from laughton.com (fallback: mougino.free.fr) to source/
  FILE.EXISTS fe, "../source/" + f$
  IF fe THEN FN.RTN 1 % already on device!
  BYTE.OPEN r, fid, "http://laughton.com/basic/programs/html/GW%20(GUI-Web%20lib)/third-party-libs/" + f$
  IF fid<0 THEN BYTE.OPEN r, fid, "http://mougino.free.fr/tmp/GW/third-party-libs/" + f$
  IF fid<0 THEN END "Error: GW was unable to download 3rd party lib " + f$ + "\n" + GETERROR$()
  PRINT "Downloading 3rd party lib " + f$
  BYTE.COPY fid, "../source/" + f$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CHECK_THEME(theme$) % (internal) Check existence on the device of main .css file for a theme
  IF GW_THEME_EXISTS(theme$) THEN FN.RTN 1 % already on device!
  IF IS_IN("native-droid", theme$)=1 THEN theme$="native-droid"
  IF !GW_DOWNLOAD_THEME(theme$)
    END "There was a problem downloading GW theme '"+theme$+"'.\n" + GETERROR$()
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_DOWNLOAD_THEME(e$) % Download to device all files for a given theme
  idx=GW_THEME_INDEX(e$)
  IF idx THEN FN.RTN GW_DOWNLOAD_THEME_FILES(idx) ELSE FN.RTN 0
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_DOWNLOAD_THEME_FILES(theme) % (internal) Download theme #theme (full set of files) to the device
  BUNDLE.GET 1, "gw-theme-" + INT$(theme) + "-files", allfiles$
  SPLIT file$[], allfiles$, ","
  ARRAY.LENGTH nfiles, file$[]
  res=1
  FOR i=1 TO nfiles
    res *= GW_CHECK_AND_DOWNLOAD("GW/"+TRIM$(file$[i]))
  NEXT
  FN.RTN res
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_THEME_INDEX(e$) % (internal) return index of GW theme
  e$=LOWER$(e$)
  IF e$="default" THEN FN.RTN 1
  IF e$="flat-ui" THEN FN.RTN 2
  IF e$="classic" THEN FN.RTN 3
  IF e$="ios" THEN FN.RTN 4
  IF e$="bootstrap" THEN FN.RTN 5
  IF e$="android-holo" THEN FN.RTN 6
  IF e$="square-ui" THEN FN.RTN 7
  IF e$="metro" THEN FN.RTN 8
  IF IS_IN("native-droid", e$)=1 THEN FN.RTN 9
  FN.RTN 0 % any other case=illegal theme
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_THEME_OF_PAGE$(page) % (internal) return the theme of the page 'page'
  e$=GW_PAGE$(page) % each command calling GW_THEME_OF_PAGE$() must have checked validity of 'page'
  ARRAY.LOAD thm$[], "default", "flat-ui", "classic", "ios", ~
    "bootstrap", "android-holo", "square-ui", "metro", "native-droid"
  ARRAY.LENGTH nthm, thm$[]
  FOR i=1 TO nthm
    IF IS_IN(GW_THEME_CSS$(thm$[i]), e$) THEN F_N.BREAK
  NEXT
  FN.RTN thm$[i]
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_LOAD_THEME(e$)
  IF GW_THEME_INDEX(e$)=0 % Throw an error
    e$="Illegal GW theme: '"+e$+"'.\n"
    e$+="Should be: 'default', 'flat-ui', 'classic', 'ios', 'bootstrap', "
    e$+="'android-holo', 'square-ui', 'metro', or 'native-droid'."
    END e$
  ENDIF
  % Change 'theme' property in the global bundle
  BUNDLE.PUT 1, "gw-theme", LOWER$(e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_UNLOAD_THEME()
  % Reset theme to default
  FN.RTN GW_LOAD_THEME("default")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_THEME_EXISTS(e$) % Return true|false depending if theme's full set of files exist on device
  idx=GW_THEME_INDEX(e$)
  IF idx THEN FN.RTN GW_THEME_FILES_EXIST(idx) ELSE FN.RTN 0
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_THEME_FILES_EXIST(theme) % (internal) Check existence of theme #theme (full set of files) on the device
  BUNDLE.GET 1, "gw-theme-" + INT$(theme) + "-files", allfiles$
  SPLIT file$[], allfiles$, ","
  ARRAY.LENGTH nfiles, file$[]
  exists=1
  FOR i=1 TO nfiles
    file$=TRIM$(file$[i])
    IF IS_APK() THEN MAKE_SURE_IS_ON_SD("GW/" + file$) % in APK mode: if theme file is not on sdcard, copy it from assets
    FILE.EXISTS fe, "GW/" + file$ % is the theme file in the new 'GW' subfolder?
    IF !fe
      FILE.EXISTS fe, file$ % if no is it at the old place?
      IF fe     % yes -> move it!
        MAKE_FULL_PATH("GW/" + file$)
        FILE.RENAME file$, "GW/" + file$
        IF IS_IN("/", file$) THEN DEL_FULL_PATH(file$) % remove old folder hierarchy if possible (and if it's not the data/ root)
      ENDIF
    ENDIF
    exists *= fe
  NEXT
  FN.RTN exists
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_THEME_CSS$(e$) % (internal) Return path to main .css file for a desired theme
  IF e$="default" THEN FN.RTN "jquery.mobile-1.4.5.min.css"
  IF e$="classic" THEN FN.RTN "theme-classic.css"
  IF e$="flat-ui" THEN FN.RTN "flatui/jquery.mobile.flatui.css"
  IF e$="ios" THEN FN.RTN "ios/ios.css"
  IF e$="bootstrap" THEN FN.RTN "bootstrap/Bootstrap.min.css"
  IF e$="android-holo" THEN FN.RTN "android-holo/android-holo-light.min.css"
  IF e$="square-ui" THEN FN.RTN "squareui/jquery.mobile.squareui.min.css"
  IF e$="metro" THEN FN.RTN "metro/jquery.mobile.metro.theme.css"
  IF IS_IN("native-droid", e$)=1 THEN FN.RTN "nativedroid/jquerymobile.nativedroid.css"
  FN.RTN "" % any other case=illegal theme
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% FUNCTION TO CREATE A NEW GW PAGE
%---------------------------------------------------------------------------------------------
FN.DEF GW_NEW_PAGE() % Return an index (<0)to a new GW page
  script$="<script>"
  % Script to solve gray circle issue for Android System WebView > 44.0.2403.117
  script$+="$(document).bind('mobileinit',function(){$.mobile.changePage.defaults.changeHash=false;"
  script$+="$.mobile.hashListeningEnabled=false;$.mobile.pushStateEnabled=false;});"
  script$+="$(document).ready(function(){"
  FILE.EXISTS fe, "GW_debug"
  IF fe % Script to debug elements by long-pressing on them
    script$+="var c0=performance.now();(function($){$.fn.desc=function(){var t=$(this).get(0).tagName.toLowerCase();"
    script$+="var i=' id="+CHR$(34)+"'+$(this).attr('id')+'"+CHR$(34)+"';if(i.indexOf('undefined')>0)i='';"
    script$+="var c=' class="+CHR$(34)+"'+$(this).attr('class')+'"+CHR$(34)+"';if(c.indexOf('undefined')>0)c='';"
    script$+="return '<'+t+i+c+'>';};})(jQuery);"
    script$+="$('*').bind('taphold',function(){if(performance.now()-c0>1000){var e='Element:\\n'+$(this).desc()+'\\n\\n';"
    script$+="var p='Parent:\\n'+$(this).parent().desc()+'\\n\\n';var c='Child:\\n'+$(this).children().eq(0).desc();"
    script$+="var ci='';if(e.indexOf('id=')<0 && p.indexOf('id=')<0)ci='\\n\\nClosest id:\\n'+$(this).closest('[id]').desc();"
    script$+="if (confirm(e+p+c+ci+'\\n\\nSee more?')){var gp='Grandparent:\\n'+$(this).parent().parent().desc()+'\\n\\n';"
    script$+="var c2='2nd child:\\n'+$(this).children().eq(1).desc();alert(gp+c2);};c0=performance.now();}});"
  ENDIF
  % Script to prevent input controls to be hidden by soft keyboard when being edited (except for dialogs)
  BUNDLE.GET 1, "gw-zoom-input", zoom
  IF zoom
    script$+="function scrollTop(h){$('#btmpad').css('height',$.mobile.getScreenHeight()/2);$('html,body').animate({scrollTop:h-70},500);};"
    script$+="$('input,textarea').bind('focus',function(){if(0==$(this).parents('.ui-popup').length && $(this).attr('type')!='submit'){"
    script$+="scrollTop($(this).offset().top);}});$('input,textarea').bind('blur',function(){$('#btmpad').css('height',0);});"
    script$+="$(document).delegate('.ui-slider-input','focus',function(){scrollTop($(this).offset().top);});"
    script$+="$(document).delegate('.ui-slider-input','blur',function(){$('#btmpad').css('height',0);});"
  ENDIF
  % Script to force SELECTBOX to fire 'change' event when re-selecting current option
  script$+="$(document).delegate('.ui-selectmenu li','vmousedown',function(){"
  script$+="if($(this).attr('aria-selected')=='true'){var e=$(this).closest('[id]').attr('id');"
  script$+="e=e.substr(0,e.indexOf('-'));$('#'+e).trigger('change');}});"
  script$+="});</script>"
  % Check presence of theme CSS and load it
  BUNDLE.GET 1, "gw-theme", theme$
  GW_CHECK_THEME(theme$)
  css$=GW_THEME_CSS$(theme$)
  % Build beginning of HTML string
  e$ ="<html>"
  e$+="<head>"
  e$+="<meta charset='ISO-8859-2'>"
  e$+="<meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no'>"
  e$+="<style>body .ui-header .ui-title, .ui-footer .ui-title {margin-left:0; margin-right:0}</style>"
  % The following themes need another CSS to work
  IF theme$="ios"
    e$+="<link rel='stylesheet' href='GW/ios/jquery.mobile-1.2.0.min.css' />"
    e$+="<link rel='stylesheet' href='GW/"+css$+"' />"
    e$+="<script src='GW/ios/jquery-1.7.1.min.js'></script>"
    e$+=script$+"<script src='GW/ios/jquery.mobile-1.2.0.min.js'></script>"
  ELSEIF theme$="android-holo"
    e$+="<link rel='stylesheet' href='GW/"+css$+"' />"
    e$+="<link rel='stylesheet' href='GW/android-holo/jquery.mobile.structure-1.1.0.min.css' />"
    e$+="<script src='GW/android-holo/jquery-1.7.1.min.js'></script>"
    e$+=script$+"<script src='GW/android-holo/jquery.mobile-1.1.0.min.js'></script>"
  ELSEIF theme$="metro"
    e$+="<link rel='stylesheet' href='GW/"+css$+"' />"
    e$+="<link rel='stylesheet' href='GW/metro/jquery.mobile.structure-1.1.0.min.css' />"
    e$+="<script src='GW/metro/jquery-1.7.1.min.js'></script>"
    e$+="<script src='GW/metro/jquery.mobile.metro.theme.init.js'></script>"
    e$+=script$+"<script src='GW/metro/jquery.mobile-1.1.0.min.js'></script>"
  ELSEIF IS_IN("native-droid", theme$)=1
    e$=LEFT$(e$, IS_IN("<style>", e$)-1) % remove the titlebar/footbar null-margin constraint
    e$+="<link rel='stylesheet' href='GW/nativedroid/font-awesome.min.css' />"
    e$+="<link rel='stylesheet' href='GW/nativedroid/jquery.mobile-1.4.2.min.css' />"
    e$+="<link rel='stylesheet' href='GW/"+css$+"' />"
    IF IS_IN("-dark-", theme$)
      e$+="<link rel='stylesheet' href='GW/nativedroid/jquerymobile.nativedroid.dark.css' />"
    ELSE
      e$+="<link rel='stylesheet' href='GW/nativedroid/jquerymobile.nativedroid.light.css' />"
    ENDIF
    IF IS_IN("-green", theme$)
      e$+="<link rel='stylesheet' href='GW/nativedroid/jquerymobile.nativedroid.color.green.css' />"
    ELSEIF IS_IN("-purple", theme$)
      e$+="<link rel='stylesheet' href='GW/nativedroid/jquerymobile.nativedroid.color.purple.css' />"
    ELSEIF IS_IN("-red", theme$)
      e$+="<link rel='stylesheet' href='GW/nativedroid/jquerymobile.nativedroid.color.red.css' />"
    ELSEIF IS_IN("-yellow", theme$)
      e$+="<link rel='stylesheet' href='GW/nativedroid/jquerymobile.nativedroid.color.yellow.css' />"
    ELSE
      e$+="<link rel='stylesheet' href='GW/nativedroid/jquerymobile.nativedroid.color.blue.css' />"
    ENDIF
    e$+="<script src='GW/nativedroid/jquery-1.9.1.min.js'></script>"
    e$+=script$+"<script src='GW/nativedroid/jquery.mobile-1.4.2.min.js'></script>"
  ELSEIF theme$<>"default" THEN
    GW_CHECK_THEME("default")
    e$+="<link rel='stylesheet' href='GW/"+GW_THEME_CSS$("default")+"' />"
  ENDIF
  % Embed the correct JQM JavaScript
  IF theme$<>"ios" & theme$<>"android-holo" & theme$<>"metro" & !IS_IN("native-droid", theme$)
    e$+="<link rel='stylesheet' href='GW/"+css$+"' />"
    e$+="<script src='GW/jquery-2.1.1.min.js'></script>"
    e$+=script$+"<script src='GW/jquery.mobile-1.4.5.min.js'></script>"
  ENDIF
  e$+="<script>$(document).bind('mobileinit', function(){$.mobile.activeBtnClass='unused';});"
  IF theme$="ios" | theme$="android-holo" | theme$="metro"
    e$+="$('.ui-dialog button').live('click', function(){$('[data-role=dialog]').dialog().dialog('close');});"
    e$+="$(document).on('vclick','[data-rel=back]',function(e){e.stopImmediatePropagation();e.preventDefault();var href=$(this).attr('href');window.location.href=href;});"
    e$=REPLACE$(e$, "</style>", " .ui-listview sup{font-size:0.6em;color:#cc0000;} .ios-dlg{color:#fff;text-shadow:0 -1px 0 #4c596a}</style>")
    e$=REPLACE$(e$, "</style>", " .ui-listview sup{font-size:0.6em;color:#cc0000;} .ios-dlg{color:#fff;text-shadow:0 -1px 0 #4c596a}</style>")
  ENDIF
  e$+="function populate(my_id,my_txt){document.getElementById(my_id).innerHTML=my_txt;} "
  e$+="function RFO(data){Android.dataLink(data);} "
  e$+="function replace(ctlid, tag){var obj=document.getElementById(ctlid); var regex=new RegExp('<'+obj.tagName,'i'); var newTag=obj.outerHTML.replace(regex,'<'+tag); regex=new RegExp('</'+obj.tagName,'i'); newTag=newTag.replace(regex,'</'+tag); obj.outerHTML=newTag;}</script>"
  e$+="</head><body>"
  % Add the page to the list of GW pages
  ls=GW_KEY_IDX("page") + 1 % The 3 following calls to GW_THEME_CUSTO$() do NOT reset GW_USE_THEME_CUSTO_ONCE token
  e$+="<div data-role='page' id='page0' "+GW_THEME_CUSTO$("page")+"></div>"
  e$+="<div data-role='page' id='page"+INT$(ls)+"' "+GW_THEME_CUSTO$("page")+">"
  e$+="<div data-role='content' id='content"+INT$(ls)+"' "+GW_THEME_CUSTO$("content")+">"
  GW_ADD_SKEY("page", e$)
  BUNDLE.GET 1, "gw-default-page-transition", dpt$
  GW_ADD_SKEY("transition", dpt$) % fade|pop|flip|turn|flow|slidefade|slide|slideup|slidedown|none
  BUNDLE.PUT 1, "gw-last-edited-page", -ls
  FN.RTN -ls % index to a PAGE is < 0 to differentiate from indexes to CONTROLs
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% FUNCTIONS TO TRANSFORM PAGE - TO BE INSERTED BEFORE CONTENT
%---------------------------------------------------------------------------------------------
FN.DEF GW_INSERT_BEFORE(page, main$, ins$) % (internal) insert element before another (content, head...)
  e$=GW_PAGE$(page) % each command calling GW_INSERT_BEFORE() must have REGISTERED its name
  sens=1 : IF IS_IN("^", main$)=1 THEN sens=-1 : main$=MID$(main$, 2)
  i=IS_IN(main$, e$, sens)
  IF !i THEN FN.RTN 0
  e$=LEFT$(e$, i-1) + ins$ + MID$(e$, i)
  GW_SET_SKEY("page", page, e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_PREVENT_SELECT(page)
  GW_REGISTER("GW_PREVENT_SELECT")
  e$=GW_PAGE$(page)
  IF IS_IN("body{-webkit-user-select:none}", e$) THEN FN.RTN 1
  i=IS_IN("<style>", e$)
  IF !i THEN FN.RTN 0
  i+= LEN("<style>")
  e$=LEFT$(e$, i-1) + "body{-webkit-user-select:none} " + MID$(e$, i)
  GW_SET_SKEY("page", page, e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ALLOW_SELECT(page)
  GW_REGISTER("GW_ALLOW_SELECT")
  e$=GW_PAGE$(page)
  GW_SET_SKEY("page", page, REPLACE$(e$, "body{-webkit-user-select:none} ", ""))
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_USE_FONT(page, fnt$)
  IF IS_APK() THEN MAKE_SURE_IS_ON_SD(fnt$) % in APK mode: if font file is not on sdcard, copy it from assets
  i=IS_IN("/", fnt$, -1)
  IF i THEN ff$=MID$(fnt$, i+1) ELSE ff$=fnt$
  i=IS_IN(".", ff$)
  IF i THEN ff$=LEFT$(ff$, i-1)
  ff$=REPLACE$(ff$, " ", "")
  ins$="<style>@font-face{"
  ins$+=" font-family:'"+ff$+"';"
  ins$+=" src: url('"+fnt$+"');"
  ins$+="} body,.ui-btn{font-family:"+ff$+";}</style>"
  GW_REGISTER("GW_USE_FONT")
  FN.RTN GW_INSERT_BEFORE(page, "</head>", ins$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_TRANSITIONS_PARSE(all$, elt$)
  i=IS_IN(elt$+"=", all$)
  IF !i THEN FN.RTN 0
  i += LEN(elt$+"=")
  j=IS_IN(",", all$, i)
  IF !j THEN j=LEN(all$)+1
  fx$=MID$(all$, i, j-i)
  BUNDLE.PUT 1, "gw-default-"+elt$+"-transition", fx$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_DEFAULT_TRANSITIONS(fxs$) % set default transitions: fx$="page=fx, panel=fx, dialog_message=fx"
  e$=LOWER$(REPLACE$(fxs$, " ", ""))
  e$=REPLACE$(e$, "dialog_message", "dlg")
  e$=REPLACE$(e$, "dialog_input", "dlg")
  e$=REPLACE$(e$, "dialog_checkbox", "dlg")
  e$=REPLACE$(e$, "dialog", "dlg")
  GW_TRANSITIONS_PARSE(e$, "page")
  GW_TRANSITIONS_PARSE(e$, "panel")
  GW_TRANSITIONS_PARSE(e$, "dlg")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SET_TRANSITION(ctl_id, fx$) % set transition of PAGE, DIALOG or PANEL (during build or after render)
  IF ctl_id=0
    END "Bad page id or control id: '0' in command GW_SET_TRANSITION().\nUndefined id."
  ELSEIF ctl_id < 0 % Transition of a PAGE
    page=ABS(ctl_id)
    ls=GW_KEY_IDX("page")
    IF page > ls
      e$="Bad page id: '"+INT$(page)+"' in command GW_SET_TRANSITION().\n"
      e$+="Out of range (last page id is '-"+INT$(ls)+"')."
      END e$
    ENDIF
    GW_SET_SKEY("transition", page, fx$) % register transition of PAGE. It will be used in GW_RENDER()
    FN.RTN 1 % done -> exit function
  ENDIF
  % Else get Unique IDentifier of the control (PANEL or DIALOG)
  GW_REGISTER("GW_SET_TRANSITION")
  ctl$=GW_ID$(ctl_id)
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page % setting transition needs an existing page
    page$=GW_PAGE$(page) % 'page' is sure to exist -> no need to REGISTER command
    IF IS_IN("</html>", page$) % page already rendered -> modify transition via dynamic javascript
      IF IS_IN("panel", ctl$)=1 % PANEL
        JS("$('#"+ctl$+"').panel({display:'"+fx$+"'})")
      ELSE % DIALOG
        JS("var effect"+ctl$+"='"+fx$+"'")
      ENDIF
    ELSE % page under construction -> set transition via static html
      IF IS_IN("panel", ctl$)=1 % PANEL
        i=IS_IN("id='"+ctl$, page$)
        i=IS_IN("data-display='", page$, i) + LEN("data-display=")
        j=IS_IN("'", page$, i+1)
        page$=LEFT$(page$, i) + fx$ + MID$(page$, j)
        GW_SET_SKEY("page", page, page$)
      ELSE % DIALOG
        i=IS_IN("effect"+ctl$+"='", page$)
        IF i % existing transition -> modify it
          i+=LEN("effect"+ctl$+"=")
          j=IS_IN("'", page$, i+1)
          page$=LEFT$(page$, i) + fx$ + MID$(page$, j)
          GW_SET_SKEY("page", page, page$)
        ELSE % newly set transition -> create it
          script$="<script>var effect"+ctl$+"='"+fx$+"'</script>"
          GW_INSERT_BEFORE(page, "<div", script$) % 'page' is sure to exist -> no need to REGISTER command
        ENDIF % /transition of new/existing dialog
      ENDIF % /panel/dialog
    ENDIF % /page already-rendered/under-construction
  ENDIF % /last-edited-page exists
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CUSTO_DLGBTN(page, dlg, btn$, custo$)
  i=IS_IN(">", btn$) : IF i THEN btn$=LEFT$(btn$, i-1)
  custo$=LOWER$(custo$)
  IF IS_IN("icon=", custo$) & !IS_IN("iconpos", custo$) ~
    & !IS_IN("notext", custo$) THEN custo$="iconpos=left "+custo$
  GW_REGISTER("GW_CUSTO_DLGBTN")
  e$=GW_PAGE$(page)
  i=IS_IN("id='"+GW_ID$(dlg), e$) : IF 0=i THEN FN.RTN 0
  i=IS_IN("'>"+WEB$(btn$)+"<", e$, i) : IF 0=i THEN FN.RTN 0
  j=IS_IN("class='", e$, i-LEN(e$)) : IF 0=j THEN FN.RTN 0
  j=IS_IN("'", e$, j+LEN("class='"))
  GW_USE_THEME_CUSTO_ONCE(custo$)
  e$=LEFT$(e$, j-1) + " " + GW_THEME_CUSTO$("hfbtn") + MID$(e$, j)
  GW_SET_SKEY("page", page, e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_DIALOG$(ctl_id) % BUTTON link to display a DIALOG (MESSAGE/INPUT/CHECKBOX)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_SHOW_DIALOG$")
  ctl$=GW_ID$(ctl_id)
  FN.RTN "#"+ctl$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_DIALOG_MESSAGE$(ctl_id) % legacy
  FN.RTN GW_SHOW_DIALOG$(ctl_id)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_DIALOG_INPUT$(ctl_id) % legacy
  FN.RTN GW_SHOW_DIALOG$(ctl_id)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_DIALOG(ctl_id) % manually trigger a DIALOG (MESSAGE/INPUT/CHECKBOX)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_SHOW_DIALOG")
  ctl$=GW_ID$(ctl_id)
  BUNDLE.GET 1, "gw-last-rendered-page", page
  IF page THEN theme$=GW_THEME_OF_PAGE$(page)
  IF theme$="ios" | theme$="android-holo" | theme$="metro"
    JS("$('#show"+ctl$+"')[0].click()")
  ELSE
    JS("$('#"+ctl$+"').popup('open',{transition:effect"+ctl$+"})")
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_DIALOG_MESSAGE(ctl_id) % legacy
  FN.RTN GW_SHOW_DIALOG(ctl_id)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_DIALOG_INPUT(ctl_id) % legacy
  FN.RTN GW_SHOW_DIALOG(ctl_id)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_DIALOG(ctl_id) % manually close a DIALOG (MESSAGE/INPUT/CHECKBOX)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_CLOSE_DIALOG")
  ctl$=GW_ID$(ctl_id)
  JS("$('#"+ctl$+"').popup('close',{transition:effect"+ctl$+"})")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_DIALOG_MESSAGE(ctl_id) % legacy
  FN.RTN GW_CLOSE_DIALOG(ctl_id)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_DIALOG_INPUT(ctl_id) % legacy
  FN.RTN GW_CLOSE_DIALOG(ctl_id)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEW_DLG_BTN$(btn_axn$[], hor_btns) % (internal) for DIALOGs (MESSAGE/INPUT/CHECKBOX)
  ARRAY.LENGTH al, btn_axn$[]
  FOR i=1 TO al
    k=IS_IN(">", btn_axn$[i], -1)
    IF !k THEN k=LEN(btn_axn$[i])+1
    bt$=WEB$(LEFT$(btn_axn$[i], k-1))
    ax$=MID$(btn_axn$[i], k+1)
    IF IS_IN("#dlg", ax$)=1 % chaining popups
      v$="show"+MID$(ax$,2) % js one-time variable
      script$="javascript:var "+v$+"=1;"
      script$+="$(&quot;[data-role=popup]&quot;).on(&quot;popupafterclose&quot;,function(){"
      script$+="if("+v$+"){"+v$+"=0;"
      script$+="$(&quot;"+ax$+"&quot;).popup(&quot;open&quot;"
      script$+=",{transition:effect"+MID$(ax$,2)
      script$+="});}})' data-ajax='false"
      ax$=script$
    ELSE % any other (normal) link
      ax$=WEB$(GW_FORMAT_LINK$(ax$))
    ENDIF
    BUNDLE.GET 1, "gw-last-edited-page", page
    IF page THEN theme$=GW_THEME_OF_PAGE$(page)
    IF theme$="ios" | theme$="android-holo" | theme$="metro"
      e$+="<button class='' href='#' onclick='"+ax$+"'>"+bt$+"</button>"
    ELSE
      e$+="<a class='ui-btn ui-corner-all ui-shadow"
      IF hor_btns THEN e$+=" ui-btn-inline"
      e$+="' href='#' data-rel='back' onclick='"+ax$+"'>"+bt$+"</a>"
    ENDIF
  NEXT
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEW_DLG_TITLE$(title$) % (internal) for DIALOGs (MESSAGE/INPUT/CHECKBOX)
  IF title$="" THEN FN.RTN ""
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page THEN theme$=GW_THEME_OF_PAGE$(page)
  IF theme$="ios" | theme$="android-holo" | theme$="metro"
    FN.RTN "<h2>"+WEB$(title$)+"</h2>"
  ELSE
    FN.RTN "<div data-role='header' style='padding:10px'><h1>"+WEB$(title$)+"</h1></div>"
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_DIALOG_MESSAGE$(title$, msg$, btn_axn$[])
  % Create the control
  u$=GW_NEWID$("dlgmsg")
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page THEN theme$=GW_THEME_OF_PAGE$(page)
  custo$=GW_THEME_CUSTO$("dlgmsg")
  hor=IS_IN("inline", LOWER$(custo$)) % CUSTO 'inline' means horizontal buttons, else vertical buttons
  IF hor THEN custo$=LEFT$(custo$,hor-1)+MID$(custo$,hor+6)
  IF theme$="ios" | theme$="android-holo" | theme$="metro"
    e$="<div data-role='dialog' id='"+u$+"' "+custo$+"><div data-role='content'>"
    e$+="<div id='"+u$+"-title' class='ios-dlg'>"+GW_NEW_DLG_TITLE$(title$)+"</div>"
    e$+="<h4 id='"+u$+"-text' class='ios-dlg'>"+WEB$(msg$)+"</h4>"
    e$+="<div id='"+u$+"-buttons'>"+GW_NEW_DLG_BTN$(btn_axn$[], hor)+"</div>"
    e$+="</div></div>" % <!--/content--><!--/dialog-->
    e$+="<a hidden id='show"+u$+"' href='"+GW_FORMAT_LINK$("#"+u$)+"'></a>"
  ELSE
    e$="<div data-role='popup' id='"+u$+"' data-dismissible='false' "+custo$+">"
    e$+="<div id='"+u$+"-title'>"+GW_NEW_DLG_TITLE$(title$)+"</div>"
    e$+="<div role='main' class='ui-content'><h3 id='"+u$+"-text' class='ui-title'>"+WEB$(msg$)+"</h3>"
    e$+="<div id='"+u$+"-buttons' style='margin:0 auto; text-align:center;'>"+GW_NEW_DLG_BTN$(btn_axn$[], hor)+"</div>"
    e$+="</div></div>" % <!--/main--><!--/popup-->
  ENDIF
  % Create the default control transition
  IF page % setting transition needs an existing page (being built since user calls GW_ADD_*)
    BUNDLE.GET 1, "gw-default-dlg-transition", ddt$
    script$="<script>var effect"+u$+"='"+ddt$+"'</script>" % fade|pop|flip|turn|flow|slidefade|slide|slideup|slidedown|none
    GW_INSERT_BEFORE(page, "<div", script$) % 'page' is sure to exist -> no need to REGISTER the command
  ENDIF
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_DIALOG_MESSAGE(page, title$, msg$, btn_axn$[])
  % Add to the page before page-content
  GW_REGISTER("GW_ADD_DIALOG_MESSAGE")
  ctl$=GW_ADD_DIALOG_MESSAGE$(title$, msg$, btn_axn$[])
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page THEN theme$=GW_THEME_OF_PAGE$(page)
  IF theme$="ios" | theme$="android-holo" | theme$="metro"
    GW_INSERT_BEFORE(page, "^<div data-role='page'", ctl$)
  ELSE
    GW_INSERT_BEFORE(page, "<div data-role='content'", ctl$)
  ENDIF
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_DIALOG_INPUT$(title$, msg$, inpu$, btn_axn$[])
  % Create the control
  u$=GW_NEWID$("dlginp")
  custo$=GW_THEME_CUSTO$("dlginp")
  hor=IS_IN("inline", LOWER$(custo$)) % CUSTO 'inline' means horizontal buttons, else vertical buttons
  IF hor THEN custo$=LEFT$(custo$,hor-1)+MID$(custo$,hor+6)
  typ$="text" % by default
  IF MID$(inpu$,2,1)=">" % input type: "0>"|"1>"=number ; "*>"=password ; "@>"=email ; "<>"=url
    cod$=LEFT$(inpu$,1)
    IF cod$="0" | cod$="1" THEN typ$="number"
    IF cod$="*" THEN typ$="password"
    IF cod$="@" THEN typ$="email"
    IF cod$="<" THEN typ$="url"
    inpu$=MID$(inpu$,3)
  ENDIF
  e$="<div data-role='popup' id='"+u$+"' data-dismissible='false' "+custo$+">"
  e$+="<div id='"+u$+"-title'>"+GW_NEW_DLG_TITLE$(title$)+"</div>"
  e$+="<div role='main' class='ui-content'><h3 id='"+u$+"-text' class='ui-title'>"+WEB$(msg$)+"</h3>"
  e$+="<input id='"+u$+"-input' value='"+inpu$+"' type='"+typ$+"'>"
  e$+="<div id='"+u$+"-buttons' style='margin:0 auto; text-align:center;'>"
  e$+=GW_NEW_DLG_BTN$(btn_axn$[], hor)
  e$+="</div></div></div>" % <!--/buttons--><!--/main--><!--/popup-->
  % Position input popup at top of screen + focus in input field
  e$+="<style>#"+u$+"-popup{top:10px !important;bottom:auto !important; position:fixed}</style>"
  e$+="<script>$('#"+u$+"').on('popupafteropen',function(){$('#"+u$+"-input').focus();})</script>"
  % Create the default control transition
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page % setting transition needs an existing page (being built since user calls GW_ADD_*)
    BUNDLE.GET 1, "gw-default-dlg-transition", ddt$
    script$="<script>var effect"+u$+"='"+ddt$+"'</script>" % fade|pop|flip|turn|flow|slidefade|slide|slideup|slidedown|none
    GW_INSERT_BEFORE(page, "<div", script$) % 'page' is sure to exist -> no need to REGISTER the command
  ENDIF
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_DIALOG_INPUT(page, title$, msg$, inpu$, btn_axn$[])
  % Add to the page
  ctl$=GW_ADD_DIALOG_INPUT$(title$, msg$, inpu$, btn_axn$[])
  GW_REGISTER("GW_ADD_DIALOG_INPUT")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + ctl$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_DIALOG_CHECKBOX$(title$, msg$, chk_lbl$, btn_axn$[])
  % Create the control
  u$=GW_NEWID$("dlgchk")
  custo$=GW_THEME_CUSTO$("dlgchk")
  hor=IS_IN("inline", LOWER$(custo$)) % CUSTO 'inline' means horizontal buttons, else vertical buttons
  IF hor THEN custo$=LEFT$(custo$,hor-1)+MID$(custo$,hor+6)
  e$="<div data-role='popup' id='"+u$+"' data-dismissible='false' "+custo$+">"
  e$+="<div id='"+u$+"-title'>"+GW_NEW_DLG_TITLE$(title$)+"</div>"
  e$+="<div role='main' class='ui-content'><h3 id='"+u$+"-text' class='ui-title'>"+WEB$(msg$)+"</h3>"
  r$=WEB$(chk_lbl$)
  IF LEFT$(r$,1)=">"
    checked$="checked='' "
    r$=MID$(r$,2)
  ENDIF
  IF LEN(r$) THEN e$+="<label id='"+u$+"-lbl' for='"+u$+"-chk'>"+r$+"</label>"
  e$+="<input name='"+u$+"-chk' id='"+u$+"-chk' "+checked$+" type='checkbox' />"
  e$+="<div id='"+u$+"-buttons' style='margin:0 auto; text-align:center;'>"
  e$+=GW_NEW_DLG_BTN$(btn_axn$[], hor)
  e$+="</div></div></div>" % <!--/buttons--><!--/main--><!--/popup-->
  % Create the default control transition
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page % setting transition needs an existing page (being built since user calls GW_ADD_*)
    BUNDLE.GET 1, "gw-default-dlg-transition", ddt$
    script$="<script>var effect"+u$+"='"+ddt$+"'</script>" % fade|pop|flip|turn|flow|slidefade|slide|slideup|slidedown|none
    GW_INSERT_BEFORE(page, "<div", script$) % 'page' is sure to exist -> no need to REGISTER the command
  ENDIF
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_DIALOG_CHECKBOX(page, title$, msg$, chk_lbl$, btn_axn$[])
  % Add to the page before page-content
  ctl$=GW_ADD_DIALOG_CHECKBOX$(title$, msg$, chk_lbl$, btn_axn$[])
  GW_REGISTER("GW_ADD_DIALOG_CHECKBOX")
  GW_INSERT_BEFORE(page, "<div data-role='content'", ctl$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BAR_TITLE$(e$) % for TITLEBAR and FOOTBAR
  FN.RTN "<h1 id='-title'>"+WEB$(e$)+"</h1>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BAR_BTN$(ba$, type$) % (internal) for TITLEBAR and FOOTBAR (type$="left"|"right")
  k=IS_IN(">", ba$, -1)
  IF 0=k THEN k=LEN(ba$)+1
  bt$=WEB$(LEFT$(ba$, k-1))
  ax$=GW_FORMAT_LINK$(MID$(ba$, k+1))
  cs$=GW_THEME_CUSTO$("hfbtn")
  IF !IS_IN("ui-btn-icon-", cs$) THEN cs$+=" ui-btn-icon-left"
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page THEN theme$=GW_THEME_OF_PAGE$(page)
  IF theme$="ios" | theme$="android-holo" | theme$="metro"
    e$="<a "+cs$+" "
  ELSE
    e$="<a class='ui-btn-"+type$+" ui-btn ui-corner-all ui-shadow "
    e$+="ui-btn-inline ui-mini "+cs$+"' "
  ENDIF
  e$+="id='-"+LEFT$(type$,1)+"button' href='"+ax$+"'>"+bt$+"</a>" % id will become title|footbar1-lbutton|rbutton
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BAR_LBUTTON$(ba$) % for TITLEBAR and FOOTBAR
  FN.RTN GW_ADD_BAR_BTN$(ba$, "left")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BAR_RBUTTON$(ba$) % for TITLEBAR and FOOTBAR
  FN.RTN GW_ADD_BAR_BTN$(ba$, "right")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BAR_MENU$(bna$[], type$) % (internal) for TITLEBAR and FOOTBAR (type$="left"|"right")
  e$="<div data-role='fieldcontain' style='position:absolute;top:-3px;"+type$+":0;margin:0;padding:0'>"
  e$+="<select id='-"+LEFT$(type$,1)+"menu' data-native-menu='false'" % id will become title|footbar1-lmenu|rmenu
  e$+=GW_THEME_CUSTO$("selectbox")+" data-mini='true' data-inline='true'>"
  e$+=GW_NEW_OPT$(bna$[])
  e$+="</select></div>" % <!--/fieldcontain-->
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BAR_LMENU$(bna$[]) % for TITLEBAR and FOOTBAR
  FN.RTN GW_ADD_BAR_MENU$(bna$[], "left")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BAR_RMENU$(bna$[]) % for TITLEBAR and FOOTBAR
  FN.RTN GW_ADD_BAR_MENU$(bna$[], "right")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TITLEBAR$(content$)
  % Create the control
  u$=GW_NEWID$("titlebar")
  e$="<div data-role='header' data-position='fixed' data-tap-toggle='false' "+GW_THEME_CUSTO$("titlebar")+">"
  IF LEFT$(content$, 1)="<"
    e$+=REPLACE$(content$,"id='","id='"+u$)
  ELSE
    e$=e$+"<h1 id='"+u$+"-title'>"+WEB$(content$)+"</h1>"
  ENDIF
  e$+="</div>"
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TITLEBAR(page, content$)
  % Add to the page before page-content
  GW_REGISTER("GW_ADD_TITLEBAR")
  GW_INSERT_BEFORE(page, "^<div data-role='content'", GW_ADD_TITLEBAR$(content$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_FOOTBAR$(content$)
  % Create the control
  u$=GW_NEWID$("footbar")
  e$="<div data-role='footer' data-position='fixed' data-tap-toggle='false' "+GW_THEME_CUSTO$("footbar")+">"
  IF LEFT$(content$, 1)="<"
    e$+=REPLACE$(content$,"id='","id='"+u$)
  ELSE
    e$=e$+"<h1 id='"+u$+"-title'>"+WEB$(content$)+"</h1>"
  ENDIF
  e$+="</div>"
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_FOOTBAR(page, content$)
  % Add to the page before page-content
  GW_REGISTER("GW_ADD_FOOTBAR")
  GW_INSERT_BEFORE(page, "<div data-role='content'", GW_ADD_FOOTBAR$(content$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_PANEL$(content$)
  % First format the default text, if any
  IF LEFT$(content$, 1)<>"<" THEN ini$="<p>"+content$+"</p>" ELSE ini$=content$
  % Get the default control transition
  BUNDLE.GET 1, "gw-default-panel-transition", dpt$ % push|reveal|overlay
  % Create the control
  u$=GW_NEWID$("panel")
  e$="<div data-role='panel' id='"+u$+"' data-display='"+dpt$+"' "
  e$+=GW_THEME_CUSTO$("panel")+">"+WEB$(ini$)+"</div>" % <!--/panel-->
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_PANEL(page, content$)
  % Add to the page before page-content
  ctl$=GW_ADD_PANEL$(content$)
  GW_REGISTER("GW_ADD_PANEL")
  GW_INSERT_BEFORE(page, "<div data-role='content'", ctl$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_PANEL$(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_SHOW_PANEL$")
  ctl$=GW_ID$(ctl_id)
  FN.RTN "#"+ctl$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_PANEL(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_SHOW_PANEL")
  ctl$=GW_ID$(ctl_id)
  JS("$('#"+ctl$+"').panel('open')")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_PANEL(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_CLOSE_PANEL")
  ctl$=GW_ID$(ctl_id)
  JS("$('#"+ctl$+"').panel('toggle')")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% FUNCTIONS TO VISUALLY CHANGE CONTROLS LAYOUTS BEFORE ADDING THEM
%---------------------------------------------------------------------------------------------
FN.DEF GW_START_CENTER$()
  FN.RTN "<div style='margin:0 auto; text-align:center;'>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_START_CENTER(page)
  % Add the center div to the page
  GW_REGISTER("GW_START_CENTER")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_START_CENTER$())
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_STOP_CENTER$()
  FN.RTN "</div>" % <!--/center-->
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_STOP_CENTER(page)
  GW_REGISTER("GW_STOP_CENTER")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_STOP_CENTER$())
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CENTER_PAGE_VER$(page)
  e$="<script>$(document.body).on('pageshow',function(e,ui){"
  e$+="$('#content"+INT$(ABS(page))+"').css('margin-top',("
  e$+="$(window).height()-$('[data-role=header]').height()"
  e$+="-$('[data-role=footer]').height()-$('#content"+INT$(ABS(page))+"').outerHeight()"
  e$+=")/2);});</script>"
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CENTER_PAGE_VER(page)
  GW_REGISTER("GW_CENTER_PAGE_VER")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_CENTER_PAGE_VER$(page))
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_OPEN_GROUP$() % for CHECKBOX or RADIO controls
  FN.RTN "<fieldset data-role='controlgroup' "+GW_THEME_CUSTO$("group")+">"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_OPEN_GROUP(page)
  % Add the group to the page
  GW_REGISTER("GW_OPEN_GROUP")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_OPEN_GROUP$()
  GW_SET_SKEY("page", page, e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_GROUP$()
  FN.RTN "</fieldset>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_GROUP(page)
  GW_REGISTER("GW_CLOSE_GROUP")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_CLOSE_GROUP$())
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_OPEN$()
  % Create the control
  u$=GW_NEWID$("shelf")
  e$="<table id='"+u$+"' style='width:100%'>"
  e$+="<thead></thead><tbody><tr><td "+GW_THEME_CUSTO$("shelf")+">"
  % Add shelf to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_OPEN(page)
  % Add the shelf to the page and return its index
  GW_REGISTER("GW_SHELF_OPEN")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_SHELF_OPEN$())
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_NEWCELL$()
  FN.RTN "</td><td "+GW_THEME_CUSTO$("shelf")+">"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_NEWCELL(page)
  GW_REGISTER("GW_SHELF_NEWCELL")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_SHELF_NEWCELL$())
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_NEWROW$()
  FN.RTN "</td></tr><tr><td "+GW_THEME_CUSTO$("shelf")+">"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_NEWROW(page)
  GW_REGISTER("GW_SHELF_NEWROW")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_SHELF_NEWROW$())
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_CLOSE$()
  FN.RTN "</td></tr></tbody></table>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHELF_CLOSE(page)
  GW_REGISTER("GW_SHELF_CLOSE")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_SHELF_CLOSE$())
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_OPEN_COLLAPSIBLE$(t$) % to expand/collapse a group of controls
  e$="<div data-role='collapsible' data-collapsed-icon='carat-r' "
  e$+="data-expanded-icon='carat-d' data-inset='false'><h2 "
  e$+=GW_THEME_CUSTO$("collapsible")+">"+WEB$(t$)+"</h2>"
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_OPEN_COLLAPSIBLE(page, t$)
  % Add the collapsible to the page
  GW_REGISTER("GW_OPEN_COLLAPSIBLE")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_OPEN_COLLAPSIBLE$(t$)
  GW_SET_SKEY("page", page, e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_COLLAPSIBLE$()
  FN.RTN "</div>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_COLLAPSIBLE(page)
  GW_REGISTER("GW_CLOSE_COLLAPSIBLE")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_CLOSE_COLLAPSIBLE$())
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% FUNCTIONS TO CREATE AND USE THEME-CUSTOMIZATIONS ON CONTROLS
%---------------------------------------------------------------------------------------------
FN.DEF GW_NEW_CLASS(class$)
  % Add the class to the list of controls and return its index
  ls=GW_ADD_SKEY("control", "." + class$)
  FN.RTN ls
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_FONT$(page, fnt$)
  IF IS_APK() THEN MAKE_SURE_IS_ON_SD(fnt$) % in APK mode: if font file is not on sdcard, copy it from assets
  i=IS_IN("/", fnt$, -1)
  IF i THEN ff$=MID$(fnt$, i+1) ELSE ff$=fnt$
  i=IS_IN(".", ff$)
  IF i THEN ff$=LEFT$(ff$, i-1)
  ff$=REPLACE$(ff$, " ", "")
  ins$="<style>@font-face{"
  ins$+=" font-family:'"+ff$+"';"
  ins$+=" src: url('"+fnt$+"');"
  ins$+="}</style>"
  GW_REGISTER("GW_ADD_FONT$")
  GW_INSERT_BEFORE(page, "</head>", ins$)
  FN.RTN ff$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEW_THEME_CUSTO(e$)
  % Add the theme customization to the list + return its index
  ls=GW_ADD_SKEY("custo", LOWER$(e$))
  FN.RTN ls
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_USE_THEME_CUSTO(custo)
  % Change 'theme-custo' properties in the global bundle
  BUNDLE.PUT 1, "gw-theme-custo", custo
  BUNDLE.PUT 1, "gw-theme-custo-token", -1 % -1=unlimited tokens=persistent theme customization
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_USE_THEME_CUSTO_ONCE(e$)
  % Add the theme-customization to the list
  custo=GW_NEW_THEME_CUSTO(e$)
  % Change 'theme-custo' properties in the global bundle
  BUNDLE.PUT 1, "gw-theme-custo", custo
  BUNDLE.PUT 1, "gw-theme-custo-token", 1 % 1 token=1-shot theme customization
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_RESET_THEME_CUSTO()
  % Change 'theme-custo' properties in the global bundle
  BUNDLE.PUT 1, "gw-theme-custo", 0
  BUNDLE.PUT 1, "gw-theme-custo-token", 0 % zero token=no customization
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_REPLACE_IN_STYLE(custo$, del$, add$) % (internal) Add a 'style' string to a theme customization
  IF !IS_IN(del$, custo$) THEN FN.RTN 0
  i=IS_IN("style='", custo$)
  IF i
    custo$=LEFT$(custo$,i+6)+add$+";"+MID$(custo$,i+7)
    custo$=REPLACE$(custo$, del$, "")
  ELSE
    custo$=REPLACE$(custo$, del$, "style='"+add$+"'")
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_THEME_CUSTO$(ctl$) % (internal) Return a formated theme customization for this control family
  BUNDLE.GET 1, "gw-theme", theme$
  BUNDLE.GET 1, "gw-theme-custo-token", tct
  IF !tct % No theme customization -> return empty string
    IF ctl$="pgbar" | ctl$="slider"
      FN.RTN "from(#5393c5),to(#6facd5)" % except for progressbars/sliders: blue gradient by default
    ELSEIF IS_IN("native-droid", theme$)=1 & IS_IN(ctl$, "page|panel|titlebar")
      FN.RTN "data-theme=b" % and except for native-droid theme=data-theme-b by default
    ELSE
      FN.RTN ""
    ENDIF
  ENDIF
  BUNDLE.GET 1, "gw-theme-custo", custo
  r$=GW_THEME$(custo) % Get the theme-customization string
  % Format it for the desired control
  IF ctl$="hfbtn" % button for TITLEBAR or FOOTBAR or DIALOG*
    r$=REPLACE$(r$, "icon=", "ui-icon-")
    r$=REPLACE$(r$, "iconpos=notext", "notext")
    r$=REPLACE$(r$, "iconpos=", "ui-btn-icon-")
    r$=REPLACE$(r$, "notext", "ui-btn-icon-notext")
    r$=REPLACE$(r$, "inline", "") % because inline by default
    r$=REPLACE$(r$, "color=", "' data-theme='")
    i=IS_IN("style='", LOWER$(r$))
    IF i THEN r$=LEFT$(r$,i-1)+"' "+REPLACE$(MID$(r$,i), "''", "'")
  ELSEIF ctl$="group" % group for checkboxes
    r$=REPLACE$(r$, "inline", "data-type='horizontal' data-mini='true'")
  ELSEIF ctl$="spinner" % spinner
    r$=REPLACE$(r$, "color=", "")
  ELSEIF ctl$="pgbar" | ctl$="slider" % progressbar and slider
    SW.BEGIN LOWER$(r$)
      SW.CASE "color=b" : r$="from(#4e9d4e),to(#5cb85c)" : SW.BREAK % 'color=b': green gradient
      SW.CASE "color=c" : r$="from(#b94743),to(#d9534f)" : SW.BREAK % 'color=c': red gradient
      SW.CASE "color=d" : r$="from(#cc9342),to(#f0ad4e)" : SW.BREAK % 'color=d': orange gradient
      SW.CASE "color=e" : r$="from(#c21e63),to(#e57eaa)" : SW.BREAK % 'color=e': pink gradient
      SW.CASE "color=f" : r$="from(#2b689c),to(#337ab7)" : SW.BREAK % 'color=f': dark blue gradient
      SW.DEFAULT : r$="from(#5393c5),to(#6facd5)" % 'color=a': blue gradient (by default)
    SW.END
  ELSE % default: all other controls
    r$=REPLACE$(r$, "color=", "data-theme=")
    r$=REPLACE$(r$, "icon=", "data-icon=")
    r$=REPLACE$(r$, "iconpos=notext", "notext")
    r$=REPLACE$(r$, "iconpos=", "data-iconpos=")
    r$=REPLACE$(r$, "position=", "data-position=")
    r$=REPLACE$(r$, "notext", "data-iconpos=notext")
    r$=REPLACE$(r$, "mini", "data-mini=true")
    IF IS_IN("dlg", ctl$)=0 THEN r$=REPLACE$(r$, "inline", "data-inline='true'")
    BUNDLE.GET 1, "gw-last-edited-page", page
    IF page % hover=X custo need an existing page for which we know if it has TITLEBAR/FOOTBAR or not
      IF IS_IN("id='titlebar", GW_PAGE$(page)) THEN top$="50px" ELSE top$="5px" % 'page' is sure to exist -> no need to REGISTER command
      IF IS_IN("id='footbar", GW_PAGE$(page)) THEN bot$="60px" ELSE bot$="5px"  % idem
      GW_REPLACE_IN_STYLE(&r$, "hover=ne", "position:fixed;top:"+top$+";right:5px")
      GW_REPLACE_IN_STYLE(&r$, "hover=nw", "position:fixed;top:"+top$+";left:5px")
      GW_REPLACE_IN_STYLE(&r$, "hover=se", "position:fixed;bottom:"+bot$+";right:5px")
      GW_REPLACE_IN_STYLE(&r$, "hover=sw", "position:fixed;bottom:"+bot$+";left:5px")
      IF ctl$="button" & IS_IN("notext", r$)
        style$="50%;margin:auto;margin-left:"
        IF IS_IN("big", r$) THEN style$+="-21px" ELSE style$+="-12px"
      ELSE
        style$="60px;right:60px;width:auto"
      ENDIF
      GW_REPLACE_IN_STYLE(&r$, "hover=n", "position:fixed;top:"+top$+";left:"+style$)
      GW_REPLACE_IN_STYLE(&r$, "hover=s", "position:fixed;bottom:"+bot$+";left:"+style$)
      GW_REPLACE_IN_STYLE(&r$, "hover=e", "position:fixed;top:50%;right:5px")
      GW_REPLACE_IN_STYLE(&r$, "hover=w", "position:fixed;top:50%;left:5px")
    ENDIF
    IF ctl$="button" THEN GW_REPLACE_IN_STYLE(&r$, "big", "width:42px;height:42px") % 'big' BUTTON
    i=IS_IN("alpha=", r$)
    IF i % transparency of control
      j=IS_IN("%", r$, i+1)
      alpha=VAL(MID$(r$, i+6, j-i-6))
      GW_REPLACE_IN_STYLE(&r$, MID$(r$,i,j+1-i), "opacity:"+ENT$(alpha/100))
    ENDIF
    GW_REPLACE_IN_STYLE(&r$, "fit-screen", "max-width:100%;height:auto") % image fit screen width (if too big)
    i=IS_IN("font=", r$)
    IF i
      j=IS_IN(" ", r$, i+1)
      IF!j THEN j=LEN(r$)+1
      ff$=MID$(r$, i+5, j-i-5)
      GW_REPLACE_IN_STYLE(&r$, MID$(r$,i,j-i), "font-family:"+ff$)
    ENDIF
  ENDIF
  % Flush use of 1-shot theme customization (GW_USE_THEME_CUSTO_ONCE), for a control! (don't flush for page/content)
  IF tct=1 & ctl$<>"page" & ctl$<>"content" THEN GW_RESET_THEME_CUSTO()
  % Return the formatted string
  FN.RTN r$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% FUNCTIONS TO ADD STANDARD CONTROLS
%---------------------------------------------------------------------------------------------
FN.DEF GW_ADD_COLORPICKER$(lbl$, ini_col$)
  IF LEFT$(ini_col$, 1) <> "#" THEN ini_col$="#"+ini_col$
  % Create the control
  u$=GW_NEWID$("colorpicker")
  % e$=<div data-role='fieldcontain'>
  e$+="<label for='"+u$+"'>"+lbl$+"</label>"
  e$+="<input type='text' id='"+u$+"' value='"+ini_col$+"'>" % </div> <!--/fieldcontain-->
  % Add color picker to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_COLORPICKER(page, lbl$, ini_col$)
  % Check resources
  IF IS_APK()
    MAKE_SURE_IS_ON_SD("GW/colorpicker/jquery.minicolors.css")
    MAKE_SURE_IS_ON_SD("GW/colorpicker/jquery.minicolors.min.js")
    MAKE_SURE_IS_ON_SD("GW/colorpicker/jquery.minicolors.png")
  ENDIF
  GW_CHECK_AND_DOWNLOAD("GW/colorpicker/jquery.minicolors.css")
  GW_CHECK_AND_DOWNLOAD("GW/colorpicker/jquery.minicolors.min.js")
  GW_CHECK_AND_DOWNLOAD("GW/colorpicker/jquery.minicolors.png")
  % Add 'minicolors' references to the page
  GW_REGISTER("GW_ADD_COLORPICKER")
  e$=GW_PAGE$(page)
  IF !IS_IN("colorpicker/jquery.minicolors", e$)
    script$="<link rel='stylesheet' href='GW/colorpicker/jquery.minicolors.css' />"
    script$+="<script src='GW/colorpicker/jquery.minicolors.min.js'></script>"
    script$+="<script>$(document).on('pagebeforeshow',function(){$.minicolors.defaults.control='wheel';});</script>"
    i=IS_IN("</head>", e$)
    e$=LEFT$(e$,i-1)+script$+MID$(e$,i)
  ENDIF
  % Add the element to the page and return its index
  GW_SET_SKEY("page", page, e$ + GW_ADD_COLORPICKER$(lbl$, ini_col$))
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LOCK_PATTERN$(opt$)
  % Create the control + script
  u$=GW_NEWID$("lock")
  e$="<div id='"+u$+"' style='margin:0 auto'></div>"
  opt$=LOWER$(opt$)
  IF IS_IN("hide-pattern", opt$)
    o$="patternVisible:false;"
    opt$=TRIM$(REPLACE$(opt$, "hide-pattern", ""))
  ENDIF
  IF IS_IN("x", opt$)=2 % 4x4, 5x7 ... 9x9
    o$+="matrix:["+LEFT$(opt$,1)+","+RIGHT$(opt$,1)+"];"
  ENDIF
  e$+="<script>var "+u$+"=new PatternLock('#"+u$+"'"
  e$+=",{"+o$+"onDraw:function(pattern){RFO('pattern:'"
  e$+="+"+u$+".getPattern());}});resizeLock("+u$+");</script>"
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LOCK_PATTERN(page, opt$)
  % Check resources
  IF IS_APK()
    MAKE_SURE_IS_ON_SD("GW/patternlock/patternLock.css")
    MAKE_SURE_IS_ON_SD("GW/patternlock/patternLock.min.js")
  ENDIF
  GW_CHECK_AND_DOWNLOAD("GW/patternlock/patternLock.css")
  GW_CHECK_AND_DOWNLOAD("GW/patternlock/patternLock.min.js")
  % Add PatternLock .css and .js reference to the page
  GW_REGISTER("GW_ADD_LOCK_PATTERN")
  e$=GW_PAGE$(page)
  IF !IS_IN("patternlock/patternLock", e$)
    script$="<link rel='stylesheet' href='GW/patternlock/patternLock.css'>"
    script$+="<script src='GW/patternlock/patternLock.min.js'></script>"
    script$+="<script>function resizeLock(lock){var ldim=lock.option('matrix');"
    script$+="var lmax=Math.max(ldim[0],ldim[1]);"
    script$+="var lpmargin=0.5*($(window).width()-10*lmax)/(3*lmax-1);"
    script$+="var lpradius=lpmargin+5;lock.option('margin',lpmargin);"
    script$+="lock.option('radius',lpradius);}</script>"
    i=IS_IN("</head>", e$)
    e$=LEFT$(e$,i-1)+script$+MID$(e$,i)
  ENDIF
  % Add the element to the page
  GW_SET_SKEY("page", page, e$ + GW_ADD_LOCK_PATTERN$(opt$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_WRONG_PATTERN(ctl_id) % show a wrong lock pattern input
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_SHOW_WRONG_PATTERN")
  ctl$=GW_ID$(ctl_id)
  JS(ctl$+".error()")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLEAR_LOCK_PATTERN(ctl_id) % clear the lock pattern
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_CLEAR_LOCK_PATTERN")
  ctl$=GW_ID$(ctl_id)
  JS(ctl$+".reset()")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SPINNER$(msg$)
  % Initialize the script
  script$="var h='',to=false,th='"+GW_THEME_CUSTO$("spinner")+"',"
  IF msg$="" THEN script$+="tv=false;" ELSE script$+="tv=true;"
  % Create the control
  u$=GW_NEWID$("spinner")
  e$="var tx"+u$+"="+CHR$(34)+msg$+CHR$(34)+";"
  e$+="function show"+u$+"(){"+script$+"$.mobile.loading('show',"
  e$+="{text:tx"+u$+",textVisible:tv,theme:th,textonly:to,html:h});}"
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN "<script>"+e$+"</script>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SPINNER(page, msg$)
  % Check resource
  IF IS_APK() THEN MAKE_SURE_IS_ON_SD("GW/images/ajax-loader.gif")
  GW_CHECK_AND_DOWNLOAD("GW/images/ajax-loader.gif")
  % Add the element to the page
  GW_REGISTER("GW_ADD_SPINNER")
  e$=GW_PAGE$(page)
  IF !IS_IN("hideloader()", e$)
    e$+="<script>function hideloader(){$.mobile.loading('hide');}</script>"
  ENDIF
  e$+=GW_ADD_SPINNER$(msg$)
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW_SPINNER(ctl_id) % manually trigger a SPINNER
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_SHOW_SPINNER")
  ctl$=GW_ID$(ctl_id)
  JS("show"+ctl$+"()")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_HIDE_SPINNER() % manually hide the SPINNER currently displayed
  JS("hideloader()")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LOADING_IMG(page, img$, dark)
  % Check resource
  IF IS_APK() THEN MAKE_SURE_IS_ON_SD(img$)
  % Declare div
  html$="<div class='se-pre-con'></div>"
  % Declare CSS
  css$ =".no-js #loader {display:none}"
  css$ += ".js #loader {display:block;position:absolute;left:100px;top:0}"
  css$ += ".se-pre-con {position:fixed;left:0px;top:0px;width:100%;height:100%;z-index:9999;"
  css$ += "background:url(" + img$ + ") center no-repeat "
  IF dark THEN css$ += "#000}" ELSE css$ += "#fff}"
  % Declare JS
  script$ ="$(window).load(function(){$('.se-pre-con').fadeOut('slow');})"
  % Add the 3 elements to the page
  GW_REGISTER("GW_ADD_LOADING_IMG")
  GW_INSERT_BEFORE(page, "</head", "<style>" + css$ + "</style>")
  GW_INSERT_BEFORE(page, "</head", "<script>" + script$ + "</script>")
  GW_INSERT_BEFORE(page, "<div", html$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_PROGRESSBAR$(label$)
  e$=GW_ADD_SLIDER$(label$, 0, 100, 0.1, 0) % min, max, step, ini
  u$=GW_ID$(GW_LAST_ID())
  e$+="<script>$(document).on('pagebeforeshow',function(){"
  e$+="$('#"+u$+"').css('display','none');"
  e$+="$('#"+u$+"').next('.ui-slider-track').css({'margin':'0 15px 0 15px','height':'26px'}).css('pointer-events','none');"
  e$+="$('#"+u$+"').next().find('.ui-slider-handle').remove();"
  e$+="});</script>"
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_PROGRESSBAR(page, label$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_PROGRESSBAR")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_PROGRESSBAR$(label$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SET_PROGRESSBAR(ctl_id, v)
  FN.RTN GW_MODIFY(ctl_id, "val", ENT$(v))
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_IMAGE$(img$)
  % Separate image path from possible link
  i=IS_IN(">", img$, -1)
  IF i
    lnk$=MID$(img$, i+1)
    img$=LEFT$(img$, i-1)
  ENDIF
  IF IS_APK() & !STARTS_WITH("http",img$) THEN MAKE_SURE_IS_ON_SD(img$) % in APK mode: if image is not on sdcard, copy it from assets
  % Create the control
  u$=GW_NEWID$("image")
  IF LEN(lnk$)
    e$="<a href='"+GW_FORMAT_LINK$(lnk$)+"'>" %TODO: might bug -> change to WEB$(GW_FORMAT_LINK$())
    e$+="<img id='"+u$+"' src='"+img$+"' "
    e$+=GW_THEME_CUSTO$("image")+"></a>"
  ELSE
    e$="<img id='"+u$+"' src='"+img$+"' "+GW_THEME_CUSTO$("image")+">"
  ENDIF
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_IMAGE(page, img$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_IMAGE")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_IMAGE$(img$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_GET_IMAGE_DIM$(img$) % return dimension of image in the form "WxH"
  script$ ="$('<img/>').attr('src','"+img$+"').on('load',"
  script$+="function(){RFO(this.width+'x'+this.height);});"
  JS(script$)
  FN.RTN GW_WAIT_ACTION$()
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ICON$(ctl_id)
  GW_REGISTER("GW_ICON$")
  GW_USE_THEME_CUSTO_ONCE("notext ui-nodisc-icon icon="+GW_ID$(ctl_id))
  FN.RTN ">#"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_ICON(page, ico$, w, h)
  IF IS_APK() & !IS_IN("http", ico$) THEN MAKE_SURE_IS_ON_SD(ico$) % in APK mode: if icon is not on sdcard, copy it from assets
  % Add the icon style to the page (in the header)
  u$=GW_NEWID$("icon")
  style$="<style>.ui-icon-"+u$+":after{"
  style$+="background-image:url("+ico$+");"
  style$+="background-size:"+INT$(w)+"px "+INT$(h)+"px;}"
  style$+="</style>"
  GW_REGISTER("GW_ADD_ICON")
  GW_INSERT_BEFORE(page, "</head>", style$)
  % Add the control to the list of controls + return its index
  GW_ADD_SKEY("control", u$)
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEW_TBL$(n_cols, table$[]) % (internal)
  firstrow=1
  IF LEFT$(table$[1], 1)=">"
    e$="<thead><tr>"
    FOR col=1 TO n_cols
      IF LEFT$(table$[col], 1)=">" THEN t$=MID$(table$[col], 2) ELSE t$=table$[col]
      e$+="<th data-priority='persistent'>"+t$+"</th>"
    NEXT
    e$+="</tr></thead>"
    firstrow=2
  ENDIF
  e$+="<tbody>"
  ARRAY.LENGTH al, table$[]
  FOR row=firstrow TO al/n_cols
    e$+="<tr>"
    FOR col=1 to n_cols
      i=n_cols*(row-1)+col
      e$+="<td>"+table$[i]+"</td>"
    NEXT
    e$+="</tr>"
  NEXT
  e$+="</tbody>"
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TABLE$(n_cols, table$[])
  % Create the control
  u$=GW_NEWID$("table")
  e$="<table data-role='table' id='"+u$+"' class='ui-responsive ui-shadow' data-mode='columntoggle'"+GW_THEME_CUSTO$("table")+">"
  e$+=GW_NEW_TBL$(n_cols, table$[])
  e$+="</table>"
  % Add the table's number of columns to the dedicated list
  GW_ADD_NKEY("table-column", n_cols)
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TABLE(page, n_cols, table$[])
  % Add table style and js to the page
  GW_REGISTER("GW_ADD_TABLE")
  e$=GW_PAGE$(page)
  IF !IS_IN("columntoggle-btn", e$)
    script$="<style>.ui-table-columntoggle-btn{display: none !important;}" % hide tables' column-toggle button
    script$+="th{border-bottom:1px solid #d6d6d6;}tr:nth-child(even){background:#e9e9e9;}</style>" % styling tables
    i=IS_IN("</head>", e$)
    e$=LEFT$(e$,i-1)+script$+MID$(e$,i)
  ENDIF
  % Add the control to the page
  GW_SET_SKEY("page", page, e$ + GW_ADD_TABLE$(n_cols, table$[]))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_VIDEO$(video$)
  % In APK mode: if video is not on sdcard, copy it from assets
  IF IS_APK() & !IS_IN("http", video$) THEN MAKE_SURE_IS_ON_SD(video$)
  % Poster parameter specified ?
  i=IS_IN(">", video$, -1)
  IF i THEN poster$=" poster='"+MID$(video$, i+1)+"'" : video$=LEFT$(video$, i-1)
  % Create the control
  u$=GW_NEWID$("video")
  e$="<video controls width='100%' id='"+u$+"'"+poster$+" src='"+video$+"'>"+video$+"</video>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_VIDEO(page, video$)
  % Add the video to the page
  GW_REGISTER("GW_ADD_VIDEO")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_VIDEO$(video$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_AUDIO$(audio$)
  % In APK mode: if audio is not on sdcard, copy it from assets
  IF IS_APK() & !IS_IN("http", audio$) THEN MAKE_SURE_IS_ON_SD(audio$)
  % Add the audio to the page
  u$=GW_NEWID$("audio")
  e$="<audio controls><source id='"+u$+"' src='"+audio$+"'></audio>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_AUDIO(page, audio$)
  % Add the audio to the page
  GW_REGISTER("GW_ADD_AUDIO")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_AUDIO$(audio$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_FORMAT_LINK$(link$) % (internal)
  IF IS_IN("#dlg", link$)=1
    BUNDLE.GET 1, "gw-last-edited-page", page
    IF page THEN theme$=GW_THEME_OF_PAGE$(page)
    IF theme$="ios" | theme$="android-holo" | theme$="metro"
      href$=link$+"' data-rel='dialog' data-transition='slideup"
    ELSE
      href$="#' onclick="+CHR$(34)+"$('"+link$+"').popup('open',{transition:"
      href$+="effect"+MID$(link$, 2)+"})"+CHR$(34)+" data-ajax='false"
    ENDIF
  ELSEIF IS_IN("#panel", link$)=1
    href$=link$ % TODO: double-check if commenting line below is ok
    % href$="#' onclick="+CHR$(34)+"javascript:$('"+link$+"').panel('open')"+CHR$(34)+" data-ajax='false"
  ELSEIF LEFT$(link$, 4)="http" | LEFT$(link$,1)="#"
    href$=link$+"' data-ajax='false"
  ELSEIF link$<>""
    href$="javascript:RFO("+CHR$(34)+URL_ENCODE$(link$)+CHR$(34)+");' data-ajax='false"
  ENDIF
  FN.RTN href$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BUTTON$(label$, link$)
  % First treat the link: web hyperlink or user command?
  href$=GW_FORMAT_LINK$(link$)
  % Create the control
  u$=GW_NEWID$("button")
  e$="<a id='"+u$+"' href='"+href$+"' "+GW_THEME_CUSTO$("button")
  e$+=" data-role='button'>"+WEB$(label$)+"</a>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_BUTTON(page, label$, link$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_BUTTON")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_BUTTON$(label$, link$))
  % Return the index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LINK$(label$, link$)
  % First treat the link: web hyperlink or user command?
  href$=GW_FORMAT_LINK$(link$)
  % Create the control
  u$=GW_NEWID$("link")
  e$="<a id='"+u$+"' href='"+href$+"' "+GW_THEME_CUSTO$("link") % v1.6: removed <p></p>
  e$+=">"+WEB$(label$)+"</a>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LINK(page, label$, link$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_LINK")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_LINK$(label$, link$))
  % Return the index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TITLE$(title$)
  % Create the control
  u$=GW_NEWID$("title")
  e$="<h3 id='"+u$+"' "+GW_THEME_CUSTO$("title")
  e$+=" class='ui-bar ui-bar-a ui-corner-all'>"+WEB$(title$)+"</h3>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TITLE(page, title$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_TITLE")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_TITLE$(title$))
  % Return the index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TEXT$(txt$)
  % Create the control
  u$=GW_NEWID$("text")
  e$="<div class='ui-body'>"
  IF LEFT$(txt$,1)="<"
    i=IS_IN(">", txt$)
    e$+=LEFT$(txt$, i-1)+" id='"+u$+"' "+GW_THEME_CUSTO$("text")+MID$(txt$,i)
  ELSE
    e$+="<p id='"+u$+"' "+GW_THEME_CUSTO$("text")+">"+WEB$(txt$)+"</p>"
  ENDIF
  e$+="</div>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TEXT(page, txt$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_TEXT")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_TEXT$(txt$))
  % Return the index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TEXTBOX$(txt$)
  % Create the control
  u$=GW_NEWID$("textbox")
  e$="<div class='ui-body ui-body-a ui-corner-all'>"
  IF LEFT$(txt$,1)="<"
    i=IS_IN(">", txt$)
    e$+=LEFT$(txt$,i-1)+" id='"+u$+"' "+GW_THEME_CUSTO$("textbox")+MID$(txt$,i)
  ELSE
    e$+="<p id='"+u$+"' "+GW_THEME_CUSTO$("textbox")+">"+WEB$(txt$)+"</p>"
  ENDIF
  e$+="</div>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_TEXTBOX(page, txt$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_TEXTBOX")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_TEXTBOX$(txt$))
  % Return the index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_FLIPSWITCH$(label$, s_opt1$, s_opt2$)
  u$=GW_NEWID$("flipswitch")
  % Add the javascript snippet
  e$="<script>$(document.body).on('change','#"+u$+"',function(e){"
  e$+="RFO('"+u$+":'+$('#"+u$+"').val());});</script>"
  % Create the control
  % e$+="<div data-role='fieldcontain'>"
  e$+="<label for='"+u$+"'>"+WEB$(label$)+"</label>"
  BUNDLE.GET 1, "gw-last-edited-page", page
  IF page THEN theme$=GW_THEME_OF_PAGE$(page)
  IF theme$="ios" | theme$="android-holo" | theme$="metro"
    e$+="<select name='"+u$+"' id='"+u$+"' data-role='slider' "+GW_THEME_CUSTO$("flipswitch")+">"
  ELSE
    e$+="<select name='"+u$+"' id='"+u$+"' data-role='flipswitch' "+GW_THEME_CUSTO$("flipswitch")+">"
  ENDIF
  e$+="<option value='"+WEB$(s_opt1$)+"'>"+WEB$(s_opt1$)+"</option>"
  e$+="<option "
  r$=WEB$(s_opt2$)
  IF LEFT$(r$,1)=">"
    e$+="selected "
    r$=MID$(r$,2)
  ENDIF
  e$+="value='"+r$+"'>"+r$+"</option>"
  e$+="</select>"
  % e$+="</div>" % <!--/fieldcontain-->
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_FLIPSWITCH(page, label$, s_opt1$, s_opt2$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_FLIPSWITCH")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_FLIPSWITCH$(label$, s_opt1$, s_opt2$))
  % Return the index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% LISTVIEWS
%---------------------------------------------------------------------------------------------
FN.DEF GW_LV_CELL$(e$) % (internal) listview-cell parser
  % Test against "..@@ICO" --> inline icon
  j=IS_IN("@@", e$)
  IF j
    ico$=MID$(e$, j+2)
    IF IS_APK() & !IS_IN("http", ico$) THEN MAKE_SURE_IS_ON_SD(ico$)
    thb$="<img src='"+ico$+"' class='ui-li-icon'>"
    e$=LEFT$(e$, j-1)
  ENDIF
  % Test against "..@IMG" --> thumbnail
  j=IS_IN("@", e$)
  IF j
    img$=MID$(e$, j+1)
    IF IS_APK() & !IS_IN("http", img$) THEN MAKE_SURE_IS_ON_SD(img$)
    thb$="<img src='"+img$+"'>"
    e$=LEFT$(e$, j-1)
  ENDIF
  % Test against "..{NN}" --> count bubble
  m=IS_IN("{", e$, -1)
  n=IS_IN("}", e$, m)
  IF m & n & n>m % "bla bla (12)"
    bbl$="<span class='ui-li-count'>"
    bbl$+=MID$(e$, m+1, n-m-1)+"</span>"
    e$=LEFT$(e$, m-1)+MID$(e$, n+1)
  ENDIF
  % Test against ".. \n .." --> 2-line listview (BOLD \n Normal)
  k=IS_IN("\n", e$)
  IF k THEN e$="<h2>"+LEFT$(e$, k-1)+"</h2><p>"+MID$(e$, k+1)+"</p>"
  FN.RTN thb$ + WEB$(e$) + bbl$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEW_LV$(txt_axn$[]) % (internal) new listview
  ARRAY.LENGTH al, txt_axn$[]
  IF IS_IN("~", txt_axn$[1])=1 % first element starting with '~' --> means sortable list
    sortable=1
    txt_axn$[1]=MID$(txt_axn$[1],2)
  ENDIF
  % Scan listview for links
  FOR i=1 TO al
    IF IS_IN(">", txt_axn$[i], -1)>2
      linked=1 % At least 1 'link' value means a 'linked' listview
      F_N.BREAK
    ENDIF
  NEXT
  % Create listview elements, 1 by 1
  FOR i=1 TO al
    ar$=txt_axn$[i]
    IF i=1 & IS_IN("#", ar$)=1 THEN ar$=MID$(ar$, 2) % ignore 'ordered' switch
    k=IS_IN(">", ar$)
    IF k=1 % ">Listview title" --> divider
      ar$=MID$(ar$, 2)
      IF i=1 & IS_IN("#", ar$)=1 THEN ar$=MID$(ar$, 2) % ignore 'ordered' switch
      k=IS_IN(">", ar$, -1) % link separator "Bla bla>AXN"
      IF k>0 THEN ar$=LEFT$(ar$, k-1)
      e$+="<li data-role='list-divider'>"+GW_LV_CELL$(ar$)+"</li>"
    ELSE % not a divider --> regular cell
      swipe1=IS_IN("|", ar$) : swipe2=0               % "Opt1|Bla bla" --> swipe w/ at least 1 option
      IF swipe1 THEN swipe2=IS_IN("|", ar$, swipe1+1) % "Opt1|Bla bla|Opt2" --> swipe w/ 2 options
      swiped=swipe1+swipe2 : opt1$="" : opt2$=""
      IF swipe2 % handle swipe w/ 2 options (easiest)
        opt2$=MID$(ar$, swipe2+1)
        ar$=LEFT$(ar$, swipe2-1)
        opt1$=LEFT$(ar$, swipe1-1)
        ar$=MID$(ar$, swipe1+1)
      ELSEIF swipe1 % handle swipe w/ only 1 option (harder)
        ar1$=LEFT$(ar$, swipe1-1)
        ar2$=MID$(ar$, swipe1+1)
        IF IS_IN(" ", ar1$) & !IS_IN(" ", ar2$) % "Bla bla|Opt2" --> swipe with only right option
          opt2$=ar2$ : ar$=ar1$
        ELSEIF !IS_IN(" ", ar1$) & IS_IN(" ", ar2$) % "Opt1|Bla bla" --> swipe with only left option
          opt1$=ar1$ : ar$=ar2$
        ELSEIF LEN(ar1$)>LEN(ar2$) % "Blabla|Opt2" --> swipe with only right option
          opt2$=ar2$ : ar$=ar1$
        ELSE                      % "Opt1|Blabla" --> swipe with only left option
          opt1$=ar1$ : ar$=ar2$
        ENDIF
      ENDIF
      j=IS_IN("@", ar$, -1) % "Bla bla@IMG" or "Bla bla@@ICO" --> thumbnail/icon
      IF j>1 & "@"=MID$(ar$, j-1, 1) THEN j--
      k=IS_IN(">", ar$, -1) % "Bla bla>AXN" --> link separator
      IF j & k & j>k % "Bla bla>AXN@IMG" --> turn AXN and IMG the other way around
        ar$=LEFT$(ar$, k-1)+MID$(ar$, j)+MID$(ar$, k, j-k)
        k=IS_IN(">", ar$, -1) % now in the form "Bla bla@IMG>AXN"
      ENDIF
      IF 0=k THEN k=LEN(ar$)+1
      tx$=LEFT$(ar$, k-1)
      e$+="<li>"
      IF swiped % Create swipe options
        e$=LEFT$(e$,-1)+" data-icon='carat-l'><div class='behind'>"
        IF swipe2
          e$+="<a href='#' class='ui-btn delete-btn'>"+opt2$+"</a>"
          e$+="<a href='#' class='ui-btn edit-btn pull-left'>"+opt1$+"</a>"
        ELSEIF swipe1
          IF opt2$<>""
            e$+="<a href='#' class='ui-btn delete-btn'>"+opt2$+"</a>"
          ELSE
            e$+="<a href='#' class='ui-btn edit-btn pull-left'>"+opt1$+"</a>"
          ENDIF
        ENDIF
        e$+="</div>"
      ENDIF
      IF linked | swiped
        ax$=MID$(ar$, k+1)
        IF ax$="" THEN ax$="#" ELSE ax$=GW_FORMAT_LINK$(ax$)
        ax$=REPLACE$(ax$, CHR$(34), CHR$(92,34)) % protect double quotes with a backslash
        e$+="<a href='"+ax$+"'>"
      ENDIF
      IF sortable THEN e$+= "<span class='gray'>&#x2630; </span> "
      e$+=GW_LV_CELL$(tx$)
      IF linked | swiped THEN e$+="</a>"
      e$+="</li>"
    ENDIF
  NEXT
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LISTVIEW$(txt_axn$[])
  % Create the control
  IF IS_IN("#", txt_axn$[1])=1 THEN ordered=1 % first element starting with '#' --> means ordered list
  ARRAY.LENGTH al, txt_axn$[]
  FOR i=1 TO al
    IF IS_IN("|", txt_axn$[i])>1
      opt$="class='swipe-delete' "
      F_N.BREAK
    ENDIF
  NEXT
  u$=GW_NEWID$("listview")
  % Create the javascript snippet
  IF IS_IN("~", txt_axn$[1])=1 % sortable listview
    sortable=1
    js$ ="var "+u$+"changed=0;"
    js$+="$(document).bind('pageinit',function(){"
    js$+="$('#"+u$+" li').each(function(){"
    js$+="$(this).attr('id',$(this).index());});"
    js$+="$('#"+u$+"').sortable();"
    js$+="$('#"+u$+"').disableSelection();"
    js$+="$('#"+u$+"').bind('sortstop',function(){"
    js$+="$('#"+u$+"').listview('refresh');"
    js$+=u$+"changed=1;});});"
  ENDIF
  IF ordered THEN e$="<ol " ELSE e$="<ul "
  e$+="id='"+u$+"' data-role='listview' data-inset='true' "
  e$+=opt$+GW_THEME_CUSTO$("listview")+">"
  e$+=REPLACE$(GW_NEW_LV$(txt_axn$[]), CHR$(92,34), CHR$(34)) % unprotect double quotes
  IF ordered THEN e$=e$+"</ol>" ELSE e$=e$+"</ul>"
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  IF sortable THEN e$+="<script>"+js$+"</script>"
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LISTVIEW(page, txt_axn$[])
  % Swipe listview: add the css and javascript
  ARRAY.LENGTH al, txt_axn$[]
  FOR i=1 TO al
    IF IS_IN("|", txt_axn$[i])>1
      IF IS_APK()
        MAKE_SURE_IS_ON_SD("GW/swipe_lv.css")
        MAKE_SURE_IS_ON_SD("GW/swipe_lv.js")
      ENDIF
      GW_CHECK_AND_DOWNLOAD("GW/swipe_lv.css")
      GW_CHECK_AND_DOWNLOAD("GW/swipe_lv.js")
      IF !IS_IN("swipe_lv", GW_PAGE$(page))
        GW_INSERT_BEFORE(page, "</head>", "<link rel='stylesheet' href='GW/swipe_lv.css' />")
        GW_INSERT_BEFORE(page, "</head>", "<script src='GW/swipe_lv.js'></script>")
      ENDIF
      F_N.BREAK
    ENDIF
  NEXT
  % Sortable listview: add the javascript snippet
  IF IS_IN("~", txt_axn$[1])=1 & !IS_IN("jquery-ui.min", GW_PAGE$(page))
    IF IS_APK()
      MAKE_SURE_IS_ON_SD("GW/jquery.ui.touch-punch.min.js")
      MAKE_SURE_IS_ON_SD("GW/jquery-ui.min.js")
    ENDIF
    GW_CHECK_AND_DOWNLOAD("GW/jquery.ui.touch-punch.min.js")
    GW_CHECK_AND_DOWNLOAD("GW/jquery-ui.min.js")
    GW_INSERT_BEFORE(page, "</head>", "<script src='GW/jquery-ui.min.js'></script>")
    GW_INSERT_BEFORE(page, "</head>", "<script src='GW/jquery.ui.touch-punch.min.js'></script>")
    GW_INSERT_BEFORE(page, "</head>", "<style>.gray{color:#ccc}</style>")
  ENDIF
  % Add the element to the page
  GW_REGISTER("GW_ADD_LISTVIEW")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_LISTVIEW$(txt_axn$[]))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_LISTVIEW_CHANGED(ctl_id) % return if sortable listview has been changed by user or not
  ctl$=GW_ID$(ctl_id)
  JS("RFO("+ctl$+"changed)")
  chg$=GW_WAIT_ACTION$()
  JS(ctl$+"changed=0")
  IF !IS_NUMBER(chg$) THEN chg$="0"
  FN.RTN VAL(chg$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_GET_LISTVIEW_ORDER$(ctl_id) % return sortable listview order, as changed by the user
  ctl$=GW_ID$(ctl_id)
  % Get order of sortable listview
  js$="var t=[];$('#"+ctl$+" li').each(function(){"
  js$+="t.push($(this).attr('id'));});"
  js$+="RFO(t.join(' '));"
  JS(js$)
  r$=GW_WAIT_ACTION$()
  % Reset index-based ids of listview
  js$="$('#"+ctl$+" li').each(function(){"
  js$+="$(this).attr('id',$(this).index());})"
  JS(js$)
  FN.RTN r$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_REORDER_ARRAY(a$[],order$) % sort BASIC array according to user change of sortable listview
 SPLIT o$[], order$
 ARRAY.LENGTH n, o$[]
 DIM tmp$[n]
 FOR i=1 TO n
  k=VAL(o$[i])+1
  tmp$[i]=a$[k]
 NEXT
 ARRAY.COPY tmp$[], a$[]
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_HIDE_LISTVIEW_ROW(ctl_id, row) % hide a listview row typically from a 'Delete' swipe option
  ctl$=GW_ID$(ctl_id)
  js$ ="$('#"+ctl$+" li:nth-child("+INT$(row)+")')"
  js$+=".slideUp('fast',function(){$(this).remove()})"
  JS(js$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)


%---------------------------------------------------------------------------------------------
% FUNCTIONS TO ADD USER INPUT CONTROLS --> INPUTFORM NEEDED (HANDLED TRANSPARENTLY FOR THE USER)
%---------------------------------------------------------------------------------------------
FN.DEF GW_OPEN_INPUTFORM$() % (internal)
  % Open a form
  u$=GW_NEWID$("form")
  FN.RTN "<form id='"+u$+"' data-ajax='false'>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTMINI$(v$)
  t$=GW_THEME_CUSTO$("mini")
  e$=GW_ADD_SLIDER$("", 0, 9E9, 1, VAL(v$)) % min, max, step, ini
  e$=REPLACE$(e$,"<input name","<input "+t$+" name")
  e$=MID$(e$, IS_IN("<input",e$))
  e$=LEFT$(e$, IS_IN("<script",e$)-1)
  u$=GW_ID$(GW_LAST_ID())
  e$+="<script>$(document).on('pagebeforeshow',function(){"
  e$+="$('#"+u$+"').parent().css('display', 'inline-block');"
  e$+="$('#"+u$+"').css('float','inherit');"
  e$+="$('#"+u$+"').css('padding','inherit');"
  e$+="$('#"+u$+"').next('.ui-slider-track').remove();"
  e$+="});</script>"
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTMINI(page, v$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_INPUTMINI")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_INPUTMINI$(v$))
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEW_LI$(txt_axn$[]) % (internal)
  ARRAY.LENGTH al, txt_axn$[]
  FOR i=1 TO al
    k=IS_IN(">", txt_axn$[i], -1)
    IF !k THEN k=LEN(txt_axn$[i])+1
    tx$=WEB$(LEFT$(txt_axn$[i], k-1))
    ax$=GW_FORMAT_LINK$(MID$(txt_axn$[i], k+1)) %TODO: might be a bug -> change to WEB$(GW_FORMAT_LINK$())
    e$+="<li><a href='"+ax$+"'>"+tx$+"</a></li>"
  NEXT
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTLIST$(hint$, txt_axn$[])
  % Create the control
  u$=GW_NEWID$("inputlist")
  e$="<input id='"+u$+"' data-type='search' "
  e$+="placeholder='"+WEB$(hint$)+"' "+GW_THEME_CUSTO$("inputlist")+">"
  e$+="<ul id='"+u$+"-ul' data-filter='true' data-filter-reveal='true' "
  e$+="data-role='listview' data-input='#"+u$+"' data-inset='true'>"
  e$+=GW_NEW_LI$(txt_axn$[])
  e$+="</ul>"
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTLIST(page, hint$, txt_axn$[])
  % Add the element to the page
  GW_REGISTER("GW_ADD_INPUTLIST")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_INPUTLIST$(hint$, txt_axn$[])
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_INPUTLIST(ctl_id)
  JS("$('ul[data-filter=\"true\"]').children().addClass('ui-screen-hidden')")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEW_OPT$(txt$[]) % (internal)
  ARRAY.LENGTH al, txt$[]
  FOR i=1 TO al
    e$+="<option "
    IF LEFT$(txt$[i], 1)="#"
      e$+="data-placeholder='true' "
      txt$[i]=MID$(txt$[i], 2)
    ELSEIF LEFT$(txt$[i], 1)=">"
      e$+="selected='selected' "
      txt$[i]=MID$(txt$[i], 2)
    ENDIF
    e$+="value='"+INT$(i)+"'>"+WEB$(txt$[i])+"</option>"
  NEXT
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SELECTBOX$(label$, txt$[])
  % Create the control
  u$=GW_NEWID$("selectbox")
  % e$="<div class='ui-field-contain'>" % <!--fieldcontain-->
  e$+="<label for='"+u$+"'>"+WEB$(label$)+"</label>"
  e$+="<select name='"+u$+"' id='"+u$+"' data-native-menu='false' "+GW_THEME_CUSTO$("selectbox")+">"
  IF label$<>"" THEN e$+="<option>"+WEB$(label$)+"</option>"
  e$+=GW_NEW_OPT$(txt$[])
  e$+="</select>" % </div> <!--/fieldcontain-->
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SELECTBOX(page, label$, txt$[])
  % Add the control to the page
  GW_REGISTER("GW_ADD_SELECTBOX")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_SELECTBOX$(label$, txt$[])
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_RADIO$(parent, label$)
  % Create the control
  u$=GW_NEWID$("radio")
  GW_REGISTER("GW_ADD_RADIO$")
  IF !parent THEN v$=u$ ELSE v$=GW_ID$(parent)
  r$=WEB$(label$)
  IF LEFT$(r$,1)=">"
    checked$="checked='checked'"
    r$=MID$(r$,2)
  ENDIF
  e$="<label for='"+u$+"'>"+r$+"</label>"
  e$+="<input name='"+v$+"' id='"+u$+"' value='"+u$+"' "+checked$
  e$+=" type='radio' "+GW_THEME_CUSTO$("radio")+" />"
  % Add the parent to the list of radio parents
  ls=GW_KEY_IDX("control")
  ls++
  IF !parent THEN parent=ls
  GW_ADD_NKEY("radio-parent", parent)
  % Add the child to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_RADIO(page, parent, label$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_RADIO")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_RADIO$(parent, label$)
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_RADIO_PARENT(ctl_id) % (internal)
  % Returns the radio parent id for a given radio child id
  GW_REGISTER("GW_RADIO_PARENT")
  e$=GW_ID$(ctl_id) % "radioN"
  child_id=VAL(MID$(e$, 6)) % N
  parent_id=GW_GET_NKEY("radio-parent", child_id)
  FN.RTN parent_id
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_CHECKBOX$(label$)
  % Create the control
  u$=GW_NEWID$("checkbox")
  r$=WEB$(label$)
  IF LEFT$(r$,1)=">"
    checked$="checked='' "
    r$=MID$(r$,2)
  ENDIF
  IF LEN(r$) THEN e$="<label for='"+u$+"'>"+r$+"</label>"
  e$+="<input name='"+u$+"' id='"+u$+"' "+checked$
  e$+=GW_THEME_CUSTO$("checkbox")+" type='checkbox' />"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_CHECKBOX(page, label$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_CHECKBOX")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_CHECKBOX$(label$)
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SLIDER$(label$, n_min, n_max, n_step, n_ini)
  % Create the control
  u$=GW_NEWID$("slider")
  t$=GW_THEME_CUSTO$("slider")
  e$+="<label for='"+u$+"'>"+WEB$(label$)+"</label>"
  e$+="<input name='"+u$+"' id='"+u$+"' "
  e$+=" min='"+ENT$(n_min)+"' max='"+ENT$(n_max)+"'"
  e$+=" step='"+ENT$(n_step)+"' value='"+ENT$(n_ini)+"'"
  e$+=" type='range' data-highlight='true' />"
  e$+="<script>$(document).on('pagebeforeshow',function(){"
  e$+="$('#"+u$+"').next().find('.ui-btn-active').css({background:'-webkit-gradient(linear,left top,left bottom,"+t$+")'});"
  e$+="});</script>"
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SLIDER(page, label$, n_min, n_max, n_step, n_ini)
  % Add the control to the page
  GW_REGISTER("GW_ADD_SLIDER")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_SLIDER$(label$, n_min, n_max, n_step, n_ini)
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUT$(type$, label$, s_ini$) % (internal) generic class for input controls
  % Create the control
  u$=GW_NEWID$("input"+type$)
  % e$="<div data-role='fieldcontain'>"
  e$+="<label for='"+u$+"'>"+WEB$(label$)+"</label>"
  e$+="<input name='"+u$+"' id='"+u$+"'"
  IF type$="number" THEN e$+=" step='any'" % to allow decimal numbers
  e$+=" value='"+WEB$(s_ini$)+"'"
  e$+=" type='"+type$+"' "+ GW_THEME_CUSTO$("input"+type$)
  e$+=" data-clear-btn='true'>"
  % e$+="</div>" % <!--/fieldcontain-->
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUT(type$, page, label$, s_ini$) % (internal) generic class for input controls
  % Add the control to the page
  e$=GW_PAGE$(page) % specific commands GW_ADD_INPUT* must have already REGISTERED their name
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_INPUT$(type$, label$, s_ini$)
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTLINE$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("text", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTDATE$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("date", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTTIME$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("time", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTDATETIME$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("datetime-local", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTMONTH$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("month", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTWEEK$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("week", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTURL$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("url", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTEMAIL$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("email", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTCOLOR$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("color", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTNUMBER$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("number", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTTEL$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("tel", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTPASSWORD$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("password", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTFILE$(label$, s_ini$)
  FN.RTN GW_ADD_INPUT$("file", label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTLINE(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTLINE")
  FN.RTN GW_ADD_INPUT("text", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTDATE(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTDATE")
  FN.RTN GW_ADD_INPUT("date", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTTIME(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTTIME")
  FN.RTN GW_ADD_INPUT("time", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTDATETIME(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTDATETIME")
  FN.RTN GW_ADD_INPUT("datetime-local", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTMONTH(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTMONTH")
  FN.RTN GW_ADD_INPUT("month", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTWEEK(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTWEEK")
  FN.RTN GW_ADD_INPUT("week", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTURL(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTURL")
  FN.RTN GW_ADD_INPUT("url", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTEMAIL(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTEMAIL")
  FN.RTN GW_ADD_INPUT("email", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTCOLOR(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTCOLOR")
  FN.RTN GW_ADD_INPUT("color", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTNUMBER(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTNUMBER")
  FN.RTN GW_ADD_INPUT("number", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTTEL(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTTEL")
  FN.RTN GW_ADD_INPUT("tel", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTPASSWORD(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTPASSWORD")
  FN.RTN GW_ADD_INPUT("password", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTFILE(page, label$, s_ini$)
  GW_REGISTER("GW_ADD_INPUTFILE")
  FN.RTN GW_ADD_INPUT("file", page, label$, s_ini$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTBOX$(label$, s_ini$)
  % Create the control
  u$=GW_NEWID$("inpbox")
  % e$="<div data-role='fieldcontain'>"
  e$+="<label for='"+u$+"'>"+WEB$(label$)+"</label>"
  e$+="<textarea name='"+u$+"' id='"+u$+"' "+GW_THEME_CUSTO$("inpbox")
  e$+=" cols='20' rows='3'>"+WEB$(s_ini$)+"</textarea>" % </div> <!--/fieldcontain-->
  % Add the control to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_INPUTBOX(page, label$, s_ini$)
  % Add the control to the page
  GW_REGISTER("GW_ADD_INPUTBOX")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_INPUTBOX$(label$, s_ini$)
  GW_SET_SKEY("page", page, e$)
  % Return index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SUBMIT$(submit$)
  % Create the submit button
  u$=GW_NEWID$("submit")
  e$="<input name='"+u$+"' id='"+u$+"' value='"+WEB$(submit$)+"'"
  e$+=" type='submit' "+GW_THEME_CUSTO$("submit")+">"
  % Add the submit button to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SUBMIT(page, submit$)
  % Add the submit button to the page
  GW_REGISTER("GW_ADD_SUBMIT")
  e$=GW_PAGE$(page)
  IF !IS_IN("<form ",e$) THEN e$+=GW_OPEN_INPUTFORM$()
  e$+=GW_ADD_SUBMIT$(submit$)
  GW_SET_SKEY("page", page, e$)
  % Return index of the submit button
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% FUNCTIONS TO RENDER AND INTERACT WITH THE GW PAGE
%---------------------------------------------------------------------------------------------
FN.DEF GW_PREVENT_LANDSCAPE(page, msg$) % deprecated, prefer: HTML.ORIENTATION 1
  GW_REGISTER("GW_PREVENT_LANDSCAPE")
  e$=GW_PAGE$(page)
  e$=REPLACE$(e$, "data-position='fixed' ", "") % remove the 'fixed' position of the header
  e$+="<div id='blockland' style='position:fixed; top:0; left:0; z-index:10;"
  e$+=" text-align:center; background:gray; width:100%; height:100%; display:none;'>"
  e$+="<span id='blockmsg' style='font-size:5vw; display:inline-block; vertical-align:middle; line-height:normal;'>"
  e$+=WEB$(msg$)+"</span></div>"
  e$+="<script>$(window).resize(function() {"
  e$+="($(window).width()<$(window).height())?"
  e$+="$('#blockland').css('display','none'):"
  e$+="$('#blockland').css('display','block');"
  e$+="$('#blockmsg').css('margin-top',($(window).height()-$('#blockmsg').height())/2);"
  e$+="}); $(window).trigger('resize');</script>"
  GW_SET_SKEY("page", page, e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_PREVENT_PORTRAIT(page, msg$) % deprecated, prefer: HTML.ORIENTATION 0
  GW_REGISTER("GW_PREVENT_PORTRAIT")
  e$=GW_PAGE$(page)
  e$=REPLACE$(e$, "data-position='fixed' ", "") % remove the 'fixed' position of the header
  e$+="<div id='blockland' style='position:fixed; top:0; left:0; z-index:10;"
  e$+=" text-align:center; background:gray; width:100%; height:100%; display:none;'>"
  e$+="<span id='blockmsg' style='font-size:5vw; display:inline-block; vertical-align:middle; line-height:normal;'>"
  e$+=WEB$(msg$)+"</span></div>"
  e$+="<script>$(window).resize(function() {"
  e$+="($(window).width()>$(window).height())?"
  e$+="$('#blockland').css('display','none'):"
  e$+="$('#blockland').css('display','block');"
  e$+="$('#blockmsg').css('margin-top',($(window).height()-$('#blockmsg').height())/2);"
  e$+="}); $(window).trigger('resize');</script>"
  GW_SET_SKEY("page", page, e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CLOSE_PAGE(page) % Transition a page out 100% with javascript
  script$="$('#page"+INT$(ABS(page))+"').on('animationend webkitAnimationEnd',function(e){"
  script$+="$('#page"+INT$(ABS(page))+"').off(e);setTimeout(function(){RFO('close-endanim');},10);});"
  JS(script$)
  JS("$('#closethispage').click()")
  c0=CLOCK()
  DO
    r$=GW_ACTION$() % event: 'close-endanim'
  UNTIL LEN(r$) | (CLOCK()-c0 > 1000) % workaround when changing page at bottom of a long page (gets stuck)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_RENDER(page)
  tag$="thispage' data-transition='"
  % Transition-out last page (currently on screen)
  BUNDLE.GET 1, "gw-last-rendered-page", last
  IF last
    e$=GW_PAGE$(last) % 'last' page is sure to exist -> no need to REGISTER command
    i=IS_IN(tag$, e$) + LEN(tag$)
    j=IS_IN("'", e$, i+1)
    lastfx$=MID$(e$, i, j-i)
    IF lastfx$ <> "none" THEN GW_CLOSE_PAGE(last)
  ENDIF
  % Transition-in new page
  GW_REGISTER("GW_RENDER")
  e$=GW_PAGE$(page)
  thm$=GW_THEME_OF_PAGE$(page)
  fx$=GW_GET_SKEY$("transition", page)
  BUNDLE.GET 1, "gw-transition-script", script$
  BUNDLE.GET 1, "gw-no-transition-script", noscript$
  IF !IS_IN("</html>", e$) % PAGE being built -> finalize it
    IF IS_IN("<form ", e$) THEN e$+="</form>"
    e$+="<div id='btmpad'></div>" % bottom pad
    e$+="</div></div>" % <!--/content--><!--/page-->
    e$+="<a id='openthispage' data-transition='"+fx$+"' data-direction='reverse' href='#page"+INT$(ABS(page))+"'></a>"
    e$+="<a id='closethispage' data-transition='"+fx$+"' href='#page0'></a>"
    IF fx$="none" & thm$ <> "ios" & thm$ <> "android-holo" & thm$ <> "metro"
      e$=REPLACE$(e$, "<div data-role='page' id='page0'", "<div id='page0'")
      script$=noscript$
    ENDIF
    e$+="<script>"+script$+"</script>" % transition script
    e$+="</body></html>"
    GW_SET_SKEY("page", page, e$)
    BUNDLE.PUT 1, "gw-last-edited-page", page
  ELSEIF !IS_IN(tag$ + fx$, e$) % PAGE already finalized but with a different transition
    i=IS_IN(tag$, e$) + LEN(tag$)
    j=IS_IN("'", e$, i+1)
    oldfx$=MID$(e$, i, j-i)
    e$=REPLACE$(e$, tag$ + oldfx$, tag$ + fx$) % -> replace the transition in the DOM before RENDER
    IF oldfx$="none" THEN                      %    ...as well as the transition script
      e$=REPLACE$(e$, noscript$, script$)
      e$=REPLACE$(e$, "<div id='page0'", "<div data-role='page' id='page0'")
    ENDIF
    IF fx$="none" & thm$ <> "ios" & thm$ <> "android-holo" & thm$ <> "metro"
      e$=REPLACE$(e$, script$, noscript$)
      e$=REPLACE$(e$, "<div data-role='page' id='page0'", "<div id='page0'")
    ENDIF
    GW_SET_SKEY("page", page, e$)
  ENDIF
  HTML.LOAD.STRING e$
  r$=GW_WAIT_ACTION$() % event: 'open-endanim' (transition) or 'GwReady' (no-transition)
  i=IS_IN("'colorpicker", e$)
  WHILE i % Colorpickers need a piece of javascript to send their 'change' notification
    i += LEN("'colorpicker") : j=IS_IN("'", e$, i)
    u$="colorpicker"+MID$(e$, i, j-i) % id of colorpicker control
    JS("$('#"+u$+"').minicolors({'change':function(col,alf){RFO('"+u$+":'+col)}})")
    i=IS_IN("'colorpicker", e$, i)
  REPEAT
  IF IS_IN("swipe_lv",e$) THEN JS("swipe_lv()")
  BUNDLE.PUT 1, "gw-last-rendered-page", page
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_TRANSFORM_DATALINK$(data$) % (internal) used by GW_ACTION$/GW_WAIT_ACTION$
  IF IS_IN("BAK:", data$)=1
    data$="BACK"
  ELSEIF IS_IN("DAT:", data$)=1
    data$=MID$(data$, 5) % User link
  ELSEIF IS_IN("LNK:file:///", data$)=1 & IS_IN("?", data$) % Submit link
    i=IS_IN("?", data$)
    data$="SUBMIT&"+MID$(data$, i+1)+"&"
  ENDIF
  BUNDLE.PUT 1, "callback", data$
  FN.RTN data$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ACTION$()
  HTML.GET.DATALINK data$
  FN.RTN GW_TRANSFORM_DATALINK$(data$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_WAIT_ACTION$()
  DO
    HTML.GET.DATALINK data$
    PAUSE 1
  UNTIL data$ <> ""
  FN.RTN GW_TRANSFORM_DATALINK$(data$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_GET_VALUE(ctl_id)
  e$=GW_GET_VALUE$(ctl_id)
  IF IS_NUMBER(e$) THEN FN.RTN VAL(e$) ELSE FN.RTN 0
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_GET_VALUE$(ctl_id)
  % Parse the submit string and retrieve the value of the desired control
  BUNDLE.GET 1, "callback", answer$
  GW_REGISTER("GW_GET_VALUE() or GW_GET_VALUE$")
  ctl$=GW_ID$(ctl_id)
  i=IS_IN("&"+ctl$+"=", answer$)
  IF !i % trick to get the live content of a control
    IF IS_IN("checkbox", ctl$)
      JS("RFO(document.getElementById('"+ctl$+"').checked)")
      r$=GW_WAIT_ACTION$()
      IF r$="true" THEN FN.RTN "1" ELSE FN.RTN "0"
    ELSEIF IS_IN("radio", ctl$)
      parent=GW_RADIO_PARENT(ctl_id)
      p$=GW_ID$(parent)
      JS("RFO($('input[name="+p$+"]:checked').val())")
      FN.RTN GW_WAIT_ACTION$()
    ELSEIF IS_IN("dlginp", ctl$)
      JS("RFO($('#"+ctl$+"-input').val())")
      FN.RTN GW_WAIT_ACTION$()
    ELSEIF IS_IN("dlgchk", ctl$)
      JS("RFO(document.getElementById('"+ctl$+"-chk').checked)")
      r$=GW_WAIT_ACTION$()
      IF r$="true" THEN FN.RTN "1" ELSE FN.RTN "0"
    ELSE
      JS("RFO(document.getElementById('"+ctl$+"').value)")
      FN.RTN GW_WAIT_ACTION$()
    ENDIF
    FN.RTN r$
  ELSEIF IS_IN("checkbox", ctl$)
    IF !i THEN FN.RTN "0" ELSE FN.RTN "1"
  ENDIF
  i+=LEN("&"+ctl$+"=")
  j=IS_IN("&", answer$, i)
  IF !j THEN FN.RTN ""
  FN.RTN DECODE$("URL",, MID$(answer$, i, j-i))
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CHECKBOX_CHECKED(ctl_id)
  % Returns true/false if the checkbox is or not checked
  FN.RTN GW_GET_VALUE(ctl_id)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_RADIO_SELECTED(ctl_id)
  % Returns true/false if the radio button is or not selected
  parent=GW_RADIO_PARENT(ctl_id)
  GW_REGISTER("GW_RADIO_SELECTED")
  ctl$=GW_ID$(ctl_id)
  FN.RTN (GW_GET_VALUE$(parent)=ctl$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_FLIPSWITCH_CHANGED(ctl_id, txt$)
  % Returns true/false if the desired flip switch was just triggered to a 'txt$' state
  BUNDLE.GET 1, "callback", answer$
  GW_REGISTER("GW_FLIPSWITCH_CHANGED")
  ctl$=GW_ID$(ctl_id)
  FN.RTN (answer$=ctl$+":"+txt$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_MODIFY(ctl_id, key$, txt$)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_MODIFY")
  ctl$=GW_ID$(ctl_id)
  key$=LOWER$(key$)
  DQ$=CHR$(34)
  ctyp$=ctl$
  WHILE ASCII(ctyp$, LEN(ctyp$))<58
    ctyp$=LEFT$(ctyp$, LEN(ctyp$)-1)
  REPEAT
  % Push the new content inside the control
  IF IS_IN("style:", key$) % STYLE / CSS
    key$=MID$(key$, 7)
    IF LEFT$(ctl$,1)<>"." THEN ctl$="#"+ctl$ % handle MODIFYing a whole class=multiple controls at once
    JS("$('"+ctl$+"').css('"+key$+"','"+txt$+"')")
  ELSEIF key$="text" & IS_IN("spinner", ctyp$)=1 % SPINNER
    JS("tx"+ctl$+"="+DQ$+txt$+DQ$+";show"+ctl$+"()")
  ELSEIF key$="text" & IS_IN("text", ctyp$)=1 % TEXTBOX, TEXT
    IF LEFT$(txt$,1)<>"<" THEN txt$="<p>"+txt$+"</p>"
    JS("populate("+DQ$+ctl$+DQ$+","+DQ$+WEB$(txt$)+DQ$+")")
  ELSEIF key$="text" & (ctyp$="link" | ctyp$="button" | ctyp$="title") % LINK, BUTTON, TITLE
    JS("populate("+DQ$+ctl$+DQ$+","+DQ$+WEB$(txt$)+DQ$+")")
  ELSEIF key$="text" & ~                   % RADIO, FLIPSWITCH, CHECKBOX, SELECTBOX
    (ctyp$="radio" | ctyp$="flipswitch" | ctyp$="checkbox" | ctyp$="selectbox")
    JS("$(\"label[for='"+ctl$+"']\").html(\""+WEB$(txt$)+"\")")
  ELSEIF key$="checked" & ctyp$="checkbox" % CHECKBOX
    IF txt$="" THEN v=0 ELSE v=VAL(txt$)
    IF v THEN txt$="true" ELSE txt$="false"
    JS("document.getElementById("+DQ$+ctl$+DQ$+").checked="+txt$)
    JS("$('#"+ctl$+"').checkboxradio('refresh')")
  ELSEIF key$="selected" & ctyp$="flipswitch" % FLIPSWITCH
    JS("$('#"+ctl$+"').val('"+txt$+"').flipswitch('refresh')")
  ELSEIF key$="selected" & ctyp$="selectbox" % SELECTBOX
    JS("$('#"+ctl$+"').val('"+txt$+"').selectmenu('refresh')")
  ELSEIF key$="selected" & ctyp$="radio" % RADIO
    IF txt$="" | txt$="0" THEN v$="false" ELSE v$="true"
    parent=GW_RADIO_PARENT(ctl_id)
    p$=GW_ID$(parent)
    JS("$('input[name="+p$+"]').prop('checked', "+v$+").checkboxradio('refresh')")
  ELSEIF ctyp$="slider" % SLIDER / PROGRESSBAR / INPUTMINI
    IF key$="val" | key$="input"
      JS("$('input[name="+ctl$+"]').val('"+txt$+"')")
    ELSEIF key$="min"
      JS("$('input[name="+ctl$+"]').attr('min','"+txt$+"')")
    ELSEIF key$="max"
      JS("$('input[name="+ctl$+"]').attr('max','"+txt$+"')")
    ELSEIF key$="step"
      JS("$('input[name="+ctl$+"]').attr('step','"+txt$+"')")
    ELSEIF key$="text"
      JS("$(\"label[for='"+ctl$+"']\").html(\""+WEB$(txt$)+"\")")
    ELSE % Unknown key -> assume HTML attribute
      IF LEFT$(ctl$,1)<>"." THEN ctl$="#"+ctl$ % handle MODIFYing a whole class=multiple controls at once
      JS("$('"+ctl$+"').attr('"+key$+"',"+DQ$+txt$+DQ$+")")
    ENDIF
    JS("$('input[name="+ctl$+"]').slider('refresh')")
  ELSEIF key$="text" & (ctyp$="inputlist" | ctyp$="submit") % INPUTLIST, SUBMIT
    JS("$('#"+ctl$+"').val("+DQ$+WEB$(txt$)+DQ$+")")
  ELSEIF IS_IN("input", ctyp$)=1 | ctyp$="colorpicker" | ctyp$="inpbox" % ALL INPUT*, COLORPICKER
    IF key$="text"
      JS("$('label[for="+DQ$+ctl$+DQ$+"]').html("+DQ$+WEB$(txt$)+DQ$+")")
    ELSEIF key$="input"
      IF ctyp$="inpbox"
        JS("populate("+DQ$+ctl$+DQ$+","+DQ$+WEB$(txt$)+DQ$+")")
      ELSEIF ctyp$="colorpicker"
        JS("$('#"+ctl$+"').minicolors('value','"+txt$+"')")
      ELSE
        JS("$('#"+ctl$+"').val("+DQP$(txt$)+")")
      ENDIF
    ELSE % Unknown key -> assume HTML attribute
      IF LEFT$(ctl$,1)<>"." THEN ctl$="#"+ctl$ % handle MODIFYing a whole class=multiple controls at once
      JS("$('"+ctl$+"').attr('"+key$+"',"+DQ$+txt$+DQ$+")")
    ENDIF
  ELSEIF key$="link" & (ctyp$="link" | ctyp$="button") % LINK, BUTTON
    JS("document.getElementById("+DQ$+ctl$+DQ$+").href="+DQ$+GW_FORMAT_LINK$(txt$)+DQ$)
  ELSEIF key$="content" & (ctyp$="image" | ctyp$="audio" | ctyp$="video") % IMAGE, AUDIO, VIDEO
    IF IS_APK() & !IS_IN("http", txt$) THEN MAKE_SURE_IS_ON_SD(txt$)
    i=IS_IN(">", txt$, -1) : IF i THEN poster$=MID$(txt$, i+1) : txt$=LEFT$(txt$, i-1)
    JS("$('#"+ctl$+"').attr('src','"+txt$+"')")
    IF LEN(poster$) THEN JS("$('#"+ctl$+"').attr('poster','"+poster$+"')")
    IF ctyp$="audio" THEN JS("document.getElementById("+DQ$+ctl$+DQ$+").parentElement.load()")
    IF ctyp$="video" THEN JS("document.getElementById("+DQ$+ctl$+DQ$+").load()")
  ELSEIF (key$="title" | key$="lbutton" | key$="rbutton") & (ctyp$="titlebar" | ctyp$="footbar") % TITLEBAR/FOOTBAR
    JS("populate("+DQ$+ctl$+"-"+key$+DQ$+","+DQ$+WEB$(txt$)+DQ$+")")
  ELSEIF (key$="title" | key$="text" | key$="input" | key$="checked") & IS_IN("dlg", ctyp$)=1 % DIALOGs (MESSAGE/INPUT/CHECKBOX)
    IF key$="input"
      typ$="text" % by default
      IF MID$(txt$,2,1)=">" % input type: "0>"|"1>"=number ; "*>"=password ; "@>"=email ; "<>"=url
        cod$=LEFT$(txt$,1)
        IF cod$="0" | cod$="1" THEN typ$="number"
        IF cod$="*" THEN typ$="password"
        IF cod$="@" THEN typ$="email"
        IF cod$="<" THEN typ$="url"
        txt$=MID$(txt$,3)
      ENDIF
      JS("$("+DQ$+"#"+ctl$+"-"+key$+DQ$+").attr('type',"+DQ$+typ$+DQ$+")")
      % JS("document.getElementById("+DQ$+ctl$+"-"+key$+DQ$+").type="+DQ$+typ$+DQ$)
      JS("$("+DQ$+"#"+ctl$+"-"+key$+DQ$+").val("+DQ$+txt$+DQ$+")")
    ELSEIF key$="checked"
      JS("populate("+DQ$+ctl$+"-lbl"+DQ$+","+DQ$+txt$+DQ$+")")
    ELSE
      IF key$="title" THEN txt$=GW_NEW_DLG_TITLE$(txt$) ELSE txt$=WEB$(txt$)
      JS("populate("+DQ$+ctl$+"-"+key$+DQ$+","+DQ$+txt$+DQ$+")")
    ENDIF
    JS("$('#"+ctl$+"').enhanceWithin().popup('refresh')")
  ELSE % Unknown key -> assume HTML attribute
    IF LEFT$(ctl$,1)<>"." THEN ctl$="#"+ctl$ % handle MODIFYing a whole class=multiple controls at once
    JS("$('"+ctl$+"').attr('"+key$+"',"+DQ$+txt$+DQ$+")")
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_AMODIFY(ctl_id, key$, t$[]) % ARRAY-MODIFY
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_AMODIFY")
  ctl$=GW_ID$(ctl_id)
  key$=LOWER$(key$)
  DQ$=CHR$(34)
  ctyp$=ctl$
  WHILE ASCII(ctyp$, LEN(ctyp$))<58
    ctyp$=LEFT$(ctyp$, LEN(ctyp$)-1)
  REPEAT
  % Push the new content inside the control
  IF key$="content" & ctyp$="table" % TABLE
    n_cols=GW_GET_NKEY("table-column", VAL(MID$(ctl$, 6)))
    JS("populate("+DQ$+ctl$+DQ$+","+DQ$+WEB$(GW_NEW_TBL$(n_cols,t$[]))+DQ$+")")
  ELSEIF key$="content" & ctyp$="gallery" % GALLERY
    e$=GW_ADD_GALLERY$(t$[])
    i=IS_IN("<script>", e$)
    JS("populate("+DQ$+ctl$+DQ$+","+DQ$+LEFT$(e$, i-1)+DQ$+")") % DOM part
    e$=LTRIM$(MID$(e$, i), "<script>")
    e$=RTRIM$(e$, "</script>")
    JS(e$) % Script
    JS("$('#"+ctl$+"').data('lightGallery').destroy(true)") % kill lightGallery
    JS("$('#"+ctl$+"').lightGallery()") % and create new instance
    JS("$('#"+ctl$+"').justifiedGallery().on('jg.complete',function(e){RFO('jgComplete');})")
    DO: r$=GW_ACTION$(): PAUSE 1: UNTIL r$="jgComplete"
  ELSEIF key$="content" & ctyp$="selectbox" % SELECTBOX
    JS("$('#"+ctl$+"').html("+DQ$+GW_NEW_OPT$(t$[])+DQ$+").selectmenu('refresh')")
  ELSEIF (key$="lmenu" | key$="rmenu") & (ctyp$="titlebar" | ctyp$="footbar") % TITLEBAR/FOOTBAR
    JS("$('#"+ctl$+"-"+key$"').html("+DQ$+GW_NEW_OPT$(t$[])+DQ$+").selectmenu('refresh')")
  ELSEIF key$="list" & ctyp$="inputlist" % INPUTLIST
    li$=REPLACE$(GW_NEW_LI$(t$[]), CHR$(34), CHR$(92,34)) % protect double quotes
    JS("$('#"+ctl$+"-ul').html("+DQ$+li$+DQ$+").filterable('refresh')")
  ELSEIF key$="buttons" & IS_IN("dlg", ctyp$)=1 % DIALOGs (MESSAGE/INPUT/CHECKBOX)
    custo$=GW_THEME_CUSTO$("dlg")
    hor=IS_IN("inline", LOWER$(custo$)) % CUSTO 'inline' means horizontal buttons, else vertical buttons
    JS("populate('"+ctl$+"-buttons',"+DQ$+GW_NEW_DLG_BTN$(t$[], hor)+DQ$+")")
  ELSEIF key$="content" & ctyp$="listview" % LISTVIEW
    IF IS_IN("#", t$[1])=1 % ordered list
      JS("replace('"+ctl$+"','ol')")
    ELSE % unordered list
      JS("replace('"+ctl$+"','ul')")
    ENDIF
    IF IS_IN("~", t$[1])=1 THEN sortable=1 % sortable list
    ARRAY.LENGTH n, t$[]
    FOR i=1 TO n
      IF IS_IN("|", t$[i]) THEN swipeable=1 : F_N.BREAK % swipeable list
    NEXT
    PAUSE 100
    JS("populate("+DQ$+ctl$+DQ$+","+DQ$+GW_NEW_LV$(t$[])+DQ$+")")
    IF swipeable THEN sc$="add" ELSE sc$="remove"
    JS("$('#"+ctl$+")."+sc$+"Class('swipe-delete')")
    IF sortable
      js$ =ctl$+"changed=0;"
      js$+="$('#"+ctl$+" li').each(function(){"
      js$+="$(this).attr('id',$(this).index());});"
      js$+="$('#"+ctl$+"').sortable();"
      js$+="$('#"+ctl$+"').disableSelection();"
      js$+="$('#"+ctl$+"').bind('sortstop',function(){"
      js$+="$('#"+ctl$+"').listview('refresh');"
      js$+=ctl$+"changed=1;});"
      JS(js$)
    ENDIF
    JS("$('#"+ctl$+"').listview()") % necessary to keep JQM listview layout
    JS("$('#"+ctl$+"').listview('refresh')") % necessary to keep JQM listview layout
    IF swipeable THEN JS("swipe_lv()") % necessary to activate swipeable listview
  ELSE % Throw an error
    e$="Error in GW_AMODIFY() of control '"+ctl$+"' (id "+INT$(ctl_id)+").\n"
    e$+="Incorrect key: '"+key$+"'.\n"
    e$+="See the GW API cheatsheet for the list of correct keys."
    END e$
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_FOCUS(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_FOCUS")
  ctl$=GW_ID$(ctl_id)
  JS("document.getElementById('"+ctl$+"').focus()")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_DISABLE(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_DISABLE")
  ctl$=GW_ID$(ctl_id)
  IF LEFT$(ctl$, 1) <> "." THEN ctl$="#"+ctl$
  JS("$('"+ctl$+"').addClass('ui-disabled')")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ENABLE(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_ENABLE")
  ctl$=GW_ID$(ctl_id)
  IF LEFT$(ctl$, 1) <> "." THEN ctl$="#"+ctl$
  JS("$('"+ctl$+"').removeClass('ui-disabled')")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_HIDE(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_HIDE")
  ctl$=GW_ID$(ctl_id)
  ctyp$=ctl$
  WHILE ASCII(ctyp$, LEN(ctyp$))<58
    ctyp$=LEFT$(ctyp$, LEN(ctyp$)-1)
  REPEAT
  IF ctyp$="radio" | ctyp$="checkbox"
    JS("$('#"+ctl$+"').parent().hide()")
  ELSEIF IS_IN("input", ctyp$)=1 | ctyp$="selectbox" | ctyp$="flipswitch" | ctyp$="inpbox" | ctyp$="slider"
    JS("$('#"+ctl$+"').parent().parent().hide()")
  ELSEIF ctyp$="colorpicker"
    JS("$('#"+ctl$+"').parent().parent().parent().hide()")
  ELSE
    JS("$('#"+ctl$+"').hide()")
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SHOW(ctl_id)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_SHOW")
  ctl$=GW_ID$(ctl_id)
  ctyp$=ctl$
  WHILE ASCII(ctyp$, LEN(ctyp$))<58
    ctyp$=LEFT$(ctyp$, LEN(ctyp$)-1)
  REPEAT
  IF ctyp$="radio" | ctyp$="checkbox"
    JS("$('#"+ctl$+"').parent().show()")
  ELSEIF IS_IN("input", ctyp$)=1 | ctyp$="selectbox" | ctyp$="flipswitch" | ctyp$="inpbox" | ctyp$="slider"
    JS("$('#"+ctl$+"').parent().parent().show()")
  ELSEIF ctyp$="colorpicker"
    JS("$('#"+ctl$+"').parent().parent().parent().show()")
  ELSE
    JS("$('#"+ctl$+"').show()")
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% OTHER FUNCTIONS: DEBUG, CODE-HIGHLIGHT, SUB-FUNCTIONS NEEDED BY ABOVE ONES, ETC.
%---------------------------------------------------------------------------------------------
FN.DEF GW_KEY_IDX(k$) % (internal) return number of elements of type 'k$' in global bundle
  BUNDLE.CONTAIN 1, "gw-"+k$+"-index", idx
  IF idx THEN BUNDLE.GET 1, "gw-"+k$+"-index", idx
  FN.RTN idx
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_NKEY(k$, nb) % (internal) add a numeric element of type 'k$' to global bundle
  idx=GW_KEY_IDX(k$) + 1
  BUNDLE.PUT 1, "gw-"+k$+"-value-"+INT$(idx), nb
  BUNDLE.PUT 1, "gw-"+k$+"-index", idx
  FN.RTN idx
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SET_NKEY(k$, idx, nb) % (internal) set numeric element of type 'k$' and index 'idx'
  BUNDLE.PUT 1, "gw-"+k$+"-value-"+INT$(ABS(idx)), nb
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_GET_NKEY(k$, idx) % (internal) retrieve a numeric element of type 'k$' from global bundle
  BUNDLE.GET 1, "gw-"+k$+"-value-"+INT$(ABS(idx)), nb
  FN.RTN nb
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_SKEY(k$, content$) % (internal) add a string element of type 'k$' to global bundle
  idx=GW_KEY_IDX(k$) + 1
  BUNDLE.PUT 1, "gw-"+k$+"-content-"+INT$(idx), content$
  BUNDLE.PUT 1, "gw-"+k$+"-index", idx
  FN.RTN idx
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_SET_SKEY(k$, idx, content$) % (internal) set string element of type 'k$' and index 'idx'
  BUNDLE.PUT 1, "gw-"+k$+"-content-"+INT$(ABS(idx)), content$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_GET_SKEY$(k$, idx) % (internal) retrieve a string element of type 'k$' from global bundle
  BUNDLE.GET 1, "gw-"+k$+"-content-"+INT$(ABS(idx)), content$
  FN.RTN content$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_REGISTER(cmd$) % (internal) register a command name in case of error
  BUNDLE.PUT 1, "gw-last-command", cmd$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_LAST_COMMAND$() % (internal) retrieve name of last command executed
  BUNDLE.GET 1, "gw-last-command", cmd$
  FN.RTN cmd$+"()"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_PAGE$(page) % (internal) get Unique IDentifier of the page
  ls=GW_KEY_IDX("page")
  e$="Bad page id: '"+INT$(page)+"' in command "+GW_LAST_COMMAND$()+".\n" % in case of error
  IF page=0 % Throw an error
    e$+="Undefined page." : END e$
  ELSEIF page > 0
    e$+="You most probably used a control id instead of a page id." : END e$
  ELSEIF ABS(page) > ls
    e$+="Out of range (last page id is '-"+INT$(ls)+"')." : END e$
  ENDIF
  e$=GW_GET_SKEY$("page", page)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_LAST_ID()
  % Return Unique IDentifier of last added control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ID(ctl$)
  % Get Unique IDentifier of the control
  FOR i=1 TO GW_KEY_IDX("control")
  IF GW_GET_SKEY$("control", i)=ctl$ THEN ctl_id=i : F_N.BREAK
  NEXT
  FN.RTN ctl_id
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ID$(ctl_id)
  % Get Unique IDentifier of the control
  ls=GW_KEY_IDX("control")
  e$="Bad control id: '"+INT$(ctl_id)+"' in command "+GW_LAST_COMMAND$()+".\n" % in case of error
  IF ctl_id=0 % Throw an error
    e$+="Undefined control." : END e$
  ELSEIF ctl_id < 0
    e$+="You most probably used a page id instead of a control id." : END e$
  ELSEIF ctl_id > ls
    e$+="Out of range (last control id is '"+INT$(ls)+"')." : END e$
  ENDIF
  ctl$=GW_GET_SKEY$("control", ctl_id)
  FN.RTN ctl$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_THEME$(theme) % (internal)
  % Get Unique IDentifier of the theme-customization
  ls=GW_KEY_IDX("custo")
  IF theme <= ls THEN theme$=GW_GET_SKEY$("custo", theme)
  FN.RTN theme$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_DUMP(page)
  GW_REGISTER("GW_DUMP")
  PRINT GW_PAGE$(page)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_DUMP_TO_FILE(page, fname$)
  GW_REGISTER("GW_DUMP_TO_FILE")
  e$=GW_PAGE$(page)
  f$=fname$
  IF !IS_IN(".htm", LOWER$(f$)) THEN f$+=".html"
  BYTE.OPEN w, fid, f$
  BYTE.WRITE.BUFFER fid, e$
  BYTE.CLOSE fid
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_INJECT_HTML(page, html$)
  GW_REGISTER("GW_INJECT_HTML")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + html$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_PLACEHOLDER$()
  % Create the control
  u$=GW_NEWID$("placeholder")
  e$ ="<!-- "+u$+" -->"
  e$+="<!-- /"+u$+" -->"
  % Add to the list of controls + return its content
  GW_ADD_SKEY("control", u$)
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_PLACEHOLDER(page)
  % Add the control to the page
  GW_REGISTER("GW_ADD_PLACEHOLDER")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_PLACEHOLDER$())
  % Return the index of the control
  FN.RTN GW_KEY_IDX("control")
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_FILL_PLACEHOLDER (page, ctl_id, html$)
  GW_REGISTER("GW_FILL_PLACEHOLDER")
  e$=GW_PAGE$(page)
  ctl$=GW_ID$(ctl_id)
  i=IS_IN("<!-- "+ctl$+" -->", e$)
  j=IS_IN("<!-- /"+ctl$+" -->", e$)
  IF i & j & j>i
    i+=LEN("<!-- "+ctl$+" -->")
    GW_SET_SKEY("page", page, LEFT$(e$, i-1)+html$+MID$(e$, j))
  ENDIF
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LISTENER$(ctl_id, event$, action$)
  % Get Unique IDentifier of the control
  GW_REGISTER("GW_ADD_LISTENER$")
  IF ctl_id THEN ctl$=GW_ID$(ctl_id)
  % Create the listener
  event$=REPLACE$(event$, "longpress", "taphold")
  e$="<script>"
  IF ctl_id=0 % listener on whole page
    IF IS_IN("idle", event$)=1 % listener on 'idle' page
      idletime$=MID$(event$, 5)
      e$+="var idleTime=0;$(document).ready(function(){"
      e$+="var idleInterval=setInterval(timerIncrement,1000);"
      e$+="$(this).mousemove(function(e){idleTime=0;});"
      e$+="$(this).keypress(function(e){idleTime=0;});});"
      e$+="function timerIncrement(){idleTime++;"
      e$+="if(idleTime>"+idletime$+"){RFO('"+action$+"');}}"
    ELSE % listener on any other event on page
      e$+="$(document).on('"+event$+"', function"
      e$+="(event){RFO('"+action$+"');})"
    ENDIF
  ELSEIF IS_IN("menuchange", event$)=2 % titlebar/footbar menu listener
    ctl$+="-"+LEFT$(event$,5)
    e$+="$(document.body).on('change', "
    e$+="'#"+ctl$+"', function(){RFO('"+action$
    e$+=":'+$('#"+ctl$+" option:selected').text());})"
  ELSEIF IS_IN("panel", ctl$)=1 % panel listener
    e$+="$('#"+ctl$+"').on('panel"+event$+"',"
    e$+="function(){RFO('"+action$+"');})"
  ELSEIF IS_IN("colorpicker", ctl$)=1 % colorpicker listener
    e$+="$('#"+ctl$+"').minicolors({'"+event$+"':function"
    e$+="(col,alf){RFO('"+action$+"'+col)}})"
  ELSE % listener on any other control
    IF event$="clear"
      e$+="$(document.body).on('click','.ui-input-clear',function(){"
      e$+="if(this.parentNode.firstChild.id=='"+ctl$+"')"
    ELSE
      e$+="$(document.body).on('"+event$+"', "
      e$+="'#"+ctl$+"', function(){"
    ENDIF
    e$+="RFO('"+action$+"');})"
  ENDIF
  e$+="</script>"
  FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ADD_LISTENER(page, ctl_id, event$, action$)
  % Add the listener to the page
  GW_REGISTER("GW_ADD_LISTENER")
  GW_SET_SKEY("page", page, GW_PAGE$(page) + GW_ADD_LISTENER$(ctl_id, event$, action$))
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_ENABLE_LISTENER(e$)
  e$=LTRIM$(e$, "<script>")
  e$=RTRIM$(e$, "</script>")
  JS(e$)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_LINK$(e$) % (internal)
  IF RIGHT$(e$, 1)=">"
    r$="<a target='_blank' href='"
    lnk$=LEFT$(e$, LEN(e$)-1)
  ELSE
    r$="<a href='"
    lnk$=e$
  ENDIF
  r$+=lnk$+"'>"+lnk$+"</a>"
  FN.RTN r$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_NEWID$(ctl$) % (internal) Return a Unique IDentifier string for a control family
  BUNDLE.CONTAIN 1, ctl$, bc
  IF !bc THEN BUNDLE.PUT 1, ctl$, 0
  BUNDLE.GET 1, ctl$, n
  BUNDLE.PUT 1, ctl$, n+1
  FN.RTN ctl$+INT$(n+1)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF ENT$(i) % (internal) Return either int or float: 1.0 returns "1" ; 1.2 returns "1.2"
  e$=TRIM$(STR$(i))
  IF RIGHT$(e$, 2)=".0" THEN FN.RTN INT$(i) ELSE FN.RTN e$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF URL_ENCODE$(e$) % (internal) Safely URL-encode the string
  WHILE ++c <= LEN(e$)
    a=ASCII(MID$(e$, c, 1))
    IF (a>=48 & a<=57) | (a>=65 & a<=90) | (a>=97 & a<=122)
        r$+=CHR$(a)
    ELSE
      r$+="%"+RIGHT$("0"+HEX$(a), 2)
    ENDIF
  REPEAT
  FN.RTN r$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF WEB$(e$) % (internal) Return an HTML-safe version of the string
  r$=REPLACE$(e$, "°", "&deg;")
  r$=REPLACE$(r$, "\t", "&nbsp;&nbsp;&nbsp;")
  r$=REPLACE$(r$, "\n", "<br>")
  r$=REPLACE$(r$, CHR$(34), "&quot;")
  FN.RTN r$
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF DQP$(e$) % (internal) Return a double-quoted + double-quote-protected version of the string
  FN.RTN CHR$(34) + REPLACE$(e$, CHR$(34), CHR$(92,34)) + CHR$(34)
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_CODE_HIGHLIGHT$(raw$, black$[], blue$[], red$[])
  r$=REPLACE$(raw$, "\n", "<br>")
  gwcod$="font-family: \"Lucida Console\", Monaco, monospace; font-size: 14px;"
  gwstr$="color:#007f0e; font-style:italic; font-weight: bold;"
  gwbla$="font-weight: bold;"
  gwblu$="color:blue; font-weight: bold;"
  gwred$="color:red; font-weight: bold;"
  % Highlight content of strings (between double quotes)
  span$="<span style='"+gwstr$+"'>"
  i=IS_IN(CHR$(34), r$)
  WHILE i
    r$=LEFT$(r$, i)+span$+MID$(r$, i+1) % Opening double quote
    i=IS_IN(CHR$(34), r$, i+1)
    r$=LEFT$(r$, i-1)+"</span>"+MID$(r$, i) % Closing double quote
    i+=LEN("</span>")
    i=IS_IN(CHR$(34), r$, i+1)
  REPEAT
  % Highlight inline comments
  i=IS_IN("%", r$)
  WHILE i
    j=IS_IN("<", r$, i)
    IF !j THEN j=LEN(r$)+1
    r$=LEFT$(r$, i)+span$ +MID$(r$, i+1, j-i-1)+"</span>"+ MID$(r$, j)
    i=IS_IN("%", r$, j)
  REPEAT
  % Highlight GW keywords in blue
  span$="<span style='"+gwblu$+"'>"
  ARRAY.LENGTH al, blue$[]
  FOR i=1 TO al
    r$=REPLACE$(r$, blue$[i], span$+blue$[i]+"</span>")
  NEXT
  % Highlight BASIC! keywords in black
  span$="<span style='"+gwbla$+"'>"
  ARRAY.LENGTH al, black$[]
  FOR i=1 TO al
    r$=REPLACE$(r$, black$[i], span$+black$[i]+"</span>")
  NEXT
  % Highlight operators in red
  span$="<span style='"+gwred$+"'>"
  ARRAY.LENGTH al, red$[]
  FOR i=1 TO al
    r$=REPLACE$(r$, red$[i], span$+red$[i]+"</span>")
  NEXT
  FN.RTN "<p style='"+gwcod$+"'>"+r$+"</p>"
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_KEYWORD_NB()
  DIM kw$[399]
  GW_POPULATE_KEYWORD_ARRAY(kw$[])
  ARRAY.SEARCH kw$[], "", nb
  FN.RTN nb-1
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

FN.DEF GW_POPULATE_KEYWORD_ARRAY(kw$[])
  ARRAY.LENGTH al, kw$[]
  GRABFILE e$, "../source/GW.bas"
  i=IS_IN("% Complete list of APIs:", e$)+LEN("% Complete list of APIs:")
  j1=IS_IN("TODO TODO", e$, i)
  j2=IS_IN("% Changelog:", e$, i)
  IF j1 THEN j=j1 ELSE j=j2
  e$=MID$(e$, i, j-i)
  i=0
  DO
    i=IS_IN("GW_", e$, i+1)
    IF i
      nb++
      IF nb>al THEN FN.RTN 0
      j=IS_IN("(", e$, i)
      k=IS_IN("[", e$, i)
      l=IS_IN(" ", e$, i)
      m=IS_IN("$", e$, i)
      n=IS_IN("=", e$, i)
      IF k<j THEN SWAP j,k
      IF l<j THEN SWAP j,l
      IF m<j THEN SWAP j,m : j++
      IF n<j THEN SWAP j,n
      IF MID$(e$, j-1, 1)=" " THEN j--
      k$=MID$(e$, i, j-i)
      ARRAY.SEARCH kw$[], k$, as
      IF as THEN nb=nb-1 ELSE kw$[nb]=k$
    ENDIF
    kw$[++nb]="GW_GET_IMAGE_DIM$"
    kw$[++nb]="GW_LINK$"
  UNTIL !i
FN.END
IF !GW_SILENT_LOAD THEN GW_LOAD_PG(++GW_CFN, GW_NFN)

%---------------------------------------------------------------------------------------------
% GW LIB AUTO-UPDATER
%---------------------------------------------------------------------------------------------

IF !IS_APK()
  gws$="../../.gw.last.check" : GRABFILE gwv$, gws$
  TIME gwy$,gwm$,gwd$ : IF gwy$+gwm$+gwd$=gwv$ THEN GOTO newv_skip % already checked today > skip
  HTML.LOAD.URL "javascript:$('#label1').html('<small><i>Editor mode: checking GW lib update</i></small>')"
  gw$="http://laughton.com/basic/programs/html/GW%20(GUI-Web%20lib)/GW.bas": BYTE.OPEN r, gwi, gw$
  IF gwi<0 THEN gw$="http://mougino.free.fr/tmp/GW/GW.bas": BYTE.OPEN r, gwi, gw$
  IF gwi<0 THEN GOTO newv_skip
  BYTE.READ.BUFFER gwi, 20, gwv$ : BYTE.CLOSE gwi
  BYTE.OPEN w, gwi, gws$ : BYTE.WRITE.BUFFER gwi, gwy$+gwm$+gwd$ : BYTE.CLOSE gwi % update last time checked
  gwv$=LEFT$(gwv$, IS_IN("\n", gwv$)-1)
  gwv$=TRIM$(MID$(gwv$, IS_IN(CHR$(34), gwv$)), CHR$(34))
  IF gwv$<=GW_VER$ THEN GOTO newv_skip
  ARRAY.LOAD newv_ar$[], "DOWNLOAD>DL", "Ignore>CONT"
  newv_pg=GW_NEW_PAGE()
  gwe$="A new version is available:\nGW lib "+gwv$+"\n\n"
  gwe$+="(current version: "+GW_VER$+")"
  GW_USE_THEME_CUSTO_ONCE("inline")
  newv_dlg=GW_ADD_DIALOG_MESSAGE(newv_pg, "GW LIB", gwe$, newv_ar$[])
  GW_USE_THEME_CUSTO_ONCE("color=b")
  newv_spin=GW_ADD_SPINNER(newv_pg, "Downloading GW lib "+gwv$)
  GW_RENDER(newv_pg): GW_SHOW_DIALOG(newv_dlg)
  IF GW_WAIT_ACTION$()<>"DL" THEN GOTO newv_skip
  GW_SHOW_SPINNER(newv_spin)
  gws$="../source/GW"
  BYTE.OPEN r, gwi, gw$
  IF gwi<0 THEN GOTO newv_err
  BYTE.COPY gwi, gws$+".tmp"
  GRABFILE gwe$, gws$+".tmp"
  IF !IS_IN("%-- END OF GW LIB --%", gwe$, -1) THEN GOTO newv_err % check integrity of the lib
  BYTE.OPEN r, gwi, REPLACE$(gw$, "GW.bas", "GW_demo.bas")
  IF gwi<0 THEN GOTO newv_err
  BYTE.COPY gwi, gws$+"_demo.tmp"
  GRABFILE gwe$, gws$+"_demo.tmp"
  IF !IS_IN("%-- END OF GW DEMO --%", gwe$, -1) THEN GOTO newv_err % check integrity of the demo
  FILE.RENAME gws$+".tmp", gws$+".bas"
  FILE.RENAME gws$+"_demo.tmp", gws$+"_demo.bas"
  POPUP "GW lib and demo have\nbeen updated to "+gwv$
  GW_HIDE_SPINNER()
  IF VERSION$() > "01.90.01" THEN HTML.CLOSE : RUN ELSE GOTO newv_skip
  newv_err:
  GW_HIDE_SPINNER()
  FILE.DELETE gwi, gws$+".tmp"
  FILE.DELETE gwi, gws$+"_demo.tmp"
  POPUP "Error downloading\nGW lib "+gwv$
  newv_skip:
ENDIF
%-- END OF GW LIB --%
