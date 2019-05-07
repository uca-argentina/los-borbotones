Class {
	#name : #Effect,
	#superclass : #Object,
	#instVars : [
		'probability',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Effect >> affect: aPlayer on: aGame [
	^self subclassResponsibility.
]
