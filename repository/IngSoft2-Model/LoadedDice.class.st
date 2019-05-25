"
""Dado con caras iguales""
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	numberOfFaces:		<Object>
	random:		<Object>


    Implementation Points
"
Class {
	#name : #LoadedDice,
	#superclass : #Dice,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'private-assertions' }
LoadedDice class >> assertValidNumberOfFaces: aNumberOfFaces [
	aNumberOfFaces > 3
		ifFalse: [ GameModelError signal:'Number of faces must be 4 or greater' ]
]

{ #category : #creation }
LoadedDice class >> withFaces: aNumberOfFaces andValue: aNumber [
	self assertValidNumberOfFaces: aNumberOfFaces.
	^ self new
		initializeWithFaces: aNumberOfFaces andValue: aNumber;
		yourself
]

{ #category : #initialize }
LoadedDice >> initializeWithFaces: aNumberOfFaces andValue: aNumber [
	value := aNumber
]

{ #category : #actions }
LoadedDice >> roll [
	^ value
]
