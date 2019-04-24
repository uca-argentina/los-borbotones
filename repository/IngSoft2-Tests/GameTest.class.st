"
Game tests.
"
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
	game turnIsPlayed.
	self should: [ game turnIsPlayed  ] raise: Error
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	game turnIsPlayed.
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	game turnIsPlayed.
	self assert: game winner name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testIsRobertTurn [
	| matt martin |
	matt := Player called: 'Matt'.
	martin := Player called: 'Martin'.
	players add: matt.
	players add: martin.
	game := Game playedBy: players withStepsToWin: 20 andUsing: dices.
	game turnIsPlayed.
	game turnIsPlayed.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testPlayerMovesNineStepsWhenUsingTwoDices [
	| fiveFaceDummyDice |
	game := Game playedBy: players withStepsToWin: 9 andUsing: dices.
	fiveFaceDummyDice := SameFaceDice withFaces: 5 andValue: 5.
	dices add: fiveFaceDummyDice.
	game turnIsPlayed.
	self assert: robert position equals: 9
]

{ #category : #tests }
GameTest >> testPlayerMovesThreeStepsWhenHeGetsAFour [
	game turnIsPlayed.
	self assert: robert position equals: 3
]

{ #category : #tests }
GameTest >> testThatLuciaCanNotPlayBecouseGameHasEnded [
	| lucia lucas |
	lucia := Player called: 'Lucia'.
	lucas := Player called: 'Lucas'.
	players add: lucia.
	players add: lucas.
	game := Game playedBy: players withStepsToWin: 4 andUsing: dices.
	game turnIsPlayed.
	self should: [ game turnIsPlayed ] raise: Error
]
