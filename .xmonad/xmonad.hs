import XMonad
import System.IO
import Control.Monad
import Graphics.X11.ExtraTypes.XF86

import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalMouseBindings)

import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.Circle
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts)

import XMonad.Actions.WithAll
import qualified XMonad.Actions.ConstrainedResize as Sqr
import XMonad.Actions.GridSelect (GSConfig(..), goToSelected, bringSelected, colorRangeFromClassName, buildDefaultGSConfig)

-- ICONS PATH
wIcons = "/home/b0b1/.xmonad/icons/"
wIcons1 = " ^i(/home/b0b1/.xmonad/icons/)"

-- WORKSPACES   [0-5]
myWorkspaces :: [String]
myWorkspaces    = [
                    "TERM"       -- index 0
                    , "WEB"      -- index 1
                    , "CODE"     -- index 2
                    , "CHAT"     -- index 3
                    , "MEDIA"    -- index 4
                    , "DOCS"     -- index 5
                    ]

-- LAYOUT ICONS
iStart = "^bg(" ++ "#616161" ++ ")^fg(" ++ "#111111" ++ ")" ++ " " ++ wIcons1
iSep = ""

myLogHook handle = do
    dynamicLogWithPP $ wColor handle

-- WORKSPACE COLOUR
wColor :: Handle -> PP
wColor handle = def
    { ppOutput          = hPutStrLn handle
  , ppVisible           = dzenColor "#FFFFFF" "#111111" . pad . wrap  " "  " "
  , ppCurrent           = dzenColor "#111111" "#FFFFFF" . pad . wrap  " "  " "
  , ppHidden            = dzenColor "#FFFFFF" "#111111" . pad . wrap  " "  " "
  , ppHiddenNoWindows   = dzenColor "#444444" "#111111" . pad . wrap  " "  " "
  , ppSep               = "  "
  , ppLayout            = wrap iStart iSep .
          ( \f -> case f of
        "Circle"                    -> " ^i("++wIcons++"circle.xbm)^ca()" ++ " CIRCLE"
        "Spacing 2 ResizableTall"   -> " ^i("++wIcons++"sptall.xbm)^ca()" ++ " RESIZ    "
        "Spacing 2 SimplestFloat"   -> " ^i("++wIcons++"float.xbm)^ca()" ++ " FLOAT"
        "Spacing 2 Full"            -> " ^i("++wIcons++"full.xbm)^ca()" ++ " FULL"
        )
        ,ppOrder = \(ws:l:t:_) -> [l,ws,t]
        }

-- GRID SELECTOR COLOURS
myGridConfig = colorRangeFromClassName
    (0x18,0x15,0x12) -- lowest inactive bg
    (0x18,0x15,0x12) -- highest inactive bg
    (0x99,0x99,0x99) -- active bg
    (0x98,0x95,0x84) -- inactive fg
    (0x01,0x01,0x01) -- active fg

-- GSconfig color
myGSConfig colorizer    = (buildDefaultGSConfig myGridConfig)
    { gs_cellheight     = 65
    , gs_cellwidth      = 150
    , gs_cellpadding    = 20
    }

-- LAYOUTS
myLayout = (gaps [(U, 36), (R, 2), (L, 2), (D, 2)] $ avoidStruts $ smartBorders (resizable ||| Circle ||| float)) ||| full
  where
    float       = spacing 2 $ simplestFloat
    full        = spacing 2 $ noBorders (fullscreenFull Full)
    resizable   = spacing 2 $ ResizableTall 1 (2/100) (1/2) []

