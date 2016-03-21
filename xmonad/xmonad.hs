import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


myKeyBindings :: [((KeyMask, KeySym), X ())]
myKeyBindings =
    [
     ((mod4Mask, xK_b), nextWS)
   , ((mod4Mask, xK_v), prevWS)
   , ((mod4Mask, xK_c), sendMessage ToggleStruts)
   , ((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l")
    ] ++
    [((m .|. mod1Mask, k), windows $ f i) -- Replace 'mod1Mask' with your mod key of choice.
         | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

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
        , layoutHook = avoidStruts  $  smartBorders $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#93a1a1" "" . shorten 50
                        , ppUrgent = xmobarColor "#cb4b16" "" . xmobarStrip
                        , ppCurrent = xmobarColor "#859900" "" . xmobarStrip
                        }
        , normalBorderColor = "#002b36"
        , focusedBorderColor = "#657b83"
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , startupHook = do
            spawn "~/.xmonad/startup-hook"
        , workspaces = myWorkspaces
        }
        `additionalKeys` myKeyBindings
