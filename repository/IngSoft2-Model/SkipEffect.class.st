"
SkipEffect
"
Class {
	#name : #SkipEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SkipEffect >> actOn: aGame affect: aPlayerName by: aPlayer [
	aGame skipTurn
]
