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
	| indices shuffledIndices previousBoundary subsetIndices subset |
	
	indices := (1 to: aCollection size) asOrderedCollection.
	shuffledIndices := self shuffle: indices.
	
	previousBoundary := 0.
	
	^ aCollectionOfBoundaries collect: [ :boundary |
		subsetIndices := shuffledIndices copyFrom: previousBoundary + 1 to: boundary.
		
		"This is not the most efficient solution because it will iterate through the collection K times where K is the number of subsets. But I can't think of anything better that would make sure that the original state of aCollection is preserved in its subsets (for example its class, keys, or rowNames - check out the RandomPartitionerDataFrameTest)"
		subset := aCollection withIndexSelect: [ :each :index |
			subsetIndices includes: index ].
		
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
