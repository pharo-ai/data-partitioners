"
This is a Pharo library for partitioning a collection. Given a set of K proportions, for example 50%, 30%, and 20%, it shuffles the collection and divides it into K non-empty subsets in such a way that every element is included in exactly one subset.

RandomPartitioner can be used in machine learning and statistical analysis for splitting the data into training, validation, and test (a.k.a. holdout) sets, or partitioning the data for cross-validation.

How to use it:

```st
letters := #(a b c d e f g h i j).

subsets := AIRandomPartitioner split: letters withProportions: #(0.5 0.3 0.2).
""#((d h j a b)
  (i f e)
  (g c))""
```
"
Class {
	#name : 'AIRandomPartitioner',
	#superclass : 'Object',
	#category : 'AI-DataPartitioners',
	#package : 'AI-DataPartitioners'
}

{ #category : 'api' }
AIRandomPartitioner class >> split: aCollection withBoundaries: aCollectionOfBoundaries [

	^ self new split: aCollection withBoundaries: aCollectionOfBoundaries
]

{ #category : 'api' }
AIRandomPartitioner class >> split: aCollection withBoundaries: aCollectionOfBoundaries seed: aNumber [

	^ self new split: aCollection withBoundaries: aCollectionOfBoundaries seed: aNumber
]

{ #category : 'api' }
AIRandomPartitioner class >> split: aCollection withProportions: aCollectionOfProportions [

	^ self new split: aCollection withProportions: aCollectionOfProportions
]

{ #category : 'api' }
AIRandomPartitioner class >> split: aCollection withProportions: aCollectionOfProportions seed: aNumber [

	^ self new split: aCollection withProportions: aCollectionOfProportions seed: aNumber
]

{ #category : 'api' }
AIRandomPartitioner class >> split: aCollection withProportions: aCollectionOfProportions shuffle: aBoolean [
	"Split aCollection into multiple sets. The sets to split are determined by the size of aCollectionOfProportions, which looks like #(0.7 0.3), and commonly it represents splitting between a training and test set."

	^ self new 
		split: aCollection 
		withProportions: aCollectionOfProportions 
		shuffle: aBoolean
]

{ #category : 'api' }
AIRandomPartitioner class >> split: aCollection withSizes: aCollectionOfSizes [

	^ self new split: aCollection withSizes: aCollectionOfSizes
]

{ #category : 'accessing' }
AIRandomPartitioner >> shuffle: aCollection [

	"Default method of shuffling the elements of collection. You can override it if you need to use a different shuffling algorithm"

	^ aCollection shuffled
]

{ #category : 'accessing' }
AIRandomPartitioner >> shuffle: aCollection seed: aNumber [
	"Default method of shuffling the elements of collection. You can override it if you need to use a different shuffling algorithm"

	aNumber ifNil: [ ^ self shuffle: aCollection ].

	^ aCollection shuffleWithSeed: aNumber
]

{ #category : 'private' }
AIRandomPartitioner >> split: aCollection withBoundaries: aCollectionOfBoundaries [

	^ self split: aCollection withBoundaries: aCollectionOfBoundaries seed: nil
]

{ #category : 'private' }
AIRandomPartitioner >> split: aCollection withBoundaries: aCollectionOfBoundaries seed: aNumber [

	| shuffledIndices previousBoundary |
	shuffledIndices := self shuffle: (1 to: aCollection size) asArray seed: aNumber.

	previousBoundary := 0.

	^ aCollectionOfBoundaries collect: [ :max |
		  | res |
		  res := aCollection atAll: (shuffledIndices copyFrom: previousBoundary + 1 to: max).
		  previousBoundary := max.
		  res ]
]

{ #category : 'api' }
AIRandomPartitioner >> split: aCollection withProportions: aCollectionOfProportions [

	^ self split: aCollection withProportions: aCollectionOfProportions seed: nil
]

{ #category : 'api' }
AIRandomPartitioner >> split: aCollection withProportions: aCollectionOfProportions seed: aNumber [
	"If you want to use a fixed seed for the random numbers generator for have reproducibility"

	| cumulativeProportions boundaries |
	(aCollectionOfProportions sum closeTo: 1) ifFalse: [ Error signal: 'The proportions must sum up to 1' ].

	cumulativeProportions := aCollectionOfProportions cumulativeSum.
	boundaries := cumulativeProportions * aCollection size collect: #floor.

	^ self split: aCollection withBoundaries: boundaries seed: aNumber
]

{ #category : 'api' }
AIRandomPartitioner >> split: aCollection withProportions: aCollectionOfProportions shuffle: aBoolean [
	"See class side comment."

	| targetCollection |
	
	targetCollection := aBoolean 
		ifTrue: [ self shuffle: aCollection ]
		ifFalse: [ aCollection ].
	^ self split: targetCollection withProportions: aCollectionOfProportions seed: nil
]

{ #category : 'api' }
AIRandomPartitioner >> split: aCollection withSizes: aCollectionOfSizes [

	| boundaries |
	aCollectionOfSizes sum = aCollection size ifFalse: [ Error signal: 'The sizes must sum up to the size of collection' ].

	boundaries := aCollectionOfSizes cumulativeSum.
	^ self split: aCollection withBoundaries: boundaries
]
