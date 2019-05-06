Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
SpeedUp class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #initialization }
SpeedUp >> affect: aPlayer on: aGame [
	aGame player: aPlayer movesForwardSteps: 4.
]

{ #category : #initialization }
SpeedUp >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
SpeedUp >> probability [
	^probability
]
