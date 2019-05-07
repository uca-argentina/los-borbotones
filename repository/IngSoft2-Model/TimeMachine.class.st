"
Vuelve a la posición del turno anterior. Probabilidad de aparición: 8%.
"
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
	aGame movesToTheLastTurnPositionThePlayer: aPlayer
]

{ #category : #creation }
TimeMachine >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
TimeMachine >> probability [
	^probability
]
