"
Player Positions
"
Class {
	#name : #PlayersPositions,
	#superclass : #Object,
	#instVars : [
		'playersPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
PlayersPositions class >> withPositionsFor: aSetOfPlayers [
	^self new initializeWithPositionsFor: aSetOfPlayers.
]

{ #category : #components }
PlayersPositions >> changePositionOf: aPlayer toTile: aNumberOfTile andLap: aNumberOfLap [
	(self historyPositionOf: aPlayer)
		add: (Position tile: aNumberOfTile andLap: aNumberOfLap)
]

{ #category : #components }
PlayersPositions >> historyPositionOf: aPlayer [
	^ playersPositions at: aPlayer ifAbsent: [ GameModelError signal: 'Player not found. ' ]
]

{ #category : #accessing }
PlayersPositions >> initializeWithPositionsFor: aSetOfPlayers [
	|positionsCollection|
	
	positionsCollection := aSetOfPlayers collect: [ :player | player -> (OrderedCollection with: (Position tile: 0 andLap: 0)) ].
	playersPositions := Dictionary newFrom: positionsCollection.
]

{ #category : #actions }
PlayersPositions >> move: aPlayer steps: aStepsAmount on: aBoard [
	| newPosition newLap |
	newPosition := self
		newPositionFor: aPlayer
		calculatedWith: aStepsAmount on: aBoard.
	newLap := self newLapFor: aPlayer calculatedWith: aStepsAmount on: aBoard.
	self changePositionOf: aPlayer toTile: newPosition andLap: newLap.
]

{ #category : #components }
PlayersPositions >> moveToPreviousPosition: aPlayer [
	(self historyPositionOf: aPlayer)
		removeLast;
		removeLast
]

{ #category : #'instance creation' }
PlayersPositions >> newLapFor: aPlayer calculatedWith: aStepsAmount on: aBoard [
	^ ((self newTotalStepsMadeBy: aPlayer calculatedWith: aStepsAmount on: aBoard)
		/ aBoard numberOfTiles) floor
]

{ #category : #'instance creation' }
PlayersPositions >> newPositionFor: aPlayer calculatedWith: aStepsAmount on: aBoard [
	^ (self newTotalStepsMadeBy: aPlayer calculatedWith: aStepsAmount on: aBoard)
		% aBoard numberOfTiles
]

{ #category : #accessing }
PlayersPositions >> newTotalStepsMadeBy: aPlayer calculatedWith: aStepsAmount on: aBoard [
	^ (self totalStepsMadeOf: aPlayer on: aBoard) + aStepsAmount max: 0
]

{ #category : #components }
PlayersPositions >> positionLapOf: aPlayer [
	^ (self positionOf: aPlayer) lap
]

{ #category : #components }
PlayersPositions >> positionOf: aPlayer [
	^ (self historyPositionOf: aPlayer) last
]

{ #category : #components }
PlayersPositions >> rankPlayers [
	^ playersPositions keys
		asSortedCollection:
			[ :player1 :player2 | (self positionOf: player1) isAheadOf: (self positionOf: player2) ].
]

{ #category : #components }
PlayersPositions >> tilePositionOf: aPlayer [
	^ (self positionOf: aPlayer) tile
]

{ #category : #accessing }
PlayersPositions >> totalStepsMadeOf: aPlayer on: aBoard [
	| playerPosition |
	playerPosition := self positionOf: aPlayer.
	^ playerPosition lap * aBoard numberOfTiles + playerPosition tile
]
