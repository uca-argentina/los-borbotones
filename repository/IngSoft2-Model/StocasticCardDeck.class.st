"
A deck of cards.
"
Class {
	#name : #StocasticCardDeck,
	#superclass : #CardDeck,
	#instVars : [
		'random',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
StocasticCardDeck class >> randomDeck [
	^ self new initializeRandomCardDeck.
]

{ #category : #actions }
StocasticCardDeck >> dealCards: anAmountOfCards [
	| cardsToBeDelt |
	cardsToBeDelt := OrderedCollection new.
	anAmountOfCards timesRepeat: [ cardsToBeDelt add: cards atRandom ].
	^cardsToBeDelt
]

{ #category : #initialize }
StocasticCardDeck >> initializeRandomCardDeck [
	random := Random new.
	cards := OrderedCollection with: PermanentCard new with: InstantCard new
]
