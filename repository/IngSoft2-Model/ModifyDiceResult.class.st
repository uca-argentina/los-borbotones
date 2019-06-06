"
ModifyDiceResult
"
Class {
	#name : #ModifyDiceResult,
	#superclass : #CardEffect,
	#instVars : [
		'quantity',
		'affectedPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
ModifyDiceResult class >> modifyResultBy: aQuantity [ 
	^self new initializeWithModificationQuantity: aQuantity
]

{ #category : #action }
ModifyDiceResult >> actOn: aGame affect: aPlayer [
	aGame assertValidPlayer: aPlayer.
	affectedPlayer := aGame selectPlayerNamed: aPlayer
]

{ #category : #presentation }
ModifyDiceResult >> appliesTo: aPlayer [
	^ affectedPlayer name = aPlayer name
]

{ #category : #presentation }
ModifyDiceResult >> changesRollResult [
	^true.
]

{ #category : #initialize }
ModifyDiceResult >> initializeWithModificationQuantity: aQuantity [
	quantity := aQuantity.
]

{ #category : #accessing }
ModifyDiceResult >> quantity [
	^ quantity
]
