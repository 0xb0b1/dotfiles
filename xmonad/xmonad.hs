--------------------------------------------------------------------------------
-- XMONAD CONFIGURATION
-- A clean, developer-focused tiling window manager setup
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- IMPORTS
--------------------------------------------------------------------------------

-- Core
import XMonad
import qualified XMonad.StackSet as W
import System.IO
import Control.Monad
import Data.Maybe (fromMaybe)

-- Keys
import Graphics.X11.ExtraTypes.XF86

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)

-- Layout
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.ToggleLayouts (toggleLayouts, ToggleLayout(..))
import qualified XMonad.Layout.ToggleLayouts as TL
import XMonad.Layout.Grid
import XMonad.Layout.Spiral
import XMonad.Layout.Renamed
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ThreeColumns
import XMonad.Layout.CenteredMaster
import XMonad.Layout.Tabbed
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts, docks)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

-- Actions
import XMonad.Actions.WithAll
import XMonad.Actions.GridSelect
import qualified XMonad.Actions.ConstrainedResize as Sqr

--------------------------------------------------------------------------------
-- THEME - Catppuccin Frappe
--------------------------------------------------------------------------------

-- Base colors
colorBase, colorMantle, colorCrust :: String
colorBase   = "#303446"
colorMantle = "#292c3c"
colorCrust  = "#232634"

-- Surface colors
colorSurface0, colorSurface1, colorSurface2 :: String
colorSurface0 = "#414559"
colorSurface1 = "#51576d"
colorSurface2 = "#626880"

-- Text colors
colorText, colorSubtext0, colorSubtext1 :: String
colorText     = "#c6d0f5"
colorSubtext0 = "#a5adce"
colorSubtext1 = "#b5bfe2"

-- Accent colors
colorRosewater, colorFlamingo, colorPink, colorMauve :: String
colorRed, colorMaroon, colorPeach, colorYellow :: String
colorGreen, colorTeal, colorSky, colorSapphire, colorBlue, colorLavender :: String

colorRosewater = "#f2d5cf"
colorFlamingo  = "#eebebe"
colorPink      = "#f4b8e4"
colorMauve     = "#ca9ee6"
colorRed       = "#e78284"
colorMaroon    = "#ea999c"
colorPeach     = "#ef9f76"
colorYellow    = "#e5c890"
colorGreen     = "#a6d189"
colorTeal      = "#81c8be"
colorSky       = "#99d1db"
colorSapphire  = "#85c1dc"
colorBlue      = "#8caaee"
colorLavender  = "#babbf1"

-- Overlay colors
colorOverlay0, colorOverlay1, colorOverlay2 :: String
colorOverlay0 = "#737994"
colorOverlay1 = "#838ba7"
colorOverlay2 = "#949cbb"

-- Theme aliases for easier use
colorBg, colorBgAlt, colorFg, colorFgAlt :: String
colorAccent, colorUrgent, colorBorder :: String

colorBg      = colorBase
colorBgAlt   = colorMantle
colorFg      = colorText
colorFgAlt   = colorSubtext0
colorAccent  = colorLavender
colorUrgent  = colorRed
colorBorder  = colorSurface0

myFont :: String
myFont = "xft:JetBrainsMono Nerd Font:size=10"

myFontAlt :: String
myFontAlt = "xft:Vanilla Caramel:size=10"

--------------------------------------------------------------------------------
-- WORKSPACES
--------------------------------------------------------------------------------

myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

--------------------------------------------------------------------------------
-- LAYOUT CONFIGURATION
--------------------------------------------------------------------------------

