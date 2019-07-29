"
LastTileEffectRepeat
"
Class {
	#name : #RepeatLastTileEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatLastTileEffect >> actOn: aGame affect: aPlayerName by: aPlayer [
	| player |
	player := aGame selectPlayerNamed: aPlayerName.
	aGame repeatLastEffectTileOf: player
]
