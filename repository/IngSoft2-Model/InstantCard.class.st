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
InstantCard >> actOn: aGame [ 
	^effect actOn: aGame
]

{ #category : #action }
InstantCard >> actOn: aGame affect: anObject [ 
	effect actOn: aGame affect: anObject  
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
