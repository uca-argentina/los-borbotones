"
RedoLastCardEffect
"
Class {
	#name : #RedoLastCardEffect,
	#superclass : #CardEffect,
	#instVars : [
		'executedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
RedoLastCardEffect class >> withNoExcecutedCard [
	^ self new
		initializeWithDummyCard
		yourself
]

{ #category : #action }
RedoLastCardEffect >> actOn: aGame affect: aPlayer [
	executedCard isDummyCard
		ifTrue: [ aGame lastCardPlayed redoAffecting: aPlayer on: aGame.
			executedCard := aGame lastCardPlayed ]
		ifFalse: [ executedCard redoAffecting: aPlayer on: aGame.
			executedCard := aGame lastCardPlayed ]
]

{ #category : #initialization }
RedoLastCardEffect >> initializeWithDummyCard [
	executedCard := DummyCard new
]
