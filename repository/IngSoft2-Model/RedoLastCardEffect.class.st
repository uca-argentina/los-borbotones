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
RedoLastCardEffect >> actOn: aGame affect: aSetOfPlayers by: aPlayer [
	executedCard actOn: aGame affect: aPlayer by: aPlayer.
	executedCard := aGame lastCardPlayed
]

{ #category : #initialization }
RedoLastCardEffect >> initializeWithDummyCard [
	executedCard := DummyCard new
]
