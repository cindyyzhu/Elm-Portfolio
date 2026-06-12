module Main exposing (..)

import GraphicSVG.EllieApp exposing (..)
import GraphicSVG exposing (..)

import GraphicSVG.Secret as GSVGS exposing (Pull)
import Html
import Html.Attributes

-- 1 -- find an image on the internet which you want to trace
imageURL = "https://media.licdn.com/dms/image/D5622AQHLSFAN-mA33g/feedshare-shrink_1280/0/1709589940487?e=1714608000&v=beta&t=Ox32dJ3Yq5nSf5PCda-IdRhDH6rdIeFtt-TY7mZAhVk"
-- 2 -- set its size
imageWidth = 1000
imageHeight = 1000
-- 3 -- set its scale to blow up the part you want to trace
imageScale = 0.18
-- 4 -- pan the image to the part you want to trace
imagePos = (-600,450)

{- Basic controls 
  - Click on points and drag to move them
    - Hold shift to select multiple points 
    - Ctrl + A to select all
  - Press Backspace to delete selected points
    -When Pull points are deleted they get snapped to the middle of the line segment
  - Other options are shown on buttons and sliders 
-}

--Note: When angles are 180 degrees, a smooth curve is formed

-- ** Don't edit code below here **

{---------------------------------------
-- Curve Creator Standalone Functions --
----------------------------------------}

drawImage: Image -> Shape Msg 
drawImage image =
  Html.img [Html.Attributes.src image.url] []
  |> html image.width image.height 
  |> move image.pos
  |> scale image.scale

moveImage: Point -> Image -> Image
moveImage moveAmount image = 
  { image | pos = addTuple image.pos moveAmount }

scaleImage: Float -> Image -> Image 
scaleImage newScale image =
  { image | scale = newScale }
  
mouseMove: Point -> Point -> Model -> Model
mouseMove point posChange model =
  if model.mouseState.mouseDown then
    case model.currentAction of
      MovingPoints ->
        if model.scaleSlider.state == Dragging then
          { model | scaleSlider = updateSliderVal scaleSliderXPos (Tuple.first point) model.scaleSlider }
        else 
          { model | userCurves = updateUserCurves model posChange}
      EditingImage ->
        if model.imgZoomSlider.state == Dragging then --dragging image scale slider 
          { model | 
            imgZoomSlider = updateSliderVal scaleSliderXPos (Tuple.first point) model.imgZoomSlider,
            backgroundImage = scaleImage (getScaleMultiplier model.imgZoomSlider) model.backgroundImage }
        else 
          { model | backgroundImage = 
              moveImage (scalarMult (1 / (getScaleMultiplier model.imgZoomSlider)) posChange) model.backgroundImage}
      Exporting -> model
  else 
    model

myShapes: Model -> List (Shape Msg)
myShapes model =
  (
  (if model.currentAction /= Exporting then
    drawImage model.backgroundImage
  else 
    group []
  )
  ::
  background model
  ::
  (
  getCodeButton
    |> notifyMouseDown 
      (if model.currentAction == Exporting then SetAction MovingPoints
      else SetAction Exporting )
    |> scale 0.8
    |> move (-screenWidth / 2 + 5, screenHeight / 2 - 5)
  )
  ::
  (undoButton 
  |> move (-screenWidth / 2 + 15, screenHeight / 2 - 5)
  |> notifyMouseDown Undo)
  ::
  (
  if model.currentAction == Exporting then 
    convertCurvesToCode model.userCurves
    |> group
    |> move (-90, 50)
    |> List.singleton
  else if model.currentAction == EditingImage then
    (List.map (userCurveToShape model) model.userCurves
      |> List.map (makeTransparent 0.5))
    ++
    [editImageButton model]
    ++
    [drawSlider scaleSliderXPos model.imgZoomSlider |> move (0, -17)
      |> notifyMouseDown SelectImageSlider ]
    
  else 
    (List.map (userCurveToShape model) model.userCurves)
    ++
    --If curve selected then display helper points
    (case getSelectedCurve model of
      Nothing -> []
      Just userCurve -> 
        buildExtraInfoShapes model userCurve
        ++
        buildHelperPoints model userCurve
    )
    ++
    (case getSelectedCurve model of 
      Nothing -> []
      Just userCurve -> buildAddPointButtons (getScaleMultiplier model.scaleSlider) userCurve
    )
    -- ++
    -- buttons model
    ++
    [editImageButton model]
    ++
    [addCurveButton]
    ++
    changeColourButtons model
    ++
    [drawSlider scaleSliderXPos model.scaleSlider |> move (0, 10)
      |> notifyMouseDown SelectScaleSlider ]
    ++
    (case getSelectedCurve model of 
      Nothing -> []
      Just curve ->
        curveToCodeString 0 curve
        |> text
        |> codeFont
        |> size (min (7.5 / (toFloat <| List.length curve.pulls)) 3)
        |> filled black
        |> move (-95, -55)
        |> List.singleton
    )
    ++
    [
      trashCan model.trashStatus
      |> move (82, -38)
    ]
    ))
    -- |> List.map (notifyMouseMoveAt MouseMove)

