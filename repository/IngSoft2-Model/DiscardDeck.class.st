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

{ #category : #actions }
DiscardDeck >> addCard: aCard [
	cards add: aCard
]

{ #category : #initialization }
DiscardDeck >> initializeEmptyDeck [
	cards := OrderedCollection new.
]

{ #category : #actions }
DiscardDeck >> shuffleAndEmpty [
	| shuffledDeck randomCard |
	shuffledDeck := OrderedCollection new.
	cards size
		timesRepeat: [ randomCard := cards atRandom.
			shuffledDeck add: randomCard.
			cards remove: randomCard ].
	^shuffledDeck.
]

{ #category : #accessing }
DiscardDeck >> size [
	^ cards size.
]
