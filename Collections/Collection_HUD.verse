
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }
using { /Verse.org/Colors }

using { Player }


# Collection used when dealing with HUD parameter UI (Title Screen, Dialog Box, Heads-Up-Display, etc.)

# -----------------------------------------------------------------------------------------------------------------

base_ui_collection<public> := class<abstract><unique>:

    # Container used to initialize devices:
    PlayerContainer<public> : player_container

    # Sequence ID for Identification:
    SequenceID<public> : string
    
    # Layer that collection belongs to:
    Layer<public> : int = 0

    # Keyframe for Showing a collection:
    KeyframeToShow<public> : float = 0.0

    # Keyframe for Hiding a collection:
    KeyframeToHide<public> : float = 0.0

    # Play Show animation for this period of time:
    ShowDuration<public> : float = 0.0

    # Play Hide animation for this period of time:
    HideDuration<public> : float = 0.0


    Show<public>()<suspends> : void =
        if (Device := PlayerContainer.PlayerDevices.CSDTree[Layer]):
            Print("[ Showing [{SequenceID}] ]", ?Duration := 5.0, ?Color := NamedColors.Cyan)

            Device.SetPlaybackTime(KeyframeToShow)
            Device.Play(PlayerContainer.Agent)

            Sleep(ShowDuration)
            Device.Pause(PlayerContainer.Agent)
            


    Hide<public>()<suspends> : void =
        if (Device := PlayerContainer.PlayerDevices.CSDTree[Layer]):
            Print("[ Hiding [{SequenceID}] ]", ?Duration := 5.0, ?Color := NamedColors.Cyan)

            Device.SetPlaybackTime(KeyframeToHide)
            Device.Play(PlayerContainer.Agent)

            Sleep(HideDuration)
            Device.Pause(PlayerContainer.Agent)



ui_heads_up_display_collection<public> := class<final>(base_ui_collection):

    Layer<override> : int = 1
    KeyframeToShow<override> : float = 200.0
    KeyframeToHide<override> : float = 200.0    # Add
    ShowDuration<override> : float = 0.0
    HideDuration<override> : float = 0.0


ui_dialog_box_collection<public> := class<final>(base_ui_collection):

    Layer<override> : int = 1
    KeyframeToShow<override> : float = 300.0
    KeyframeToHide<override> : float = 300.0    # Add
    ShowDuration<override> : float = 0.0
    HideDuration<override> : float = 0.0


    
    
ui_intro_fade_ts_collection<public> := class<final>(base_ui_collection):

    Layer<override> : int = 2
    KeyframeToShow<override> : float = 100.0
    KeyframeToHide<override> : float = 101.0    # Add
    ShowDuration<override> : float = 0.0
    HideDuration<override> : float = 2.0


ui_lobby_fade_ts_collection<public> := class<final>(base_ui_collection):

    Layer<override> : int = 2
    KeyframeToShow<override> : float = 200.0
    ShowDuration<override> : float = 6.0



# -----------------------------------------------------------------------------------------------------------------