-- Your update function goes here
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of
    Tick t (getKeyStates, _, _) -> 
      let
        updatedModel = 
          { model | 
            time = t, 
            keyInfo = getKeyStates
          }
      in
      --Check for all keyboard commands
      if getKeyStates Backspace == JustDown then
        update DeleteSelected updatedModel
      else if getKeyStates (Key "e") == JustDown then
        if model.currentAction == Exporting then  
          update (SetAction MovingPoints) updatedModel
        else  
          update (SetAction Exporting) updatedModel 
      else if keyPressed getKeyStates Ctrl && getKeyStates (Key "a") == JustDown then
        update SelectAll updatedModel 
      else if keyPressed getKeyStates Ctrl && getKeyStates (Key "z") == JustDown then
        update Undo updatedModel
      else
        (updatedModel, Cmd.none)
    DeleteSelected ->
      ({ model |
        userCurves = deleteSelected model,
        selectedPoints = []
      }
      |> saveModelIfNeeded model
      , Cmd.none )
    UpdateMouseInfo pressed point ->
      ( { model | 
          mouseState = MouseState point pressed, 
          scaleSlider =  
            if pressed then model.scaleSlider 
            else deselectSlider model.scaleSlider
          ,
          imgZoomSlider =
            if pressed then model.imgZoomSlider 
            else deselectSlider model.imgZoomSlider
        }
        |> saveModelIfNeeded model
        , Cmd.none )
    SelectCurve id ->
      ( { model | selectedCurve = Just id, selectedPoints = []} 
        |> saveModelIfNeeded model
        , Cmd.none)
    SelectPoint curvePoint ->
      ( { model | 
          selectedPoints =             
            if keyPressed model.keyInfo Shift then
              if List.member curvePoint model.selectedPoints then
                model.selectedPoints
              else
                curvePoint :: model.selectedPoints
            else
              [curvePoint] 
        } |> saveModelIfNeeded model 
        , Cmd.none)
    Deselect info -> 
      ( case info of 
          All -> { model | selectedPoints = [], selectedCurve = Nothing }
          AllPoints -> { model | selectedPoints = []}
          Point curvePoint -> { model | selectedPoints = List.filter (\x -> x /= curvePoint) model.selectedPoints}
        , Cmd.none )
    MouseMove point ->
      let 
        posChange = (positionDelta model.mouseState.pos point)
      in
      ( { model | mouseState = updateMousePos model.mouseState point }
        |> mouseMove point posChange
      ,
      Cmd.none )
    ToggleEndPointLines -> 
      ( { model | pullPointDisplaySettings = 
          toggleEndPointLines model.pullPointDisplaySettings}
          |> saveModelIfNeeded model
          , Cmd.none )
    ToggleMidPointLines -> 
      ( { model | pullPointDisplaySettings = 
          toggleMidPointLines model.pullPointDisplaySettings}
          |> saveModelIfNeeded model
          , Cmd.none )
    SetAction action ->
      ( { model | currentAction = action } |> saveModelIfNeeded model, Cmd.none)
    AddPoint addPointID point -> 
      ( addPoint addPointID point model |> saveModelIfNeeded model , Cmd.none) 
    ChangeColours newColours ->
      ( { model | colours = newColours } |> saveModelIfNeeded model , Cmd.none)
    SelectScaleSlider ->
      let 
        oldSlider = model.scaleSlider
        updatedSlider = { oldSlider | state = Dragging }
      in
      ( { model | scaleSlider = updatedSlider} |> saveModelIfNeeded model, Cmd.none)
    SelectImageSlider ->
      let 
        oldSlider = model.imgZoomSlider
        updatedSlider = { oldSlider | state = Dragging }
      in
      ( { model | imgZoomSlider = updatedSlider} |> saveModelIfNeeded model, Cmd.none)
    SelectAll ->
      (selectAllPoints model |> saveModelIfNeeded model , Cmd.none)
    AddNewCurve ->
      let 
        newID = model.lastCurveID + 1
        newCurve = 
          { startingCurve | id = newID }
      in
      ({ model |
        userCurves =  newCurve :: model.userCurves,
        selectedCurve = Just newID,
        selectedPoints = [],
        lastCurveID = newID
      }
      |> saveModelIfNeeded model
      , Cmd.none)
    Undo ->
      (undo model, Cmd.none)
    UpdateTrash newStatus ->
      ({model |
        trashStatus = newStatus }
      , Cmd.none )
    TrashItems ->
      update DeleteSelected model

