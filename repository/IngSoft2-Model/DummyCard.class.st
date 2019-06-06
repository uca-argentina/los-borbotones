"
This is a dummy card. Not the real thing.
"
Class {
	#name : #DummyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DummyCard >> actOn: aGame affect: aCollection [ 

]

{ #category : #presentation }
DummyCard >> isDummyCard [
	^ true
]

{ #category : #action }
DummyCard >> redoAffecting: anObject on: aGame [
]
