Class {
	#name : #GameElementsResource,
	#superclass : #TestResource,
	#instVars : [
		'game',
		'fourFaceDummyDice',
		'dices',
		'robert',
		'players',
		'moonWalkWithProbability',
		'atomicBombWithProbability',
		'speedUpWithProbability',
		'timeMachineWithProbability',
		'emptyWithProbability',
		'wormHoleWithProbability',
		'cardDealingTileWithProbability',
		'overloadCardEffect',
		'speedCardEffect',
		'accelerationCardEffect'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameElementsResource >> isAvaliable [
	^true.
]

{ #category : #running }
GameElementsResource >> setUp [
	super setUp.
	fourFaceDummyDice := LoadedDice withFaces: 4 andValue: 4.
	dices := OrderedCollection with: fourFaceDummyDice.
	robert := Player named: 'Robert'.
	players := OrderedCollection with: robert.
	moonWalkWithProbability := (MoonWalk withNumber: 5) -> 0.05.
	atomicBombWithProbability := AtomicBomb new -> 0.02.
	speedUpWithProbability := SpeedUp new -> 0.15.
	timeMachineWithProbability := TimeMachine new -> 0.08.
	emptyWithProbability := Empty new -> 0.45.
	wormHoleWithProbability := WormHole new -> 0.15.
	cardDealingTileWithProbability := CardDealingTile new -> 0.1.
	overloadCardEffect := ModifyDiceResult modifyResultBy: -2.
	speedCardEffect := ModifyDiceResult modifyResultBy: 1.
	accelerationCardEffect := ModifyDiceResultOfAllPlayers
		modifyResultBy: 1
]
