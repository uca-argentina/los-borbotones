"
This effect does nothing. For testing purposes only.
"
Class {
	#name : #DummyEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DummyEffect >> actOn: aGame affect: aSetOfPlayer by: aPlayer [ 
]

{ #category : #action }
DummyEffect >> appliesTo: aPlayer [
	^ true
]

{ #category : #presentation }
DummyEffect >> changesRollResult [
	^false
]

{ #category : #presentation }
DummyEffect >> quantity [
 ^0

]
