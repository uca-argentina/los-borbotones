"
An instant card.
"
Class {
	#name : #InstantCard,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
InstantCard class >> withEffect: anEffect [
	^self new initializeWithEffect: anEffect
]

{ #category : #action }
InstantCard >> actOn: aGame affect: anObject [ 
	effect actOn: aGame affect: anObject.
	aGame setLastCard: self 
]

{ #category : #initialization }
InstantCard >> initializeWithEffect: aDummyEffect [ 
	effect := aDummyEffect 
]

{ #category : #presentation }
InstantCard >> isInstantCard [
	^true
]

{ #category : #presentation }
InstantCard >> isPermanentCard [
	^false
]

{ #category : #action }
InstantCard >> redoAffecting: anObject on: aGame [
	self actOn: aGame affect: anObject.
]
