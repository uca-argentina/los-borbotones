"
Board game.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'effects',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Board class >> withSteps: aNumberOfSteps [
	^ self new
		initializeWithSteps: aNumberOfSteps;
		yourself
]

{ #category : #creation }
Board class >> withSteps: aNumberOfSteps andEffects: anArrayOfEffects [
	^ self new
		initializeWithSteps: aNumberOfSteps andEffects: anArrayOfEffects ;
		yourself
]

{ #category : #accessing }
Board >> effectAt: aPosition [
	^ tiles at:aPosition + 1.
]

{ #category : #initialization }
Board >> initializeWithSteps: aNumberOfSteps [
	| prob cumulativeProbability |
	random := Random new.
	effects := Array
		with: (MoonWalk withProbability: 0.05)
		with: (AtomicBomb withProbability: 0.02)
		with: (SpeedUp withProbability: 0.15)
		with: (TimeMachine withProbability: 0.08)
		with: (Empty withProbability: 0.55)
		with: (WormHole withProbability: 0.15).
		
	tiles := (1 to: aNumberOfSteps)
		collect: [ :index | 
			cumulativeProbability := 0.
			prob := random next.
			effects
				detect: [ :each | 
					cumulativeProbability := cumulativeProbability + each probability.
					cumulativeProbability >= prob ] ]
]

{ #category : #initialization }
Board >> initializeWithSteps: aNumberOfSteps andEffects: anArrayOfEffects [
	| prob cumulativeProbability |
	random := Random new.
	effects := anArrayOfEffects.
		
	tiles := (1 to: aNumberOfSteps)
		collect: [ :index | 
			cumulativeProbability := 0.
			prob := random next.
			effects
				detect: [ :each | 
					cumulativeProbability := cumulativeProbability + each probability.
					cumulativeProbability >= prob ] ]
]

{ #category : #accessing }
Board >> numberOfTiles [
	^ tiles size
]
