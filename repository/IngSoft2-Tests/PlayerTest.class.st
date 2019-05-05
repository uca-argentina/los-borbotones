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
	player moveTo: 4 lap:1.
	self assert: player position equals: 4.
	self assert: player laps equals: 1.
]

{ #category : #tests }
PlayerTest >> testAPlayerNamedRobertWithInitialPositionAndLapsZero [
	| player |
	player := Player named: 'Robert'.
	self assert: player name equals: 'Robert'.
	self assert: player position equals: 0.
	self assert: player laps equals: 0.
]
