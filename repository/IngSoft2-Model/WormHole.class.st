"
Retrocede 4 casilleros. Probabilidad de aparición: 15%.
"
Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> affect: aPlayer on: aGame [
	aGame moves: aPlayer stepsBackwards: 4
]
