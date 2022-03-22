"
This is a Pharo library for partitioning a collection. Given a set of K proportions, for example 50%, 30%, and 20%, it shuffles the collection and divides it into K non-empty subsets in such a way that every element is included in exactly one subset.

RandomPartitioner can be used in machine learning and statistical analysis for splitting the data into training, validation, and test (a.k.a. holdout) sets, or partitioning the data for cross-validation.

How to use it:

```
letters := #(a b c d e f g h i j).

partitioner := RandomPartitioner new.
subsets := partitioner split: letters withProportions: #(0.5 0.3 0.2).
""#((d h j a b)
  (i f e)
  (g c))""
```
"
Class {
	#name : #AIRandomPartitioner,
	#superclass : #Object,
	#category : #'AI-RandomPartitioner'
}

{ #category : #accessing }
AIRandomPartitioner >> shuffle: aCollection [

	"Default method of shuffling the elements of collection. You can override it if you need to use a different shuffling algorithm"

	^ aCollection shuffle
]

{ #category : #accessing }
AIRandomPartitioner >> shuffle: aCollection seed: aNumber [

	"Default method of shuffling the elements of collection. You can override it if you need to use a different shuffling algorithm"

	^ aCollection shuffleWithSeed: aNumber
]

{ #category : #private }
AIRandomPartitioner >> split: aCollection withBoundaries: aCollectionOfBoundaries [
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

{ #category : #private }
AIRandomPartitioner >> split: aCollection withBoundaries: aCollectionOfBoundaries seed: aNumber [
	| indices shuffledIndices previousBoundary subsetIndices subset |
	
	indices := (1 to: aCollection size) asOrderedCollection.
	shuffledIndices := self shuffle: indices seed: aNumber.
	
	previousBoundary := 0.
	
	^ aCollectionOfBoundaries collect: [ :boundary |
		subsetIndices := shuffledIndices copyFrom: previousBoundary + 1 to: boundary.
		
		"This is not the most efficient solution because it will iterate through the collection K times where K is the number of subsets. But I can't think of anything better that would make sure that the original state of aCollection is preserved in its subsets (for example its class, keys, or rowNames - check out the RandomPartitionerDataFrameTest)"
		subset := aCollection withIndexSelect: [ :each :index |
			subsetIndices includes: index ].
		
		previousBoundary := boundary.
		subset ].
]

{ #category : #api }
AIRandomPartitioner >> split: aCollection withProportions: aCollectionOfProportions [

	| cumulativeProportions boundaries |

	(aCollectionOfProportions sum closeTo: 1) ifFalse: [ 
		Error signal: 'The proportions must sum up to 1' ].

	cumulativeProportions := aCollectionOfProportions cumulativeSum.
	boundaries := cumulativeProportions * aCollection size collect: #floor.

	^ self split: aCollection withBoundaries: boundaries
]

{ #category : #api }
AIRandomPartitioner >> split: aCollection withProportions: aCollectionOfProportions seed: aNumber [

	"If you want to use a fixed seed for the random numbers generator for have reproducibility"

	| cumulativeProportions boundaries |
	
	(aCollectionOfProportions sum closeTo: 1) ifFalse: [ 
		Error signal: 'The proportions must sum up to 1' ].

	cumulativeProportions := aCollectionOfProportions cumulativeSum.
	boundaries := cumulativeProportions * aCollection size collect: #floor.

	^ self split: aCollection withBoundaries: boundaries seed: aNumber
]

{ #category : #api }
AIRandomPartitioner >> split: aCollection withSizes: aCollectionOfSizes [

	| boundaries |
	
	aCollectionOfSizes sum = aCollection size ifFalse: [ 
		Error signal: 'The sizes must sum up to the size of collection' ].

	boundaries := aCollectionOfSizes cumulativeSum.
	^ self split: aCollection withBoundaries: boundaries
]