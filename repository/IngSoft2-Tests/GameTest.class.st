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
		'robert'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameTest >> setUp [
	| fourFaceDummyDice |
	super setUp.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	players := OrderedCollection with: robert
]

{ #category : #tests }
GameTest >> testCanNotGetWinnerWhileGameIsRunning [
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
	self deny: game hasEnded.
	self
		should: [ game winner ]
		raise: Error
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: 'There is no winner yet. The game is not finished' ]
]

{ #category : #tests }
GameTest >> testGameCantBePlayedOnceItIsOver [
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
	game turnIsPlayed.
	self
		should: [ game turnIsPlayed ]
		raise: Error
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: 'Game is over. ' ]
]

{ #category : #tests }
GameTest >> testGameHasEnded [
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
	self deny: game hasEnded.
	game turnIsPlayed.
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGetWinnerOnceGameIsFinished [
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
	self deny: game hasEnded.
	game turnIsPlayed.
	self assert: game hasEnded.
	self assert: game winner name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testIsRobertTurn [
	| matt martin |
	matt := Player named: 'Matt'.
	martin := Player named: 'Martin'.
	players add: matt.
	players add: martin.
	game := Game playedBy: players withStepsToWin: 20 andUsing: dices.
	game turnIsPlayed.
	game turnIsPlayed.
	game turnIsPlayed.
	self assert: game currentPlayer name equals: 'Robert'
]

{ #category : #tests }
GameTest >> testPlayerGetsA4AndMoves3BecouseTheGameHas3StepsToWin [
	game := Game playedBy: players withStepsToWin: 3 andUsing: dices.
	game turnIsPlayed.
	self assert: robert position equals: 3
]

{ #category : #tests }
GameTest >> testPlayerMovesNineStepsWhenUsingTwoDices [
	| fiveFaceDummyDice |
	fiveFaceDummyDice := LoadedDice withFaces: 5 andValue: 5.
	dices add: fiveFaceDummyDice.
	game := Game playedBy: players withStepsToWin: 9 andUsing: dices.
	game turnIsPlayed.
	self assert: robert position equals: 9
]

{ #category : #tests }
GameTest >> testThatLuciaCanNotPlayBecouseGameHasEnded [
	| lucia |
	lucia := Player named: 'Lucia'.
	players add: lucia.
	game := Game playedBy: players withStepsToWin: 4 andUsing: dices.
	game turnIsPlayed.
	self
		should: [ game turnIsPlayed ]
		raise: Error
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Game is over. ' ]
]
