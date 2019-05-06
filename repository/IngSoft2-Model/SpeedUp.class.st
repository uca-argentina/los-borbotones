Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
SpeedUp class >> withProbability: aNumber [
	^ self new
		initializeWithProbability: aNumber;
		yourself
]

{ #category : #initialization }
SpeedUp >> affect: aGame [
	"| position lap |
	lap := (aPlayer laps + (aPlayer position + 4)) / aNumberOfTiles + 1.
	position := (aPlayer position + 4) % aNumberOfTiles + 1.
	aPlayer moveTo: position lap: lap"
]

{ #category : #initialization }
SpeedUp >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
SpeedUp >> probability [
	^probability
]
