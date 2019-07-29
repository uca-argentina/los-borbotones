"
Permanent Action.
"
Class {
	#name : #PermanentAction,
	#superclass : #CardAction,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
PermanentAction class >> withEffect: anEffect [
	^self new initializeWithEffect: anEffect.
]

{ #category : #initialization }
PermanentAction >> initializeWithEffect: anEffect [
	effect := anEffect
]

{ #category : #action }
PermanentAction >> update: aResult for: aPlayer [
	^effect update: aResult for: aPlayer.
]

{ #category : #action }
PermanentAction >> use: aCard on: aGame affecting: aSetOfPlayers byRequestOf: aPlayer [
	aGame currentPlayer name = aPlayer name
		ifFalse: [ GameModelError signal: 'Cannot play permanent card if it is not your turn. ' ].
	effect actOn: aGame affect: aSetOfPlayers by: aPlayer.
	aGame addPermanentCard: aCard
]
