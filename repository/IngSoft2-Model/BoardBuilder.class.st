"
Board builder.
"
Class {
	#name : #BoardBuilder,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#classVars : [
		'steps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoardBuilder class >> startBoardWithSteps: aStepsAmount [
	^self subclassResponsibility 
]

{ #category : #actions }
BoardBuilder >> buildBoard [
	^ self subclassResponsibility
]
