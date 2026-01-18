Class {
	#name : 'AIHashPartitionerDataFrameTest',
	#superclass : 'TestCase',
	#category : 'AI-DataPartitioners-DataFrameTests',
	#package : 'AI-DataPartitioners-DataFrameTests'
}

{ #category : 'tests' }
AIHashPartitionerDataFrameTest >> testPartitionDataFrameWithCustomRowNames [

	| dataFrame proportions subsets |
	dataFrame := DataFrame
		             withColumns: #( #( Monday Tuesday Wednesday Thursday Friday Saturday Sunday ) #( Lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche ) )
		             rowNames: #( Mon Tue Wed Thu Fri Sat Sun )
		             columnNames: #( English French ).

	proportions := #( 0.8 0.2 ).

	subsets := AIHashPartitioner split: dataFrame withProportions: proportions.

	self assert: (subsets collect: #size) equals: #( 5 2 ).

	subsets do: [ :eachSubset |
		self assert: eachSubset class equals: DataFrame.
		self assert: eachSubset columnNames equals: dataFrame columnNames.

		eachSubset rowNames do: [ :rowName | self assert: (dataFrame row: rowName) equals: (eachSubset row: rowName) ] ]
]
