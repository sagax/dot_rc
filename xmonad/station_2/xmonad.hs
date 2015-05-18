import System.IO
import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowMenu
import XMonad.Actions.Promote
import XMonad.Actions.SimpleDate
import XMonad.Actions.WorkspaceNames
import XMonad.Config.Gnome
import XMonad.Operations
import Dzen
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.NamedWindows
import XMonad.Util.PositionStore
import XMonad.Util.Themes
import XMonad.Util.CustomKeys
import XMonad.Layout.Circle
import XMonad.Layout.Cross
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.StackTile
import XMonad.Layout.TwoPane
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.Mosaic
import XMonad.Layout.Spacing
import XMonad.Layout.ZoomRow
import XMonad.Layout.Spiral
import XMonad.Layout.SimplestFloat
import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.ShowWName
import XMonad.Layout.Accordion
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.MagicFocus
import XMonad.Layout.MultiColumns
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myModMask = mod4Mask

myLayouts = noBorders Full |||
            ( showWName $ avoidStruts $ smartBorders $ spacing 2 $
              noBorders Full |||
              Tall 2 (10/100) (1/2) |||
              ResizableTall 1 (3/100) (1/2) [] |||
              simpleCross |||
              (reflectVert $ Tall 2 (10/100) (1/2)) |||
              (magnifier $ Tall 1 (10/100) (1/2)) |||
              (magnifier $ Tall 4 (10/100) (1/2)) |||
              multiCol [1] 4 0.01 0.5 |||
              Circle |||
              simpleTabbed |||
              ThreeCol 1 (10/100) (1/3) |||
              ThreeColMid 1 (10/100) (1/3) |||
              TwoPane (10/100) (1/2) |||
              OneBig (3/5) (3/5) |||
              StackTile 2 (10/100) (1/2) |||
              mosaic 2 [3,2] |||
              spiral (6/7) |||
              simplestFloat |||
              zoomRow |||
              Grid |||
              Accordion )
myterminal = "custom-gnome-terminal"
myworkspaces = ["[ 1 ]", "[ 2 ]", "[ 3 ]", "[ 4 ]", "[ 5 ]", "[ 6 ]", "[ 7 ]", "[ 8 ]", "[ 9 ]"]
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myStatusbar = DzenConf {
    x_position = Just 0
  , y_position = Just 0
  , width      = Just 1920
  , height     = Just 24
  , alignment  = Just LeftAlign
  , font       = Just "arial:bold:size=8"
  , fg_color   = Just "#ffffff"
  , bg_color   = Just "#000000"
  , exec       = []
  , addargs    = []
}
myLogHook h = dynamicLogWithPP $ myPrettyPrinter h
myPrettyPrinter h = dzenPP {
    ppOutput   = hPutStrLn h
  , ppCurrent  = dzenColor "#ffffff" "#001542"
  , ppHidden   = dzenColor "#85abff" "#000000"
  , ppHiddenNoWindows = dzenColor "#444444" "#000000"
  , ppUrgent   = dzenColor "#ff0000" "#000000". dzenStrip
  , ppWsSep    = ""
  , ppSep      = " :: "
}
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
    [
      ((modm, xK_g), goToSelected defaultGSConfig)
    , ((modm, xK_b), spawnSelected defaultGSConfig ["gvim", "gpick", "xmonad_start", "mtpain", "gimp", "inkscape", "alsamixergui", "hexchat"])
    , ((modm, xK_o ), windowMenu)
    , ((modm, xK_s), promote)
    , ((modm, xK_d), date)
    , ((modm, xK_a), sendMessage MirrorShrink)
    , ((modm, xK_z), sendMessage MirrorExpand)
    ]

main = do
    workspaceBar <- spawnDzen myStatusbar
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        terminal = myterminal
      , workspaces = myworkspaces
      , logHook  = myLogHook workspaceBar
      , focusFollowsMouse  = myFocusFollowsMouse
      , borderWidth = 4
      , layoutHook = myLayouts
      , manageHook = manageHook defaultConfig <+> manageDocks
      , startupHook = setWMName "LG3D"
      , normalBorderColor = "#444444"
      , focusedBorderColor = "#1477eb"
      , keys = myKeys <+> keys defaultConfig
}
