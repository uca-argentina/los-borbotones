"
I am a position.
"
Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'tile',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'private-assertions' }
Position class >> assertValidTile: aTileNumber andLap: aLapNumber [ 
	aTileNumber < 0 ifTrue: [ GameModelError signal: 'Tile number must be a non negative integer. ' ].
	aLapNumber  < 0 ifTrue: [ GameModelError signal: 'Lap number must be a non negative integer. ' ]
]

{ #category : #creation }
Position class >> tile: aTileNumber andLap: aLapNumber [
	self assertValidTile: aTileNumber andLap: aLapNumber.
	^ self new
		initializeWithTileNumber: aTileNumber andLap: aLapNumber;
		yourself
]

{ #category : #initialization }
Position >> initializeWithTileNumber: aTileNumber andLap: aLapNumber [
	tile := aTileNumber.
	lap := aLapNumber
]

{ #category : #accessing }
Position >> isAheadOf: aPosition [
	^ (lap > aPosition lap) or: ((lap = aPosition lap) and: (tile > aPosition tile))

]

{ #category : #accessing }
Position >> lap [
	^ lap
]

{ #category : #accessing }
Position >> tile [
	^ tile
]
