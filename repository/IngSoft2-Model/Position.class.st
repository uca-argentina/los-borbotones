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

{ #category : #initialization }
Position >> initializeWithTileNumber: aTileNumber andLap: aLapNumber [
	tile := aTileNumber.
	lap := aLapNumber
]

{ #category : #accessing }
Position >> lap [
	^lap
]

{ #category : #accessing }
Position >> tile [
	^tile
]
