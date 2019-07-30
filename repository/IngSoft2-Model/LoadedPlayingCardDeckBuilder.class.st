"
LoadedCardDeckBuilder
"
Class {
	#name : #LoadedPlayingCardDeckBuilder,
	#superclass : #CardDeckBuilder,
	#instVars : [
		'cardsAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LoadedPlayingCardDeckBuilder class >> assertCardsAmountIsValid: aCardsAmount [
	aCardsAmount < 1
		ifTrue: [ GameModelError
				signal: 'CardDeck cards amount must be a positive integer. ' ]
]

{ #category : #'as yet unclassified' }
LoadedPlayingCardDeckBuilder class >> startWithCardsAmount: aCardsAmount [ 
	self assertCardsAmountIsValid: aCardsAmount.
	^ self new
		initializeWithCardsAmount: aCardsAmount
]

{ #category : #building }
LoadedPlayingCardDeckBuilder >> buildCardDeck [
	^PlayingCardDeck withCards: cards.
]

{ #category : #initialization }
LoadedPlayingCardDeckBuilder >> initializeWithCardsAmount: aCardsAmount [
	cards := OrderedCollection new.
	cardsAmount := aCardsAmount.
]

{ #category : #building }
LoadedPlayingCardDeckBuilder >> withCard: aCard [
	cardsAmount timesRepeat: [  cards add: aCard ].
]
