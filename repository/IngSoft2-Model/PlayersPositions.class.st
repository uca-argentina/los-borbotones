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
	^ playersPositions at: aPlayer
]

{ #category : #accessing }
PlayersPositions >> initializeWithPositionsFor: aSetOfPlayers [
	|positionsCollection|
	
	positionsCollection := aSetOfPlayers collect: [ :player | player -> (OrderedCollection with: (Position tile: 0 andLap: 0)) ].
	playersPositions := Dictionary newFrom: positionsCollection.
]

{ #category : #components }
PlayersPositions >> moveToPreviousPosition: aPlayer [
	(self historyPositionOf: aPlayer)
		removeLast;
		removeLast
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
