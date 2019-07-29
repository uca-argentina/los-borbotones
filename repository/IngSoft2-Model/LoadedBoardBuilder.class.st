"
LoadedBoardBuilder.
	
"
Class {
	#name : #LoadedBoardBuilder,
	#superclass : #BoardBuilder,
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LoadedBoardBuilder class >> assertPositiveAmount: aStepsAmount [
	(aStepsAmount>0) ifFalse: [ GameModelError signal:'Steps amount must be a positive integer. ' ]
]

{ #category : #creation }
LoadedBoardBuilder class >> startBoardWithSteps: aStepsAmount [
	self assertPositiveAmount: aStepsAmount.
	^ self new initializeBoardWithSteps: aStepsAmount
]

{ #category : #creation }
LoadedBoardBuilder >> buildBoard [
	^ Board withTiles: tiles
]

{ #category : #initialize }
LoadedBoardBuilder >> initializeBoardWithSteps: aStepsAmount [
	steps := aStepsAmount
]

{ #category : #creation }
LoadedBoardBuilder >> withEffectProbabilityAssociation: anEffectProbabilityAssociation [
	tiles := (1 to: steps)
		collect: [ :index | anEffectProbabilityAssociation key ]
]
