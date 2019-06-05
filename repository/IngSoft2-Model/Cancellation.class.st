"
CardCancellation
"
Class {
	#name : #Cancellation,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Cancellation >> actOn: aGame affect: aPermanentCard [ 
	aGame permanentCards notEmpty ifFalse: [ GameModelError signal: 'Cannot play Cancellation card if there are no active permanent cards. '].
	aGame removePermanentCard: aPermanentCard 
]
