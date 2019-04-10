"
""soy un dado""
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
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Dice class >> assertValidFaces: aNumberOfFaces [
	aNumberOfFaces > 3
		ifFalse: [ self error: 'Number of faces must be 4 or greater' ]
]

{ #category : #creation }
Dice class >> withFaces: aNumberOfFaces [
	self assertValidFaces: aNumberOfFaces.
	^ self new
		initializeWithFaces: aNumberOfFaces;
		yourself
]

{ #category : #initialize }
Dice >> initializeWithFaces: aNumberOfFaces [
	numberOfFaces := aNumberOfFaces.
	random := Random new
]

{ #category : #actions }
Dice >> numberOfFaces [
	^ numberOfFaces
]

{ #category : #actions }
Dice >> roll [
	^ (random next * numberOfFaces) floor + 1
]
