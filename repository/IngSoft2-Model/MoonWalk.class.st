"
Los demás vuelven hacia atras N casilleros. Probabilidad de aparición: 5%.
"
Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'numberN'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
MoonWalk class >> withNumber: aNumber [ 
	^ self new
		initializeWithNumber: aNumber;
		yourself
]

{ #category : #action }
MoonWalk >> affect: aPlayer on: aGame [
	aGame players
		do: [ :player | aGame moves: player stepsBackwards: numberN ]
		without: aGame currentPlayer
]

{ #category : #initialization }
MoonWalk >> initializeWithNumber: aNumber [
	numberN := aNumber
]
