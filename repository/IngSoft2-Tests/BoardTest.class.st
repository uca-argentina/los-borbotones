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
		'emptyWithProbability',
		'wormHoleWithProbability',
		'moonWalkWithProbability'
	],
	#category : #'IngSoft2-Tests'
}

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
	emptyWithProbability := Empty new -> 0.55.
	wormHoleWithProbability := WormHole new -> 0.15
]

{ #category : #tests }
BoardTest >> testIfRobertGoesToAnAtomicBombTileAllPlayersGoBackToTheStart [
	| board game lucas juan|
	lucas:= Player named: 'Lucas'.
	juan := Player named: 'Juan'.
	lucas moveTo: 2 lap: 0.
	juan moveTo: 3 lap: 3.
	players add: lucas; add: juan.
	board := (LoadedBoardBuilder startBoardWithSteps: 5) withEffectProbabilityAssociation: atomicBombWithProbability; buildBoard. 
	
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.
	game turnIsPlayed.
	self assert: (players allSatisfy: [ :player | player position = 0 ])
]

{ #category : #tests }
BoardTest >> testMoonWalkEffectMakesInactivePlayersGoBackNSteps [
	| board game lucas juan lucia|
	lucas:= Player named: 'Lucas'.
	juan := Player named: 'Juan'.
	lucia := Player named: 'Lucia'.
	
	lucas moveTo: 7 lap: 3.
	juan moveTo: 2 lap: 1.
	lucia moveTo: 1 lap: 0.
	
	players add: lucas; add: juan; add:lucia.
	board := (LoadedBoardBuilder startBoardWithSteps: 6) withEffectProbabilityAssociation: moonWalkWithProbability; buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.
	game turnIsPlayed.
	
	self assert: lucas position equals: 2.
	self assert: lucas lap equals: 3.
	self assert: juan position equals: 3.
	self assert: juan lap equals: 0.
	self assert: lucia position equals: 0.
	self assert: lucia lap equals: 0.
]

{ #category : #tests }
BoardTest >> testSpeedUpEffectMakesPlayerMove4StepsForward [
	| board game |
	
	board := (LoadedBoardBuilder startBoardWithSteps: 10) withEffectProbabilityAssociation: speedUpWithProbability; buildBoard.
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.

	self assert: robert position equals: 0.
	game turnIsPlayed.
	
	self assert: robert position equals: 8.
]

{ #category : #tests }
BoardTest >> testTimeMachineEffectMakesPlayerMove4StepsBackwards [
	| board game |
	
	board := (LoadedBoardBuilder startBoardWithSteps: 10) withEffectProbabilityAssociation: timeMachineWithProbability; buildBoard.
		
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.
	robert moveTo: 2 lap: 0.
	robert moveTo: 3 lap:0. 
	self assert: robert position equals: 3.
	game turnIsPlayed.
	self assert: robert position equals: 2.
	
]

{ #category : #tests }
BoardTest >> testWormholeEffectMakesPlayerMove4StepsBackwards [
	| board game |
	
	board := (LoadedBoardBuilder startBoardWithSteps: 10) withEffectProbabilityAssociation: wormHoleWithProbability; buildBoard.
	
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.

	self assert: robert position equals: 0.
	game turnIsPlayed.
	
	self assert: robert position equals: 0.
]
