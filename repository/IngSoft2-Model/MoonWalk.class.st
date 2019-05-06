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
MoonWalk >> affect: aGame [
	"| targetPlayers newPosition lapsToGoBack| 
	targetPlayers := players reject: [ :player | player = aPlayer ].
	lapsToGoBack := (numberN / (aGame board numberOfTiles)) floor.
	targetPlayers
		do: [ :player | 
			newPosition := ((player position - numberN) abs % aGame board numberOfTiles) + 1.
			player moveTo: newPosition lap: ((player laps - lapsToGoBack) max: 0). ]"
]

{ #category : #initialization }
MoonWalk >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
MoonWalk >> probability [
	^probability
]
