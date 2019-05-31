"
Board game.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Board class >> withTiles: tiles [
	^ self new
		initializeWithTiles: tiles;
		yourself
]

{ #category : #accessing }
Board >> effectAt: aPosition affect: aPlayer on: game [
	| effect |
	effect := tiles at: aPosition + 1.
	effect affect: aPlayer on: game
]

{ #category : #initialization }
Board >> initializeWithTiles: tileCollection [
	tiles := tileCollection
]

{ #category : #accessing }
Board >> numberOfTiles [
	^ tiles size
]
