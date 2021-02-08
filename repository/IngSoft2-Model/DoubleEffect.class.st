"
DoubleEffect
"
Class {
	#name : #DoubleEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DoubleEffect >> actOn: aGame affect: aPlayerName by: aPlayer [
	aGame repeatTurn
]
