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
ModifyDiceResult >> actOn: aGame affect: aPlayer by: actingPlayer [
	aGame assertValidPlayer: aPlayer.
	affectedPlayer := aGame selectPlayerNamed: aPlayer
]

{ #category : #initialize }
ModifyDiceResult >> initializeWithModificationQuantity: aQuantity [
	quantity := aQuantity.
]

{ #category : #presentation }
ModifyDiceResult >> update: aResult for: aPlayer [
	^ affectedPlayer name = aPlayer name
		ifTrue: [ aResult + quantity ]
		ifFalse: [ aResult ]
]
