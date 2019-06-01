"
Permanent card.
"
Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #presentation }
PermanentCard >> isInstantCard [
	^false.
]

{ #category : #presentation }
PermanentCard >> isPermanentCard [
	^true
]
