"
A deck of cards.
"
Class {
	#name : #CardDeck,
	#superclass : #Object,
	#instVars : [
		'random',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
CardDeck class >> randomDeck [
	^ self new initializeRandomCardDeck.
]

{ #category : #actions }
CardDeck >> dealCards: anAmountOfCards [
	| cardsToBeDelt |
	cardsToBeDelt := OrderedCollection new.
	anAmountOfCards timesRepeat: [ cardsToBeDelt add: cards atRandom ].
	^cardsToBeDelt
]

{ #category : #initialize }
CardDeck >> initializeRandomCardDeck [
	random := Random new.
	cards := OrderedCollection with: PermanentCard new with: InstantCard new
]
