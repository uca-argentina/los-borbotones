Class {
	#name : #Effect,
	#superclass : #Object,
	#instVars : [
		'probability',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Effect >> affect: players withCurrentPlayer: aPlayer andNumberOfTiles: aNumberOfTiles [
	^self subclassResponsibility.
]
