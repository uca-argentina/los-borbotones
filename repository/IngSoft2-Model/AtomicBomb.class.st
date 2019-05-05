Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
AtomicBomb class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #initialization }
AtomicBomb >> affect: players withCurrentPlayer: aPlayer andNumberOfTiles: aNumberOfTiles [
	players do: [ :player | player moveTo:0 lap:0 ].
]

{ #category : #initialization }
AtomicBomb >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
AtomicBomb >> probability [
	^probability
]
