"
""soy un jugador""
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
	dice:		<Object>
	playerName:		<Object>


    Implementation Points
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'history'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Player class >> named: aName [
	^ self new
		initializeWithName: aName;
		yourself
]

{ #category : #status }
Player >> history [
	^ history.
]

{ #category : #initialize }
Player >> initializeWithName: aName [
	name := aName.
	history := LinkedList with: (Position tile: 0 andLap: 0).
]

{ #category : #actions }
Player >> lap [
	^ history last lap
]

{ #category : #accessing }
Player >> laps [
	^history last lap.
]

{ #category : #actions }
Player >> moveTo: tileNumber lap: lap [
	history add: (Position tile: tileNumber andLap: lap)
]

{ #category : #presentation }
Player >> name [
	^ name
]

{ #category : #actions }
Player >> position [
	^ history last tile.
]
