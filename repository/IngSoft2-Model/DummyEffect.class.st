"
This effect does nothing. For testing purposes only.
"
Class {
	#name : #DummyEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DummyEffect >> actOn: aGame [ 
	
]

{ #category : #presentation }
DummyEffect >> changesRollResult [
	^false
]
