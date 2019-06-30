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
		'fourFaceDummyDice'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardsTest >> assertPosition: aNumberOfTile andLap: aNumberOfLap for: aPlayer on: aGame [
	self assert: (game tilePositionOf: aPlayer) equals: aNumberOfTile.
	self assert: (game positionLapOf: aPlayer) equals: aNumberOfLap
]

{ #category : #tests }
CardsTest >> cardDeckWithCard: aCard [ 
	^CardDeck withCards: (OrderedCollection with: aCard)
]

{ #category : #tests }
CardsTest >> juan [
	^ Player named: 'Juan'
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
	cardDealingTileWithProbability := CardDealingTile new -> 0.1
]

{ #category : #tests }
CardsTest >> testOverloadCardAffectsPlayerInConsecutiveTurns [
	| board  permanentCard  |
	permanentCard := PermanentCard
		named: 'Overload'
		withEffect: (ModifyDiceResult modifyResultBy: -1).
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	self assert: game currentPlayer name equals: 'Robert'.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertPosition: 2 andLap: 0 for: juan on: game.
	self assert: game currentPlayer name equals: 'Robert'.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assertPosition: 4 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerCannotMoveToNegativeLapAndTileValuesOnCardEffects [
	| board  permanentCard  |
	permanentCard := PermanentCard
		named: 'Overload'
		withEffect: (ModifyDiceResult modifyResultBy: -4).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	self assertPosition: 0 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerCantPlayCancellationIfNoPermanentCardsAreActive [
	| board  instantCard permanentCard loadedDeck |
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	permanentCard := PermanentCard
		named: 'Test'
		withEffect: DummyEffect new.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard
		withEffect: Cancellation new.
	loadedDeck := (self cardDeckWithCard: instantCard).
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
		should: [ robert playsCard: instantCard affecting: permanentCard on: game]
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
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	permanentCard := PermanentCard
		named: 'Test'
		withEffect: DummyEffect new.
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
	permanentCard := PermanentCard
		named: 'Acceleration'
		withEffect: (ModifyDiceResultOfAllPlayers  modifyResultBy: 1).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	self assertPosition: 4 andLap: 0 for: juan on: game.
	self assertPosition: 4 andLap: 0 for: robert on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysAccelerationCardAndLapIsFinished [
	| board  permanentCard  |
	permanentCard := PermanentCard
		named: 'Acceleration'
		withEffect: (ModifyDiceResultOfAllPlayers  modifyResultBy: 1).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 9.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	permanentCard := PermanentCard
		named: 'Test'
		withEffect: DummyEffect new.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard
		withEffect: Cancellation new.
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
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard withEffect: DummyEffect new.
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
	permanentCard := PermanentCard
		named: 'Overload'
		withEffect: (ModifyDiceResult modifyResultBy: -2).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	permanentCard := PermanentCard
		named: 'Overload'
		withEffect: (ModifyDiceResult modifyResultBy: -2).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 5.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	self assertPosition: 1 andLap: 0 for: juan on: game.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysPermanentCard [
	| board  permanentCard |
	players remove:juan.
	permanentCard := PermanentCard
		named: 'Test'
		withEffect: DummyEffect new.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
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
	
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
		
	permanentCard := PermanentCard
		named: 'Test'
		withEffect: DummyEffect new.
		
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard withEffect: (RedoLastCardEffect withNoExcecutedCard).
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
	
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
		
	instantCard2 := InstantCard
		withEffect: DummyEffect new.
		
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard withEffect: (RedoLastCardEffect withNoExcecutedCard).
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
	instantCard := InstantCard withEffect: RepeatLastTileEffect new.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	permanentCard := PermanentCard
		named: 'Speed'
		withEffect: (ModifyDiceResult modifyResultBy: 1).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	permanentCard := PermanentCard
		named: 'Speed'
		withEffect: (ModifyDiceResult modifyResultBy: 1).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
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
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard
		withEffect: RedoLastCardEffect withNoExcecutedCard.
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
