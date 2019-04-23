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
	game nextTurnPlayed.
	self should: [ game playedNextBy: robert ] raise: Error
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	game nextTurnPlayed.
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	game nextTurnPlayed.
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
	game nextTurnPlayed.
	game nextTurnPlayed.
	game nextTurnPlayed.
	self assert: game thePlayersTurn name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testPlayerMovesFourStepsWhenHeGetsAFour [
	game nextTurnPlayed.
	self assert: robert position equals: 4
]

{ #category : #tests }
GameTest >> testPlayerMovesNineStepsWhenUsingTwoDices [
	| fiveFaceDummyDice |
	fiveFaceDummyDice := SameFaceDice withFaces: 5 andValue: 5.
	dices add: fiveFaceDummyDice.
	game nextTurnPlayed.
	self assert: robert position equals: 9
]

{ #category : #tests }
GameTest >> testThatLuciaCanNotPlayBecouseGameHasEnded [
	| lucia lucas |
	lucia := Player called: 'Lucia'.
	lucas := Player called: 'Lucas'.
	players add: lucia.
	players add: lucas.
	game := Game playedBy: players withStepsToWin: 4 andUsing: dices.
	game nextTurnPlayed.
	self should: [ game nextTurnPlayed ] raise: Error
]
