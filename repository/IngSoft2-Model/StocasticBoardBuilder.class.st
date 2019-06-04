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
		new 
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
StocasticBoardBuilder >> selectEffectFrom: effectProbabilityPairs [
	| prob cumulativeProbability |
	^ [ :index | cumulativeProbability := 0.
	prob := random next.
	effectProbabilityPairs
		detect:
			[ :each | 
			cumulativeProbability := cumulativeProbability + each value.
			cumulativeProbability >= prob ] key ]
]

{ #category : #creation }
StocasticBoardBuilder >> withEffects: effectProbabilityPairs [
	tiles := OrderedCollection new.
	steps timesRepeat: [ tiles add: (self selectEffectFrom: effectProbabilityPairs)]
]