-- Your subscriptions go here
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- Your main function goes here
main : EllieAppWithTick () Model Msg
main =
  ellieAppWithTick Tick
    { init = \flags -> (init, Cmd.none)
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
-- You view function goes here
view : Model -> { title: String, body : Collage Msg }
view model = 
  {
    title = "My App Title"
  , body = collage screenWidth screenHeight (myShapes model)
  }


{---------------------------------
-- Curve Creator Main Functions --
----------------------------------}


toggleLinesButtons: Model -> Shape Msg
toggleLinesButtons model =
  let 
    endSelected = model.pullPointDisplaySettings.drawEndPointLines
    midSelected = model.pullPointDisplaySettings.drawMidPointLines
  in
  [
    drawColourSchemePreview endSelected (PullPointLineDisplayInfo True False) model.colours
      |> move (73, 52)
      |> notifyMouseDown ToggleEndPointLines
    ,
    drawColourSchemePreview midSelected (PullPointLineDisplayInfo False True) model.colours
      |> move (88, 52)
      |> notifyMouseDown ToggleMidPointLines
  ]
  |> group


changeColourButton: Model -> ColourScheme -> Shape Msg 
changeColourButton model colours =
  let 
    selected = model.colours == colours
  in
  drawColourSchemePreview selected (PullPointLineDisplayInfo True True) colours
    |> notifyMouseDown (ChangeColours colours)

--Draws a small sample of what a curve in a given colour scheme would look like
drawColourSchemePreview: Bool -> PullPointLineDisplayInfo -> ColourScheme -> Shape Msg
drawColourSchemePreview selected lineInfo colours =
  let
    start = (-10, -10)
    pull1 = (10, 0)
    end1 = (-10, 10)

    scaleSize: Float
    scaleSize = 1 / 3
  in
  (
    (roundedRect 33 33 3
      |> filled colours.pullPointFill
      |> if selected then 
          addOutline (solid 2) colours.selectedOutline 
        else 
          identity
    )
    ::
    (curve start [GSVGS.Pull pull1 end1] |> outlined (solid 2) colours.lineColour)
    ::
    (buildPullPointLines (1) colours lineInfo start pull1 end1)
    ::
    [
      --start 
      circle 3
        |> filled colours.endPointFill
        |> addOutline (solid 1) colours.unselectedOutline
        |> move start
      ,
      --pull
      circle 3 
        |> filled colours.pullPointFill
        |> addOutline (solid 1) colours.unselectedOutline
        |> move pull1
      ,
      --end (selected)
      circle 3
        |> filled colours.endPointFill
        |> addOutline (solid 1) colours.selectedOutline
        |> move end1
    ]
  )
  |> group
  |> scale scaleSize

changeColourButtons: Model -> List (Shape Msg) 
changeColourButtons model = 
  [
    changeColourButton model blackWithWhite
    |> move (58, 25)
    ,
    changeColourButton model whiteWithBlack
    |> move (73, 25)
    ,
    changeColourButton model yellowWithRed
    |> move (88, 25)
  ]

buttons: Model -> List (Shape Msg)
buttons model = [
  -- toggleLinesButtons model,
  -- addPointsButton model
  ]

getScaleMultiplier: Slider -> Float
getScaleMultiplier slider = 
  2 ^ slider.currentVal

--xOffset = xPos of center of slider
updateSliderVal: Float -> Float -> Slider -> Slider 
updateSliderVal xOffset mouseX slider =
  { slider |
    currentVal = 
      mouseX - xOffset 
      |> (+) (slider.width / 2)
      |> (*) (1 / slider.width) 
      |> (*) (slider.max - slider.min)
      |> (+) slider.min
      |> clamp slider.min slider.max
  }

drawSlider: Float -> Slider -> Shape Msg
drawSlider xOffset slider =
  let
    ballPos = 
      slider.currentVal
      |> (+) (-slider.min) 
      |> (*) (1 / (slider.max - slider.min))
      |> (*) slider.width 
      |> (+) (-slider.width / 2)
  in  
  group
  [
    roundedRect slider.width 2 1
    |> filled lightBlue
    ,
    circle 4
    |> filled darkBlue
    |> move (ballPos, 0)
  ]
  |> move (xOffset, 0)
  |> notifyMouseDown (Deselect AllPoints)
  |> notifyMouseMoveAt MouseMove
  |> notifyMouseDownAt (UpdateMouseInfo True)
  |> notifyMouseUpAt (UpdateMouseInfo False)
  
--Returns a list with either the selected curve only or nothing
filterBySelected: Model -> List UserCurve
filterBySelected model =
  List.filter (\curve -> Just curve.id == model.selectedCurve) model.userCurves

--Returns all unselected curves
filterByUnselected: Model -> List UserCurve
filterByUnselected model =
  List.filter (\curve -> Just curve.id /= model.selectedCurve) model.userCurves

getSelectedCurve: Model -> Maybe UserCurve
getSelectedCurve model =
  filterBySelected model
  |> List.head

--Draws points which can be dragged to adjust curve
buildHelperPoint: Float -> Model -> Point -> CurvePoint -> Shape Msg
buildHelperPoint scaleMult model point curvePoint =
  let
    selected = List.member curvePoint model.selectedPoints
    outlineCol = if selected then model.colours.selectedOutline else model.colours.unselectedOutline
    fillCol = 
      case curvePoint of 
        PullPoint _ -> model.colours.pullPointFill
        _ -> model.colours.endPointFill

  in
  circle 3
  |> filled fillCol
  |> addOutline (solid 1) outlineCol
  |> scale scaleMult
  |> move point
  |> notifyMouseDown (SelectPoint curvePoint)
  |> notifyMouseDownAt (UpdateMouseInfo True)
  |> notifyMouseDown (SelectPoint curvePoint)
  |> notifyMouseMoveAt MouseMove
  |> notifyMouseUpAt (UpdateMouseInfo False)
           
--Builds dashed lines from the pull points to the curve and to the neighboring endpoints
buildPullPointLines: Float -> ColourScheme -> PullPointLineDisplayInfo -> Point -> Point -> Point -> Shape Msg
buildPullPointLines scaleMult colours displayInfo leftEnd pullPoint rightEnd =
  let
    style = dashed (0.4 * scaleMult)
    colour = colours.dottedLineColour
  in
  ((
    if displayInfo.drawMidPointLines then
      getMidpoint leftEnd rightEnd
        |> getMidpoint pullPoint
        |> line pullPoint
        |> outlined style colour
        |> List.singleton
    else   
      []
  )
  ++
  (
    if displayInfo.drawEndPointLines then
      [
      line leftEnd pullPoint
        |> outlined style colour
      ,
      line rightEnd pullPoint 
        |> outlined style colour
      ]
    else 
      []
  ))
  |> group
  |> notifyMouseDownAt (UpdateMouseInfo True)
  |> notifyMouseUpAt (UpdateMouseInfo False)

--draws extra info on certain points 
--eg. position lines (in future angles)
buildExtraInfoShapes: Model -> UserCurve -> List (Shape Msg) 
buildExtraInfoShapes model userCurve =
  let 
    curvePoints = List.map2 Tuple.pair (getPullPoints userCurve) (getEndPoints userCurve)
    endPoints = userCurve.start :: getEndPoints userCurve
    pullPoints = getPullPoints userCurve
  in
  (
    (
      if List.member Start model.selectedPoints then 
        drawPositionInfo model.colours (getScaleMultiplier model.scaleSlider) userCurve.start
      else 
        group []
    )
  ::
  List.indexedMap (tryBuildPositionInfo model) curvePoints
  ++
  buildAngleShapes model 0 curvePoints
  ++
  buildPullAddPointButtons model 0 endPoints pullPoints
  )
  |> List.map (notifyMouseMoveAt MouseMove)
  |> List.map (notifyMouseDownAt <| UpdateMouseInfo True)
  |> List.map (notifyMouseUpAt <| UpdateMouseInfo False)

buildPullAddPointButtons: Model -> Int -> List Point -> List Point -> List (Shape Msg)
buildPullAddPointButtons model index endPoints pullPoints =
  let 
    pullSelected = List.member (PullPoint index) model.selectedPoints
  in
  case (endPoints, pullPoints) of
    (end1 :: end2 :: endTail, pull :: pullTail) ->
      if List.member (PullPoint index) model.selectedPoints then
        let
          vect1 = positionDelta end1 pull
          vect2 = positionDelta end2 pull
          moveDir = averageDir vect1 vect2
          scaleMult = getScaleMultiplier model.scaleSlider
          moveAmount = scalarMult (6 * scaleMult) moveDir
        in
        (
        [
          circle 3
          |> filled model.colours.pullPointFill
          |> addOutline (solid 1) model.colours.unselectedOutline
          ,
          text "+"
          |> size 6 
          |> centered 
          |> filled black
          |> move (0, -2)
        ]
        |> group
        |> scale (2/3)
        |> scale scaleMult
        |> move pull
        |> move moveAmount
        |> notifyMouseDown (AddPoint (InsertAtPull index) pull)
        )
        ::
        buildPullAddPointButtons model (index + 1) (end2 :: endTail) (pullTail)
      else
        buildPullAddPointButtons model (index + 1) (end2 :: endTail) (pullTail)
    _ -> []


tryBuildPositionInfo: Model -> Int -> (Point, Point) -> Shape Msg
tryBuildPositionInfo model index (pull, end) =
  let 
    pullSelected = List.member (PullPoint index) model.selectedPoints
    endSelected = List.member (EndPoint index) model.selectedPoints
    drawFunc = drawPositionInfo model.colours (getScaleMultiplier model.scaleSlider) 
  in
  [
    if pullSelected then 
      drawFunc pull
    else 
      group []
    ,
    if endSelected then
      drawFunc end
    else 
      group []
  ]
  |> group

--Shows the angles between pullpoints outside of the endpoints (only if one of the pullpoints or the endpoint is selected)
buildAngleShapes: Model -> Int -> List (Point, Point) -> List (Shape Msg)
buildAngleShapes model index curvePoints  =
  let 
    selected = model.selectedPoints
  in
  case curvePoints of 
    (pull1, end1) :: (pull2, end2) :: tail ->
      if List.member (PullPoint index) selected || List.member (PullPoint (index + 1)) selected || List.member (EndPoint index) selected then
        (displayAngle (getScaleMultiplier model.scaleSlider) pull1 end1 pull2) :: buildAngleShapes model (index + 1) ((pull2, end2) :: tail)
      else
        buildAngleShapes model (index + 1) ((pull2, end2) :: tail)
    _ -> []

displayAngle: Float -> Point -> Point -> Point -> Shape Msg
displayAngle scaleAmount pull1 end pull2 = 
  let 
    angleTxt = 
      calculateAngle pull1 end pull2 
      |> (*) (180 / pi)
      |> round
      |> String.fromInt
      |> (\str -> str ++ "°")
    
    vect1 = positionDelta end pull1 |> normalize
    vect2 = positionDelta end pull2 |> normalize
    
    offsetDir = averageDir vect1 vect2
    
    textOffset = 
      getMidpoint vect1 vect2 
        |> getMidpoint (scalarMult 1.6 offsetDir) 
  in
  group
  [
    curve vect1 [GSVGS.Pull (scalarMult 1.6 offsetDir) vect2]
      |> outlined (solid 0.1) black 
      |> subtract (circle 0.45 |> ghost |> move textOffset)
    -- ,
    -- circle 0.45 |> filled red |> move textOffset 
    ,

    text angleTxt
      |> centered
      |> size 0.4
      |> filled black --change to new blue later
      |> move textOffset
      |> move (0, scaleAmount * -0.1 )
  ]
  |> scale (scaleAmount * 8)
  |> move end
  


--Draws lines to the edge of the screen showing the position
drawPositionInfo: ColourScheme -> Float -> Point -> Shape Msg
drawPositionInfo colours scale (x, y) =
  let
    xStr = floatToStringFixedDecimal 1 x
    yStr = floatToStringFixedDecimal 1 y
    xMargin = 13
    yMargin = 6
    textXOffset = 7
    textYOffset = 5
  in
  [
    line (-screenWidth / 2 + xMargin, y) (x, y)
    |> outlined (longdash (0.3 * scale)) colours.dottedLineColour
    ,
    line (x, screenHeight / 2 - yMargin) (x, y)
    |> outlined (longdash (0.3 * scale)) colours.dottedLineColour
    ,
    text xStr
    |> size 5
    |> centered
    |> filled colours.unselectedOutline 
    |> move (x, screenHeight / 2 - textYOffset)
    ,
    text yStr
    |> size 5
    |> centered
    |> filled colours.unselectedOutline 
    |> move (-screenWidth / 2 + textXOffset, y)
    |> move (0, -2)
  ]
  |> group

--Builds shapes that the user can click and drag to adjust curve
buildHelperPoints: Model -> UserCurve -> List (Shape Msg)
buildHelperPoints model userCurve = 
  let
    lastIndex = (List.length userCurve.pulls) - 1
    pullPointIds = List.map (\i -> PullPoint i) (List.range 0 lastIndex)
    fixedPointIds = List.map (\i -> EndPoint i) (List.range 0 lastIndex)
    
    pullPoints = getPullPoints userCurve
    fixedPoints = getEndPoints userCurve
    scaleMultiplier = getScaleMultiplier model.scaleSlider
  in
  --Build lines to midpoints with extra info
  (List.map3 (buildPullPointLines scaleMultiplier model.colours model.pullPointDisplaySettings) (userCurve.start :: fixedPoints) pullPoints fixedPoints)
  ++
  [buildHelperPoint scaleMultiplier model userCurve.start Start]
  ++
  (List.map2 (buildHelperPoint scaleMultiplier model) pullPoints pullPointIds)
  ++
  (List.map2 (buildHelperPoint scaleMultiplier model) fixedPoints fixedPointIds)

--Selects all points in currently selected userCurve
selectAllPoints: Model -> Model
selectAllPoints model =
  case getSelectedCurve model of 
    Nothing -> model
    Just userCurve ->
      let 
        length = List.length userCurve.pulls 
        startList = List.range 0 (length - 1)
      in 
      { model |
        selectedPoints = 
          Start 
          ::
          List.map (\i -> PullPoint i) startList
          ++
          List.map (\i -> EndPoint i) startList
      }

--Gets the endpoint of a CustomPull
getEndPoint: CustomPull -> Point
getEndPoint userPull = 
  case userPull of
    Enabled _ endPoint ->
      endPoint
    Disabled endPoint -> 
      endPoint

--Converts a CustomPull to a normal Pull 
calculatePull: Point -> CustomPull -> Pull
calculatePull prevPoint customPull =
  GSVGS.Pull (calculatePullPoint prevPoint customPull) (getEndPoint customPull)
      
calculatePullPoint: Point -> CustomPull -> Point
calculatePullPoint prevPoint customPull =
  case customPull of
    Enabled pullPoint endPoint ->
      pullPoint
    Disabled endPoint -> 
      getMidpoint prevPoint endPoint

--Converts the custom CustomPulls in Pulls that can be used in a curve
calculatePulls: UserCurve -> List Pull
calculatePulls userCurve =
  let
    startPoints = 
      List.map getEndPoint userCurve.pulls
      |> (::) userCurve.start
  in
    List.map2 calculatePull startPoints userCurve.pulls

--Gets a list of all the pullpoints from a userCurve
getPullPoints: UserCurve -> List Point
getPullPoints userCurve =
  let
    startPoints = 
      List.map getEndPoint userCurve.pulls
      |> (::) userCurve.start
  in
    List.map2 calculatePullPoint startPoints userCurve.pulls

--Gets a list of all the endPoints from a userCurve
getEndPoints: UserCurve -> List Point
getEndPoints userCurve =
  List.map getEndPoint userCurve.pulls

--Converts a userCurve to a shape that can be drawn
userCurveToShape: Model -> UserCurve -> Shape Msg
userCurveToShape model userCurve = 
  let 
    selected = model.selectedCurve == Just userCurve.id
    thicknessScale = getScaleMultiplier model.scaleSlider
  in
  curve userCurve.start (calculatePulls userCurve)
    --move curve shape styles to outside variables?
    |> outlined (solid (2 * thicknessScale)) model.colours.lineColour
    |> (if selected then identity else notifyMouseDown (SelectCurve userCurve.id))
    |> notifyMouseDownAt (UpdateMouseInfo True)
    |> notifyMouseMoveAt MouseMove
    |> notifyMouseUpAt (UpdateMouseInfo False)

--Checks if a keys state is the list of states inputted
checkKey: (Keys -> KeyState) -> List KeyState -> Keys -> Bool
checkKey keyInfo states key =
  List.filter (\keyState -> keyInfo key == keyState) states
  |> List.length
  |> (/=) 0

--Checks is a key is pressed (JustDown or Down)
keyPressed: (Keys -> KeyState) -> Keys -> Bool
keyPressed keyInfo key =
  checkKey keyInfo [Down, JustDown] key

--Changes a MouseState's position to a new position
updateMousePos: MouseState -> Point -> MouseState
updateMousePos state point =
  {state | pos = point}

--Takes a point and moves it by positionChange if it's in selectedPoints
movePointIfSelected: List CurvePoint -> (Float, Float) -> Int -> Point -> CustomPull -> CustomPull
movePointIfSelected selectedPoints positionChange pullIndex prevPoint customPull =
  let
    pullSelected = List.member (PullPoint pullIndex) selectedPoints
    endSelected = List.member (EndPoint pullIndex) selectedPoints
  in
  case (pullSelected, endSelected) of
    (True, True) ->
      case customPull of 
        Enabled midPoint endPoint -> 
          Enabled (addTuple midPoint positionChange) (addTuple endPoint positionChange)
        Disabled endPoint ->
          Enabled (addTuple (getMidpoint prevPoint endPoint) positionChange) (addTuple endPoint positionChange)
    (True, False) ->
      case customPull of 
        Enabled midPoint endPoint -> 
          Enabled (addTuple midPoint positionChange) endPoint
        Disabled endPoint ->
          Enabled (addTuple (getMidpoint prevPoint endPoint) positionChange) (endPoint)
    (False, True) ->
      case customPull of 
        Enabled midPoint endPoint -> 
          Enabled midPoint (addTuple endPoint positionChange)
        Disabled endPoint ->
          Disabled (addTuple endPoint positionChange)
    (False, False) ->
      customPull

--Takes a curve and moves each point by positionChange if it's in selectedPoints
movePoints: List CurvePoint -> (Float, Float) -> UserCurve -> UserCurve
movePoints selectedPoints positionChange userCurve =
  let
    startPoints = 
      List.map getEndPoint userCurve.pulls
      |> (::) userCurve.start
    indices = List.range 0 ((List.length userCurve.pulls) - 1)
  in 
  { userCurve |
    start = if List.member Start selectedPoints then addTuple userCurve.start positionChange else userCurve.start,
    pulls = List.map3 (movePointIfSelected selectedPoints positionChange) indices startPoints userCurve.pulls
  }

--Takes the model and moves selected points by moveAmount 
updateUserCurves: Model -> (Float, Float) -> List UserCurve
updateUserCurves model moveAmount =
  filterByUnselected model 
  ++
  (
    filterBySelected model
    |> List.map (movePoints model.selectedPoints moveAmount) 
  )

--Orders points for deletion
--Pulls are always prioritized (Less Than) over End Points 
--Points are then ordered by index (Highest to Lowest)
orderPoints: CurvePoint -> CurvePoint -> Order
orderPoints p1 p2 =
  case (p1,p2) of 
    (Start, Start) -> EQ
    (Start, _) -> GT
    (_, Start) -> LT
    (PullPoint _, EndPoint _) -> LT
    (EndPoint _, PullPoint _) -> GT
    (EndPoint num1, EndPoint num2) -> compare num2 num1 --Reverse Compare
    (PullPoint num1, PullPoint num2) -> compare num2 num1 --Reverse Compare

--Maybe think of a better system instead of a list of Curves
--Create a check for if the line only has one point after deletions, as a single point won't be visible and becomes garbage
deletePoint: CurvePoint -> UserCurve -> Maybe UserCurve
deletePoint point userCurve =
  case point of 
    Start ->
      case userCurve.pulls of
      (head :: tail) -> Just { userCurve | start = getEndPoint head, pulls = tail } 
      [] -> Nothing
    PullPoint index ->
      { userCurve | pulls =
        List.take index userCurve.pulls
        ++
        (
        case List.head <| List.drop index userCurve.pulls of
          Nothing -> []
          Just customPull ->
            (Disabled (getEndPoint customPull))
            :: 
            (List.drop (index + 1) userCurve.pulls)
        )
      }
      |> Just
    EndPoint index ->
      { userCurve | pulls =
        case List.head <| List.drop (index + 1) userCurve.pulls of
          Nothing -> 
            List.take index userCurve.pulls
          Just customPull ->
            (List.take index userCurve.pulls)
            ++
            [Disabled (getEndPoint customPull)]
            ++
            (List.drop (index + 2) userCurve.pulls)
      }
      |> Just

--Returns an empty list if all points are deleted
deleteSelectedPoints: Bool -> List CurvePoint -> UserCurve -> Maybe UserCurve
deleteSelectedPoints pointsSorted selectedPoints userCurve =
  let
    sortedPoints = 
      if pointsSorted then 
        selectedPoints 
      else
        List.sortWith orderPoints selectedPoints
  in
  case sortedPoints of
    [] -> Just userCurve
    (point :: tail) -> 
      deletePoint point userCurve 
        |> Maybe.andThen (deleteSelectedPoints True tail)
    
--Deletes selected points on curve
--If no points are selected just delete the curve 
deleteSelected: Model -> List UserCurve
deleteSelected model =
  case getSelectedCurve model of 
    Nothing -> 
      model.userCurves
    Just userCurve -> 
      case model.selectedPoints of 
        [] ->
          filterByUnselected model
        selectedPoints ->
          (
          case (deleteSelectedPoints False model.selectedPoints userCurve) of
            Nothing -> []
            Just curve ->
              case curve.pulls of 
                [] -> []
                _ -> List.singleton curve
          )
          ++
          filterByUnselected model
      
--Builds points on the ends of the userCurve to add new points
buildAddPointButtons: Float -> UserCurve -> List (Shape Msg) 
buildAddPointButtons scaleAmount userCurve = 
  let
    button = 
      group
      [
        circle 3
        |> filled white
        |> addOutline (solid 1) black
      ,
        text "+"
        |> size 6
        |> centered
        |> filled black
        |> move (0, -2)
      ]
      |> scale (2/3 * scaleAmount)
    
    buttonDistance = 6 * scaleAmount
    startButtonPos = 
      userCurve.pulls
      |> List.head
      |> Maybe.withDefault (Disabled (0,0))
      |> calculatePullPoint userCurve.start
      |> positionDelta userCurve.start
      |> normalize
      |> scalarMult (buttonDistance * -1)
      |> addTuple userCurve.start
    
    endPull = 
      userCurve.pulls
      |> List.reverse 
      |> List.head
      |> Maybe.withDefault (Disabled (0,0))
    
    secondToLastPull = 
      userCurve.pulls
      |> List.reverse
      |> List.drop 1
      |> List.head

    secondToLastEndPoint = 
      case secondToLastPull of
        Nothing -> 
          userCurve.start
        Just customPull ->
          getEndPoint customPull
    endButtonPos = 
      calculatePullPoint secondToLastEndPoint endPull
      |> positionDelta (getEndPoint endPull)
      |> normalize 
      |> scalarMult (buttonDistance * -1)
      |> addTuple (getEndPoint endPull)
  in  
  [
    button
    |> move startButtonPos
    |> notifyMouseDown (AddPoint BeforeStart startButtonPos)
    |> notifyMouseDownAt (UpdateMouseInfo True)
    |> notifyMouseMoveAt MouseMove
    |> notifyMouseUpAt (UpdateMouseInfo False)
    ,
    button 
    |> move endButtonPos
    |> notifyMouseDown (AddPoint AfterEnd endButtonPos)
    |> notifyMouseDownAt (UpdateMouseInfo True)
    |> notifyMouseMoveAt MouseMove
    |> notifyMouseUpAt (UpdateMouseInfo False)
  ]

--Saves a version of the model to the history if significant changed have been made
saveModelIfNeeded: Model -> Model -> Model
saveModelIfNeeded oldModel newModel =
  if List.head (oldModel.prevModels) == Just (modelToPrevModel oldModel) then 
    newModel
  else 
    { newModel | 
      prevModels = 
        oldModel.prevModels
        |> (::) (modelToPrevModel oldModel)
        |> List.take maxUndoSteps
    }
    
--Undoes the last change
undo: Model -> Model 
undo model =
  case model.prevModels of  
    [] -> 
      model
    (prevModel :: tail) ->
      prevModelToModel prevModel model

--Removes certain variables from the model so they can be compared to previous Models
--Eg. mouse position and keyboard inputs are going to be stored in previous models
modelToPrevModel: Model -> PrevModel
modelToPrevModel model =
  {
    userCurves = model.userCurves, 
    selectedCurve = model.selectedCurve, 
    selectedPoints = model.selectedPoints,
    pullPointDisplaySettings = model.pullPointDisplaySettings,
    currentAction = model.currentAction,
    colours = model.colours,
    scaleSlider = model.scaleSlider,
    imgZoomSlider = model.imgZoomSlider,
    lastCurveID = model.lastCurveID,
    trashStatus = model.trashStatus,
    backgroundImage = model.backgroundImage 
  }

--Fills in extra info with the model provided
prevModelToModel: PrevModel -> Model -> Model
prevModelToModel prevModel model  =
  {
    userCurves = prevModel.userCurves, 
    selectedCurve = prevModel.selectedCurve, 
    selectedPoints = prevModel.selectedPoints,
    pullPointDisplaySettings = prevModel.pullPointDisplaySettings,
    currentAction = prevModel.currentAction,
    colours = prevModel.colours,
    scaleSlider = prevModel.scaleSlider,
    imgZoomSlider = prevModel.imgZoomSlider,
    lastCurveID = prevModel.lastCurveID,
    trashStatus = prevModel.trashStatus,
    backgroundImage = prevModel.backgroundImage,
    time = model.time,
    keyInfo = model.keyInfo,
    mouseState = model.mouseState,
    prevModels = List.drop 1 model.prevModels
  }

roundToDigits: Int -> Float -> Float
roundToDigits digits value = 
  10 ^ digits
    |> toFloat 
    |> (*) value
    |> round
    |> toFloat
    |> (*) (toFloat (10 ^ -digits))

--Gets the index of a character in a string
getIndex: Char -> String -> Maybe Int
getIndex char string =
  case String.uncons string of 
    Just (head, tail) ->
      if head == char then
        Just 0
      else 
        Maybe.map ((+) 1) (getIndex char tail)
    Nothing -> 
      Nothing 

--Truncates a float to a fixed number of decimal places
floatToStringFixedDecimal: Int -> Float -> String 
floatToStringFixedDecimal digits float =
  let 
    rawStr = String.fromFloat float
    decimalPos = getIndex '.' rawStr
    length = String.length rawStr
  in
    case decimalPos of 
      Just index ->
        let 
          trimmedStr = String.dropRight (length - index - digits - 1) rawStr
          newLength = String.length trimmedStr
        in
        trimmedStr ++ (String.repeat (index + digits - newLength ) "0")
      Nothing ->
        rawStr ++ "." ++ (String.repeat digits "0")


pullToCodeString: Point -> Point -> String
pullToCodeString (pullX, pullY) (endX, endY) =
  [
    "Pull (", floatToStringFixedDecimal 1 pullX, ", ", floatToStringFixedDecimal 1 pullY, ") ",
    "(", floatToStringFixedDecimal 1 endX, ", ", floatToStringFixedDecimal 1 endY, ")"
  ]
  |> List.foldr (++) ""

curveToCodeString: Int -> UserCurve -> String
curveToCodeString tabs curve =
  let 
    endPoints = getEndPoints curve
    pullPoints = getPullPoints curve
  in
  (
    [ getTabs tabs ,"curve (", floatToStringFixedDecimal 1 <| Tuple.first curve.start, ", ", floatToStringFixedDecimal 1 <| Tuple.second curve.start, ") ["]
    |> List.foldr (++) ""
  )
  ++
  (
    List.map2 pullToCodeString pullPoints endPoints
    |> List.intersperse ", "
    |> List.foldr (++) ""
  )
  ++
  "]"

getTabs: Int -> String
getTabs num =
  String.repeat num "  " 

addOutlineToCodeString: Int -> String -> String
addOutlineToCodeString tabs str = 
  str ++ "\n" ++ getTabs tabs ++ "|> outlined (solid 2) black"

convertCurvesToCode: List UserCurve -> List (Shape Msg)
convertCurvesToCode userCurves =  
  case userCurves of 
    [] -> 
      []
    curve :: [] -> 
      curveToCodeString 1 curve
      |> addOutlineToCodeString 2
      |> stringToTextShapes
      
    curves ->
      (
        "group\n  [\n"
        ++
        (
        List.map (curveToCodeString 2) curves
        |> List.map (addOutlineToCodeString 3)
        |> List.intersperse "\n    ,\n"
        |> List.foldr (++) ""
        )
        ++
        "\n  ]"
      )
      |> stringToTextShapes

stringToTextShapes: String -> List (Shape Msg)
stringToTextShapes string =
  String.split "\n" string
    |> List.map (\str -> text str)
    |> List.map codeFont
    |> List.map (size 4)
    |> List.map selectable
    |> List.map (filled black)
    |> List.indexedMap (\index shape -> move (0, (toFloat index) * -5) shape)

addPoint: AddPointID -> Point -> Model -> Model
addPoint addPointID newPointPos model =
  case getSelectedCurve model of 
    Nothing -> model
    Just userCurve -> 
      { model | 
        userCurves = 
          (case addPointID of 
            BeforeStart ->
              { userCurve | 
                start = newPointPos,
                pulls = (Disabled userCurve.start) :: userCurve.pulls
              }
            AfterEnd ->
              { userCurve | 
                pulls = userCurve.pulls ++ [Disabled newPointPos]
              }
            InsertAtPull pullNum ->
              {
                userCurve |
                  pulls = 
                    (List.take pullNum userCurve.pulls)
                    ++
                    [
                      Disabled newPointPos 
                      ,
                      List.drop pullNum userCurve.pulls 
                      |> List.head 
                      |> Maybe.withDefault (Disabled (0,0))
                      |> getEndPoint
                      |> Disabled
                    ]
                    ++
                    (List.drop (pullNum + 1) userCurve.pulls)
              }
          )
          ::
          filterByUnselected model
        ,
        selectedPoints =
          case addPointID of 
            BeforeStart -> [Start]
            AfterEnd -> [EndPoint (List.length userCurve.pulls)]
            InsertAtPull num -> [EndPoint (num)]

      }

deselectSlider: Slider -> Slider 
deselectSlider slider = 
  { slider | state = Waiting }

toggleEndPointLines: PullPointLineDisplayInfo -> PullPointLineDisplayInfo
toggleEndPointLines info = 
  { info | drawEndPointLines = not info.drawEndPointLines}

toggleMidPointLines: PullPointLineDisplayInfo -> PullPointLineDisplayInfo
toggleMidPointLines info = 
  { info | drawMidPointLines = not info.drawMidPointLines}

{---------------------------
-- Curve Creator Contants --
----------------------------}

tracingImage: Image
tracingImage = 
  {
    url = imageURL,
    width = imageWidth,
    height = imageHeight,
    scale = imageScale,
    pos = imagePos
  }

graphColour : Color
graphColour = (hsl 3.371 1 0.562)

graphColourLight : Color
graphColourLight = (hsl 3.371 1 0.862)

graphColourLighter : Color
graphColourLighter = (hsl 3.371 1 0.962)

graphDark : Color
graphDark = (hsl 3.371 1 0.4)

highlight : Color
highlight = (hsla 0.406 1 0.562 0.8)

codeFont : Stencil -> Stencil
--codeFont = customFont "Source Code Pro"
codeFont = fixedwidth

headlineFont : Stencil -> Stencil
headlineFont = customFont "Raleway"

serifFont : Stencil -> Stencil
--serifFont = customFont "Gentium Plus"
serifFont = sansserif

screenWidth: Float
screenWidth = 192 

screenHeight: Float
screenHeight = 128

init : Model
init = { 
  time = 0,
  userCurves = [startingCurve], 
  selectedCurve = Nothing, 
  selectedPoints = [],
  mouseState = MouseState (0,0) False,
  keyInfo = defaultKeyInfo,
  pullPointDisplaySettings = PullPointLineDisplayInfo True False,
  currentAction = MovingPoints,
  colours = blackWithWhite,
  scaleSlider = scaleSliderInit,
  imgZoomSlider = imgZoomSliderInit,
  lastCurveID = 1,
  trashStatus = False,
  backgroundImage = tracingImage,
  prevModels = []
  }
 
scaleSliderInit: Slider
scaleSliderInit = 
  {
    min = -3,
    max = 2,
    width = 40,
    currentVal = 0,
    state = Waiting
  }

scaleSliderXPos: Float
scaleSliderXPos = 73
  
--Scale Function

imgZoomSliderInit: Slider
imgZoomSliderInit = 
  {
    min = -5,
    max = 4,
    width = 40,
    currentVal = clamp -5 5 (logBase 2 imageScale),
    state = Waiting
  }

maxUndoSteps: Int
maxUndoSteps = 100

blackWithWhite: ColourScheme
blackWithWhite = 
  {
    pullPointFill = white,
    endPointFill = black,
    selectedOutline = darkGreen,
    unselectedOutline = black,
    lineColour = black,
    dottedLineColour = graphColour
  }

whiteWithBlack: ColourScheme
whiteWithBlack =
 {
    pullPointFill = black,
    endPointFill = white,
    unselectedOutline = white,
    selectedOutline = lightGreen,
    lineColour = white,
    dottedLineColour = graphColour
  }

yellowWithRed: ColourScheme
yellowWithRed = 
  {
    pullPointFill = green,
    endPointFill = yellow,
    unselectedOutline = yellow,
    selectedOutline = red,
    lineColour = yellow,
    dottedLineColour = graphColour
  } 

defaultKeyInfo: Keys -> KeyState
defaultKeyInfo _ = Up

startingCurve: UserCurve
startingCurve = UserCurve 1 (0,0) [Enabled (20, 20) (0, 40), Disabled (25, -25), Enabled (10, -10) (-10, -35)]

background: Model -> Shape Msg
background model =
  rect 2000 1000 
  |> filled blank
  |> notifyMouseDown 
    (if model.selectedPoints == [] 
      then (Deselect All) 
      else (Deselect AllPoints))
  |> notifyMouseDownAt (UpdateMouseInfo True)
  |> notifyMouseMoveAt MouseMove
  |> notifyMouseUpAt (UpdateMouseInfo False)

addCurveButton: Shape Msg
addCurveButton = 
  [
    roundedRect 30 7 1
      |> filled grey
      |> addOutline (solid 1) black
    ,
    text "Add Curve" 
      |> centered
      |> size 4.5
      |> serifFont
      |> filled black
      |> move (0, -1.5)
  ]
  |> group
  |> move (80, 40)
  |> notifyMouseDown AddNewCurve

editImageButton: Model -> Shape Msg
editImageButton model =
  let 
    txt = 
      if model.currentAction == EditingImage then
        "Stop Editing"
      else 
        "Edit Image"
  in
  [
    roundedRect 30 7 1
      |> filled grey
      |> addOutline (solid 1) black
    ,
    text txt
      |> centered
      |> size 4.5
      |> serifFont
      |> filled black
      |> move (0, -1.75)
  ]
  |> group
  |> move (80, -3)
  |> (if model.currentAction == EditingImage then  
        notifyMouseDown (SetAction MovingPoints)
      else
        notifyMouseDown (SetAction EditingImage) >> notifyMouseDown (Deselect All))

{-
addPointsButton: Model -> Shape Msg
addPointsButton model = 
  let 
    txt = 
      if model.currentAction == AddingPoints then
        "Move Points"
      else 
      "Add Points"
  in
  [
    roundedRect 30 7 1
      |> filled grey
      |> addOutline (solid 1) black
    ,
    text txt
      |> centered
      |> size 5
      |> filled black
      |> move (0, -2)
  ]
  |> group
  |> move (80, 40)
  |> (if model.currentAction == AddingPoints then  
        notifyMouseDown (SetAction MovingPoints)
      else
        notifyMouseDown (SetAction AddingPoints) )
-}

getCodeButton: Shape Msg
getCodeButton =
  group 
    [ circle 5 |> filled (rgba 0 150 255 0.5 )
      , group [ roundedRect 8 3 2 |> filled white 
      , circle 1.5 |> filled white |> move (-1.5, 1)
      , circle 2.3 |> filled white |> move (1,1)] 
      , group [ rect 2 6 |> filled white 
      , triangle 3 |> filled white |> rotate (degrees 270) |> move(0,-1.5) ]  |> scale 0.4 |> move(0,-2)
    ] 

trashCan: Bool -> Shape Msg
trashCan open = 
  let
    clr = if open then red else grey
  in
  group [ polygon [(0,0),(10,0),(8,-10),(2,-10)] |> filled clr 
        , rect 1 8 |> filled white |> rotate (degrees 10) |> move (2.5,-5)
        , rect 1 8 |> filled white |> rotate (degrees -10) |> move (7.5,-5)
        , rect 1 7 |> filled white |> move (5,-5)
        , group [ rect 11 2 |> filled clr |> move (5.5,3)
        , rect 4 1 |> filled clr |> move(5.5,4.5) ] |> ( case open of 
                                                            True -> ( rotate (degrees -30) >> move(0,20)) 
                                                            False -> rotate (degrees 0)) 
        , group [ curve (0,-2) [GSVGS.Pull (5,5) (0,10), GSVGS.Pull (-6,13) (-9,7), GSVGS.Pull (-10,15) (-10,16), GSVGS.Pull (-3,20) (4,16), GSVGS.Pull (11,9) (0,-2) ] |> filled clr |> scale 0.25 |> move (1,-3)
        , triangle 2 |> filled clr |> rotate (degrees 195) |> move(-1.5,0.15) ] |> mirrorX |> move(-2,1)
        , roundedRect 15 20 2 |> filled blank |> move (5, -2.5)
        ] 
  |> notifyEnter (UpdateTrash True)
  |> notifyLeave (UpdateTrash False)
  |> notifyMouseMoveAt MouseMove
  |> notifyMouseUp TrashItems

undoButton = 
  group 
    [ circle 4 |> filled (rgb 50 50 50)
    , group [curve (0,-2) [GSVGS.Pull (5,5) (0,10), GSVGS.Pull (-6,13) (-9,8), GSVGS.Pull (-10,15) (-10,16), GSVGS.Pull (-3,20) (4,16), GSVGS.Pull (11,9) (0,-2) ] |> filled gray |> scale 0.25 |> move (1.2,-2.5)
    , triangle 2 |> filled gray |> rotate (degrees 195) |> move(-1.3,0.65) ]] 



{-----------------------
      -- Types --
------------------------}

type DeselectInfo = AllPoints | Point CurvePoint | All 
type alias Point = (Float, Float)
type alias MouseState = {pos: Point, mouseDown: Bool}
type AddPointID = BeforeStart | AfterEnd | InsertAtPull Int 
type Action = MovingPoints | EditingImage | Exporting

type alias Image =  
  {
    url : String,
    width : Float,
    height : Float,
    scale : Float,
    pos : (Float, Float)
  }

-- if Pull is enabled store both pull point and end point
-- if Pull is disabled only store end point and calculate pull points to be the midpoint
type CustomPull = Enabled Point Point
  | Disabled Point
  
type alias PullPointLineDisplayInfo = 
  { 
    drawEndPointLines : Bool,
    drawMidPointLines : Bool 
  }
 
type alias UserCurve = 
  {
    id: Int, 
    start: Point, 
    pulls: List CustomPull
  }
  
--Used for identifying points that the user clicks on (Starts at 0)
type CurvePoint = Start | PullPoint Int | EndPoint Int

--type ShapeID = Background | Curve Int | Point CurvePoint

type alias Slider =
  {
    width : Float,
    min : Float,
    max : Float,
    currentVal : Float,
    state : SliderState
  }

type SliderState = Waiting | Dragging

type alias ColourScheme = 
  {
    pullPointFill : Color,
    endPointFill : Color,
    unselectedOutline : Color,
    selectedOutline : Color,
    lineColour : Color,
    dottedLineColour : Color
  }

-- Add messages here
type Msg = Tick Float GetKeyState
  | MouseMove Point
  | UpdateMouseInfo Bool Point
  | ToggleEndPointLines
  | ToggleMidPointLines
  | SetAction Action
  | AddPoint AddPointID Point
  | SelectPoint CurvePoint
  | SelectCurve Int
  | Deselect DeselectInfo
  | ChangeColours ColourScheme
  | DeleteSelected
  | SelectScaleSlider 
  | SelectImageSlider
  | SelectAll
  | AddNewCurve
  | Undo
  | UpdateTrash Bool
  | TrashItems

-- This is the type of your model
type alias Model = 
  { 
    time : Float, 
    userCurves: List UserCurve, 
    selectedPoints: List CurvePoint,
    selectedCurve: Maybe Int, 
    mouseState: MouseState,
    keyInfo: Keys -> KeyState,
    pullPointDisplaySettings : PullPointLineDisplayInfo,
    currentAction : Action,
    colours : ColourScheme,
    scaleSlider : Slider,
    imgZoomSlider : Slider,
    lastCurveID : Int,
    trashStatus : Bool,
    backgroundImage : Image,
    prevModels : List PrevModel
  }

--Used for storing previous models
type alias PrevModel =
  { 
    userCurves: List UserCurve, 
    selectedCurve: Maybe Int, 
    selectedPoints: List CurvePoint,
    pullPointDisplaySettings : PullPointLineDisplayInfo,
    currentAction : Action,
    colours : ColourScheme,
    scaleSlider : Slider,
    imgZoomSlider : Slider,
    trashStatus : Bool,
    backgroundImage : Image,
    lastCurveID : Int
  }


{-----------------------
 -- Vector Functions --
------------------------}

addTuple: (Float, Float) -> (Float, Float) -> (Float, Float)
addTuple (a1, b1) (a2, b2) =
  (a1 + a2, b1 + b2)

getMidpoint: (Float, Float) -> (Float, Float) -> (Float, Float)
getMidpoint (x1, y1) (x2, y2) =
  ((x1 + x2) / 2, (y1 + y2) / 2)

positionDelta: (Float, Float) -> (Float, Float) -> (Float, Float) 
positionDelta (a, b) (c, d) =
  (c - a,  d - b)

magnitude: (Float, Float) -> Float
magnitude (x, y) = 
  (x ^ 2 + y ^ 2) ^ 0.5

normalize: (Float, Float) -> (Float, Float)
normalize (x, y) =
  let
    mag = magnitude (x, y)
  in
    if mag == 0 then
      (0, 0)
    else
      (x / mag, y / mag)

scalarMult: Float -> (Float, Float) -> (Float, Float)
scalarMult c (a, b) = (a * c, b * c)

dotProduct: (Float, Float) -> (Float, Float) -> Float
dotProduct (a1, a2) (b1, b2) =
  (a1 * b1) + (a2 * b2)

angleBetweenVectors: (Float, Float) -> (Float, Float) -> Float
angleBetweenVectors vect1 vect2 =
  magnitude vect1 
  |> (*) (magnitude vect2)
  |> (/) (dotProduct vect1 vect2) 
  |> acos

calculateAngle: (Float, Float) -> (Float, Float) -> (Float, Float) -> Float
calculateAngle pull1 end pull2 =
  let 
    vect1 = positionDelta end pull1
    vect2 = positionDelta end pull2
  in
  angleBetweenVectors vect1 vect2 

rot: Float -> (Float, Float) -> (Float, Float)
rot angle (x,y) = 
  ( cos angle * x - sin angle * y
  , sin angle * x + cos angle * y)

averageDir: (Float, Float) -> (Float, Float) -> (Float, Float)
averageDir vect1 vect2 = 
  let 
    sum = addTuple vect1 vect2 
  in
  if magnitude sum <= 0.000001 then 
    rot (degrees 90) vect1 
    |> normalize
  else 
    normalize sum