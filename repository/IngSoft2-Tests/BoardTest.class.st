Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'dices',
		'players'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BoardTest >> setUp [
	| fourFaceDummyDice robert |
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
	self assert: (players allSatisfy: [ :player | player position = 1 ])
]
