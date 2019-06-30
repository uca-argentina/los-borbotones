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

{ #category : #creation }
CardDeck class >> withCards: aCardsCollection [
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
