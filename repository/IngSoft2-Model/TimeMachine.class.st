"
Vuelve a la posición del turno anterior. Probabilidad de aparición: 8%.
"
Class {
	#name : #TimeMachine,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
TimeMachine >> affect: aPlayer on: aGame [
	aGame moveToPreviousPosition: aPlayer
]
