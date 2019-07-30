"
Intsant Action.
"
Class {
	#name : #InstantAction,
	#superclass : #CardAction,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
InstantAction class >> withEffect: anEffect [
	^self new initializeWithEffect: anEffect.
]

{ #category : #initialization }
InstantAction >> initializeWithEffect: anEffect [
	effect := anEffect
]

{ #category : #action }
InstantAction >> use: aCard on: aGame affecting: aSetOfPlayers byRequestOf: aPlayer [
	effect actOn: aGame affect: aSetOfPlayers by: aPlayer.
	aGame addToDiscardDeck: aCard.
]
