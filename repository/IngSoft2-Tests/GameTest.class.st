"
Game tests.
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'dices',
		'players',
		'game',
		'robert',
		'moonWalkWithProbability',
		'atomicBombWithProbability',
		'speedUpWithProbability',
		'timeMachineWithProbability',
		'emptyWithProbability',
		'wormHoleWithProbability'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> juan [
	^ Player named: 'Juan'
]

{ #category : #tests }
GameTest >> lucas [
	^ Player named: 'Lucas'
]

{ #category : #running }
GameTest >> setUp [
	| fourFaceDummyDice |
	super setUp.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	players := OrderedCollection    with: robert.
	
	moonWalkWithProbability := (MoonWalk withNumber: 5) -> 0.05.
	
	atomicBombWithProbability := AtomicBomb new -> 0.02.
	speedUpWithProbability := SpeedUp new -> 0.15.
	timeMachineWithProbability := TimeMachine new -> 0.08.
	emptyWithProbability := Empty new -> 0.55.
	wormHoleWithProbability := WormHole new -> 0.15
]

{ #category : #tests }
GameTest >> testCanNotGetWinnerWhileGameIsRunning [
	| board |
	board := (LoadedBoardBuilder startBoardWithSteps: 3) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
		
	game := Game
		playedBy: players
		withLapsToWin: 1
		board: board
		using: dices.
	self deny: game hasEnded.
	self
		should: [ game winner ]
		raise: GameModelError 
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: 'There is no winner yet. The game is not finished' ]
]

{ #category : #tests }
GameTest >> testGameCantBePlayedOnceItIsOver [
	|board|
	board := (LoadedBoardBuilder startBoardWithSteps: 3) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
		
	game := Game playedBy: players withLapsToWin: 1 board: board using: dices.
	game turnIsPlayed.
	self
		should: [ game turnIsPlayed ]
		raise: GameModelError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: 'Game is over. ' ]
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	|board|
	board := (LoadedBoardBuilder startBoardWithSteps: 3) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	game := Game playedBy: players withLapsToWin: 1 board: board using: dices.
	self deny: game hasEnded.
	game turnIsPlayed.
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGameStartsWithA4StepsBoard [
	|board|
	board := (LoadedBoardBuilder startBoardWithSteps: 4) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	
	game := Game playedBy: players withLapsToWin: 1 board: board using: dices.
	self assert: game board numberOfTiles equals: 4
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	|board|
	board := (LoadedBoardBuilder startBoardWithSteps: 3) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	
	game := Game playedBy: players withLapsToWin: 1 board: board using: dices.
	self deny: game hasEnded.
	game turnIsPlayed.
	self assert: game hasEnded.
	self assert: game winner name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testIsRobertTurn [
	| matt martin board|
	matt := Player named: 'Matt'.
	martin := Player named: 'Martin'.
	players add: matt.
	players add: martin.
	
	board := (LoadedBoardBuilder startBoardWithSteps: 20) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	
	game := Game playedBy: players withLapsToWin: 1 board: board using: dices.
	game turnIsPlayed.
	game turnIsPlayed.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testLuciaCanNotPlayBecouseGameHasEnded [
	| lucia board|
	lucia := Player named: 'Lucia'.
	players add: lucia.
	board := (LoadedBoardBuilder startBoardWithSteps: 3) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	game := Game playedBy: players withLapsToWin: 1 board: board using: dices.
	game turnIsPlayed.
	self
		should: [ game turnIsPlayed  ]
		raise: GameModelError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: 'Game is over. ' ]
	
	
]

{ #category : #tests }
GameTest >> testPlayerMovesNineStepsWhenUsingTwoDices [
	| fiveFaceDummyDice board |
	fiveFaceDummyDice := LoadedDice withFaces: 5 andValue: 5.
	dices add: fiveFaceDummyDice.
	board := (LoadedBoardBuilder startBoardWithSteps: 3) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	game := Game playedBy: players withLapsToWin: 3 board: board using: dices.
	game turnIsPlayed.
	self assert: robert position equals: 0.
	self assert: robert lap equals: 3
]

{ #category : #tests }
GameTest >> testPositionOfRobertAndLuciaAfterAtomicBombIsZero [
	| lucia board |
	lucia := Player named: 'Lucia'.
	players add: lucia.
	board := (LoadedBoardBuilder startBoardWithSteps: 10) withEffectProbabilityAssociation: atomicBombWithProbability ; buildBoard.
		
		
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.
		
	game turnIsPlayed.
	self assert: robert position equals: 0.
	self assert: robert lap equals: 0.
	self assert: lucia position equals: 0.
	self assert: lucia lap equals: 0
]

{ #category : #tests }
GameTest >> testRobertCannotMoveToANegativePosition [
	| board |
	board := (LoadedBoardBuilder startBoardWithSteps: 5) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 3
		board: board
		using: dices.
	game turnIsPlayed.
	self assert: robert position equals: 4.
	game player: robert movesBackwardsSteps: 4.
	self assert: robert position equals: 0.
	game player: robert movesBackwardsSteps: 5.
	self assert: robert position equals: 0.
	self assert: robert lap equals: 0
]

{ #category : #tests }
GameTest >> testThatRoberIsThirdLucasIsSecondAndJuanIsFirstInTheRanking [
	| board lucas juan |
	lucas := self lucas.
	juan := self juan.
	players
		add: lucas;
		add: juan.
	board := (LoadedBoardBuilder startBoardWithSteps: 16) withEffectProbabilityAssociation: emptyWithProbability; buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 5
		board: board
		using: dices.
	game turnIsPlayed.
	lucas moveTo: 3 lap: 4.
	juan moveTo: 5 lap: 5.
	self assert: (game ranking at: 1) equals: juan.
	self assert: (game ranking at: 2) equals: lucas.
	self assert: (game ranking at: 3) equals: robert
]
