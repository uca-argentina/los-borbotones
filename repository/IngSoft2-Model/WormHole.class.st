"
Retrocede 4 casilleros. Probabilidad de aparición: 15%.
"
Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
WormHole >> affect: aPlayer on: aGame [
	aGame player: aPlayer movesBackwardsSteps: 4.
]

{ #category : #accessing }
WormHole >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
WormHole >> probability [
	^probability
]
