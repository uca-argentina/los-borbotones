"
CardCancellation
"
Class {
	#name : #Cancellation,
	#superclass : #CardEffect,
	#instVars : [
		'cardToRemove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Cancellation class >> affect: aPermanentCard [ 
	^ self new initializeWithCardToCancel: aPermanentCard.
]

{ #category : #action }
Cancellation >> actOn: aGame [ 
	aGame permanentCards notEmpty ifFalse: [ GameModelError signal: 'Cannot play Cancellation card if there are no active permanent cards. '].
	aGame removePermanentCard: cardToRemove.
]

{ #category : #initialize }
Cancellation >> initializeWithCardToCancel: aPermanentCard [ 
	cardToRemove := aPermanentCard 
]
