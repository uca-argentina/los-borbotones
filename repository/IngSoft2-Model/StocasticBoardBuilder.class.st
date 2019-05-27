"
StocasticBoardBuilder.
	
"
Class {
	#name : #StocasticBoardBuilder,
	#superclass : #BoardBuilder,
	#instVars : [
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
StocasticBoardBuilder class >> startBoardWithSteps: aStepsAmount [
	^ self
		new;
		initializeBoardWithSteps: aStepsAmount
]

{ #category : #creation }
StocasticBoardBuilder >> buildBoard [
	^ Board withTiles: tiles
]

{ #category : #initialize }
StocasticBoardBuilder >> initializeBoardWithSteps: aStepsAmount [
	steps := aStepsAmount.
	random := Random new
]

{ #category : #creation }
StocasticBoardBuilder >> withEffects: effectProbabilityPair [
	| cumulativeProbability prob |
	tiles := (1 to: steps)
		collect: [ :index | 
			cumulativeProbability := 0.
			prob := random next.
			effectProbabilityPair
				detect:
					[ :each | 
					cumulativeProbability := cumulativeProbability + each value.
					cumulativeProbability >= prob ] key ]
]
