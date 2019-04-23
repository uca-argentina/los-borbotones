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
		'turnPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> playedBy: aSetOfPlayers withStepsToWin: aStepsAmount  andUsing: dices [
	^ self new
		 initializeWithSteps: aStepsAmount players: aSetOfPlayers andUsing: dices;
		 yourself.
]

{ #category : #presentation }
Game >> assertGameHasEnded [
	self hasEnded
		ifTrue: [ self error: 'Game is over. ' ]
]

{ #category : #status }
Game >> hasEnded [
	^ players anySatisfy: [ :player | player position >= numberOfSteps ]
]

{ #category : #status }
Game >> initializeWithSteps: aStepsAmount players: setOfPlayers andUsing: setOfDices [
	players := setOfPlayers.
	numberOfSteps := aStepsAmount.
	dices := setOfDices.
	turnPosition := 1
]

{ #category : #presentation }
Game >> nextTurnPlayed [
	self assertGameHasEnded.
	self thePlayersTurn playsRolling: dices.
	turnPosition := turnPosition % players size + 1
]

{ #category : #status }
Game >> thePlayersTurn [
	^ players at: turnPosition
]

{ #category : #presentation }
Game >> winner [
	^ players detect: [ :player | player position > numberOfSteps ]
]
