"
Permanent card.
"
Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#instVars : [
		'name',
		'effect',
		'affectedPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
PermanentCard class >> named: aName withEffect: aCardEffect [ 
	^self new initializeWithName: aName withEffect: aCardEffect
]

{ #category : #action }
PermanentCard >> actOn: aGame affect: aSetOfPlayers [ 
	affectedPlayers :=  aSetOfPlayers.
	aGame setLastCard: self.
	aGame addPermanentCard: self
]

{ #category : #presentation }
PermanentCard >> appliesTo: aPlayer [ 
	^affectedPlayers anySatisfy: [ :player | player name = aPlayer name ] 
]

{ #category : #presentation }
PermanentCard >> changesRollResult [
	^effect changesRollResult
]

{ #category : #initialize }
PermanentCard >> initializeWithName: aName withEffect: aCardEffect [
	name := aName.
	effect := aCardEffect.
	affectedPlayers := OrderedCollection new
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
