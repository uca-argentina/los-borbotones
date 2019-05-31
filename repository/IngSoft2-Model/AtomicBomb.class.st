"
Todos vuelven al principio. Probabilidad de aparición: 2%.
"
Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> affect: aPlayer on: aGame [
	aGame players
		do: [ :player | aGame changePositionOf: player toTile: 0 andLap: 0 ]
]
