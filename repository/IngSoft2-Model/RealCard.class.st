"
Real Card.
"
Class {
	#name : #RealCard,
	#superclass : #Card,
	#instVars : [
		'action',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
RealCard class >> named: aName withAction: anAction [
	^self new initializeWithName: aName andAction: anAction.
]

{ #category : #action }
RealCard >> actOn: aGame affect: aSetOfPlayers by: aPlayer [
	action use: self on: aGame affecting: aSetOfPlayers byRequestOf: aPlayer.
	aGame setLastCard: self.
]

{ #category : #initialization }
RealCard >> initializeWithName: aName andAction: anAction [
	name := aName.
	action := anAction.
]

{ #category : #action }
RealCard >> update: aResult for: aGame [
	^action  update: aResult for: aGame.
]
