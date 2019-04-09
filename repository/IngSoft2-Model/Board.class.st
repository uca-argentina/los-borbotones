"
""Soy un tablero""
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
	numberOfPlayers:		<Object>
	numberOfStepsToWin:		<Object>
	stepsToWin:		<Object>


    Implementation Points
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'stepsToWin',
		'numberOfStepsToWin',
		'numberOfPlayers',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Board class >> WithStepsToWin: aNumberOfStepsToWin andPlayers: aNumberOfplayers [
	^ self new
		initializeWithStepsToWin: aNumberOfStepsToWin
			andPlayers: aNumberOfplayers;
		
		yourself
]

{ #category : #initialize }
Board >> initializeWithStepsToWin: aNumberOfStepsToWin andPlayers: aNumberOfPlayers [
	numberOfStepsToWin := aNumberOfStepsToWin .
	numberOfPlayers := aNumberOfPlayers .
	position := 0.
	
]

{ #category : #description }
Board >> players [
	^ numberOfPlayers 
]

{ #category : #description }
Board >> stepsToWin [
	^ numberOfStepsToWin 
]
