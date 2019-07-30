"
This is a dummy card. Not the real thing.
"
Class {
	#name : #DummyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DummyCard >> actOn: aGame affect: aCollection by: aPlayer [
	"Does nothing." 
	aGame lastCardPlayed actOn: aGame affect: aCollection by: aPlayer

]
