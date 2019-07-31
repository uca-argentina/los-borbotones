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
	aGame playPermanentCard: aCard byRequestOf: aPlayer.
	effect actOn: aGame affect: aSetOfPlayers by: aPlayer.
]
