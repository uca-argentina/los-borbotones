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
StocasticBoardBuilder class >> assertPositiveAmount: aStepsAmount [
	(aStepsAmount>0) ifFalse: [ GameModelError signal:'Steps amount must be a positive integer. ' ]
]

{ #category : #creation }
StocasticBoardBuilder class >> startBoardWithSteps: aStepsAmount [
	self assertPositiveAmount: aStepsAmount.
	^ self new initializeBoardWithSteps: aStepsAmount
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
	sum := (sum * 100) rounded / 100.
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
StocasticBoardBuilder >> selectEffectFrom: anEffectProbabilityPairsCollection [
	| prob cumulativeProbability |
	cumulativeProbability := 0.
	prob := random next.
	^(anEffectProbabilityPairsCollection
		detect:
			[ :each | 
			cumulativeProbability := cumulativeProbability + each value.
			cumulativeProbability >= prob ]) key 
]

{ #category : #creation }
StocasticBoardBuilder >> withEffects: anEffectProbabilityPairsSet [
	self assertValidProbabilitiesSumFor: anEffectProbabilityPairsSet.
	self assertProbabilitiesAreBetweenZeroAndOneFor: anEffectProbabilityPairsSet.
	tiles := OrderedCollection new.
	steps
		timesRepeat: [ tiles add: (self selectEffectFrom: anEffectProbabilityPairsSet) ]
]
