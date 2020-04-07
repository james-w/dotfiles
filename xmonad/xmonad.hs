import qualified Data.Map as M
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import XMonad.Util.Run(spawnPipe)
import System.IO
import Graphics.X11.ExtraTypes.XF86


myKeyBindings conf@(XConfig {XMonad.modMask = modm}) = keys defaultConfig conf `M.union` (M.fromList $
    [
     ((modm, xK_b), nextWS)
   , ((modm, xK_v), prevWS)
   , ((modm, xK_c), sendMessage ToggleStruts)
   , ((shiftMask .|. modm, xK_l), spawn "gnome-screensaver-command -l")
   , ((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse sset Master 5%-")
   , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse sset Master 5%+")
   , ((0, xF86XK_AudioMute), spawn "amixer -D pulse sset Master toggle")
   , ((modm .|. shiftMask    , xK_equal    ), windows $ copyToAll)    -- Pin to all workspaces
   , ((modm                  , xK_minus    ), killAllOtherCopies )    -- remove from all but current
    ] ++
    [((m .|. modm, k), windows $ f i)
         | (i, k) <- zip (workspaces conf) [xK_1 .. xK_9]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]] ++
    [((m .|. modm, k), windows $ f i)
         | (i, k) <- zip (workspaces conf) [xK_a, xK_s, xK_d, xK_f, xK_g]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]])

myWorkspaces :: [[Char]]
myWorkspaces =
    [
        "1:Editor", "2:Personal", "3:Work", "4:Terminal", "5:Other"
    ]

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  noBorders $ layoutHook defaultConfig
        , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#93a1a1" "" . shorten 50
                        , ppUrgent = xmobarColor "#cb4b16" "" . xmobarStrip
                        , ppCurrent = xmobarColor "#859900" "" . xmobarStrip
                        }
                    <+> fadeInactiveLogHook 0.8
        , normalBorderColor = "#002b36"
        , focusedBorderColor = "#657b83"
        , keys = myKeyBindings
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , startupHook = do
            spawn "~/.xmonad/startup-hook"
        , workspaces = myWorkspaces
        }
