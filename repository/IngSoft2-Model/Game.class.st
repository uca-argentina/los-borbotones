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
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> withStepsToWin: aStepsAmount [ 
	^ self new
		 initializeWithSteps: aStepsAmount;
		 yourself.
]

{ #category : #playing }
Game >> goFrom: currentStep to: someOtherStep [
	|sum|
	sum := currentStep + someOtherStep.
	
	^ (sum < board stepsToWin)	ifTrue: [ ^sum ]; ifFalse: [ ^board stepsToWin ].

]

{ #category : #status }
Game >> initializeWithSteps: aStepsAmount [
	board := Board withStepsToWin: aStepsAmount.
]

{ #category : #status }
Game >> status [
	^'running'.
]
