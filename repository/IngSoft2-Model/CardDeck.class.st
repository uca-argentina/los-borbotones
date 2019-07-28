"
Abstract cardDeck.
"
Class {
	#name : #CardDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
CardDeck class >> assertCardCollectionIsValid: aCardsCollection [
	aCardsCollection size == 0
		ifTrue: [ GameModelError
				signal: 'CardDeck must have at least one card to be created. ' ]
]

{ #category : #creation }
CardDeck class >> withCards: aCardsCollection [
	self assertCardCollectionIsValid: aCardsCollection.
	^ self new initializeWithCards: aCardsCollection.
]

{ #category : #actions }
CardDeck >> dealACard [
	^ self dealCards: 1.
]

{ #category : #actions }
CardDeck >> dealCards: anAmountOfCards [
	|cardsToBeDelt |
	cardsToBeDelt := OrderedCollection new.
	anAmountOfCards timesRepeat: [ cardsToBeDelt add: cards atRandom ].
	^cardsToBeDelt
]

{ #category : #initialization }
CardDeck >> initializeWithCards: aCardsCollection [
	cards := aCardsCollection.
]
