"
A CardAction.
"
Class {
	#name : #CardAction,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CardAction >> use: aCard on: aGame affecting: aSetOfPlayers byRequestOf: aPlayer [
	self subclassResponsibility.
]
