"
LastTileEffectRepeat
"
Class {
	#name : #RepeatLastTileEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatLastTileEffect >> actOn: aGame affect: aPlayerName [
	| aPlayer |
	aPlayer := aGame selectPlayerNamed: aPlayerName.
	aGame repeatLastEffectTileOf: aPlayer
]
