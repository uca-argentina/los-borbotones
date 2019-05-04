"
I am a random dice.
"
Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'private-assertions' }
RandomDice class >> assertValidNumberOfFaces: aNumberOfFaces [
	aNumberOfFaces > 3
		ifFalse: [ self error: 'Number of faces must be greater than 3' ]
]

{ #category : #creation }
RandomDice class >> withFaces: aNumberOfFaces [
	self assertValidNumberOfFaces: aNumberOfFaces.
	^ self new
		initializeWithFaces: aNumberOfFaces;
		yourself
]

{ #category : #initialize }
RandomDice >> initializeWithFaces: aNumberOfFaces [
	numberOfFaces := aNumberOfFaces
]

{ #category : #actions }
RandomDice >> numberOfFaces [
	^ numberOfFaces
]

{ #category : #actions }
RandomDice >> roll [
	^ numberOfFaces atRandom
]
