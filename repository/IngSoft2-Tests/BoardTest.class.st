Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'dices',
		'players',
		'robert'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BoardTest >> setUp [
	| fourFaceDummyDice  |
	super setUp.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	players := OrderedCollection with: robert
]

{ #category : #tests }
BoardTest >> testIfRobertGoesToAnAtomicBombTileAllPlayersGoBackToTheStart [
	| board game lucas juan|
	lucas:= Player named: 'Lucas'.
	juan := Player named: 'Juan'.
	lucas moveTo: 2 lap: 0.
	juan moveTo: 3 lap: 3.
	players add: lucas; add: juan.
	board := Board
		withSteps: 5
		andEffects: (Array with: (AtomicBomb  withProbability: 1)).
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
	board := Board
		withSteps: 6
		andEffects: (Array with: (MoonWalk  withProbability: 1 andN: 5)).
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.
	game turnIsPlayed.
	
	self assert: lucas position equals: 2.
	self assert: lucas laps equals: 3.
	self assert: juan position equals: 3.
	self assert: juan laps equals: 0.
	self assert: lucia position equals: 0.
	self assert: lucia laps equals: 0.
]

{ #category : #tests }
BoardTest >> testSpeedUpEffectMakesPlayerMove4StepsForward [
	| board game |
	
	board := Board
		withSteps: 10
		andEffects: (Array with: (SpeedUp  withProbability: 1)).
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
	
	board := Board
		withSteps: 10
		andEffects: (Array with: (TimeMachine   withProbability: 1)).
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
	
	board := Board
		withSteps: 10
		andEffects: (Array with: (WormHole  withProbability: 1)).
	game := Game
		playedBy: players
		withLapsToWin: 4
		board: board
		using: dices.

	self assert: robert position equals: 0.
	game turnIsPlayed.
	
	self assert: robert position equals: 0.
]
