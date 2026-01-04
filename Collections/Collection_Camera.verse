
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


# Collection used when dealing with Camera content:

# -----------------------------------------------------------------------------------------------------------------

base_camera_collection<public> := class<abstract>:

    # Container used to initialize devices:
    PlayerContainer<public> : player_container

    # Sequence ID for Identification:
    SequenceID<public> : string

    # Keyframe for Starting a collection:
    KeyframeToStart<protected> : float = 0.0

    # Keyframe for Stopping a collection:
    KeyframeToStop<protected> : float = 0.0

    # Play Start animation for this duration:
    StartDuration<protected> : float = 0.0

    # Play Stop animation for this duration:
    StopDuration<protected> : float = 0.0
    
    # Is Camera Stationary (Does Camera stay on screen until otherwise prompted?):
    KeepOnScreen<protected> : logic = false

    CancellationEvent<protected> : event() = event():
    

    Play<public>()<suspends> : void =
        race:
            if (Device := PlayerContainer.PlayerDevices.CSDTree[0]):
                Print("[ Playing [{SequenceID}] ]", ?Duration := 5.0, ?Color := NamedColors.Cyan)

                Device.SetPlaybackTime(KeyframeToStart)
                Device.Play(PlayerContainer.Agent)

                Sleep(StartDuration)

                if (not KeepOnScreen?):
                    Stop()

                else Device.Pause(PlayerContainer.Agent)
                
            CancellationEvent.Await()


            
    Stop<public>()<suspends> : void =
        if (Device := PlayerContainer.PlayerDevices.CSDTree[0]):
            Print("[ Stopping [{SequenceID}] ]", ?Duration := 5.0, ?Color := NamedColors.Cyan)

            CancellationEvent.Signal()

            Device.SetPlaybackTime(KeyframeToStop)
            Device.Play(PlayerContainer.Agent)

            Sleep(StopDuration)
            Device.Stop(PlayerContainer.Agent)




camera_lobby_collection<public> := class<final>(base_camera_collection):

    KeyframeToStart<override> : float = 100.0
    KeyframeToStop<override> : float = 101.0
    StartDuration<override> : float = 1.0   
    StopDuration<override> : float = 0.0    

    KeepOnScreen<override> : logic = true


camera_stage_collection<public> := class<final>(base_camera_collection):

    KeyframeToStart<override> : float = 1.0
    KeyframeToStop<override> : float = 2.0
    StartDuration<override> : float = 0.1   
    StopDuration<override> : float = 0.0    

    KeepOnScreen<override> : logic = false



# -----------------------------------------------------------------------------------------------------------------

