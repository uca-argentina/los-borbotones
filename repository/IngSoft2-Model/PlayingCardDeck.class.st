"
Playing card deck.
"
Class {
	#name : #PlayingCardDeck,
	#superclass : #CardDeck,
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
PlayingCardDeck class >> assertCardCollectionIsValid: aCardsCollection [
	aCardsCollection size == 0
		ifTrue: [ GameModelError
				signal: 'CardDeck must have at least one card to be created. ' ]
]

{ #category : #creation }
PlayingCardDeck class >> withCards: aCollectionOfCards [
	self assertCardCollectionIsValid: aCollectionOfCards.
	^ self new
		initializeWithCards: aCollectionOfCards.
]

{ #category : #actions }
PlayingCardDeck >> dealACard [
	^ self dealCards: 1.
]

{ #category : #actions }
PlayingCardDeck >> dealCards: anAmountOfCards [
	| cardsToBeDelt |
	cardsToBeDelt := OrderedCollection new.
	anAmountOfCards
		timesRepeat: [ cardsToBeDelt add: cards first.
			cards removeFirst ].
	^ cardsToBeDelt
]

{ #category : #initialization }
PlayingCardDeck >> initializeWithCards: aSetOfCards [ 
	cards := aSetOfCards.
]
