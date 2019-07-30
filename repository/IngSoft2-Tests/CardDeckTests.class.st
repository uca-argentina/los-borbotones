"
Card Deck tests.
"
Class {
	#name : #CardDeckTests,
	#superclass : #TestCase,
	#instVars : [
		'cardDeck',
		'cardsWithProbabilities',
		'gameElements',
		'instantCard',
		'fourFaceDummyDice',
		'dices',
		'robert',
		'players',
		'emptyWithProbability',
		'board',
		'game',
		'permanentCard',
		'instantCardWithProbability',
		'permanentCardWithProbability'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardDeckTests >> cardDeckWithCard: aCard andAmountOfCards: anAmountOfCards [
	
	^((LoadedPlayingCardDeckBuilder startWithCardsAmount: anAmountOfCards) withCard: aCard) buildCardDeck
]

{ #category : #tests }
CardDeckTests >> juan [
	^Player named: 'Juan'
]

{ #category : #asserting }
CardDeckTests >> loadedBoard [
 	^(LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: emptyWithProbability;
		buildBoard.
]

{ #category : #running }
CardDeckTests >> setUp [
	super setUp.
	gameElements := GameElementsResource current.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	players := OrderedCollection with: robert.
	
	emptyWithProbability := Empty -> 1.
	board := self loadedBoard.
	instantCard := gameElements dummyInstantCard.
	permanentCard := gameElements dummyPermanentCard.
	cardsWithProbabilities  := OrderedCollection with: instantCard->1.
	instantCardWithProbability  := OrderedCollection with: instantCard->1.	
	permanentCardWithProbability  := OrderedCollection with: permanentCard->1.

]

{ #category : #asserting }
CardDeckTests >> should: aBlock raise: anError withErrorMessage: aMessage [
	self should: aBlock
		raise: anError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: aMessage ]
]

{ #category : #asserting }
CardDeckTests >> should: aBlock raiseGameErrorWithMessage: aMessage [
	self should: aBlock
		raise: GameModelError 
		withErrorMessage: aMessage.
]

{ #category : #asserting }
CardDeckTests >> stocasticCardDeckWithCardsAmount: aCardsAmount [
	^self stocasticPlayingCardDeckFrom: cardsWithProbabilities  withCardsAmount: aCardsAmount.
]

{ #category : #asserting }
CardDeckTests >> stocasticPlayingCardDeckFrom: aCardProbabilityPairsCollection withCardsAmount: aCardsAmount [
	^((StocasticPlayingCardDeckBuilder startWithCardsAmount: aCardsAmount) withCardsFrom: aCardProbabilityPairsCollection) buildCardDeck
]

{ #category : #tests }
CardDeckTests >> testCannotCreateCardDeckWithNegativeCards [
	self should: [ self stocasticPlayingCardDeckFrom: cardsWithProbabilities withCardsAmount: 0 ] raiseGameErrorWithMessage: 'CardDeck cards amount must be a positive integer. '.
	self should: [ self stocasticPlayingCardDeckFrom: cardsWithProbabilities withCardsAmount: -2 ] raiseGameErrorWithMessage: 'CardDeck cards amount must be a positive integer. '.
	
]

{ #category : #tests }
CardDeckTests >> testCannotCreateCardDeckWithoutCards [
	self should: [PlayingCardDeck withCards: {}] raiseGameErrorWithMessage: 'CardDeck must have at least one card to be created. '.
	
]

{ #category : #tests }
CardDeckTests >> testCannotCreateStocasticCardDeckWithInvalidCardProbabilityPairs [
	self should: [self stocasticPlayingCardDeckFrom: {} withCardsAmount: 2] raiseGameErrorWithMessage: 'Builder must be provided with at least one card and probability pair. '.
	self should: [self stocasticPlayingCardDeckFrom: (OrderedCollection with:permanentCard->0.5) withCardsAmount: 2] raiseGameErrorWithMessage: 'Sum of probabilities must be equal to 1. '.	
]

{ #category : #tests }
CardDeckTests >> testDiscardCardDeckFillsWithOneUsedInstantCard [
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: (self cardDeckWithCard: instantCard andAmountOfCards:  4)
		using: dices.
	self assert: game deck size equals: 2.
	self assert: game discardDeck size equals: 0.
	robert playsCard: instantCard affecting: 'Juan' on: game.
	self assert: game discardDeck size equals: 1
]

{ #category : #tests }
CardDeckTests >> testDiscardCardDeckFillsWithOneUsedPermanentCard [
	| juan cancellationCard|
	juan := self juan.
	players add: juan.
	cancellationCard :=  gameElements cancellationCard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: (self cardDeckWithCard: permanentCard andAmountOfCards:6) 
		using: dices.
	self assert: game deck size equals: 2.
	self assert: game discardDeck size equals: 0.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self assert: game permanentCards size equals: 1.
	juan take: { cancellationCard }.
	juan playsCard: cancellationCard affecting: permanentCard on: game. 
	self assert: game permanentCards size equals: 0.
	self assert: game discardDeck size equals: 2
]

{ #category : #tests }
CardDeckTests >> testFiniteAndDeterministicCardDeckCanBeCreated [
	cardDeck := self stocasticPlayingCardDeckFrom: cardsWithProbabilities  withCardsAmount: 5.
	self assert: cardDeck  size equals: 5.
	self assert: cardDeck dealACard first equals: instantCard.
]
