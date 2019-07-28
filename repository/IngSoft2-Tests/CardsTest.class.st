"
Cards tests
"
Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#instVars : [
		'dices',
		'players',
		'game',
		'robert',
		'cardDealingTileWithProbability',
		'emptyWithProbability',
		'juan',
		'fourFaceDummyDice',
		'overloadCardEffect',
		'speedCardEffect',
		'accelerationCardEffect'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardsTest >> assertPosition: aNumberOfTile andLap: aNumberOfLap for: aPlayer on: aGame [
	self assert: (game tilePositionOf: aPlayer) equals: aNumberOfTile.
	self assert: (game positionLapOf: aPlayer) equals: aNumberOfLap
]

{ #category : #tests }
CardsTest >> cancellationCard [
	^ RealCard
		named: 'Cancellation'
		andAction: (InstantAction withEffect: Cancellation new)
]

{ #category : #tests }
CardsTest >> cardDeckWithCard: aCard [ 
	^CardDeck withCards: (OrderedCollection with: aCard)
]

{ #category : #tests }
CardsTest >> dummyInstantCard [
	^ RealCard
		named: 'Test'
		andAction: (InstantAction  withEffect: DummyEffect new)
]

{ #category : #tests }
CardsTest >> dummyPermanentCard [
	^ RealCard
		named: 'Test'
		andAction: (PermanentAction withEffect: DummyEffect new)
]

{ #category : #tests }
CardsTest >> juan [
	^ Player named: 'Juan'
]

{ #category : #tests }
CardsTest >> loadedBoard [
 	^(LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
]

{ #category : #tests }
CardsTest >> overloadCard [
	^ RealCard
		named: 'Overload'
		andAction: (PermanentAction withEffect: overloadCardEffect).
]

{ #category : #tests }
CardsTest >> redoCard [
	^ RealCard
		named: 'Test'
		andAction: (InstantAction withEffect: RedoLastCardEffect withNoExcecutedCard)
]

{ #category : #running }
CardsTest >> setUp [
	super setUp.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	juan := self juan.
	emptyWithProbability := Empty new -> 0.45.
	players := OrderedCollection with: robert with:juan.
	cardDealingTileWithProbability := CardDealingTile new -> 0.1.
	
	overloadCardEffect := ModifyDiceResult modifyResultBy: -2.
	speedCardEffect := ModifyDiceResult modifyResultBy: 1.
	accelerationCardEffect := ModifyDiceResultOfAllPlayers  modifyResultBy: 1.
	
]

{ #category : #tests }
CardsTest >> speedCard [ 
	^ RealCard
		named: 'Overload'
		andAction: (PermanentAction withEffect: speedCardEffect ).
]

{ #category : #tests }
CardsTest >> testOverloadCardAffectsPlayerInConsecutiveTurns [
	| board permanentCard |
	permanentCard := self overloadCard.
	board := self loadedBoard.
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
		assertPosition: 0
		andLap: 0
		for: juan
		on: game.
	game turnIsPlayed.
	self
		assertPosition: 1
		andLap: 0
		for: juan
		on: game.
	self assert: game currentPlayer name equals: 'Robert'.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self
		assertPosition: 2
		andLap: 0
		for: juan
		on: game
]

{ #category : #tests }
CardsTest >> testPlayerCannotMoveToNegativeLapAndTileValuesOnCardEffects [
	| board permanentCard |
	permanentCard := RealCard
		named: 'GoBack4'
		andAction: (PermanentAction withEffect: (ModifyDiceResult modifyResultBy: -4)).
	board := self loadedBoard.
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
		assertPosition: 0
		andLap: 0
		for: juan
		on: game
]

{ #category : #tests }
CardsTest >> testPlayerCantPlayCancellationIfNoPermanentCardsAreActive [
	| board instantCard permanentCard loadedDeck |
	board := self loadedBoard.
	permanentCard := self dummyPermanentCard.
	instantCard := self cancellationCard.
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
	| board permanentCard|
	board := self loadedBoard.
	permanentCard := self dummyPermanentCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (self cardDeckWithCard: permanentCard)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	self assert: game currentPlayer name equals: 'Juan'.
	self should: [robert playsCard: permanentCard affecting: 'Juan' on: game] raise: GameModelError
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Cannot play permanent card if it is not your turn. ' ]
]

{ #category : #tests }
CardsTest >> testPlayerPlaysAccelerationCard [
	| board  permanentCard  |
	permanentCard := RealCard
		named: 'Acceleration'
		andAction: (PermanentAction withEffect: accelerationCardEffect).
	board := self loadedBoard.
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
	self assertPosition: 4 andLap: 0 for: juan on: game.
	self assertPosition: 4 andLap: 0 for: robert on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysAccelerationCardAndLapIsFinished [
	| board  permanentCard  |
	permanentCard := RealCard
		named: 'Acceleration'
		andAction: (PermanentAction withEffect: accelerationCardEffect).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 9.
	board := self loadedBoard.
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
	self assertPosition: 0 andLap: 1 for: juan on: game.
	self assertPosition: 0 andLap: 1 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysCancellationCardOutOfHisTurn [
	| board  instantCard permanentCard loadedDeck secondLoadedDeck |
	
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	dices := OrderedCollection with: fourFaceDummyDice.
	board := self loadedBoard.
	permanentCard := self dummyPermanentCard.
	instantCard := self cancellationCard.
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
	| board  instantCard |
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	board := self loadedBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := self dummyInstantCard.
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
	| board  permanentCard  |
	permanentCard := self overloadCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := self loadedBoard.
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
	self assertPosition: 1 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysOverloadCardOnAnotherPlayerTwice [
	| board  permanentCard  |
	permanentCard := self overloadCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 5.
	dices := OrderedCollection with: fourFaceDummyDice.
	board := self loadedBoard.
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
	self assertPosition: 1 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysPermanentCard [
	| board  permanentCard |
	players remove:juan.
	permanentCard := self dummyPermanentCard.
	board := self loadedBoard.
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
	| board  instantCard  loadedDeck  permanentCard secondDeck |
	
	board := self loadedBoard.
		
	permanentCard := self dummyPermanentCard.
		
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := self redoCard.
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
	| board  instantCard  loadedDeck  instantCard2 secondDeck |
	
	board := self loadedBoard.
		
	instantCard2 := self dummyInstantCard.
	instantCard := self redoCard.
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
	| board instantCard  |
	instantCard := self redoCard.
	board := self loadedBoard.
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
CardsTest >> testPlayerPlaysSpeedCardOnAnotherPlayer [
	| board permanentCard |
	permanentCard := self speedCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := self loadedBoard.
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
	self assertPosition: 4 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysSpeedCardOnAnotherPlayerMoreThanOnce [
	| board  permanentCard  |
	permanentCard := self speedCard.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := self loadedBoard.
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
	self assertPosition: 6 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testRedoCardHasNoEffectWhenNoCardWasPlayedBefore [
	| board instantCard loadedDeck |
	board := self loadedBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := self redoCard.
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
