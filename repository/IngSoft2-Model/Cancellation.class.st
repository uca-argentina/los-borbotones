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
	self assertActivePermanentCardsOn: aGame.
	aGame removePermanentCard: aPermanentCard
]

{ #category : #assertion }
Cancellation >> assertActivePermanentCardsOn: aGame [
	aGame permanentCards isEmpty
		ifTrue: [ GameModelError
				signal:
					'Cannot play Cancellation card if there are no active permanent cards. ' ]
]
