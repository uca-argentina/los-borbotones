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
		'playersPositions',
		'dices',
		'deck',
		'turnPosition',
		'board',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> playedBy: aSetOfPlayers withLapsToWin: aLapsAmount board: aBoard deck: aDeck using: dices [
	^ self new
		initializeWithLaps: aLapsAmount
			board: aBoard
			players: aSetOfPlayers
			cardDeck: aDeck
			andUsing: dices;
		yourself
]

{ #category : #'private-assertions' }
Game >> assertGameHasNotEnded [
	self hasEnded
		ifTrue: [ GameModelError signal: 'Game is over. ' ]
]

{ #category : #components }
Game >> board [
	^ board
]

{ #category : #components }
Game >> changePositionOf: aPlayer toTile: aNumberOfTile andLap: aNumberOfLap [
	(self historyPositionOf: aPlayer)
		add: (Position tile: aNumberOfTile andLap: aNumberOfLap)
]

{ #category : #status }
Game >> currentPlayer [
	^ players at: turnPosition
]

{ #category : #presentation }
Game >> deck [
	^ deck
]

{ #category : #status }
Game >> hasEnded [
	^ players
		anySatisfy: [ :player | (self positionLapOf: player) >= laps ]
]

{ #category : #components }
Game >> historyPositionOf: aPlayer [
	^ playersPositions at: (self indexOf: aPlayer)
]

{ #category : #components }
Game >> indexOf: aPlayer [
	^ players indexOf: aPlayer
]

{ #category : #initialize }
Game >> initializeWithLaps: aLapsAmount board: aBoard players: aSetOfPlayers cardDeck: aDeck andUsing: aSetOfDices [
	players := aSetOfPlayers.
	playersPositions := players
		collect: [ :player | OrderedCollection with: (Position tile: 0 andLap: 0) ].
	laps := aLapsAmount.
	dices := aSetOfDices.
	board := aBoard.
	deck := aDeck.
	turnPosition := 1
]

{ #category : #actions }
Game >> moveToPreviousPosition: aPlayer [
	(self historyPositionOf: aPlayer)
		removeLast;
		removeLast
]

{ #category : #actions }
Game >> moves: aPlayer stepsBackwards: aStepsAmount [
	| newPosition newLap playerHistoryPosition |
	playerHistoryPosition := self historyPositionOf: aPlayer.
	newPosition := self
		newPositionBackwardFor: aPlayer
		calculatedWith: aStepsAmount.
	newLap := self newLapBackwardFor: aPlayer calculatedWith: newPosition.
	playerHistoryPosition
		add: (Position tile: newPosition andLap: newLap)
]

{ #category : #actions }
Game >> moves: aPlayer stepsFoward: aStepsAmount [
	| newPosition newLap playerHistoryPosition |
	playerHistoryPosition := self historyPositionOf: aPlayer.
	newPosition := self
		newPositionForwardFor: aPlayer
		calculatedWith: aStepsAmount.
	newLap := self newLapFowardFor: aPlayer calculatedWith: aStepsAmount.
	playerHistoryPosition
		add: (Position tile: newPosition andLap: newLap)
]

{ #category : #components }
Game >> newLapBackwardFor: aPlayer calculatedWith: aStepsAmount [
	^ ((self
		newTotalStepsBackwardMadeBy: aPlayer
		calculatedWith: aStepsAmount) / board numberOfTiles) floor
]

{ #category : #components }
Game >> newLapFowardFor: aPlayer calculatedWith: aStepsAmount [
	^ (((self positionOf: aPlayer) lap + aStepsAmount)
		/ board numberOfTiles) floor
]

{ #category : #components }
Game >> newPositionBackwardFor: aPlayer calculatedWith: aStepsAmount [
	^ (self
		newTotalStepsBackwardMadeBy: aPlayer
		calculatedWith: aStepsAmount) % board numberOfTiles
]

{ #category : #components }
Game >> newPositionForwardFor: aPlayer calculatedWith: aStepsAmount [
	^ ((self positionOf: aPlayer) tile + aStepsAmount)
		% board numberOfTiles
]

{ #category : #components }
Game >> newTotalStepsBackwardMadeBy: aPlayer calculatedWith: aStepsAmount [
	^ (self totalStepsMadeOf: aPlayer) - aStepsAmount max: 0
]

{ #category : #status }
Game >> players [
	^ players
]

{ #category : #components }
Game >> positionLapOf: aPlayer [
	^ (self positionOf: aPlayer) lap
]

{ #category : #components }
Game >> positionOf: aPlayer [
	^ (playersPositions at: (self indexOf: aPlayer)) last
]

{ #category : #status }
Game >> ranking [
	^ players
		asSortedCollection:
			[ :player1 :player2 | (self positionOf: player1) isAheadOf: (self positionOf: player2) ]
]

{ #category : #actions }
Game >> rollDicesForCurrentPlayer [
	| rollResult currentPlayer |
	currentPlayer := self currentPlayer.
	rollResult := dices sum: #roll.
	self moves: currentPlayer stepsFoward: rollResult.
	board
		effectAt: (self tilePositionOf: currentPlayer)
		affect: currentPlayer
		on: self
]

{ #category : #components }
Game >> tilePositionOf: aPlayer [
	^ (self positionOf: aPlayer) tile
]

{ #category : #components }
Game >> totalStepsMadeOf: aPlayer [
	| playerPosition |
	playerPosition := self positionOf: aPlayer.
	^ playerPosition lap * board numberOfTiles + playerPosition tile
]

{ #category : #actions }
Game >> turnIsPlayed [
	self assertGameHasNotEnded.
	self rollDicesForCurrentPlayer.
	turnPosition := turnPosition % players size + 1
]

{ #category : #status }
Game >> winner [
	^ players
		detect: [ :player | (self positionLapOf: player) >= laps ]
		ifNone: [ GameModelError
				signal: 'There is no winner yet. The game is not finished' ]
]
