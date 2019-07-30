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
StocasticPlayingCardDeckBuilder >> assertCardProbabilitySetIsNotEmpty: aCardProbabilityCollection [ 
	aCardProbabilityCollection isEmpty
		ifTrue: [ GameModelError
				signal: 'Builder must be provided with at least one card and probability pair. ' ]
]

{ #category : #'private-assertions' }
StocasticPlayingCardDeckBuilder >> assertProbabilitiesAreBetweenZeroAndOne: aCardProbabilityPairsCollection [ 
	(aCardProbabilityPairsCollection anySatisfy: [ :pair | pair value > 1 or: pair value < 0 ]) ifTrue: [ GameModelError signal:'Probabilities must be in the range between 0 and 1. ' ]
]

{ #category : #'private-assertions' }
StocasticPlayingCardDeckBuilder >> assertSumOfProbabilitiesIsEqualToOne: aCardProbabilityPairsCollection [ 
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
	self assertProbabilitiesAreBetweenZeroAndOne: aCardsProbabilityPairsSet.
	self assertCardProbabilitySetIsNotEmpty: aCardsProbabilityPairsSet.
	self assertSumOfProbabilitiesIsEqualToOne: aCardsProbabilityPairsSet.
	cardsAmount
		timesRepeat: [ cards add: (self selectCardUsing: aCardsProbabilityPairsSet) ]
]
