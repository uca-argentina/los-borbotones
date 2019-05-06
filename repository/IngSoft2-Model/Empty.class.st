Class {
	#name : #Empty,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Empty class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #initialization }
Empty >> affect: players withCurrentPlayer: aPlayer on: aGame [
	
]

{ #category : #initialization }
Empty >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
Empty >> probability [
	^probability
]
