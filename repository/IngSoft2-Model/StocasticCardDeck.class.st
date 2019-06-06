"
A deck of cards.
"
Class {
	#name : #StocasticCardDeck,
	#superclass : #CardDeck,
	#instVars : [
		'random',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
StocasticCardDeck class >> randomDeck [
	^ self new initializeRandomCardDeck.
]

{ #category : #cards }
StocasticCardDeck >> accelerationCard [
	^ PermanentCard
		named: 'Acceleration'
		withEffect: (ModifyDiceResultOfAllPlayers modifyResultBy: 2)
]

{ #category : #actions }
StocasticCardDeck >> dealACard [
	^self dealCards: 1.
]

{ #category : #actions }
StocasticCardDeck >> dealCards: anAmountOfCards [
	| cardsToBeDelt |
	cardsToBeDelt := OrderedCollection new.
	anAmountOfCards timesRepeat: [ cardsToBeDelt add: cards atRandom ].
	^cardsToBeDelt
]

{ #category : #initialize }
StocasticCardDeck >> initializeRandomCardDeck [
	| overload speed acceleration cancelation redo repeat |
	overload := self overloadCard.
	speed := self speedCard.
	acceleration := self accelerationCard.
	cancelation := Cancellation new.
	redo := RedoLastCardEffect new.
	repeat := RepeatLastTileEffect new.
	random := Random new.
	cards := OrderedCollection with: overload with: speed with: acceleration with: cancelation with: redo
	 with: repeat.
]

{ #category : #cards }
StocasticCardDeck >> overloadCard [
	^ PermanentCard
		named: 'Overload'
		withEffect: (ModifyDiceResult modifyResultBy: -1)
]

{ #category : #cards }
StocasticCardDeck >> speedCard [
	^ PermanentCard
		named: 'Speed'
		withEffect: (ModifyDiceResult modifyResultBy: 1)
]
