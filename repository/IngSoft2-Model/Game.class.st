"
""soy un juego""

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'dices',
		'turnPosition',
		'board',
		'laps',
		'ranking'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> playedBy: aSetOfPlayers withLapsToWin: aLapsAmount board: aBoard using: dices [
	^ self new
		initializeWithLaps: aLapsAmount
			board: aBoard
			players: aSetOfPlayers
			andUsing: dices;
		yourself
]

{ #category : #'private-assertions' }
Game >> assertGameHasNotEnded [
	self hasEnded
		ifTrue: [ self error: 'Game is over. ' ]
]

{ #category : #components }
Game >> board [
	^board
]

{ #category : #status }
Game >> currentPlayer [
	^ players at: turnPosition
]

{ #category : #status }
Game >> hasEnded [
	^ players anySatisfy: [ :player | player laps >= laps ]
]

{ #category : #actions }
Game >> inactivePlayers [
	^ players reject: [ :player | player = self currentPlayer ]
]

{ #category : #initialize }
Game >> initializeWithLaps: aLapsAmount board: aBoard players: aSetOfPlayers andUsing: aSetOfDices [
	players := aSetOfPlayers.
	laps := aLapsAmount.
	dices := aSetOfDices.
	board := aBoard.
	turnPosition := 1
]

{ #category : #actions }
Game >> movesToTheLastTurnPositionThePlayer: aPlayer [
	aPlayer
		moveTo: (aPlayer history at: (aPlayer history size - 2)) tile
		lap: (aPlayer history at: (aPlayer history size - 2)) lap
]

{ #category : #actions }
Game >> player: aPlayer movesBackwardsSteps: aNumberOfSteps [ 
	| totalStepsMade newPositionInSteps lap position|
	totalStepsMade := (aPlayer laps * board numberOfTiles) + aPlayer position.
	newPositionInSteps := totalStepsMade - aNumberOfSteps.
	newPositionInSteps := newPositionInSteps max: 0.
	lap := (newPositionInSteps / board numberOfTiles) floor.
	position := ((newPositionInSteps) % board numberOfTiles).
	aPlayer moveTo: position lap: lap.
	
	
	
]

{ #category : #actions }
Game >> player: aPlayer movesForwardSteps: aStepsAmount [ 
	|newPosition lap|
	newPosition := (aPlayer position + aStepsAmount) % board numberOfTiles .
	lap := ((aPlayer position + aStepsAmount) / board numberOfTiles) floor.
	aPlayer moveTo: newPosition lap: lap.
]

{ #category : #status }
Game >> players [
	^ players
]

{ #category : #status }
Game >> ranking [
	^ players
		asSortedCollection: [ :player1 :player2 | 
			player1 lap * board numberOfTiles + player1 position
				>= (player2 lap * board numberOfTiles + player2 position) ]
]

{ #category : #actions }
Game >> rollDicesFor: aPlayer [
	| rollResult |
	rollResult := dices sum: #roll.
	self player: aPlayer movesForwardSteps: rollResult.
	(board effectAt: aPlayer position) affect: aPlayer on: self
]

{ #category : #actions }
Game >> turnIsPlayed [
	self assertGameHasNotEnded.
	self rollDicesFor: self currentPlayer.
	turnPosition := turnPosition % players size + 1
]

{ #category : #status }
Game >> winner [
	^ players
		detect: [ :player | player laps >= laps ]
		ifNone: [ self error: 'There is no winner yet. The game is not finished' ]
]
