"
LoadedCardDeckBuilder.
"
Class {
	#name : #StocasticPlayingCardDeckBuilder,
	#superclass : #CardDeckBuilder,
	#instVars : [
		'cardsAmount',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
StocasticPlayingCardDeckBuilder class >> assertCardsAmountIsValid: aCardsAmount [
	aCardsAmount < 1
		ifTrue: [ GameModelError
				signal: 'CardDeck cards amount must be a positive integer. ' ]
]

{ #category : #'as yet unclassified' }
StocasticPlayingCardDeckBuilder class >> startWithCardsAmount: aCardsAmount [ 
	self assertCardsAmountIsValid: aCardsAmount.
	^ self new
		initializeWithCardsAmount: aCardsAmount
]

{ #category : #'private-assertions' }
StocasticPlayingCardDeckBuilder >> assertCardProbabilityIsNotEmpty: aCardProbabilityCollection [ 
	aCardProbabilityCollection isEmpty
		ifTrue: [ GameModelError
				signal: 'Builder must be provided with at least one card and probability pair. ' ]
]

{ #category : #'private-assertions' }
StocasticPlayingCardDeckBuilder >> assertValidCardProbabilitySet: aCardProbabilityPairsCollection [ 
	|sumOfProbabilities|
	sumOfProbabilities := aCardProbabilityPairsCollection sum: #value.
	sumOfProbabilities := (sumOfProbabilities * 100) rounded / 100.
	sumOfProbabilities ~= 1 ifTrue: [ GameModelError signal: 'Sum of probabilities must be equal to 1. ' ]
]

{ #category : #building }
StocasticPlayingCardDeckBuilder >> buildCardDeck [
	^PlayingCardDeck withCards: cards.
]

{ #category : #initialization }
StocasticPlayingCardDeckBuilder >> initializeWithCardsAmount: aCardsAmount [
	cards := OrderedCollection new.
	cardsAmount := aCardsAmount.
	random := Random new.
]

{ #category : #building }
StocasticPlayingCardDeckBuilder >> selectCardUsing: aCardProbabiltiyPairsCollection [
	| prob cumulativeProbability |
	cumulativeProbability := 0.
	prob := random next.
	^ (aCardProbabiltiyPairsCollection
		detect:
			[ :each | 
			cumulativeProbability := cumulativeProbability + each value.
			cumulativeProbability >= prob ]) key 
]

{ #category : #initialization }
StocasticPlayingCardDeckBuilder >> withCardsFrom: aCardsProbabilityPairsSet [
	self assertCardProbabilityIsNotEmpty: aCardsProbabilityPairsSet.
	self assertValidCardProbabilitySet: aCardsProbabilityPairsSet.
	cardsAmount
		timesRepeat: [ cards add: (self selectCardUsing: aCardsProbabilityPairsSet) ]
]
