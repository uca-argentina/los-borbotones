Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'numberN'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
MoonWalk class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #initialization }
MoonWalk >> affect: players withCurrentPlayer: aPlayer andNumberOfTiles: aNumberOfTiles [
	"| targetPlayers newPosition | 
	targetPlayers := players reject: [ :player | player = aPlayer ].
	targetPlayers
		do: [ :player | 
			newPosition := ((aNumberOfTiles - (player position - numberN) abs) % aNumberOfTiles) floor.
			player moveTo: newPosition lap: 0 ]"
]

{ #category : #initialization }
MoonWalk >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
MoonWalk >> probability [
	^probability
]
