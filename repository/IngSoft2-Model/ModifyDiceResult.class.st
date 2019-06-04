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

{ #category : #creation }
ModifyDiceResult class >> modifyResultBy: aQuantity affect: aPlayer [ 
	^self new initializeWithModificationQuantity: aQuantity affecting: aPlayer
]

{ #category : #presentation }
ModifyDiceResult >> changesRollResult [
	^true.
]

{ #category : #initialize }
ModifyDiceResult >> initializeWithModificationQuantity: aQuantity [
	quantity := aQuantity.
]

{ #category : #presentation }
ModifyDiceResult >> quantity [
	^ quantity
]
