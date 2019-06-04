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
PermanentCard class >> named: aName withEffect: aCardEffect affect: aSetOfPlayers [ 
	^self new initializeWithName: aName withEffect: aCardEffect  affecting: aSetOfPlayers
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
PermanentCard >> initializeWithName: aName withEffect: aCardEffect affecting: aSetOfPlayers [
	name := aName.
	effect := aCardEffect.
	affectedPlayers := aSetOfPlayers
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
