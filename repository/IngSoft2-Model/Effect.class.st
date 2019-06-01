"
An effect.
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Effect >> affect: aPlayer on: aGame [
	^self subclassResponsibility.
]
