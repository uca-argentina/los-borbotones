"
Dice tests.
"
Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> should: aBlock raise: anError withErrorMessage: aMessage [
	self should: aBlock
		raise: anError
		withExceptionDo: [ :signal | 
			self
				assert: signal messageText
				equals: aMessage ]
]

{ #category : #tests }
DiceTest >> should: aBlock raiseGameErrorWithMessage: aMessage [
	self should: aBlock
		raise: GameModelError 
		withErrorMessage: aMessage.
]

{ #category : #tests }
DiceTest >> testDiceCantHaveLessThanFourFaces [
	self
		should: [ RandomDice withFaces: 3 ]
		raiseGameErrorWithMessage: 'Number of faces must be greater than 3'.
	self
		should: [ RandomDice withFaces: 0 ]
		raiseGameErrorWithMessage: 'Number of faces must be greater than 3'.
	self
		should: [ RandomDice withFaces: -1 ]
		raiseGameErrorWithMessage: 'Number of faces must be greater than 3'.
]

{ #category : #tests }
DiceTest >> testDiceRollsAndReturnsAValidNumber [
	| fourFacesDice rollingResult |
	fourFacesDice := RandomDice withFaces: 4.
	rollingResult := fourFacesDice roll.
	self assert: (rollingResult between: 1 and: 4)
]

{ #category : #tests }
DiceTest >> testFourFaceDiceHasFourFaces [
	| fourFaceDice |
	fourFaceDice := RandomDice withFaces: 4.
	self assert: fourFaceDice numberOfFaces equals: 4
]
