"
Resource para tests
"
Class {
	#name : #GameElementsResource,
	#superclass : #TestResource,
	#classVars : [
		'accelerationCardEffect',
		'overloadCardEffect',
		'speedCardEffect'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameElementsResource >> accelerationCard [
	^ RealCard
		named: 'Acceleration'
		withAction: (PermanentAction withEffect: accelerationCardEffect)
]

{ #category : #running }
GameElementsResource >> cancellationCard [
	^ RealCard
		named: 'Cancellation'
		withAction: (InstantAction withEffect: Cancellation new)
]

{ #category : #running }
GameElementsResource >> dummyInstantCard [
	^ RealCard
		named: 'Test'
		withAction: (InstantAction  withEffect: DummyEffect new)
]

{ #category : #running }
GameElementsResource >> dummyPermanentCard [
	^ RealCard
		named: 'Test'
		withAction: (PermanentAction withEffect: DummyEffect new)
]

{ #category : #running }
GameElementsResource >> isAvaliable [
	^true.
]

{ #category : #running }
GameElementsResource >> overloadCard [
	^ RealCard
		named: 'Overload'
		withAction: (PermanentAction withEffect: overloadCardEffect).
]

{ #category : #running }
GameElementsResource >> redoCard [
	^ RealCard
		named: 'Redo'
		withAction: (InstantAction withEffect: RedoLastCardEffect withNoExcecutedCard)
]

{ #category : #running }
GameElementsResource >> repeatCard [
	^ RealCard
		named: 'Repeat'
		withAction: (InstantAction withEffect: RepeatLastTileEffect new)
]

{ #category : #running }
GameElementsResource >> setUp [
	super setUp.
	
	overloadCardEffect := ModifyDiceResult modifyResultBy: -2.
	speedCardEffect := ModifyDiceResult modifyResultBy: 1.
	accelerationCardEffect := ModifyDiceResultOfAllPlayers
		modifyResultBy: 1
]

{ #category : #running }
GameElementsResource >> speedCard [
	^ RealCard
		named: 'Speed'
		withAction: (PermanentAction withEffect: speedCardEffect)
]

{ #category : #running }
GameElementsResource >> stocasticCardDeck [
	| cardsWithProbabilities redo overload speed acceleration cancellation repeat |
	overload := self overloadCard.
	speed := self speedCard.
	acceleration := self accelerationCard.
	redo := self redoCard.
	cancellation := self cancellationCard.
	repeat := self repeatCard.
	
	cardsWithProbabilities := OrderedCollection
		with: overload -> 0.1
		with: speed -> 0.2
		with: redo -> 0.3
		with: acceleration -> 0.1
		with: repeat -> 0.1
		with: cancellation -> 0.2.
	^ ((StocasticPlayingCardDeckBuilder startWithCardsAmount: 30) withCardsFrom: cardsWithProbabilities) buildCardDeck
]
