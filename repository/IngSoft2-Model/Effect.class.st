Class {
	#name : #Effect,
	#superclass : #Object,
	#instVars : [
		'probability',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Effect class >> named: aName withProbability: aNumber [
	^ self new
		initializeWithName: aName andProbability: aNumber;
		yourself
]

{ #category : #initialization }
Effect >> initializeWithName: aName andProbability: aNumber [
	name := aName.
	probability := aNumber.
]

{ #category : #accessing }
Effect >> probability [
	^probability
]
