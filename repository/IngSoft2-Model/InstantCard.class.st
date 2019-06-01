"
An instant card.
"
Class {
	#name : #InstantCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #presentation }
InstantCard >> isInstantCard [
	^true
]

{ #category : #presentation }
InstantCard >> isPermanentCard [
	^false
]
