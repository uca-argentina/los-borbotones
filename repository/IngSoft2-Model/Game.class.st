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
		'numberOfSteps',
		'players',
		'dices',
		'turnPosition',
		'board',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> playedBy: aSetOfPlayers withLapsToWin: aLapsAmount withSteps: aStepsAmount using: dices [
	^ self new
		initializeWithLaps: aLapsAmount
			stepsPerLap: aStepsAmount
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

{ #category : #initialize }
Game >> initializeWithLaps: aLapsAmount stepsPerLap: aStepsAmount players: aSetOfPlayers andUsing: aSetOfDices [
	players := aSetOfPlayers.
	laps := aLapsAmount.
	numberOfSteps := aStepsAmount.
	dices := aSetOfDices.
	board := Board withSteps: aStepsAmount.
	turnPosition := 1
]

{ #category : #actions }
Game >> rollDicesFor: aPlayer [
	| newPosition newLap rollResult |
	
	rollResult := dices sum: #roll.
	
	newLap := aPlayer laps + (aPlayer position + rollResult) / (board numberOfSteps) floor.
	
	newPosition := (aPlayer position + rollResult) % (board numberOfSteps) floor.
	
	aPlayer moveTo: newPosition lap: newLap.
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
