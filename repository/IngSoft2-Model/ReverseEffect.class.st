"
ReverseEffect
"
Class {
	#name : #ReverseEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ReverseEffect >> actOn: aGame affect: aPlayerName by: aPlayer [
	aGame reverseTurns
]
