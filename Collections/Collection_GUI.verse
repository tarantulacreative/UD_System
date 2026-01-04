using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Simulation }
using { /Verse.org/Assets }
using { /Verse.org/Colors }

using { Player }
using { Utility }
using { World }


# -----------------------------------------------------------------------------------------------------------------

# Structural Hierarcialy Menu Collection:
base_gui_collection<public> := class<abstract><unique>:

    PlayerContainer<public> : player_container

    var Canvas<public> : canvas = canvas:

    var SelectButtons<protected>  : ?[]select_button = false
    var PageButtons<protected>    : ?[]page_button = false
    var ConfirmButtons<protected> : ?[]confirm_button = false
    var ExitButtons<protected>    : ?[]exit_button = false

    var SelectButtonRef<protected>  : []text_button_base = array:
    var ConfirmButtonRef<protected> : []text_button_base = array:

    var SelectButtonEvents<protected>   : []listenable(widget_message) = array:
    var PageButtonEvents<protected>     : []listenable(widget_message) = array:
    var ConfirmButtonEvents<protected>  : []listenable(widget_message) = array:
    var ExitButtonEvents<protected>     : []listenable(widget_message) = array:
        

    KeepVisible<public> : logic = false
    UsesVerseCanvas<public> : logic = true

    UninitializeEvent<public> : event() = event():


    # Initialize canvas for player:
    Initialize<public>(RootCanvas : canvas, Layouts : []base_gui_collection)<suspends> : void =
        InitializeCollectionComponents()

        CanvasToSlot := case(Layouts.Length - 1):
            0 =>
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 1.0}}
                    ZOrder := 1
                    Widget := Canvas
            1 =>   
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 1.0}}
                    ZOrder := 2
                    Widget := Canvas
            _ =>  
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 1.0}}
                    ZOrder := 0
                    Widget := Canvas

        
        RootCanvas.AddWidget(CanvasToSlot)

        set PlayerContainer.CurrentMenu = option {Self}
        
        race:
            HandleInteractions()
            UninitializeEvent.Await()



    Uninitialize<public>(RootCanvas : canvas)<suspends> : void =
        UninitializeEvent.Signal()

        RootCanvas.RemoveWidget(Canvas)
        RootCanvas.ForceUpdate()

        Print("Menu Uninitialized")

        

    InitializeCollectionComponents<protected>() : void =
        set SelectButtonEvents = for (Index -> isCanvas : SelectButtons?,  CastedCanvas := canvas[isCanvas.Slot.Widget])
            do:
                Canvas.AddWidget(isCanvas.Slot)
                    
                if (Button := text_button_base[CastedCanvas.Slots[0].Widget]):
                    set SelectButtonRef += array{Button}
                    Button.OnClick()

                else button_quiet{}.OnClick()
            

        set PageButtonEvents = for (Index -> isCanvas : PageButtons?, CastedCanvas := canvas[isCanvas.Slot.Widget])
            do:
                Canvas.AddWidget(isCanvas.Slot)
                    
                if (Button := text_button_base[CastedCanvas.Slots[0].Widget]):
                    Button.OnClick()

                else button_quiet{}.OnClick()

            
        set ConfirmButtonEvents = for (Index -> isCanvas : ConfirmButtons?, CastedCanvas := canvas[isCanvas.Slot.Widget])
            do:
                Canvas.AddWidget(isCanvas.Slot)
                    
                if (Button := text_button_base[CastedCanvas.Slots[0].Widget]):
                    set ConfirmButtonRef += array{Button}
                    Button.OnClick()

                else button_quiet{}.OnClick()
            

        set ExitButtonEvents = for (Index -> isCanvas : ExitButtons?, CastedCanvas := canvas[isCanvas.Slot.Widget])
            do:
                Canvas.AddWidget(isCanvas.Slot)
                    
                if (Button := text_button_base[CastedCanvas.Slots[0].Widget]):
                    Button.OnClick()

                else button_quiet{}.OnClick()

        

    Show<public>()<suspends> : void =
        Sleep(0.2)
        
        PlayerContainer.PlayerUIManager.Show(Self)

        UninitializeEvent.Await()


    HandleInteractions<protected>()<suspends> : void = Sleep(Inf)
    Update<public>()<suspends> : void = Sleep(Inf)
    OnSelectButtonPressed<protected>()<suspends> : void = Sleep(Inf)
    OnPageButtonPressed<protected>()<suspends> : void = Sleep(Inf)
    OnConfirmButtonPressed<protected>()<suspends> : void = Sleep(Inf)
    OnExitButtonPressed<protected>()<suspends> : void = Sleep(Inf)
        


# -----------------------------------------------------------------------------------------------------------------

base_button<public> := class:
    Slot<public> : canvas_slot

select_button<public> := class(base_button):
page_button<public> := class(base_button):
confirm_button<public> := class(base_button):
exit_button<public> := class(base_button):


    