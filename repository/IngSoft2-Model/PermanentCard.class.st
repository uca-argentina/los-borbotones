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
PermanentCard >> actOn: aGame affect: aSetOfPlayers [
	effect actOn: aGame affect: aSetOfPlayers.
	aGame setLastCard: self.
	aGame addPermanentCard: self
]

{ #category : #presentation }
PermanentCard >> appliesTo: aPlayer [ 
	^effect appliesTo: aPlayer
]

{ #category : #presentation }
PermanentCard >> changesRollResult [
	^effect changesRollResult
]

{ #category : #initialize }
PermanentCard >> initializeWithName: aName withEffect: aCardEffect [
	name := aName.
	effect := aCardEffect
]

{ #category : #presentation }
PermanentCard >> isInstantCard [
	^false.
]

{ #category : #presentation }
PermanentCard >> isPermanentCard [
	^true
]

{ #category : #presentation }
PermanentCard >> quantity [
	^effect quantity
]

{ #category : #action }
PermanentCard >> redoAffecting: anObject on: aGame [
	self actOn: aGame affect: anObject.
]
