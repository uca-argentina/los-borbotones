"
""soy un juego""

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


    Implementation Points
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'numberOfSteps',
		'status',
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> playedBy: aSetOfPlayers withStepsToWin: aStepsAmount [ 
	^ self new
		 initializeWithSteps: aStepsAmount andPlayers: aSetOfPlayers;
		 yourself.
]

{ #category : #status }
Game >> hasEnded [
	^ (status = 'ended').
]

{ #category : #status }
Game >> initializeWithSteps: aStepsAmount andPlayers: setOfPlayers [
	players := setOfPlayers.
	numberOfSteps := aStepsAmount.
	status := 'running'.
]

{ #category : #status }
Game >> status [
	^status.
]

{ #category : #status }
Game >> updateGameStatusWhenPlayerMovesTo: aPosition [
	(aPosition > numberOfSteps) ifTrue: [ status := 'ended'. ]
]

{ #category : #presentation }
Game >> winner [
	^ players detect: [ :player | player position > numberOfSteps ]
]
