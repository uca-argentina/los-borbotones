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

{ #category : #'as yet unclassified' }
BoardBuilder >> buildBoard [
	^self subclassResponsibility 
]
