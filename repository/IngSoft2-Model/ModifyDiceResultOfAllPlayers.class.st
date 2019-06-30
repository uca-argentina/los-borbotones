"
ModifyDiceResultOfAllPlayers
"
Class {
	#name : #ModifyDiceResultOfAllPlayers,
	#superclass : #CardEffect,
	#instVars : [
		'quantity',
		'affectedPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
ModifyDiceResultOfAllPlayers class >> modifyResultBy: aQuantity [ 
	^self new initializeWithModificationQuantity: aQuantity
]

{ #category : #action }
ModifyDiceResultOfAllPlayers >> actOn: aGame affect: aSetOfPlayers by: aPlayer [
	affectedPlayers := aGame players 
]

{ #category : #presentation }
ModifyDiceResultOfAllPlayers >> appliesTo: aPlayer [
	^ true
]

{ #category : #initialization }
ModifyDiceResultOfAllPlayers >> initializeWithModificationQuantity: aQuantity [
	quantity := aQuantity.
]

{ #category : #accessing }
ModifyDiceResultOfAllPlayers >> quantity [
	^ quantity
]
