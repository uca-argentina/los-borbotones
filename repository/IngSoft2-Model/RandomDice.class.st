"
I am a random dice.
"
Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
RandomDice class >> assertValidThatADiceHas3OrMoreFaces: aNumberOfFaces [
	aNumberOfFaces > 3
		ifFalse: [ self error: 'Number of faces must be 4 or greater' ]
]

{ #category : #creation }
RandomDice class >> withFaces: aNumberOfFaces [
	self assertValidThatADiceHas3OrMoreFaces: aNumberOfFaces.
	^ self new
		initializeWithFaces: aNumberOfFaces;
		yourself
]

{ #category : #initialize }
RandomDice >> initializeWithFaces: aNumberOfFaces [
	numberOfFaces := aNumberOfFaces.
]

{ #category : #actions }
RandomDice >> roll [
	^ numberOfFaces atRandom 
]
