Class {
	#name : #StocasticBoardBuilder,
	#superclass : #BoardBuilder,
	#instVars : [
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
StocasticBoardBuilder class >> startBoardWithSteps: aStepsAmount [
	^self new; initializeBoardWithSteps: aStepsAmount
]

{ #category : #'as yet unclassified' }
StocasticBoardBuilder >> buildBoard [
	^Board withTiles: tiles
]

{ #category : #'as yet unclassified' }
StocasticBoardBuilder >> initializeBoardWithSteps: aStepsAmount [
	steps := aStepsAmount.
	random := Random new.
	
]

{ #category : #'as yet unclassified' }
StocasticBoardBuilder >> withEffects: effectProbabilityPair [  
 	| cumulativeProbability prob|
	tiles := (1 to: steps)
		collect: [ :index | 
			cumulativeProbability := 0.
			prob := random next.
			effectProbabilityPair
				detect: [ :each | 
					cumulativeProbability := cumulativeProbability + each value.
					cumulativeProbability >= prob ] key ]
]
