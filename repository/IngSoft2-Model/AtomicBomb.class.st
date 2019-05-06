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
AtomicBomb >> affect: aGame [
	aGame players do: [ :player | player moveTo:1 lap:0 ].
]

{ #category : #initialization }
AtomicBomb >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
AtomicBomb >> probability [
	^probability
]
