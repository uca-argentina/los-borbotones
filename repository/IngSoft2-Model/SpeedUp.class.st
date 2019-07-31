"
Avanzar 4 casilleros. Probabilidad de aparición: 15%.
"
Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> affect: aPlayer on: aGame [
	aGame move: aPlayer steps: 4
]
