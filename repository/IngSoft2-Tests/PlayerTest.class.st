"
Player tests.
"
Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAPlayerNamedRobertMovetoPositionNumberFour [
	| player |
	player := Player named: 'Robert'.
	player moveTo: 4.
	self assert: player position equals: 4
]

{ #category : #tests }
PlayerTest >> testAPlayerNamedRobertWithInitialPositionZero [
	| player |
	player := Player named: 'Robert'.
	self assert: player name equals: 'Robert'.
	self assert: player position equals: 0
]
