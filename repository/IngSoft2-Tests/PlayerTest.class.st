Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAPlayerCalledRobertWithInitialPositionZero [
	| player |
	player := Player called: 'Robert'.
	self assert: player name equals: 'Robert'.
	self assert: player position equals: 0
]

{ #category : #tests }
PlayerTest >> testInitialPositionOfRobertIsZero [
	| player |
	player := Player called: 'Robert'.
	self assert: player position equals: 0
]
