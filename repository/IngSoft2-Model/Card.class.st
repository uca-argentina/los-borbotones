"
A card.
"
Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Card >> actOn: aGame affect: aCollection by: anObject [ 
	^self subclassResponsibility.
]
