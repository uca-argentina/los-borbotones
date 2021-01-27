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
		'laps',
		'permanentCards',
		'lastCardPlayed',
		'orientationTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'private-assertions' }
Game class >> assertLapsAmountIsPositive: aLapsAmount [ 
	(aLapsAmount < 1) ifTrue: [ GameModelError signal: 'Laps amount must be a positive integer. ' ]
]

{ #category : #'private-assertions' }
Game class >> assertSetOfDicesIsValid: aSetOfDices [ 
	aSetOfDices size < 1 ifTrue: [ GameModelError signal: 'Invalid set of dices. ' ]
]

{ #category : #'private-assertions' }
Game class >> assertValidSetOfPlayers: aSetOfPlayers [ 
	(aSetOfPlayers size == 0) ifTrue: [ GameModelError signal: 'Invalid set of players. ' ]
]

{ #category : #creation }
Game class >> playedBy: aSetOfPlayers withLapsToWin: aLapsAmount board: aBoard deck: aDeck using: aSetOfDices [
	self assertValidSetOfPlayers: aSetOfPlayers.
	self assertLapsAmountIsPositive: aLapsAmount.
	self assertSetOfDicesIsValid: aSetOfDices.
	^ self new
		initializeWithLaps: aLapsAmount
			board: aBoard
			players: aSetOfPlayers
			cardDeck: aDeck
			andUsing: aSetOfDices;
		yourself
]

{ #category : #actions }
Game >> addPermanentCard: aPermanentCard [ 
	permanentCards add: aPermanentCard 
]

{ #category : #'private-assertions' }
Game >> assertGameHasNotEnded [
	self hasEnded
		ifTrue: [ GameModelError signal: 'Game is over. ' ]
]

{ #category : #'private-assertions' }
Game >> assertValidPlayer: aPlayerName [
	(players anySatisfy: [ :aPlayer | aPlayer name = aPlayerName  ])
		ifFalse: [ GameModelError signal: 'There is no such player.' ]
]

{ #category : #'private-assertions' }
Game >> assertValidPlayers: aPlayersCollection [
	| playersName |
	playersName := players collect: [ :player | player name ].
	(playersName
		includesAll: (aPlayersCollection collect: [ :player | player name ]))
		ifFalse: [ GameModelError signal: 'No son jugadores del juego' ]
]

{ #category : #presentation }
Game >> board [
	^ board
]

{ #category : #actions }
Game >> changeOrientationTurn [
	orientationTurn := orientationTurn * -1.
]

{ #category : #actions }
Game >> changePositionOf: aPlayer toTile: aTileNumber andLap: aLapNumber [ 
	playersPositions changePositionOf: aPlayer toTile: aTileNumber andLap: aLapNumber.
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
		anySatisfy: [ :player | (playersPositions positionLapOf: player) >= laps ]
]

{ #category : #initialize }
Game >> initializeWithLaps: aLapsAmount board: aBoard players: aSetOfPlayers cardDeck: aDeck andUsing: aSetOfDices [
	players := aSetOfPlayers.
	playersPositions := PlayersPositions withPositionsFor: players.
	laps := aLapsAmount.
	dices := aSetOfDices.
	board := aBoard.
	deck := aDeck.
	lastCardPlayed := DummyCard new.
	permanentCards := OrderedCollection new.
	turnPosition := 1.
	orientationTurn := 1.
	players do: [ :player | player take: (deck dealCards: 2)]
]

{ #category : #presentation }
Game >> lastCardPlayed [
	^ lastCardPlayed.
]

{ #category : #actions }
Game >> moveToPreviousPosition: aPlayer [
	playersPositions moveToPreviousPosition: aPlayer.
]

{ #category : #actions }
Game >> moves: aPlayer steps: aStepsAmount [
	| newPosition newLap playerHistoryPosition |
	playerHistoryPosition := playersPositions historyPositionOf: aPlayer.
	newPosition := self
		newPositionFor: aPlayer
		calculatedWith: aStepsAmount.
	newLap := self newLapFor: aPlayer calculatedWith: aStepsAmount.
	playerHistoryPosition
		add: (Position tile: newPosition andLap: newLap)
]

{ #category : #actions }
Game >> moves: aPlayer stepsBackwards: aPositiveStepsAmount [
	self moves: aPlayer steps: -1*aPositiveStepsAmount.
]

{ #category : #actions }
Game >> newLapFor: aPlayer calculatedWith: aStepsAmount [
	^ ((self
		newTotalStepsMadeBy: aPlayer
		calculatedWith: aStepsAmount) / board numberOfTiles) floor
]

{ #category : #actions }
Game >> newPositionFor: aPlayer calculatedWith: aStepsAmount [
	^ (self
		newTotalStepsMadeBy: aPlayer
		calculatedWith: aStepsAmount) % board numberOfTiles
]

{ #category : #actions }
Game >> newTotalStepsMadeBy: aPlayer calculatedWith: aStepsAmount [
	^ (playersPositions totalStepsMadeOf: aPlayer on: board) + aStepsAmount max: 0
]

{ #category : #actions }
Game >> performTurnPosition [
	turnPosition := turnPosition + orientationTurn.
	turnPosition = 0
	ifTrue: [ turnPosition := players size ].
	turnPosition > players size
	ifTrue: [ turnPosition := 1 ].
]

{ #category : #presentation }
Game >> permanentCards [
	^permanentCards copy.
]

{ #category : #status }
Game >> players [
	^ players copy.
]

{ #category : #presentation }
Game >> playersPositions [
	^ playersPositions
]

{ #category : #status }
Game >> ranking [
	^ playersPositions rankPlayers.

]

{ #category : #actions }
Game >> removePermanentCard: aCard [ 
	permanentCards remove: aCard ifAbsent: [].
]

{ #category : #actions }
Game >> repeatLastEffectTileOf: aPlayer [ 
	board
		effectAt: (playersPositions tilePositionOf: aPlayer)
		affect: aPlayer 
		on: self
]

{ #category : #actions }
Game >> reverseTurns [
	self changeOrientationTurn.
	self performTurnPosition.
	self performTurnPosition.
]

{ #category : #actions }
Game >> rollDicesForCurrentPlayer [
	| rollResult currentPlayer |
	currentPlayer := self currentPlayer.
	rollResult := permanentCards
		inject: (dices sum: #roll)
		into: [ :result :card | card update: result for: currentPlayer ].
	self moves: currentPlayer steps: rollResult.
	board
		effectAt: (playersPositions tilePositionOf: currentPlayer)
		affect: currentPlayer
		on: self
]

{ #category : #actions }
Game >> selectPlayerNamed: aPlayerName [
	self assertValidPlayer: aPlayerName .
	^ players
		detect: [ :aPlayer | aPlayer name = aPlayerName ]
]

{ #category : #actions }
Game >> selectPlayers: aPlayersCollection [
	self assertValidPlayers: aPlayersCollection.
	^ players
]

{ #category : #actions }
Game >> setLastCard: aCard [ 
	lastCardPlayed := aCard.
]

{ #category : #actions }
Game >> skipTurn [
	self performTurnPosition.
]

{ #category : #actions }
Game >> turnIsPlayed [
	self assertGameHasNotEnded.
	self rollDicesForCurrentPlayer.
	self performTurnPosition
]

{ #category : #status }
Game >> winner [
	^ players
		detect: [ :player | (playersPositions positionLapOf: player) >= laps ]
		ifNone: [ GameModelError
				signal: 'There is no winner yet. The game is not finished' ]
]
