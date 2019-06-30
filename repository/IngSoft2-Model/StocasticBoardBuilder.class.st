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

{ #category : #'private - assertions' }
StocasticBoardBuilder >> assertProbabilitiesAreBetweenZeroAndOneFor: aDictionaryOfPairs [
	(aDictionaryOfPairs anySatisfy: [ :pair | pair value > 1 or: pair value < 0 ])
	ifTrue: [ GameModelError signal: 'Probabilities must be between 0 and 1.' ]
]

{ #category : #'private - assertions' }
StocasticBoardBuilder >> assertValidProbabilitiesSumFor: aDictionaryOfPairs [
	| sum |
	sum := aDictionaryOfPairs sum: #value.
	sum ~= 1 ifTrue: [ GameModelError signal: 'Sum of probabilities must be equal to 1.' ].
	
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
	self assertValidProbabilitiesSumFor: effectProbabilityPairs.
	self assertProbabilitiesAreBetweenZeroAndOneFor: effectProbabilityPairs.
	tiles := OrderedCollection new.
	steps
		timesRepeat: [ tiles add: (self selectEffectFrom: effectProbabilityPairs) ]
]
