"
Board tests.
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'dices',
		'players',
		'robert',
		'atomicBombWithProbability',
		'speedUpWithProbability',
		'timeMachineWithProbability',
		'cardDealingTileWithProbability',
		'emptyWithProbability',
		'wormHoleWithProbability',
		'moonWalkWithProbability'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> assertPosition: aNumberOfTile andLap: aNumberOfLap for: aPlayer on: game [
	self assert: (game tilePositionOf: aPlayer) equals: aNumberOfTile.
	self assert: (game positionLapOf: aPlayer) equals: aNumberOfLap
]

{ #category : #running }
BoardTest >> setUp [
	| fourFaceDummyDice |
	super setUp.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	players := OrderedCollection with: robert.
	moonWalkWithProbability := (MoonWalk withNumber: 5) -> 0.05.
	atomicBombWithProbability := AtomicBomb new -> 0.02.
	speedUpWithProbability := SpeedUp new -> 0.15.
	timeMachineWithProbability := TimeMachine new -> 0.08.
	emptyWithProbability := Empty new -> 0.45.
	wormHoleWithProbability := WormHole new -> 0.15.
	cardDealingTileWithProbability := CardDealingTile new -> 0.1
]

{ #category : #tests }
BoardTest >> testCardDealingTileGivesPlayerOneCard [
	| board game fourFaceDummyDice |
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: cardDealingTileWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: StocasticCardDeck randomDeck
		using: dices.
	game turnIsPlayed.
	self assert: robert cards size equals: 3.
	game turnIsPlayed.
	self assert: robert cards size equals: 4
]

{ #category : #tests }
BoardTest >> testIfRobertGoesToAnAtomicBombTileAllPlayersGoBackToTheStart [
	| board game lucas juan |
	lucas := Player named: 'Lucas'.
	juan := Player named: 'Juan'.
	players
		add: lucas;
		add: juan.
	board := (LoadedBoardBuilder startBoardWithSteps: 5)
		withEffectProbabilityAssociation: atomicBombWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: StocasticCardDeck randomDeck
		using: dices.
	game changePositionOf: lucas toTile: 2 andLap: 0.
	game changePositionOf: juan toTile: 3 andLap: 3.
	game turnIsPlayed.
	self
		assert: (players allSatisfy: [ :player | (game tilePositionOf: player) = 0 ])
]

{ #category : #tests }
BoardTest >> testMoonWalkEffectMakesInactivePlayersGoBackNSteps [
	| board game lucas juan lucia |
	lucas := Player named: 'Lucas'.
	juan := Player named: 'Juan'.
	lucia := Player named: 'Lucia'.
	players
		add: lucas;
		add: juan;
		add: lucia.
	board := (LoadedBoardBuilder startBoardWithSteps: 6)
		withEffectProbabilityAssociation: moonWalkWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: StocasticCardDeck randomDeck
		using: dices.
	game changePositionOf: lucas toTile: 7 andLap: 3.
	game changePositionOf: juan toTile: 2 andLap: 1.
	game changePositionOf: lucia toTile: 1 andLap: 0.
	game turnIsPlayed.
	self
		assertPosition: 2
		andLap: 3
		for: lucas
		on: game.
	self
		assertPosition: 3
		andLap: 0
		for: juan
		on: game.
	self
		assertPosition: 0
		andLap: 0
		for: lucia
		on: game
]

{ #category : #tests }
BoardTest >> testSpeedUpEffectMakesPlayerMove4StepsForward [
	| board game |
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: speedUpWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: StocasticCardDeck randomDeck 
		using: dices.
	self assert: (game tilePositionOf: robert) equals: 0.
	game turnIsPlayed.
	self assert: (game tilePositionOf: robert) equals: 8
]

{ #category : #tests }
BoardTest >> testStocasticBoardIsValid [
	| boardBuilder board effects |
	boardBuilder := StocasticBoardBuilder startBoardWithSteps: 6.
	effects := OrderedCollection
		with: moonWalkWithProbability
		with: atomicBombWithProbability
		with: timeMachineWithProbability
		with: emptyWithProbability
		with: wormHoleWithProbability.
	boardBuilder withEffects: effects.
	board := boardBuilder buildBoard.
	self assert: board numberOfTiles equals: 6
	
]

{ #category : #tests }
BoardTest >> testTimeMachineEffectMakesPlayerMove4StepsBackwards [
	| board game |
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: timeMachineWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: StocasticCardDeck randomDeck
		using: dices.
	game changePositionOf: robert toTile: 2 andLap: 0.
	game changePositionOf: robert toTile: 3 andLap: 0.
	self assert: (game tilePositionOf: robert) equals: 3.
	game turnIsPlayed.
	self assert: (game tilePositionOf: robert) equals: 2
]

{ #category : #tests }
BoardTest >> testWormholeEffectMakesPlayerMove4StepsBackwards [
	| board game fourFaceDummyDice |
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 2.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: wormHoleWithProbability;
		buildBoard.
	dices := OrderedCollection with: fourFaceDummyDice.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: StocasticCardDeck randomDeck
		using: dices.
	game changePositionOf: robert toTile: 1 andLap: 0.
	self assert: (game tilePositionOf: robert) equals: 1.
	game turnIsPlayed.
	self assert: (game tilePositionOf: robert) equals: 0
]
