Class {
	#name : 'AIRandomPartitionerTest',
	#superclass : 'TestCase',
	#instVars : [
		'partitioner',
		'df'
	],
	#category : 'AI-DataPartitioners-Tests',
	#package : 'AI-DataPartitioners-Tests'
}

{ #category : 'running' }
AIRandomPartitionerTest >> setUp [

	super setUp.
	df := DataFrame withRows: #( #( 'Barcelona' 1.609 true ) #( 'Dubai' 2.789 true ) #( 'London' 8.788 false ) ).

	df rowNames: #( 'A' 'B' 'C' ).
	df columnNames: #( 'City' 'Population' 'BeenThere' )
]

{ #category : 'tests' }
AIRandomPartitionerTest >> testSplitDataWithProportionsCase1 [

	| data proportions expectedSizes subsets subsetsSizes |
	data := #( a b c d e f g h i j ).
	proportions := #( 0.5 0.15 0.15 0.2 ).
	expectedSizes := #( 5 1 2 2 ).

	subsets := AIRandomPartitioner split: data withProportions: proportions.
	subsetsSizes := subsets collect: #size.

	self assert: subsets size equals: 4.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: expectedSizes
]

{ #category : 'tests' }
AIRandomPartitionerTest >> testSplitDataWithProportionsCase2 [

	| data proportions expectedSizes subsets subsetsSizes |
	data := #( a b c d e f g h i j ).
	proportions := #( 0.5 0.15 0.1 0.15 0.1 ).
	expectedSizes := #( 5 1 1 2 1 ).

	subsets := AIRandomPartitioner split: data withProportions: proportions.
	subsetsSizes := subsets collect: #size.

	self assert: subsets size equals: 5.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: expectedSizes
]

{ #category : 'tests' }
AIRandomPartitionerTest >> testSplitDataWithSizesCase1 [

	| data sizes subsets subsetsSizes |
	data := #( a b c d e f g h i j ).
	sizes := #( 5 2 1 2 ).

	subsets := AIRandomPartitioner split: data withSizes: sizes.
	subsetsSizes := subsets collect: #size.

	self assert: subsets size equals: 4.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: sizes
]

{ #category : 'tests' }
AIRandomPartitionerTest >> testSplitDataWithSizesCase2 [

	| data sizes subsets subsetsSizes |
	data := #( a b c d e f g h i j ).
	sizes := #( 5 1 1 2 1 ).

	subsets := AIRandomPartitioner split: data withSizes: sizes.
	subsetsSizes := subsets collect: #size.

	self assert: subsets size equals: 5.
	self assert: subsetsSizes sum equals: data size.
	self assert: subsetsSizes equals: sizes
]

{ #category : 'tests' }
AIRandomPartitionerTest >> testSplitTrainTestFromUsingTargetColumnWithProportionsShuffle [

	| expectedPartition partitionedDataSet |
	
	expectedPartition := AIPartitionedDataSet new
		xTrain: (DataFrame 
			withRows: #( #( 'Barcelona' 1.609 ) #( 'London' 8.788 )) 
			rowNames: #('A' 'C')
			columnNames: #( 'City' 'Population' ));
		xTest: (DataFrame 
			withRows: #( #( 'Dubai' 2.789 )) 
			rowNames: #('B')
			columnNames: #( 'City' 'Population' ));
		yTrain: (DataFrame 
			withRows: #( #( true ) #( false )) 
			rowNames: #('A' 'C')
			columnNames:  #( 'BeenThere' ));
		yTest: (DataFrame 
			withRows: #( #( true )) 
			rowNames: #('B')
			columnNames:  #( 'BeenThere' ));
		yourself.

	partitionedDataSet := (AIRandomPartitioner new 
		splitTrainTestFrom: df 
		usingTargetColumn: #('BeenThere') 
		withProportions: #(0.7 0.3)  
		seed: 1).

	self
		assert: partitionedDataSet
		equals: expectedPartition
]
