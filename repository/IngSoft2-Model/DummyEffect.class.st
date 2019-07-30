"
This effect does nothing. For testing purposes only.
"
Class {
	#name : #DummyEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DummyEffect >> actOn: aGame affect: aSetOfPlayers by: aPlayer [ 
]

{ #category : #action }
DummyEffect >> update: aResult for: aPlayer [
	"Does nothing."

	^ 0
]
