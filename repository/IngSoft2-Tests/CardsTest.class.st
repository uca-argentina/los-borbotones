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
		'emptyWithProbability'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> juan [
	^ Player named: 'Juan'
]

{ #category : #running }
CardsTest >> setUp [
		| fourFaceDummyDice |
	super setUp.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	emptyWithProbability := Empty new -> 0.45.
	players := OrderedCollection with: robert.
	cardDealingTileWithProbability := CardDealingTile new -> 0.1
]

{ #category : #tests }
CardsTest >> testOverloadCardAffectsPlayerInConsecutiveTurns [
	| board fourFaceDummyDice permanentCard juan |
	juan := self juan.
	players add: juan.
	
	permanentCard := PermanentCard
		named: 'Overload'
		withEffect: (ModifyDiceResult modifyResultBy: -1).
		

				
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsPermanentCardOn: game affecting: (OrderedCollection with: juan).
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	self assert: game currentPlayer name equals: 'Robert'.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assert: (game positionOf: juan) tile equals: 2.
	self assert: (game positionOf: juan) lap equals: 0.
	self assert: game currentPlayer name equals: 'Robert'.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	
	self assert: (game positionOf: juan) tile equals: 4.
	self assert: (game positionOf: juan) lap equals: 0
]

{ #category : #tests }
CardsTest >> testPlayerCantPlayCancellationIfNoPermanentCardsAreActive [
	| board fourFaceDummyDice instantCard permanentCard loadedDeck |
	players add: self juan.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	permanentCard := PermanentCard
		named: 'Test'
		withEffect: DummyEffect new.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard
		withEffect: (Cancellation affect: permanentCard).
	loadedDeck := LoadedCardDeck withCard: instantCard.
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
		should: [ robert playsInstantCardOn: game]
		raise: GameModelError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals:
					'Cannot play Cancellation card if there are no active permanent cards. ' ]
]

{ #category : #tests }
CardsTest >> testPlayerCantPlayPermanentCardOutOfHisTurn [
	| board fourFaceDummyDice juan|
	juan := self juan.
	players add: juan.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (LoadedCardDeck withCard: PermanentCard new)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	self assert: game currentPlayer name equals: 'Juan'.
	self should: [robert playsPermanentCardOn: game affecting: (OrderedCollection with: juan)] raise: GameModelError
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Cannot play permanent card if it is not your turn. ' ]
]

{ #category : #tests }
CardsTest >> testPlayerPlaysAccelerationCard [
	| board fourFaceDummyDice permanentCard juan |
	juan := self juan.
	players add: juan.
	permanentCard := PermanentCard
		named: 'Acceleration'
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
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert picks: permanentCard andPlayItOn: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assert: (game positionOf: juan) tile equals: 4.
	self assert: (game positionOf: juan) lap equals: 0.
	self assert: (game positionOf: robert) tile equals: 4.
	self assert: (game positionOf: robert) lap equals: 0
]

{ #category : #tests }
CardsTest >> testPlayerPlaysAccelerationCardAndLapIsFinished [
	| board fourFaceDummyDice permanentCard juan |
	juan := self juan.
	players add: juan.
	permanentCard := PermanentCard
		named: 'Acceleration'
		withEffect: (ModifyDiceResult modifyResultBy: 1).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 9.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsPermanentCardOn: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assert: (game positionOf: juan) tile equals: 0.
	self assert: (game positionOf: juan) lap equals: 1.
	self assert: (game positionOf: robert) tile equals: 0.
	self assert: (game positionOf: robert) lap equals: 1
]

{ #category : #tests }
CardsTest >> testPlayerPlaysCancellationCardOutOfHisTurn [
	| board fourFaceDummyDice instantCard permanentCard loadedDeck secondLoadedDeck |
	players add: self juan.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	permanentCard := PermanentCard
		named: 'Test'
		withEffect: DummyEffect new.
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard
		withEffect: (Cancellation affect: permanentCard).
	loadedDeck := LoadedCardDeck withCard: instantCard.
	secondLoadedDeck := LoadedCardDeck withCard: permanentCard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: loadedDeck
		using: dices.
	robert take: (secondLoadedDeck dealCards: 1).
	self assert: robert cards size equals: 3.
	robert playsPermanentCardOn: game.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	robert playsInstantCardOn: game.
	self assert: game permanentCards size equals: 0
]

{ #category : #tests }
CardsTest >> testPlayerPlaysInstantCardOutOfHisTurn [
	| board fourFaceDummyDice instantCard |
	players add: self juan.
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
		deck: (LoadedCardDeck withCard: instantCard)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	self assert: game currentPlayer name equals: 'Juan'.
	robert playsInstantCardOn: game.
	self assert: robert cards size equals: 2
]

{ #category : #tests }
CardsTest >> testPlayerPlaysOverloadCardOnAnotherPlayer [
	| board fourFaceDummyDice permanentCard juan |
	juan := self juan.
	players add: juan.
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
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsPermanentCardOn: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assert: (game positionOf: juan) tile equals: 1.
	self assert: (game positionOf: juan) lap equals: 0
]

{ #category : #tests }
CardsTest >> testPlayerPlaysOverloadCardOnAnotherPlayerTwice [
	| board fourFaceDummyDice permanentCard juan |
	juan := self juan.
	players add: juan.
	permanentCard := PermanentCard
		named: 'Overload'
		withEffect: (ModifyDiceResult modifyResultBy: -1).
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 3.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsPermanentCardOn: game.
	robert playsPermanentCardOn: game.
	self assert: robert cards size equals: 0.
	self assert: game permanentCards size equals: 2.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assert: (game positionOf: juan) tile equals: 1.
	self assert: (game positionOf: juan) lap equals: 0
]

{ #category : #tests }
CardsTest >> testPlayerPlaysPermanentCard [
	| board fourFaceDummyDice permanentCard |
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
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
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	robert playsPermanentCardOn: game.
	self assert: game permanentCards size equals: 1
]

{ #category : #tests }
CardsTest >> testPlayerPlaysRedoCardOutOfHisTurn [
	| board fourFaceDummyDice instantCard  loadedDeck  |
	players add: self juan.
	
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
		
	dices := OrderedCollection with: fourFaceDummyDice.
	instantCard := InstantCard withEffect: (RedoLastCardEffect new).
	loadedDeck := LoadedCardDeck withCard: instantCard.
	
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: loadedDeck
		using: dices.
		
	
	self assert: game currentPlayer name equals: 'Juan'.
	robert playsInstantCardOn: game.
	self assert: game permanentCards  size equals: 0.
]

{ #category : #tests }
CardsTest >> testPlayerPlaysSpeedCardOnAnotherPlayer [
	| board fourFaceDummyDice permanentCard juan |
	juan := self juan.
	players add: juan.
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
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	self assert: robert cards size equals: 2.
	robert playsPermanentCardOn: game.
	self assert: robert cards size equals: 1.
	self assert: game permanentCards size equals: 1.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assert: (game positionOf: juan) tile equals: 4.
	self assert: (game positionOf: juan) lap equals: 0
]

{ #category : #tests }
CardsTest >> testPlayerPlaysSpeedCardOnAnotherPlayerMoreThanOnce [
	| board fourFaceDummyDice permanentCard juan |
	juan := self juan.
	players add: juan.
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
		deck: (LoadedCardDeck withCard: permanentCard)
		using: dices.
	robert take: (game deck dealCards: 1).
	self assert: robert cards size equals: 3.
	robert playsPermanentCardOn: game.
	robert playsPermanentCardOn: game.
	robert playsPermanentCardOn: game.
	self assert: robert cards size equals: 0.
	self assert: game permanentCards size equals: 3.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Juan'.
	game turnIsPlayed.
	self assert: (game positionOf: juan) tile equals: 6.
	self assert: (game positionOf: juan) lap equals: 0
]
