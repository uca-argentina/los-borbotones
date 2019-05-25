"
Player tests.
"
Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAPlayeHasAHistoryOfHisMoves [
	| player |
	player := Player named: 'Robert'.
	player moveTo: 4 lap: 1.
	player moveTo: 5 lap: 2.
	player moveTo: 7 lap: 3.
	self
		assert:
			(player history
				anySatisfy: [ :aPosition | (aPosition tile) = 4 and: (aPosition lap = 1) ]).
	self
		assert:
			(player history
				anySatisfy: [ :aPosition | aPosition tile = 5 and: aPosition lap = 2 ]).
	self
		assert:
			(player history
				anySatisfy: [ :aPosition | aPosition tile = 7 and: aPosition lap = 3 ])
]

{ #category : #tests }
PlayerTest >> testAPlayerNamedRobertMovetoPositionNumberFour [
	| player |
	player := Player named: 'Robert'.
	player moveTo: 4 lap:1.
	self assert: player position equals: 4.
	self assert: player lap equals: 1.
]

{ #category : #tests }
PlayerTest >> testAPlayerNamedRobertWithInitialPositionAndLapsZero [
	| player |
	player := Player named: 'Robert'.
	self assert: player name equals: 'Robert'.
	self assert: player position equals: 0.
	self assert: player lap equals: 0.
]
