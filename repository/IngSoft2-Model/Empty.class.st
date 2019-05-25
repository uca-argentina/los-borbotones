"
Probabilidad de aparición: 55%.
"
Class {
	#name : #Empty,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Empty >> affect: aPlayer on: aGame [
	
]

{ #category : #initialization }
Empty >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
Empty >> probability [
	^probability
]
