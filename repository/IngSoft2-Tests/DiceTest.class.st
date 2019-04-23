"
Dice tests.
"
Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testDiceCantHaveLessThanFourFaces [
	self should: [ RandomDice withFaces: 3 ] raise: Error.
	self should: [ RandomDice withFaces: 0 ] raise: Error.
	self should: [ RandomDice withFaces: -1 ] raise: Error
]

{ #category : #tests }
DiceTest >> testDiceRollsAndReturnsAValidNumber [
	| fourFacesDice rollingResult |
	fourFacesDice := RandomDice withFaces: 4.
	rollingResult := fourFacesDice roll.
	self assert: (rollingResult >= 1 and: rollingResult <= 4)
]

{ #category : #tests }
DiceTest >> testFourFaceDiceHasFourFaces [
	| fourFaceDice |
	fourFaceDice := RandomDice withFaces: 4.
	self assert: fourFaceDice numberOfFaces equals: 4
]
