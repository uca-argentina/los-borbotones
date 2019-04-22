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
	fourFaceDummyDice := SameFaceDice withFaces: 4 andValue: 4.
	dices := LinkedList with: fourFaceDummyDice.
	robert := Player called: 'Robert'.
	players := LinkedList with: robert.
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices
]

{ #category : #tests }
GameTest >> testGameCantBePlayedOnceItIsOver [
	| lucia |
	lucia := Player called: 'Lucia'.
	players add: lucia.

	game playedNextBy: lucia.
	
	self should: [ game playedNextBy: robert. ] raise: Error.
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	game playedNextBy: robert.
	
	self assert: game hasEnded.
]

{ #category : #tests }
GameTest >> testGetPositionOfPlayersOnceGameIsOver [
	| lucia lucas|
	
	lucia := Player called: 'Lucia'.
	lucas := Player called: 'Lucas'.
	players add: lucia.
	players add: lucas.

	game := Game playedBy: players withStepsToWin: 8 andUsing: dices.
	game playedNextBy: lucia.
	game playedNextBy: robert.
	game playedNextBy: lucia.
	
	self assert: lucia position equals: 8.
	self assert: lucas position equals: 0.
	self assert: robert position equals: 4.
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	game playedNextBy: robert.
	self assert: game winner name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testIsMattTurn [
	| matt |
	matt := Player called: 'Matt'.
	players add: matt.
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
	self assert: game turn equals: 'Matt'
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
