"
Card Deck tests.
"
Class {
	#name : #CardDeckTest,
	#superclass : #TestCase,
	#instVars : [
		'gameElements',
		'instantCard',
		'fourFaceDummyDice',
		'dices',
		'robert',
		'players',
		'board',
		'game',
		'permanentCard',
		'cardDealingTileWithProbability'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardDeckTest >> cardDeckWithCard: aCard andAmountOfCards: anAmountOfCards [
	
	^((LoadedPlayingCardDeckBuilder startWithCardsAmount: anAmountOfCards) withCard: aCard) buildCardDeck
]

{ #category : #running }
CardDeckTest >> cardDeckWithCards: aCardsCollection andAmountPerCard: anAmountOfCards [
	|boardBuilder |
	boardBuilder := LoadedPlayingCardDeckBuilder startWithCardsAmount: anAmountOfCards.
	aCardsCollection do: [ :card | boardBuilder withCard: card].
	^boardBuilder buildCardDeck
]

{ #category : #tests }
CardDeckTest >> juan [
	^Player named: 'Juan'
]

{ #category : #running }
CardDeckTest >> setUp [
	super setUp.
	gameElements := GameElementsResource current.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	players := OrderedCollection with: robert.
	
	cardDealingTileWithProbability := CardDealingTile new -> 0.1.
	board := gameElements emptyBoardWithSteps: 10.
	instantCard := gameElements dummyInstantCard.
	permanentCard := gameElements dummyPermanentCard.

]

{ #category : #asserting }
CardDeckTest >> should: aBlock raise: anError withErrorMessage: aMessage [
	self should: aBlock
		raise: anError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: aMessage ]
]

{ #category : #asserting }
CardDeckTest >> should: aBlock raiseGameErrorWithMessage: aMessage [
	self should: aBlock
		raise: GameModelError 
		withErrorMessage: aMessage.
]

{ #category : #tests }
CardDeckTest >> testCannotCreateCardDeckWithNegativeCards [
	self
		should: [ gameElements stocasticCardDeckWithCardsAmount: 0 ]
		raiseGameErrorWithMessage: 'CardDeck cards amount must be a positive integer. '.
	self
		should: [ gameElements stocasticCardDeckWithCardsAmount: -1 ]
		raiseGameErrorWithMessage: 'CardDeck cards amount must be a positive integer. '
]

{ #category : #tests }
CardDeckTest >> testCannotCreateCardDeckWithoutCards [
	self
		should: [ PlayingCardDeck withCards: DiscardDeck emptyDeck ]
		raiseGameErrorWithMessage: 'CardDeck must have at least one card to be created. '
]

{ #category : #tests }
CardDeckTest >> testCannotCreateStocasticCardDeckWithoutCards [
	self
		should: [ gameElements stocasticPlayingCardDeckFrom: {} withCardsAmount: 2 ]
		raiseGameErrorWithMessage:
			'Builder must be provided with at least one card and probability pair. '.
]

{ #category : #tests }
CardDeckTest >> testCannotTakeCardsWhenPlayingAndDiscardDecksAreEmpty [
	| cardDeck |
	cardDeck := self
		cardDeckWithCards: {permanentCard}
		andAmountPerCard: 2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: cardDeck
		using: dices.
	self assert: cardDeck size equals: 0.
	self assert: game discardDeck size equals: 0.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self
		should: [ game turnIsPlayed ]
		raiseGameErrorWithMessage: 'No available cards. Decks are empty! '
]

{ #category : #tests }
CardDeckTest >> testCardProbabilitiesMustBeBetweenZeroAndOne [
	self
		should: [ gameElements
				stocasticPlayingCardDeckFrom: { permanentCard -> 1.5 . permanentCard -> -0.5}
				withCardsAmount: 2 ]
		raiseGameErrorWithMessage: 'Probabilities must be in the range between 0 and 1. '
]

{ #category : #tests }
CardDeckTest >> testCardProbabilitiesSumMustBeEqualToOneToMakeStocasticDeck [
	self
		should: [ gameElements
				stocasticPlayingCardDeckFrom: {permanentCard -> 0.5}
				withCardsAmount: 2 ]
		raiseGameErrorWithMessage: 'Sum of probabilities must be equal to 1. '
]

{ #category : #tests }
CardDeckTest >> testDiscardCardDeckFillsWithOneUsedInstantCard [
	| cardDeck |
	cardDeck := self cardDeckWithCard: instantCard andAmountOfCards:  4.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: cardDeck
		using: dices.
	self assert: cardDeck size equals: 2.
	self assert: game discardDeck size equals: 0.
	robert playsCard: instantCard affecting: 'Juan' on: game.
	self assert: game discardDeck size equals: 1
]

{ #category : #tests }
CardDeckTest >> testDiscardCardDeckFillsWithOneUsedPermanentCard [
	| juan cancellationCard cardDeck|
	cardDeck := self cardDeckWithCard: permanentCard andAmountOfCards:6.
	juan := self juan.
	players add: juan.
	cancellationCard :=  gameElements cancellationCard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: cardDeck
		using: dices.
	self assert: cardDeck size equals: 2.
	self assert: game discardDeck size equals: 0.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self assert: game permanentCards size equals: 1.
	juan take: { cancellationCard }.
	juan playsCard: cancellationCard affecting: permanentCard on: game. 
	self assert: game permanentCards size equals: 0.
	self assert: game discardDeck size equals: 2
]

{ #category : #tests }
CardDeckTest >> testDiscardDeckEmptiesWhenShuffledForUse [
	| discardDeck shuffledDeck  |
	discardDeck := DiscardDeck emptyDeck.
	discardDeck addCard: instantCard.
	discardDeck addCard: permanentCard.
	discardDeck addCard: instantCard.
	shuffledDeck := discardDeck shuffleAndEmpty.
	self assert: discardDeck isEmpty.
	self assert: shuffledDeck size equals: 3.
	
]

{ #category : #tests }
CardDeckTest >> testDiscardDeckShufflesEffectively [ 
	| discardDeck shuffledDeck anotherInstantCard |
	anotherInstantCard := gameElements dummyInstantCard.
	discardDeck := DiscardDeck emptyDeck.
	discardDeck addCard: instantCard.
	discardDeck addCard: permanentCard.
	discardDeck addCard: anotherInstantCard.
	shuffledDeck := discardDeck shuffleAndEmpty.
	self assert: (shuffledDeck anySatisfy: [ :card | card = instantCard ]).
	self assert: (shuffledDeck anySatisfy: [ :card | card = permanentCard ]).
	self assert: (shuffledDeck anySatisfy: [ :card | card = anotherInstantCard  ])
]

{ #category : #tests }
CardDeckTest >> testFiniteCardDeckCanBeCreated [
	|cardDeck|
	cardDeck := gameElements stocasticCardDeckWithCardsAmount: 5.
	self assert: cardDeck  size equals: 5.
]

{ #category : #tests }
CardDeckTest >> testPlayingCardDeckIsDeterministicOnceCreated [
	| testingDiscardDeck cardDeck|
	cardDeck := self cardDeckWithCards: {instantCard . permanentCard } andAmountPerCard: 1.
	self assert: cardDeck  size equals: 2.
	testingDiscardDeck := DiscardDeck emptyDeck.
	self assert: (cardDeck dealACardIfNoneUse: testingDiscardDeck ) first equals: instantCard.
	self assert: (cardDeck dealACardIfNoneUse: testingDiscardDeck) first equals: permanentCard.
]

{ #category : #tests }
CardDeckTest >> testPlayingDeckTakesCardsFromShuffledDiscardDeckWhenItIsEmpty [
	|cardDeck|
	cardDeck := self cardDeckWithCards: { instantCard. permanentCard } andAmountPerCard:  2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: cardDeck
		using: dices.
	self assert: cardDeck size equals: 2.
	game turnIsPlayed.
	game turnIsPlayed.
	self assert: game discardDeck size equals: 0.
	self assert: cardDeck size equals: 0.
	robert playsCard: instantCard affecting: 'Juan' on: game.
	robert playsCard: instantCard affecting: 'Juan' on: game.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	game removePermanentCard: permanentCard.
	game removePermanentCard: permanentCard.
	self assert: game discardDeck size equals: 4.
	game turnIsPlayed.
	self assert: game discardDeck size equals: 0.
	self assert: cardDeck size equals: 3.
	self assert: robert cards size equals: 1.
	
]
