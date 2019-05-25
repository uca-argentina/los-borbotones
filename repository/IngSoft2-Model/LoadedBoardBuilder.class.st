Class {
	#name : #LoadedBoardBuilder,
	#superclass : #BoardBuilder,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LoadedBoardBuilder class >> startBoardWithSteps: aStepsAmount [
	^self new initializeBoardWithSteps: aStepsAmount
	
]

{ #category : #creation }
LoadedBoardBuilder >> buildBoard [
	^Board withTiles: tiles
]

{ #category : #creation }
LoadedBoardBuilder >> initializeBoardWithSteps: aStepsAmount [
	steps := aStepsAmount
]

{ #category : #creation }
LoadedBoardBuilder >> withEffectProbabilityAssociation: anEffectProbabilityAssociation [
	 tiles := (1 to: steps) collect: [ :index | anEffectProbabilityAssociation key]
]
