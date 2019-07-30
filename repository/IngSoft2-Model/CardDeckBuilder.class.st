"
CardDeckBuilder
"
Class {
	#name : #CardDeckBuilder,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #building }
CardDeckBuilder >> buildCardDeck [
	self subclassResponsibility.
]
