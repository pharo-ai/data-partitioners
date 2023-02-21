Class {
	#name : #AIRandomPartitionerDataFrameTest,
	#superclass : #TestCase,
	#category : #'AI-DataPartitioners-DataFrameTests'
}

{ #category : #tests }
AIRandomPartitionerDataFrameTest >> testPartitionDataFrameWithCustomRowNames [
	| dataFrame sizes partitioner subsets |
	
	dataFrame := DataFrame
		withColumns: #(
			(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
			(Lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche))
		rowNames: #(Mon Tue Wed Thu Fri Sat Sun)
		columnNames: #(English French).
		
	sizes := #(4 3).
		
	partitioner := AIRandomPartitioner new.
	subsets := partitioner split: dataFrame withSizes: sizes.
	
	self assert: (subsets collect: #size) equals: sizes.
	
	subsets do: [ :eachSubset |
		self assert: eachSubset class equals: DataFrame.
		self assert: eachSubset columnNames equals: dataFrame columnNames.
		
		eachSubset rowNames do: [ :rowName |
			self assert: (dataFrame row: rowName) equals: (eachSubset row: rowName) ] ].
]

{ #category : #tests }
AIRandomPartitionerDataFrameTest >> testPartitionDataSeriesWithCustomKeys [
	| series sizes partitioner subsets |
	
	series := DataSeries
		withKeys: #(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
		values: #(Mon Tue Wed Thu Fri Sat Sun)
		name: 'Weekdays'.
		
	sizes := #(4 3).
		
	partitioner := AIRandomPartitioner new.
	subsets := partitioner split: series withSizes: sizes.
	
	self assert: (subsets collect: #size) equals: sizes.
	
	subsets do: [ :eachSubset |
		self assert: eachSubset class equals: DataSeries.
		self assert: eachSubset name equals: series name.
		
		eachSubset keysAndValuesDo: [ :key :value |
			self assert: key equals: (series keyAtValue: value) ] ].
]

{ #category : #tests }
AIRandomPartitionerDataFrameTest >> testPartitionDataSeriesWithDefaultKeys [
	| series sizes partitioner subsets |
	
	series := DataSeries
		withValues: #(Mon Tue Wed Thu Fri Sat Sun)
		name: 'Weekdays'.
		
	sizes := #(4 3).
		
	partitioner := AIRandomPartitioner new.
	subsets := partitioner split: series withSizes: sizes.
	
	self assert: (subsets collect: #size) equals: sizes.
	
	subsets do: [ :eachSubset |
		self assert: eachSubset class equals: DataSeries.
		self assert: eachSubset name equals: series name.
		
		eachSubset keysAndValuesDo: [ :key :value |
			self assert: key equals: (series keyAtValue: value) ] ].
]
