Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'fourFaceDummyDice',
		'dices',
		'player',
		'players',
		'game'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameTest >> setUp [
	
	super setUp.
	fourFaceDummyDice := SameFaceDice withFaces: 4  andValue: 4.
	
	dices := LinkedList  with: fourFaceDummyDice.
	
	player := Player called: 'Robert'.
	players := Array with: player.
	
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	
	game playedNextBy: player.
	
	self assert: game hasEnded.
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	game playedNextBy: player.
	self assert: game winner name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testPlayerMovesFourStepsWhenHeGetsAFour [
	
	game playedNextBy: player.
	
	self assert: player position equals: 4
]

{ #category : #tests }
GameTest >> testPlayerMovesNineStepsWhenUsingTwoDices [
	| fiveFaceDummyDice |
	fiveFaceDummyDice := SameFaceDice withFaces: 5 andValue: 5.
	dices add: fiveFaceDummyDice.

	game playedNextBy: player.
	
	self assert: player position equals: 9
]
