Class {
	#name : #RandomPartitioner,
	#superclass : #Object,
	#category : #RandomPartitioner
}

{ #category : #'as yet unclassified' }
RandomPartitioner >> shuffle: aCollection [ 
	"Default method of shuffling the elements of collection. You can override it if you need to use a different shuffling algorithm"
	^ aCollection shuffle
]

{ #category : #'as yet unclassified' }
RandomPartitioner >> split: aCollection withBoundaries: aCollectionOfBoundaries [
	| indices shuffledIndices previousBoundary subset |
	
	indices := (1 to: aCollection size) asOrderedCollection.
	shuffledIndices := self shuffle: indices.
	
	previousBoundary := 0.
	
	^ aCollectionOfBoundaries collect: [ :boundary |
		subset := (previousBoundary + 1 to: boundary) collect: [ :i |
			aCollection at: (shuffledIndices at: i) ].
		
		previousBoundary := boundary.
		subset ].
]

{ #category : #'as yet unclassified' }
RandomPartitioner >> split: aCollection withProportions: aCollectionOfProportions [
	| cumulativeProportions boundaries |

	(aCollectionOfProportions sum closeTo: 1) ifFalse: [ 
		Error signal: 'The proportions must sum up to 1' ].
	
	cumulativeProportions := aCollectionOfProportions cumulativeSum.
	boundaries := (cumulativeProportions * aCollection size) collect: #floor.
	
	^ self split: aCollection withBoundaries: boundaries
]

{ #category : #'as yet unclassified' }
RandomPartitioner >> split: aCollection withSizes: aCollectionOfSizes [
	| boundaries |

	(aCollectionOfSizes sum = aCollection size) ifFalse: [ 
		Error signal: 'The sizes must sum up to the size of collection' ].
	
	boundaries := aCollectionOfSizes cumulativeSum.
	^ self split: aCollection withBoundaries: boundaries
]
