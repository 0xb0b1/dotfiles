import XMonad

import System.IO
import Control.Monad
-- import Graphics.X11.ExtraTypes.XF86

import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalMouseBindings)

import XMonad.Layout.Gaps
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
import XMonad.Actions.GridSelect
import qualified XMonad.Actions.ConstrainedResize as Sqr

-- WORKSPACES   [0-5]
myWorkspaces :: [String]
myWorkspaces    = [
                      "ONE"         -- index 0
                    , "TWO"         -- index 1
                    , "THREE"       -- index 2
                    , "FOUR"        -- index 3
                    , "FIVE"        -- index 4
                    , "SIX"         -- index 5
                    ]

myLogHook handle = dynamicLogWithPP $ wColor handle

-- WORKSPACE COLOUR
wColor :: Handle -> PP
wColor handle = def
    { ppOutput          = hPutStrLn handle
  , ppVisible           = dzenColor "#FFFFFF" "#272727" . pad . wrap  " "  " "
  , ppCurrent           = dzenColor "#272727" "#FFFFFF" . pad . wrap  " "  " "
  , ppHidden            = dzenColor "#FFFFFF" "#272727" . pad . wrap  " "  " "
  , ppHiddenNoWindows   = dzenColor "#444444" "#272727" . pad . wrap  " "  " "
  , ppSep               = "   "
  , ppLayout            = wrap iStart iSep .
          ( \f -> case f of
        "Spacing Circle"        -> " ^i("++wIcons++"circle.xbm)^ca()" ++ " "
        "Spacing ResizableTall" -> " ^i("++wIcons++"sptall.xbm)^ca()" ++ " "
        "Spacing SimplestFloat" -> " ^i("++wIcons++"float.xbm)^ca()" ++ " "
        "Full"                  -> " ^i("++wIcons++"full.xbm)^ca()" ++ " "
        )
        ,ppOrder = \(ws:l:t:_) -> [l,ws,t]
        }
  where iStart  = "^bg(" ++ "#313131" ++ ")^fg(" ++ "#FFFfFf" ++ ")" ++ " " ++ wIcons1
        iSep    = " "
        wIcons  = "~/.xmonad/icons/"
        wIcons1 = " ^i(~/.xmonad/icons/)"

-- GRID SELECTOR COLOURS
greyColorizer = colorRangeFromClassName
    black            -- lowest inactive bg
    black            -- highest inactive bg
    white            -- active bg
    white            -- inactive fg
    black            -- active fg
  where white = maxBound
        black = minBound

-- GRIG CONFIG
gridConfig colorizer    = (buildDefaultGSConfig greyColorizer)
    { gs_cellheight     = 65
    , gs_cellwidth      = 150
    , gs_cellpadding    = 20
    , gs_font           = "xft:Exo 2:size=8"
    }

-- LAYOUTS
myLayout = gaps [(U, 32), (R, 2), (L, 2), (D, 2)] (avoidStruts $ smartBorders (spacing 2 $ resizable ||| Circle ||| float)) ||| full
  where
    float       = simplestFloat
    full        = noBorders (fullscreenFull Full)
    resizable   = ResizableTall 1 (2/100) (1/2) []

-- KEYBINGS
myKeys = [

  -- APPS
    ((mod4Mask, xK_Return), spawn "xst -e tmux")
    , ((mod4Mask, xK_a), spawn "chromium")
    , ((mod4Mask, xK_p), spawn "xst -e ranger")
    , ((mod4Mask, xK_t), spawn "telegram-desktop")
    , ((mod4Mask, xK_d), spawn "rofi -show run -matching fuzzy -font 'Exo 2 12' -padding 60 -width 35 -lines 6 -click-to-exit rofi -color-normal '#272727,#EEF6F6,#272727,#FFFFFF,#000000' -color-window '#272727,#FFFFFF,#272727' -hide-scrollbar")

-- GRID
    , ((mod4Mask, xK_m), goToSelected $ gridConfig greyColorizer)
    , ((mod4Mask .|. shiftMask, xK_m), bringSelected $ gridConfig greyColorizer)

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

-- FOR RESIZABLE WINDOW
    , ((mod4Mask, xK_h), sendMessage Shrink)
    , ((mod4Mask, xK_l), sendMessage Expand)

-- BRIGHTNESS
    , ((mod4Mask .|. shiftMask, xK_i), spawn "xbacklight -inc 5")
    , ((mod4Mask .|. shiftMask, xK_u), spawn "xbacklight -dec 5")

-- VOLUME, change it if you don't use `alsa`
    , ((mod4Mask, xK_i), spawn "amixer -q sset Master 5%+ unmute")
    , ((mod4Mask, xK_u), spawn "amixer -q sset Master 5%- unmute")

-- EDIT CONFIGURATION FILE
    , ((mod4Mask, xK_e), spawn "emacs $HOME/.xmonad/xmonad.hs")

-- RECOMPILE AND RESTART XMONAD
    , ((mod4Mask, xK_r), spawn "xmonad --restart")
    , ((mod4Mask, xK_q), spawn "killall dzen2; xmonad --recompile; xmonad --restart")

-- CLOSE WINDOW
    , ((mod4Mask, xK_x), killAll)]

-- MOUSE RESIZE AND MOVE
myMouseKeys = [ ((mod4Mask .|. shiftMask, button3), \w -> focus w >> Sqr.mouseResizeWindow w True) ]

-- APP RULES
myApps = composeAll
  [ className =? "Chromium"      --> doShift (myWorkspaces !! 1)
  , className =? "Anki"             --> doShift (myWorkspaces !! 5)
  , className =? "TelegramDesktop"  --> doShift (myWorkspaces !! 3)
  , className =? "Sxiv"             --> doFullFloat     <+> doShift (myWorkspaces !! 4)
  , className =? "mpv"              --> doCenterFloat   <+> doShift (myWorkspaces !! 4)
  ]

-- AUTOSTART
myStartupHook :: X()
myStartupHook = do
    spawn "hsetroot -fill $HOME/Images/daft.jpg"
    spawn "xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"

-- STATUS BAR
myRightBar  = "sleep 0.1;conky -c $HOME/.xmonad/bar | dzen2 -p -ta r -fn 'Exo 2:size=10' -fg '#FFFFFF' -bg '#272727' -x 520 -h 30 -w 1350"
myLeftBar   = "sleep 0.1;dzen2 -p -ta l -fn 'Exo 2:size=10' -fg '#FFFFFF' -bg '#272727' -h 30 -w 650"

-- CONFIG
main = do
    barL <- spawnPipe myLeftBar
    barR <- spawnPipe myRightBar

    xmonad $ def
        { manageHook = myApps <+> manageDocks <+> manageHook def
        , layoutHook = myLayout
        , modMask = mod4Mask
        , borderWidth = 1
        , normalBorderColor = "#272727"
        , focusedBorderColor = "#FFFFFF"
        , workspaces = myWorkspaces
        , logHook = myLogHook barL
        , startupHook = myStartupHook
            } `additionalKeys` myKeys
              `additionalMouseBindings` myMouseKeys

