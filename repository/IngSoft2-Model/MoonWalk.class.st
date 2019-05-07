Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'numberN',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
MoonWalk class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #creation }
MoonWalk class >> withProbability: aProbability andN: aNumber [
	^ self new
		initializeWithProbability: aProbability andN: aNumber;
		yourself
]

{ #category : #initialization }
MoonWalk >> affect: aPlayer on: aGame [
	aGame inactivePlayers
		do: [ :player | aGame player: player movesBackwardsSteps: numberN ]
]

{ #category : #initialization }
MoonWalk >> initializeWithProbability: aNumber [
	probability := aNumber.
	random := Random new.
	numberN := (random next * 10) floor.
]

{ #category : #initialization }
MoonWalk >> initializeWithProbability: aProbability andN: aNumber [
	probability := aNumber.
	numberN := aNumber.
]

{ #category : #accessing }
MoonWalk >> probability [
	^probability
]
