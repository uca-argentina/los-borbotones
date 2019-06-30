"
Permanent card.
"
Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#instVars : [
		'name',
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
PermanentCard class >> named: aName withEffect: aCardEffect [ 
	^self new initializeWithName: aName withEffect: aCardEffect
]

{ #category : #action }
PermanentCard >> actOn: aGame affect: aSetOfPlayers by: aPlayer [
	aGame currentPlayer name = aPlayer name
		ifFalse: [ GameModelError signal: 'Cannot play permanent card if it is not your turn. ' ].
	effect actOn: aGame affect: aSetOfPlayers by: aPlayer.
	aGame setLastCard: self.
	aGame addPermanentCard: self
]

{ #category : #initialize }
PermanentCard >> initializeWithName: aName withEffect: aCardEffect [
	name := aName.
	effect := aCardEffect
]

{ #category : #presentation }
PermanentCard >> isDummyCard [
	^ false
]

{ #category : #action }
PermanentCard >> update: aResult for: aGame [
	^(effect appliesTo: aGame currentPlayer) ifTrue: [ aResult + effect quantity ] ifFalse: [aResult].
	
]
