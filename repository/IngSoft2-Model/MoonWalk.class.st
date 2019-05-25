Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'numberN'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk class >> withNumber: aNumber [ 
	^ self new
		initializeWithNumber: aNumber;
		yourself
]

{ #category : #initialization }
MoonWalk >> affect: aPlayer on: aGame [
	aGame inactivePlayers
		do: [ :player | aGame player: player movesBackwardsSteps: numberN ]
]

{ #category : #'as yet unclassified' }
MoonWalk >> initializeWithNumber: aNumber [
	numberN := aNumber
]
