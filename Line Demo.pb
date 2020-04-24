; =================================
;
; LINE DEMO -- A Graphics Demo
; Version 2.01
; Copyleft 2020 by Erich Kohl
;
; Feel free to use this code.
;
; =================================

EnableExplicit

Declare DemoLoop()
Declare.i Init()
Declare Main()

Global.i dw
Global.i dh

If Init()
  Main()
EndIf

End

Procedure DemoLoop()
  
  Define.i x
  Define.i y
  Define.i distance
  Define.i xChange
  Define.i yChange
  Define.i reverse
  Define.i xDest
  Define.i yDest
  Define.i lineWidth
  Define.i lineTotal
  Define.i lineLimit
  Define.i lineColor
  Define.i backColor
  Define.i clearBackground
  Define.i delayTime
  Define.i a
  
  x = dw / 2
  y = dh / 2
  reverse = 0
  lineWidth = 5
  lineTotal = 0
  lineLimit = 1000
  lineColor = RGB(Random(255, 32), Random(255, 32), Random(255, 32))
  backColor = #Black
  clearBackground = #False
  delayTime = 100
  
  CreateImage(0, dw, dh, 32)
  
  Repeat
    Repeat
      If Random(100) = 100
        distance = Random(dh - 50, 200)
      Else
        distance = Random(175, 25)
      EndIf
      Repeat
        xChange = Random(3, 1) - 2
        yChange = Random(3, 1) - 2
      Until (xChange <> 0 Or yChange <> 0) And (xChange + yChange <> reverse)
      xDest = x + (distance * xChange)
      yDest = y + (distance * yChange)
    Until xDest >= 0 And yDest >= 0 And xDest <= dw And yDest <= dh
    Reverse = -(xChange + yChange)
    StartDrawing(ImageOutput(0))
    If lineTotal = lineLimit Or clearBackground
      Box(0, 0, dw, dh, backColor)
      x = dw / 2
      y = dh / 2
      reverse = 0
      lineTotal = 0
      clearBackground = #False
      lineColor = RGB(Random(255, 32), Random(255, 32), Random(255, 32))
    Else
      Repeat
        Circle(x, y, lineWidth, lineColor)
        x = x + xChange
        y = y + yChange
      Until x = xDest And y = yDest
      lineTotal = lineTotal + 1
      If Random(100) = 100
        lineColor = RGB(Random(255, 32), Random(255, 32), Random(255, 32))
      EndIf
    EndIf
    StopDrawing()
    StartDrawing(ScreenOutput())
    DrawImage(ImageID(0), 0, 0)  
    StopDrawing()
    FlipBuffers()
    Delay(delayTime)
    ExamineKeyboard()
    If KeyboardPushed(#PB_Key_Up) Or KeyboardReleased(#PB_Key_Up)
      delayTime = delayTime - 10
      If delayTime < 10
        delayTime = 10
      EndIf
    ElseIf KeyboardPushed(#PB_Key_Down) Or KeyboardReleased(#PB_Key_Down)
      delayTime = delayTime + 10
      If delayTime > 200
        delayTime = 200
      EndIf
    ElseIf KeyboardPushed(#PB_Key_Left) Or KeyboardReleased(#PB_Key_Left)
      lineWidth = lineWidth - 1
      If lineWidth < 1
        lineWidth = 1
      EndIf
    ElseIf KeyboardPushed(#PB_Key_Right) Or KeyboardReleased(#PB_Key_Right)
      lineWidth = lineWidth + 1
      If lineWidth > 25
        lineWidth = 25
      EndIf
    ElseIf KeyboardPushed(#PB_Key_Space) Or KeyboardReleased(#PB_Key_Space)
      lineColor = RGB(Random(255, 32), Random(255, 32), Random(255, 32))
    ElseIf KeyboardPushed(#PB_Key_C) Or KeyboardReleased(#PB_Key_C)
      backColor = RGB(Random(255, 32), Random(255, 32), Random(255, 32))
      clearBackground = #True
    ElseIf KeyboardPushed(#PB_Key_B) Or KeyboardReleased(#PB_Key_B)
      backColor = #Black
      clearBackground = #True
    ElseIf KeyboardPushed(#PB_Key_Return) Or KeyboardReleased(#PB_Key_Return)
      BackColor = #Black
      lineWidth = 5
      delayTime = 100
      clearBackground = #True
    ElseIf KeyboardPushed(#PB_Key_Escape) Or KeyboardReleased(#PB_Key_Escape)
      Break
    EndIf
  ForEver
  
  For a = 1 To 2
    ; This was necessary or else we had part of the line image blinking upon returning to the title screen
    StartDrawing(ImageOutput(0))
    Box(0, 0, dw, dh, #Black)
    StopDrawing()
    StartDrawing(ScreenOutput())
    DrawImage(ImageID(0), 0, 0)
    StopDrawing()
    FlipBuffers()
  Next a
  
  FreeImage(#PB_All)
  
EndProcedure

Procedure.i Init()
  
  Define.i result
  
  InitKeyboard()
  InitSprite()
  
  ExamineDesktops()
  
  dw = DesktopWidth(0)
  dh = DesktopHeight(0)
  
  result = OpenScreen(dw, dh, 32, "Line Demo", #PB_Screen_SmartSynchronization)
  
  If result = 0 Or dw < 1440 Or dh < 900
    ProcedureReturn #False
  Else
    ProcedureReturn #True
  EndIf
  
EndProcedure

Procedure Main()
  
  Define.i titleFont
  Define.i titleX
  Define.i titleY
  Define.i textY
  Define.s k
  Define.s s
  
  titleFont = LoadFont(#PB_Any, "Arial", 24)
  
  titleX = dw / 2 - 275
  titleY = 5
  
  Repeat
    StartDrawing(ScreenOutput())
    ; Draw the L
    LineXY(titleX, titleY, titleX, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX, titleY + 100, titleX + 100, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    ; Draw the I
    LineXY(titleX + 150, titleY, titleX + 250, titleY, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 150, titleY + 100, titleX + 250, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 200, titleY, titleX + 200, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    ; Draw the N
    LineXY(titleX + 300, titleY, titleX + 300, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 300, titleY, titleX + 400, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 400, titleY, titleX + 400, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    ; Draw the E
    LineXY(titleX + 450, titleY, titleX + 450, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 450, titleY, titleX + 550, titleY, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 450, titleY + 50, titleX + 550, titleY + 50, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 450, titleY + 100, titleX + 550, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    titleY = titleY + 150
    ; Draw the D
    LineXY(titleX, titleY, titleX, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX, titleY, titleX + 75, titleY, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX, titleY + 100, titleX + 75, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 75, titleY, titleX + 100, titleY + 25, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 75, titleY + 100, titleX + 100, titleY + 75, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 100, titleY + 25, titleX + 100, titleY + 75, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    ; Draw the E
    LineXY(titleX + 150, titleY, titleX + 150, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 150, titleY, titleX + 250, titleY, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 150, titleY + 50, titleX + 250, titleY + 50, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 150, titleY + 100, titleX + 250, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))    
    ; Draw the M
    LineXY(titleX + 300, titleY, titleX + 300, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 300, titleY, titleX + 350, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 350, titleY + 100, titleX + 400, titleY, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 400, titleY, titleX + 400, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    ; Draw the O
    LineXY(titleX + 450, titleY, titleX + 550, titleY, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 550, titleY, titleX + 550, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 450, titleY, titleX + 450, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    LineXY(titleX + 450, titleY + 100, titleX + 550, titleY + 100, RGB(Random(255, 32), Random(255, 32), Random(255, 32)))
    titleY = titleY - 150
    DrawingFont(FontID(titleFont))
    FrontColor($FFFFFF)
    s = "Line Demo v2.01 -- A Graphics Demo"
    textY = dh / 2 - 150
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "Copyleft 2020 by Erich Kohl"
    textY = textY + 35
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "During the demo you can use the following commands:"
    textY = textY + 105
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "Up-arrow/Down-arrow: Increase/decrease speed"
    textY = textY + 70
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "Left-arrow/Right-arrow: Decrease/increase width of line"
    textY = textY + 35
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "Space Bar: Change line to random color"
    textY = textY + 35
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "C: Clear background to random color"
    textY = textY + 35
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "B: Clear background to black"
    textY = textY + 35
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "Enter/Return: Set back to defaults"
    textY = textY + 35
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "Esc: Exit to the main menu"
    textY = textY + 35
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    s = "Press Enter/Return to start the demo.  Press Esc to quit."
    textY = dh - 70
    DrawText(dw / 2 - TextWidth(s) / 2, textY, s)
    StopDrawing()
    FlipBuffers()
    Delay(100)
    ExamineKeyboard()
    If KeyboardPushed(#PB_Key_Return) Or KeyboardReleased(#PB_Key_Return)
      DemoLoop()
    ElseIf KeyboardPushed(#PB_Key_Escape) Or KeyboardReleased(#PB_Key_Escape)
      Break
    EndIf
  ForEver
  
EndProcedure
; IDE Options = PureBasic 5.71 LTS (Windows - x64)
; Folding = -
; EnableXP