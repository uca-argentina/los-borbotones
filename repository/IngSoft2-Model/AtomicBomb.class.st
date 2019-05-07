"
Todos vuelven al principio. Probabilidad de aparición: 2%.
"
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
AtomicBomb >> affect: aPlayer on: aGame [
	aGame players do: [ :player | player moveTo:0 lap:0 ].
]

{ #category : #initialization }
AtomicBomb >> initializeWithProbability: aNumber [
	probability := aNumber.
]

{ #category : #accessing }
AtomicBomb >> probability [
	^probability
]
