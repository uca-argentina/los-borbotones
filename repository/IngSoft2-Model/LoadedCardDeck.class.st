Class {
	#name : #LoadedCardDeck,
	#superclass : #CardDeck,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
LoadedCardDeck class >> withCard: aCard [
	^ self new initializeWithCard: aCard.
]

{ #category : #actions }
LoadedCardDeck >> dealCards: aCardsAmount [
	| cardsToBeDelt |
	cardsToBeDelt := OrderedCollection new.
	aCardsAmount timesRepeat: [ cardsToBeDelt add: card ].
	^cardsToBeDelt
]

{ #category : #initialization }
LoadedCardDeck >> initializeWithCard: aCard [
	card := aCard.
	
]
