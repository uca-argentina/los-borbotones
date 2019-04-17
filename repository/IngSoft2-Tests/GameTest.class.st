Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'fourFaceDummyDice',
		'dices',
		'players',
		'game',
		'robert'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameTest >> setUp [
	
	super setUp.
	fourFaceDummyDice := SameFaceDice withFaces: 4  andValue: 4.
	
	dices := LinkedList  with: fourFaceDummyDice.
	robert := Player called: 'Robert'.
	
	players := LinkedList with: robert.
	
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	game playedNextBy: robert.
	
	self assert: game hasEnded.
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	game playedNextBy: robert.
	self assert: game winner name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testPlayerMovesFourStepsWhenHeGetsAFour [
	
	game playedNextBy: robert.
	
	self assert: robert position equals: 4
]

{ #category : #tests }
GameTest >> testPlayerMovesNineStepsWhenUsingTwoDices [
	| fiveFaceDummyDice |
	fiveFaceDummyDice := SameFaceDice withFaces: 5 andValue: 5.
	dices add: fiveFaceDummyDice.

	game playedNextBy: robert.
	
	self assert: robert position equals: 9
]
