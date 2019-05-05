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

{ #category : #initialization }
Board >> initializeWithSteps: aNumberOfSteps [
	| prob cumulativeProbability |
	random := Random new.
	effects := Array
		with: (Effect named: 'MoonWalk' withProbability: 0.05)
		with: (Effect named: 'Atomic Bomb' withProbability: 0.02)
		with: (Effect named: 'SpeedUp' withProbability: 0.15)
		with: (Effect named: 'Time Machine' withProbability: 0.08)
		with: (Effect named: 'Empty' withProbability: 0.55)
		with: (Effect named: 'WormHole' withProbability: 0.15).
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
Board >> numberOfSteps [
	^ tiles size
]