myLayout = tiledLayouts ||| fullLayout
  where
    tiledLayouts = avoidStruts $ smartBorders $ spacingWithEdge 2 $
        renamed [Replace "tall"]     tall     |||
        renamed [Replace "wide"]     wide     |||
        renamed [Replace "three"]    three    |||
        renamed [Replace "center"]   center   |||
        renamed [Replace "grid"]     grid     |||
        renamed [Replace "spiral"]   sprl     |||
        renamed [Replace "tabbed"]   tabs     |||
        renamed [Replace "float"]    float
    fullLayout = renamed [Replace "full"] $ noBorders Full

    -- Layouts
    tall   = ResizableTall 1 (3/100) (1/2) []           -- Master left, stack right
    wide   = Mirror tall                                 -- Master top, stack bottom
    three  = ThreeColMid 1 (3/100) (1/2)                -- Three columns, master center
    center = centerMaster grid                           -- Master centered, others around
    grid   = Grid                                        -- Equal grid
    sprl   = spiral (6/7)                               -- Fibonacci spiral
    tabs   = tabbed shrinkText myTabConfig              -- Tabbed windows
    float  = simplestFloat                              -- Floating

-- Tabbed layout config (Catppuccin Frappe)
myTabConfig = def
    { fontName            = "xft:Vanilla Caramel:size=10"
    , activeColor         = "#303446"
    , inactiveColor       = "#232634"
    , urgentColor         = "#e78284"
    , activeBorderColor   = "#babbf1"
    , inactiveBorderColor = "#414559"
    , urgentBorderColor   = "#e78284"
    , activeTextColor     = "#c6d0f5"
    , inactiveTextColor   = "#a5adce"
    , urgentTextColor     = "#c6d0f5"
    }

--------------------------------------------------------------------------------
-- GRID SELECT
--------------------------------------------------------------------------------

myGridConfig :: GSConfig Window
myGridConfig = def
    { gs_cellheight   = 80
    , gs_cellwidth    = 280
    , gs_cellpadding  = 8
    , gs_font         = "xft:Vanilla Caramel:style=Bold:size=11"
    , gs_navigate     = navNSearch
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_bordercolor  = colorSurface1
    }

-- Catppuccin colorizer for grid select
myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
    (0x30, 0x34, 0x46)  -- lowest  bg (colorBase)
    (0x41, 0x45, 0x59)  -- highest bg (colorSurface0)
    (0xca, 0x9e, 0xe6)  -- active  bg (colorMauve)
    (0xc6, 0xd0, 0xf5)  -- inactive fg (colorText)
    (0x23, 0x26, 0x34)  -- active   fg (colorCrust)

myGridConfig' :: GSConfig Window
myGridConfig' = myGridConfig { gs_colorizer = myColorizer }

--------------------------------------------------------------------------------
-- LAYOUT NOTIFICATION
--------------------------------------------------------------------------------

-- Get current layout name
getLayoutName :: X String
getLayoutName = do
    ws <- gets windowset
    return $ description . W.layout . W.workspace . W.current $ ws

-- Switch to next layout and show notification
-- Also sinks floating windows back to tiled
switchLayoutWithNotify :: X ()
switchLayoutWithNotify = do
    withFocused $ windows . W.sink  -- Sink floating window first
    sendMessage NextLayout
    layoutName <- getLayoutName
    spawn $ "~/.xmonad/layout-osd.sh '" ++ layoutName ++ "'"

-- Reset to default layout and show notification
resetLayoutWithNotify :: X ()
resetLayoutWithNotify = do
    asks config >>= setLayout . layoutHook
    layoutName <- getLayoutName
    spawn $ "~/.xmonad/layout-osd.sh '" ++ layoutName ++ "'"

--------------------------------------------------------------------------------
-- KEYBINDINGS
--------------------------------------------------------------------------------

