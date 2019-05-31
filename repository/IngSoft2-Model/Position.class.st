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

{ #category : #creation }
Position class >> tile: aTileNumber andLap: aLapNumber [
	^ self new
		initializeWithTileNumber: aTileNumber andLap: aLapNumber;
		yourself
]

{ #category : #accessing }
Position >> changeTileTo: aTileNumber andChangeLapTo: aLapNumber [
	tile := aTileNumber.
	lap := aLapNumber
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
