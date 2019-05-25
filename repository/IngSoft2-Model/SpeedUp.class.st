"
Avanzar 4 casilleros. Probabilidad de aparición: 15%.
"
Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

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
