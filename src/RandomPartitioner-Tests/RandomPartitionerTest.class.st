Class {
	#name : #RandomPartitionerTest,
	#superclass : #TestCase,
	#category : #'RandomPartitioner-Tests'
}

{ #category : #tests }
RandomPartitionerTest >> testSplitDataWithProportionsCase1 [
	| data proportions expectedSizes partitioner subsets subsetsSizes |
	
	data := #(a b c d e f g h i j).
	proportions := #(0.5 0.15 0.15 0.2).
	expectedSizes := #(5 1 2 2).
	
	partitioner := RandomPartitioner new.
	subsets := partitioner split: data withProportions: proportions.
	subsetsSizes := subsets collect: #size.
	
	self assert: subsets size equals: 4.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: expectedSizes.
]

{ #category : #tests }
RandomPartitionerTest >> testSplitDataWithProportionsCase2 [
	| data proportions expectedSizes partitioner subsets subsetsSizes |
	
	data := #(a b c d e f g h i j).
	proportions := #(0.5 0.15 0.1 0.15 0.1).
	expectedSizes := #(5 1 1 2 1).
	
	partitioner := RandomPartitioner new.
	subsets := partitioner split: data withProportions: proportions.
	subsetsSizes := subsets collect: #size.
	
	self assert: subsets size equals: 5.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: expectedSizes.
]

{ #category : #tests }
RandomPartitionerTest >> testSplitDataWithSizesCase1 [
	| data sizes partitioner subsets subsetsSizes |
	
	data := #(a b c d e f g h i j).
	sizes := #(5 2 1 2).
	
	partitioner := RandomPartitioner new.
	subsets := partitioner split: data withSizes: sizes.
	subsetsSizes := subsets collect: #size.
	
	self assert: subsets size equals: 4.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: sizes.
]

{ #category : #tests }
RandomPartitionerTest >> testSplitDataWithSizesCase2 [
	| data sizes partitioner subsets subsetsSizes |
	
	data := #(a b c d e f g h i j).
	sizes := #(5 1 1 2 1).
	
	partitioner := RandomPartitioner new.
	subsets := partitioner split: data withSizes: sizes.
	subsetsSizes := subsets collect: #size.
	
	self assert: subsets size equals: 5.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: sizes.
]
