"
Abstract cardDeck.
"
Class {
	#name : #CardDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
CardDeck >> size [
	^cards size.
]
