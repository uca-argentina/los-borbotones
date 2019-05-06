Class {
	#name : #TimeMachine,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
TimeMachine class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #creation }
TimeMachine >> affect: aPlayer on: aGame [
	aGame player: aPlayer goesBackTurns: 1.
]

{ #category : #creation }
TimeMachine >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
TimeMachine >> probability [
	^probability
]
