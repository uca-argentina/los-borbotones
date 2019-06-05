"
RedoLastCardEffect
"
Class {
	#name : #RedoLastCardEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoLastCardEffect >> actOn: aGame affect: aPlayer [ 
	aGame lastCardPlayed redoAffecting: aPlayer on: aGame.
]
