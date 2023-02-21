Class {
	#name : #AIHashPartitionerTest,
	#superclass : #TestCase,
	#category : #'AI-DataPartitioners-Tests'
}

{ #category : #tests }
AIHashPartitionerTest >> testSplitDataWithProportionsCase1 [

	| data proportions expectedSizes subsets subsetsSizes |
	data := (1 to: 10000) asArray.
	proportions := #( 0.5 0.15 0.15 0.2 ).
	expectedSizes := #( 5000 1500 1500 2000 ).

	subsets := AIHashPartitioner split: data withProportions: proportions.
	subsetsSizes := subsets collect: #size.

	self assert: subsets size equals: 4.
	self assert: subsetsSizes sum equals: data size.
	"With this partitioner we do not have an exact size, so we check +-5"
	subsetsSizes with: expectedSizes do: [ :actual :expected | self assert: (actual between: expected - 5 and: expected + 5) ]
]
