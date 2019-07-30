"
Discard deck.
"
Class {
	#name : #DiscardDeck,
	#superclass : #CardDeck,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
DiscardDeck class >> emptyDeck [
	^self new initializeEmptyDeck.
]

{ #category : #adding }
DiscardDeck >> add: aCard [
	cards add: aCard
]

{ #category : #initialization }
DiscardDeck >> initializeEmptyDeck [
	cards := OrderedCollection new.
]

{ #category : #accessing }
DiscardDeck >> size [
	^ cards size.
]
