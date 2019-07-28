"
Game tests.
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'game',
		'fourFaceDummyDice',
		'dices',
		'robert',
		'players',
		'moonWalkWithProbability',
		'atomicBombWithProbability',
		'speedUpWithProbability',
		'timeMachineWithProbability',
		'emptyWithProbability',
		'wormHoleWithProbability',
		'cardDealingTileWithProbability',
		'overloadCardEffect',
		'speedCardEffect',
		'accelerationCardEffect'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
GameTest class >> resources [ 
	^{GameElementsResource}
]

{ #category : #asserting }
GameTest >> assertPosition: aNumberOfTile andLap: aNumberOfLap for: aPlayer on: aGame [
	self assert: (aGame tilePositionOf: aPlayer) equals: aNumberOfTile.
	self assert: (aGame positionLapOf: aPlayer) equals: aNumberOfLap
]

{ #category : #tests }
GameTest >> juan [
	^ Player named: 'Juan'
]

{ #category : #tests }
GameTest >> loadedBoard [
	^(LoadedBoardBuilder startBoardWithSteps: 3)
		withEffectProbabilityAssociation: emptyWithProbability;
		buildBoard 
]

{ #category : #tests }
GameTest >> lucas [
	^ Player named: 'Lucas'
]

{ #category : #running }
GameTest >> setUp [
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
	cardDealingTileWithProbability := CardDealingTile new -> 0.1.
	overloadCardEffect := ModifyDiceResult modifyResultBy: -2.
	speedCardEffect := ModifyDiceResult modifyResultBy: 1.
	accelerationCardEffect := ModifyDiceResultOfAllPlayers
		modifyResultBy: 1.
	
]

{ #category : #asserting }
GameTest >> should: aBlock raise: anError withErrorMessage: aMessage [
	self should: aBlock
		raise: anError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: aMessage ]
]

{ #category : #asserting }
GameTest >> should: aBlock raiseGameErrorWithMessage: aMessage [
	self should: aBlock
		raise: GameModelError 
		withErrorMessage: aMessage.
]

{ #category : #tests }
GameTest >> stocasticCardDeck [
	| cards redo overload speed acceleration cancellation repeat |
	overload := RealCard
		named: 'Overload'
		andAction: (PermanentAction withEffect: overloadCardEffect).
	speed := RealCard
		named: 'Speed'
		andAction: (PermanentAction withEffect: speedCardEffect).
	acceleration := RealCard
		named: 'Acceleration'
		andAction: (PermanentAction withEffect: accelerationCardEffect).
	redo := RealCard
		named: 'RedoLastCardEffect'
		andAction: (InstantAction withEffect: RedoLastCardEffect withNoExcecutedCard).
	cancellation := RealCard
		named: 'Cancellation'
		andAction: (InstantAction withEffect: Cancellation new).
		
	repeat := RealCard
		named: 'Redo'
		andAction: (InstantAction withEffect: RedoLastCardEffect new).
		
	cards := OrderedCollection
		with: overload
		with: speed
		with: redo
		with: acceleration
		with: repeat
		with: cancellation.
	^ CardDeck withCards: cards
]

{ #category : #tests }
GameTest >> testCanNotGetWinnerWhileGameIsRunning [
	| board |
	board := self loadedBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck
		using: dices.
	self deny: game hasEnded.
	self
		should: [ game winner ]
		raiseGameErrorWithMessage: 'There is no winner yet. The game is not finished'.
]

{ #category : #tests }
GameTest >> testGameCantBePlayedOnceItIsOver [
	| board |
	board := self loadedBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck
		using: dices.
	game turnIsPlayed.
	self
		should: [ game turnIsPlayed ]
		raiseGameErrorWithMessage: 'Game is over. '.
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	| board |
	board := self loadedBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck 
		using: dices.
	self deny: game hasEnded.
	game turnIsPlayed.
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGameStartsWithA4StepsBoard [
	| board |
	board := (LoadedBoardBuilder startBoardWithSteps: 4)
		withEffectProbabilityAssociation: emptyWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck
		using: dices.
	self assert: game board numberOfTiles equals: 4
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	| board |
	board := self loadedBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck
		using: dices.
	self deny: game hasEnded.
	game turnIsPlayed.
	self assert: game hasEnded.
	self assert: game winner name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testIsRobertTurn [
	| matt martin board |
	matt := Player named: 'Matt'.
	martin := Player named: 'Martin'.
	players add: matt.
	players add: martin.
	board := (LoadedBoardBuilder startBoardWithSteps: 20)
		withEffectProbabilityAssociation: emptyWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck
		using: dices.
	game turnIsPlayed.
	game turnIsPlayed.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testLuciaCanNotPlayBecouseGameHasEnded [
	| lucia board |
	lucia := Player named: 'Lucia'.
	players add: lucia.
	board := self loadedBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck
		using: dices.
	game turnIsPlayed.
	self
		should: [ game turnIsPlayed ]
		raiseGameErrorWithMessage: 'Game is over. '.
]

{ #category : #tests }
GameTest >> testPlayerMovesNineStepsWhenUsingTwoDices [
	| fiveFaceDummyDice board |
	fiveFaceDummyDice := LoadedDice withFaces: 5 andValue: 5.
	dices add: fiveFaceDummyDice.
	board := self loadedBoard.
	game := Game
		playedBy: players
		withLapsToWin: 3
		board: board
		deck: self stocasticCardDeck 
		using: dices.
	game turnIsPlayed.
	self
		assertPosition: 0
		andLap: 3
		for: robert
		on: game
]

{ #category : #tests }
GameTest >> testPlayersStartWithTwoCards [
	| board tomas lucia |
	tomas := Player named: 'Tomas'.
	lucia := Player named: 'Lucia'.
	players add: tomas.
	players add: lucia.
	board := self loadedBoard.
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		deck: self stocasticCardDeck 
		using: dices.
	game players
		do: [ :player | self assert: player cards size equals: 2 ]
]

{ #category : #tests }
GameTest >> testPositionOfRobertAndLuciaAfterAtomicBombIsZero [
	| lucia board |
	lucia := Player named: 'Lucia'.
	players add: lucia.
	board := (LoadedBoardBuilder startBoardWithSteps: 10)
		withEffectProbabilityAssociation: atomicBombWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		deck: self stocasticCardDeck 
		using: dices.
	game turnIsPlayed.
	self
		assertPosition: 0
		andLap: 0
		for: robert
		on: game.
	self
		assertPosition: 0
		andLap: 0
		for: lucia
		on: game
]

{ #category : #tests }
GameTest >> testThatRoberIsThirdLucasIsSecondAndJuanIsFirstInTheRanking [
	| board lucas juan |
	lucas := self lucas.
	juan := self juan.
	players
		add: lucas;
		add: juan.
	board := (LoadedBoardBuilder startBoardWithSteps: 16)
		withEffectProbabilityAssociation: emptyWithProbability;
		buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 5
		board: board
		deck: self stocasticCardDeck
		using: dices.
	game turnIsPlayed.
	game changePositionOf: lucas toTile: 3 andLap: 4.
	game changePositionOf: juan toTile: 5 andLap: 5.
	self assert: game ranking first equals: juan.
	self assert: game ranking second equals: lucas.
	self assert: game ranking third equals: robert
]