-- KEYBINGS
myKeys = [
  -- APPS
    ((mod4Mask, xK_Return), spawn "xst")
    , ((mod4Mask, xK_a), spawn "qutebrowser")
    , ((mod4Mask, xK_p), spawn "xst -e ranger")
    , ((mod4Mask, xK_t), spawn "$HOME/Telegram/Telegram")
    , ((mod4Mask, xK_d), spawn  "dmenu_run -b -i -l 3 -p 'MENU: ' -fn 'Exo 2:size=12' -nb '#111111' -nf '#FFFFFF' -sb '#FFFFFF' -sf '#111111' ")

-- GRID
    , ((mod4Mask, xK_m), goToSelected $ myGSConfig myGridConfig)
    , ((mod4Mask .|. shiftMask, xK_m), bringSelected $ myGSConfig myGridConfig)

-- MOVING FLOATING WINDOWS
    , ((mod4Mask, xK_Up), sendMessage (MoveUp 10))
    , ((mod4Mask, xK_Down), sendMessage (MoveDown 10))
    , ((mod4Mask, xK_Left), sendMessage (MoveLeft 10))
    , ((mod4Mask, xK_Right), sendMessage (MoveRight 10))

-- INCREASE THE SIZE OF A FLOATING WINDOW
    , ((mod4Mask .|. shiftMask, xK_Up), sendMessage (IncreaseUp 10))
    , ((mod4Mask .|. shiftMask, xK_Down), sendMessage (IncreaseDown 10))
    , ((mod4Mask .|. shiftMask, xK_Left), sendMessage (IncreaseLeft 10))
    , ((mod4Mask .|. shiftMask, xK_Right), sendMessage (IncreaseRight 10))

-- DECREASE THE SIZE OF A FLOATING WINDOW
    , ((mod4Mask .|. controlMask, xK_k), sendMessage (DecreaseUp 10))
    , ((mod4Mask .|. controlMask, xK_j), sendMessage (DecreaseDown 10))
    , ((mod4Mask .|. controlMask, xK_h), sendMessage (DecreaseLeft 10))
    , ((mod4Mask .|. controlMask, xK_l), sendMessage (DecreaseRight 10))

-- TAKE A SCREENSHOT
    , ((0, 0xff61), spawn "screenshot")

-- FOR RESIZABLE WINDOW
    , ((mod4Mask, xK_h), sendMessage Shrink)
    , ((mod4Mask, xK_l), sendMessage Expand)

-- BRIGHTNESS
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")

-- VOLUME, change it if you don't use `alsa`
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 5%+ unmute")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 5%- unmute")

-- EDIT CONFIGURATION FILE
    , ((mod4Mask, xK_e), spawn "xst -e vim $HOME/.xmonad/xmonad.hs")

-- RECOMPILE AND RESTART XMONAD
    , ((mod4Mask, xK_r), spawn "killall dzen2; xmonad --recompile; xmonad --restart")

-- CLOSE WINDOW
    , ((mod4Mask, xK_x), killAll)]

-- MOUSE RESIZE AND MOVE
myMouseKeys = [ ((mod4Mask .|. shiftMask, button3), \w -> focus w >> Sqr.mouseResizeWindow w True) ]

-- APP RULES
myApps = composeAll
  [ className =? "qutebrowser"      --> doShift (myWorkspaces !! 1)
  , className =? "Anki"             --> doShift (myWorkspaces !! 5)
  , className =? "Sxiv"             --> doFullFloat <+> doShift (myWorkspaces !! 4)
  , className =? "TelegramDesktop"  --> doFullFloat <+> doShift (myWorkspaces !! 3)
  , className =? "mpv"              --> doCenterFloat <+> doShift (myWorkspaces !! 4)
  ]

-- AUTOSTART
myStartupHook :: X()
myStartupHook = do
    spawn "hsetroot -fill $HOME/Images/daft.jpg"
    spawn "xsetroot -cursor_name left_ptr &"
    spawn "xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"

-- STATUS BAR
myRightBar  = "sleep 1;conky -c $HOME/.xmonad/bar | dzen2 -p -ta r -fn 'Exo 2:size=10' -fg '#FFFFFF' -bg '#111111' -x 850 -h 30 -y 4 -w 512"
myLeftBar   = "sleep 1;dzen2 -p -ta l -fn 'Exo 2:size=10' -fg '#FFFFFF' -bg '#111111' -h 30 -x 4 -y 4 -w 860"

-- CONFIG
main = do
    barL <- spawnPipe myLeftBar
    barR <- spawnPipe myRightBar
    xmonad $ def
        { manageHook = myApps <+> manageDocks <+> manageHook def
        , layoutHook = myLayout
        , modMask = mod4Mask
        , borderWidth = 0
        , workspaces = myWorkspaces
        , logHook = myLogHook barL
        , startupHook = myStartupHook
            } `additionalKeys` myKeys
              `additionalMouseBindings` myMouseKeys

