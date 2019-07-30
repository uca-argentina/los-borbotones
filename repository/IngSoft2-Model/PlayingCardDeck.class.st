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
PlayingCardDeck >> dealACardIfNoneUse: aDiscardDeck [ 
	^self dealCards: 1 ifNoneUse: aDiscardDeck.
]

{ #category : #actions }
PlayingCardDeck >> dealCards: anAmountOfCards ifNoneUse: aDiscardDeck [ 
	| cardsToBeDelt |
	cards isEmpty ifTrue: [ cards := aDiscardDeck shuffleAndEmpty ].
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
