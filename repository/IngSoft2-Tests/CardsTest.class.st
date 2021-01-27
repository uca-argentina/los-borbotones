"
Cards tests
"
Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#instVars : [
		'gameElementsResource',
		'dices',
		'players',
		'game',
		'robert',
		'cardDealingTileWithProbability',
		'juan',
		'fourFaceDummyDice',
		'board'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardsTest >> assertTile: aNumberOfTile andLap: aNumberOfLap for: aPlayer on: aGame [
	self assert: (game playersPositions tilePositionOf: aPlayer) equals: aNumberOfTile.
	self assert: (game playersPositions positionLapOf: aPlayer) equals: aNumberOfLap
]

{ #category : #running }
CardsTest >> cardDeckWithCard: aCard [ 
	^CardDeck withCards: (OrderedCollection with: aCard)
]

{ #category : #running }
CardsTest >> loadedBoard [
 	^(LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
]

{ #category : #running }
CardsTest >> setUp [
	super setUp.
	gameElementsResource := GameElementsResource current.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: robert with:juan.
	
	cardDealingTileWithProbability := CardDealingTile new -> 0.1.	
	board := self loadedBoard.
]

{ #category : #tests }
CardsTest >> should: aBlock raise: anError withErrorMessage: aMessage [
	self should: aBlock
		raise: anError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: aMessage ]
]

{ #category : #tests }
CardsTest >> should: aBlock raiseGameErrorWithMessage: aMessage [
	self should: aBlock
		raise: GameModelError 
		withErrorMessage: aMessage.
]

{ #category : #tests }
CardsTest >> speedCard [ 
	^gameElementsResource speedCard.
]

{ #category : #tests }
CardsTest >> testCantCreateCardDeckWithNoCards [
	self should: [ CardDeck withCards: { } ] raiseGameErrorWithMessage: 'CardDeck must have at least one card to be created. '.
]

{ #category : #tests }
CardsTest >> testOverloadCardAffectsPlayerInConsecutiveTurns [
	| permanentCard |
	permanentCard := gameElementsResource  overloadCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	self assert: game currentPlayer name equals: 'Robert'.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	self
		assertTile: 0
		andLap: 0
		for: juan
		on: game.
	game turnIsPlayed.
	self
		assertTile: 1
		andLap: 0
		for: juan
		on: game.
	self assert: game currentPlayer name equals: 'Robert'.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self
		assertTile: 2
		andLap: 0
		for: juan
		on: game
]

{ #category : #tests }
CardsTest >> testPlayerCannotMoveToNegativeLapAndTileValuesOnCardEffects [
	| permanentCard |
	permanentCard := RealCard
		named: 'GoBack4'
		withAction: (PermanentAction withEffect: (ModifyDiceResult modifyResultBy: -4)).
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self
		assertTile: 0
		andLap: 0
		for: juan
		on: game
]

{ #category : #tests }
CardsTest >> testPlayerCantPlayCancellationIfNoPermanentCardsAreActive [
	| instantCard permanentCard loadedDeck |
	permanentCard := gameElementsResource  dummyPermanentCard.
	instantCard := gameElementsResource cancellationCard.
	loadedDeck := self cardDeckWithCard: instantCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: loadedDeck
		using: dices.
	self assert: game permanentCards size equals: 0.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	self
		should: [ robert playsCard: instantCard affecting: permanentCard on: game ]
		raise: GameModelError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals:
					'Cannot play Cancellation card if there are no active permanent cards. ' ]
]

{ #category : #tests }
CardsTest >> testPlayerCantPlayPermanentCardOutOfHisTurn [
	| permanentCard |
	permanentCard := gameElementsResource dummyPermanentCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	self assert: game currentPlayer name equals: 'Juan'.
	self
		should: [ robert playsCard: permanentCard affecting: 'Juan' on: game ]
		raiseGameErrorWithMessage: 'Cannot play permanent card if it is not your turn. '
]

{ #category : #tests }
CardsTest >> testPlayerPlaysAccelerationCard [
	| permanentCard  |
	permanentCard := gameElementsResource accelerationCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	
	robert playsCard: permanentCard affecting: players on: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertTile: 4 andLap: 0 for: juan on: game.
	self assertTile: 4 andLap: 0 for: robert on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysAccelerationCardAndLapIsFinished [
	| permanentCard  |
	permanentCard := gameElementsResource accelerationCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 9.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsCard: permanentCard affecting: players on: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertTile: 0 andLap: 1 for: juan on: game.
	self assertTile: 0 andLap: 1 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysCancellationCardOutOfHisTurn [
	| instantCard permanentCard loadedDeck secondLoadedDeck |
	
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	dices := OrderedCollection with: fourFaceDummyDice.
	permanentCard := gameElementsResource dummyPermanentCard.
	instantCard := gameElementsResource cancellationCard.
	loadedDeck := (self cardDeckWithCard: instantCard).
	secondLoadedDeck := (self cardDeckWithCard: permanentCard).
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: loadedDeck
		using: dices.
	robert take: (secondLoadedDeck dealCards: 1).
	self assert: robert cards size equals: 3.
	robert playsCard: permanentCard affecting: players on: game.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	robert playsCard: instantCard affecting: permanentCard  on:game.
	self assert: game permanentCards size equals: 0
]

{ #category : #tests }
CardsTest >> testPlayerPlaysInstantCardOutOfHisTurn [
	| instantCard |
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := gameElementsResource dummyInstantCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: instantCard)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	self assert: game currentPlayer name equals: 'Juan'.
	robert playsCard: instantCard affecting: (OrderedCollection with: robert) on: game.
	self assert: robert cards size equals: 2
]

{ #category : #tests }
CardsTest >> testPlayerPlaysOverloadCardOnAnotherPlayer [
	| permanentCard  |
	permanentCard := gameElementsResource overloadCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertTile: 1 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysOverloadCardOnAnotherPlayerTwice [
	|permanentCard  |
	permanentCard := gameElementsResource overloadCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 5.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self assert: robert cards size equals: 0.
	self assert: game permanentCards size equals: 2.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertTile: 1 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysPermanentCard [
	| permanentCard |
	players remove:juan.
	permanentCard := gameElementsResource dummyPermanentCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	robert playsCard: permanentCard affecting: players on: game.
	self assert: game permanentCards size equals: 1
]

{ #category : #tests }
CardsTest >> testPlayerPlaysRedoCardOutOfHisTurn [
	| instantCard  loadedDeck  permanentCard secondDeck |
	
	permanentCard := gameElementsResource dummyPermanentCard.
		
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := gameElementsResource redoCard.
	loadedDeck := (self cardDeckWithCard: instantCard ).
	secondDeck := (self cardDeckWithCard: permanentCard).
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: loadedDeck
		using: dices.
		
	robert take: (secondDeck dealCards: 1).
	self assert: game currentPlayer name equals: 'Robert'.
	robert playsCard: permanentCard affecting: 'Robert' on: game. 
	self assert: game permanentCards  size equals: 1.
	robert playsCard: instantCard affecting: juan on: game.
	self assert: game permanentCards  size equals: 2.
	robert playsCard: instantCard affecting: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysRedoCardOutOfHisTurnTwiceAndRedoesAnInstantCard [
	| instantCard  loadedDeck  instantCard2 secondDeck |
	
	instantCard2 := gameElementsResource dummyInstantCard.
	instantCard := gameElementsResource redoCard.
	loadedDeck := (self cardDeckWithCard: instantCard ).
	
	secondDeck := (self cardDeckWithCard: instantCard2).
	
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: loadedDeck
		using: dices.
		
	robert take: (secondDeck dealCards: 1).
	self assert: game currentPlayer name equals: 'Robert'.
	robert playsCard: instantCard2 affecting: 'Robert' on: game. 
	robert playsCard: instantCard affecting: juan on: game.
	robert playsCard: instantCard affecting: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysRepeatCard [
	| instantCard  |
	instantCard := gameElementsResource repeatCard.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: instantCard)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	robert playsCard: instantCard affecting: 'Juan' on: game
]

{ #category : #tests }
CardsTest >> testPlayerPlaysReverseCard [
	| instantCard pablo rodrigo |
	instantCard := gameElementsResource reverseCard.
	pablo := Player named: 'Pablo'.
	rodrigo := Player named: 'Rodrigo'.
	players add: pablo.
	players add: rodrigo.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: instantCard )
		using: dices.
	game turnIsPlayed.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	rodrigo playsCard: instantCard affecting: players on: game.
	self assert: game currentPlayer equals: robert.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysSkipCard [
	| instantCard pablo rodrigo |
	instantCard := gameElementsResource skipCard.
	pablo := Player named: 'Pablo'.
	rodrigo := Player named: 'Rodrigo'.
	players add: pablo.
	players add: rodrigo.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: instantCard )
		using: dices.
	game turnIsPlayed.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	rodrigo playsCard: instantCard affecting: players on: game.
	self assert: game currentPlayer equals: rodrigo.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysSpeedCardOnAnotherPlayer [
	| permanentCard |
	permanentCard := self speedCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertTile: 4 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysSpeedCardOnAnotherPlayerMoreThanOnce [
	| permanentCard  |
	permanentCard := self speedCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	robert take: (game deck dealCards: 1).
	self assert: robert cards size equals: 3.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	robert playsCard: permanentCard affecting: 'Juan' on: game.
	self assert: robert cards size equals: 0.
	self assert: game permanentCards size equals: 3.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertTile: 6 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testRedoCardHasNoEffectWhenNoCardWasPlayedBefore [
	| instantCard loadedDeck |
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := gameElementsResource redoCard.
	loadedDeck := (self cardDeckWithCard: instantCard ).
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: loadedDeck
		using: dices.
	self assert: game currentPlayer name equals: 'Robert'.
	robert
		playsCard: instantCard
		affecting: (OrderedCollection with: robert)
		on: game.
	self assert: game permanentCards size equals: 0
]
