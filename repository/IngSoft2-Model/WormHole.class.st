Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
WormHole class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #initialization }
WormHole >> affect: aGame [
	"| position lap |
	lap := (aPlayer laps + (aPlayer position - 4)) / aNumberOfTiles floor.
	position := (aPlayer position - 4) % aNumberOfTiles floor.
	aPlayer moveTo: position lap: lap"
]

{ #category : #accessing }
WormHole >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
WormHole >> probability [
	^probability
]
