"
An instant card.
"
Class {
	#name : #InstantCard,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
InstantCard class >> withEffect: anEffect [
	^self new initializeWithEffect: anEffect
]

{ #category : #action }
InstantCard >> actOn: aGame affect: aSetOfPlayers by: aPlayer [
	effect actOn: aGame affect: aSetOfPlayers by: aPlayer.
	aGame setLastCard: self
]

{ #category : #initialization }
InstantCard >> initializeWithEffect: aDummyEffect [ 
	effect := aDummyEffect 
]

{ #category : #presentation }
InstantCard >> isDummyCard [
	^false
]
