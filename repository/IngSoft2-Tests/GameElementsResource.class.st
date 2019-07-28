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
		andAction: (PermanentAction withEffect: accelerationCardEffect)
]

{ #category : #running }
GameElementsResource >> cancellationCard [
	^ RealCard
		named: 'Cancellation'
		andAction: (InstantAction withEffect: Cancellation new)
]

{ #category : #running }
GameElementsResource >> dummyInstantCard [
	^ RealCard
		named: 'Test'
		andAction: (InstantAction  withEffect: DummyEffect new)
]

{ #category : #running }
GameElementsResource >> dummyPermanentCard [
	^ RealCard
		named: 'Test'
		andAction: (PermanentAction withEffect: DummyEffect new)
]

{ #category : #running }
GameElementsResource >> isAvaliable [
	^true.
]

{ #category : #running }
GameElementsResource >> overloadCard [
	^ RealCard
		named: 'Overload'
		andAction: (PermanentAction withEffect: overloadCardEffect).
]

{ #category : #running }
GameElementsResource >> redoCard [
	^ RealCard
		named: 'Redo'
		andAction: (InstantAction withEffect: RedoLastCardEffect withNoExcecutedCard)
]

{ #category : #running }
GameElementsResource >> repeatCard [
	^ RealCard
		named: 'Repeat'
		andAction: (InstantAction withEffect: RepeatLastTileEffect new)
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
		andAction: (PermanentAction withEffect: speedCardEffect)
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
