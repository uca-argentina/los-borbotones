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
GameElementsResource >> doubleCard [
	^ RealCard
		named: 'Double'
		withAction: (InstantAction   withEffect: DoubleEffect  new)
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
GameElementsResource >> reverseCard [
	^ RealCard
		named: 'Reverse'
		withAction: (InstantAction   withEffect: ReverseEffect  new)
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
GameElementsResource >> skipCard [
	^ RealCard
		named: 'Skip'
		withAction: (InstantAction   withEffect: SkipEffect  new)
]

{ #category : #running }
GameElementsResource >> speedCard [
	^ RealCard
		named: 'Speed'
		withAction: (PermanentAction withEffect: speedCardEffect)
]

{ #category : #running }
GameElementsResource >> stocasticCardDeck [
	| cards redo overload speed acceleration cancellation repeat |
	overload := self overloadCard.
	speed := self speedCard.
	acceleration := self accelerationCard.
	redo := self redoCard.
	cancellation := self cancellationCard.
	repeat := self repeatCard.
	
	cards := OrderedCollection
		with: overload
		with: speed
		with: redo
		with: acceleration
		with: repeat
		with: cancellation.
	^ CardDeck withCards: cards
]
