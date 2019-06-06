"
Abstract cardDeck.
"
Class {
	#name : #CardDeck,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardDeck >> dealACard [
	self subclassResponsibility .
]

{ #category : #actions }
CardDeck >> dealCards: aCardsAmount [
	^self subclassResponsibility.
]