myKeys =
    -- Applications (matching sxhkd style)
    [ ((mod4Mask,               xK_Return), spawn "wezterm")
    , ((mod4Mask .|. shiftMask, xK_Return), spawn "wezterm --class floating")
    , ((mod4Mask .|. controlMask, xK_t),    spawn "$HOME/Telegram/Telegram")
    , ((mod4Mask .|. shiftMask, xK_f),      spawn "thunar")

    -- Developer tools
    , ((mod4Mask,               xK_grave),      spawn "wezterm --class dropdown")
    , ((mod4Mask .|. shiftMask, xK_l),          spawn "wezterm -e lazydocker")
    , ((mod4Mask .|. shiftMask, xK_b),          spawn "wezterm -e btop")

    -- Screenshots (using rofi_screenshot like sxhkd)
    , ((0,                      xK_Print),      spawn "sh $HOME/.config/bspwm/scripts/rofi_screenshot")
    , ((mod4Mask,               xK_Print),      spawn "sh $HOME/.config/bspwm/scripts/rofi_screenshot")
    , ((mod4Mask .|. shiftMask, xK_s),          spawn "sh $HOME/.config/bspwm/scripts/rofi_screenshot")

    -- Window management
    , ((mod4Mask,               xK_q),          kill)
    , ((mod4Mask .|. shiftMask, xK_q),          killAll)
    , ((mod4Mask,               xK_space),      switchLayoutWithNotify)
    , ((mod4Mask .|. shiftMask, xK_space),      resetLayoutWithNotify)
    , ((mod4Mask,               xK_Tab),        windows W.focusDown)
    , ((mod4Mask .|. shiftMask, xK_Tab),        windows W.focusUp)
    , ((mod4Mask,               xK_j),          windows W.focusDown)
    , ((mod4Mask,               xK_k),          windows W.focusUp)
    , ((mod4Mask .|. shiftMask, xK_j),          windows W.swapDown)
    , ((mod4Mask .|. shiftMask, xK_k),          windows W.swapUp)
    , ((mod4Mask,               xK_m),          windows W.focusMaster)

    -- Resize
    , ((mod4Mask,               xK_h),          sendMessage Shrink)
    , ((mod4Mask,               xK_l),          sendMessage Expand)
    , ((mod4Mask .|. shiftMask, xK_h),          sendMessage MirrorShrink)
    , ((mod4Mask .|. shiftMask, xK_l),          sendMessage MirrorExpand)
    , ((mod4Mask,               xK_comma),      sendMessage (IncMasterN 1))
    , ((mod4Mask,               xK_period),     sendMessage (IncMasterN (-1)))
    , ((mod4Mask .|. controlMask, xK_space),    sendMessage (TL.Toggle "Full"))

    -- Floating
    , ((mod4Mask,               xK_s),          withFocused $ windows . W.sink)

    -- Grid select
    , ((mod4Mask,               xK_g),          goToSelected myGridConfig')
    , ((mod4Mask .|. shiftMask, xK_g),          bringSelected myGridConfig')

    -- Move floating windows
    , ((mod4Mask,               xK_Up),         sendMessage (MoveUp 10))
    , ((mod4Mask,               xK_Down),       sendMessage (MoveDown 10))
    , ((mod4Mask,               xK_Left),       sendMessage (MoveLeft 10))
    , ((mod4Mask,               xK_Right),      sendMessage (MoveRight 10))

    -- Resize floating windows (increase)
    , ((mod4Mask .|. shiftMask, xK_Up),         sendMessage (IncreaseUp 10))
    , ((mod4Mask .|. shiftMask, xK_Down),       sendMessage (IncreaseDown 10))
    , ((mod4Mask .|. shiftMask, xK_Left),       sendMessage (IncreaseLeft 10))
    , ((mod4Mask .|. shiftMask, xK_Right),      sendMessage (IncreaseRight 10))

    -- Resize floating windows (decrease)
    , ((mod4Mask .|. controlMask, xK_Up),       sendMessage (DecreaseUp 10))
    , ((mod4Mask .|. controlMask, xK_Down),     sendMessage (DecreaseDown 10))
    , ((mod4Mask .|. controlMask, xK_Left),     sendMessage (DecreaseLeft 10))
    , ((mod4Mask .|. controlMask, xK_Right),    sendMessage (DecreaseRight 10))

    -- System
    , ((mod4Mask .|. shiftMask,   xK_r),        spawn "xmonad --restart")
    , ((mod4Mask .|. controlMask, xK_r),        spawn "xmonad --recompile && xmonad --restart")

    -- Volume (using pamixer like sxhkd)
    , ((0, xF86XK_AudioMute),                   spawn "pamixer -t")
    , ((0, xF86XK_AudioLowerVolume),            spawn "pamixer -d 5  --allow-boost")
    , ((0, xF86XK_AudioRaiseVolume),            spawn "pamixer -i 5  --allow-boost")
    , ((mod4Mask, xK_F1),                       spawn "pamixer -t  --allow-boost")
    , ((mod4Mask, xK_F2),                       spawn "pamixer -d 5  --allow-boost")
    , ((mod4Mask, xK_F3),                       spawn "pamixer -i 5  --allow-boost")

    -- Brightness
    , ((0, xF86XK_MonBrightnessUp),             spawn "xbacklight -inc 5")
    , ((0, xF86XK_MonBrightnessDown),           spawn "xbacklight -dec 5")
    , ((mod4Mask, xK_F5),                       spawn "xbacklight -dec 5")
    , ((mod4Mask, xK_F6),                       spawn "xbacklight -inc 5")

    -- Media
    , ((0, xF86XK_AudioPlay),                   spawn "playerctl play-pause")
    , ((0, xF86XK_AudioNext),                   spawn "playerctl next")
    , ((0, xF86XK_AudioPrev),                   spawn "playerctl previous")
    , ((mod4Mask, xK_F7),                       spawn "playerctl previous")
    , ((mod4Mask, xK_F8),                       spawn "playerctl play-pause")
    , ((mod4Mask, xK_F9),                       spawn "playerctl next")

    -- Config editing
    , ((mod4Mask,               xK_e),          spawn "wezterm -e nvim ~/.xmonad/xmonad.hs")
    , ((mod4Mask .|. controlMask, xK_e),        spawn "wezterm -e nvim ~/.config")

    -- Rofi (matching sxhkd)
    , ((mod4Mask,               xK_r),          spawn "sh ~/.config/rofi/scripts/rofi-main.sh")
    , ((mod4Mask,               xK_d),          spawn "sh ~/.config/rofi/scripts/rofi-main.sh")
    , ((mod4Mask,               xK_w),          spawn "sh ~/.config/rofi/scripts/rofi-window.sh")
    , ((mod4Mask .|. shiftMask, xK_p),          spawn "rofi -show run")
    , ((mod4Mask,               xK_x),          spawn "rofi -show ssh")
    , ((mod4Mask,               xK_z),          spawn "~/.xmonad/layout-selector-improved.sh")
    , ((mod4Mask .|. shiftMask, xK_z),          spawn "~/.xmonad/show-current-layout.sh")

    -- Keyboard layout (matching sxhkd)
    , ((mod4Mask,               xK_p),          spawn "sh $HOME/.scripts/change-layout-br")
    , ((mod4Mask,               xK_u),          spawn "sh $HOME/.scripts/change-layout-us")

    -- Compositor toggle
    , ((mod4Mask .|. controlMask, xK_d),        spawn "killall picom || picom --config ~/.config/picom/picom.conf")

    -- Gaming mode toggle
    , ((mod4Mask .|. shiftMask,   xK_g),        spawn "~/.xmonad/gaming-mode.sh")

    -- Gaps
    , ((mod4Mask .|. controlMask, xK_plus),     sendMessage $ IncGap 1 L)
    , ((mod4Mask .|. controlMask, xK_minus),    sendMessage $ DecGap 1 L)
    ]

--------------------------------------------------------------------------------
-- MOUSE BINDINGS
--------------------------------------------------------------------------------

myMouseBindings =
    [ ((mod4Mask .|. shiftMask, button3), \w -> focus w >> Sqr.mouseResizeWindow w True)
    , ((mod4Mask, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
    ]

--------------------------------------------------------------------------------
-- WINDOW RULES
--------------------------------------------------------------------------------

myManageHook = composeAll
    [ className =? "Chromium"        --> doShift "2"
    , className =? "Brave-browser"   --> doShift "2"
    , className =? "TelegramDesktop" --> doShift "3"
    , className =? "Discord"         --> doFloat <+> doShift "3"
    , className =? "Anki"            --> doShift "4"
    , className =? "Calculator"      --> doFloat
    , className =? "Sxiv"            --> doFloat
    , className =? "MPlayer"         --> doFloat
    , className =? "mpv"             --> doFloat
    , className =? "zathura"         --> doShift "4"
    , className =? "dropdown"        --> doFloat
    , className =? "floating"        --> doFloat

    -- Steam
    , className =? "Steam"           --> doShift "1"
    , className =? "steam"           --> doShift "1"
    , title     =? "Steam"           --> doShift "1"
    , title     =? "Friends List"    --> doFloat <+> doShift "1"
    , title     =? "Steam - News"    --> doFloat
    , className =? "Steam" <&&> title =? "" --> doFloat  -- Steam popups
    , className =? "steam_app_0"     --> doFullFloat     -- Steam games
    , className =? "steam_app_730"   --> doFullFloat     -- CS2
    , className =? "cs2"             --> doFullFloat     -- CS2 alternative

    -- Game launchers
    , className =? "Lutris"          --> doShift "5"
    , className =? "heroic"          --> doShift "5"
    , className =? "Heroic"          --> doShift "5"
    , className =? "Battle.net"      --> doShift "5"

    -- Common games - fullscreen and no borders
    , className =? "dota2"           --> doFullFloat
    , className =? "csgo_linux64"    --> doFullFloat
    , className =? "hl2_linux"       --> doFullFloat
    , className =? "Wine"            --> doFullFloat
    , className =? "wine"            --> doFullFloat
    , className =? "Proton"          --> doFullFloat
    , isFullscreen                   --> doFullFloat

    -- Game detection by title patterns
    , title =? "Counter-Strike 2"    --> doFullFloat
    , title =? "Path of Exile"       --> doFullFloat
    , title =? "DARK SOULS"          --> doFullFloat
    , title =? "Elden Ring"          --> doFullFloat
    , title =? "Hunt: Showdown"      --> doFullFloat
    ]

--------------------------------------------------------------------------------
-- STARTUP
--------------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
    -- Set WM name for Java/game compatibility
    setWMName "LG3D"

    -- X11 settings
    spawn "xset s off"
    spawn "xset -dpms"
    spawn "xset r rate 200 40"
    spawn "xsetroot -cursor_name left_ptr"

    -- Keyboard
    spawn "setxkbmap -option caps:escape -layout us"
    spawn "xrdb -load ~/.Xresources"

    -- Applications
    spawnOnce "parcellite"
    spawn "killall redshift; redshift -l 0.01:-99.0 -g 0.8 -t 5200:5200 -r &"

    -- Notifications
    spawn "killall dunst; dunst &"

    -- Compositor
    spawn "killall picom; picom --config ~/.config/picom/picom.conf"

    -- Display
    spawn "xrandr --output DP-2 --mode 1920x1080 --rate 165.00"
    spawn "nitrogen --restore"

    -- Bar (eww)
    spawn "~/.config/eww/launch.sh start"

    -- Dock (plank)
    spawn "killall plank; plank &"

--------------------------------------------------------------------------------
-- STATUS BAR
--------------------------------------------------------------------------------

myBar :: String
myBar = "~/.config/eww/launch.sh start"

--------------------------------------------------------------------------------
-- MAIN
--------------------------------------------------------------------------------

main :: IO ()
main = xmonad $ docks $ ewmhFullscreen $ ewmh def
    { manageHook         = myManageHook <+> manageDocks <+> manageHook def
    , layoutHook         = myLayout
    , modMask            = mod4Mask
    , borderWidth        = 2
    , normalBorderColor  = colorBorder
    , focusedBorderColor = colorAccent
    , workspaces         = myWorkspaces
    , startupHook        = myStartupHook
    } `additionalKeys` myKeys
      `additionalMouseBindings` myMouseBindings
