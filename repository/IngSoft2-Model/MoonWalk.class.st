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
MoonWalk >> affect: aPlayer on: aGame [
	aGame inactivePlayers
		do: [ :player | aGame player: player goesBackSteps: numberN ]
]

{ #category : #initialization }
MoonWalk >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
MoonWalk >> probability [
	^probability
]
