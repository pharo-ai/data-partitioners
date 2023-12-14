"
Encapsulates the result of a train-test split, holding four variables:
    
# Attributes

- xTrain `DataFrame`: Training features.
- xTest `DataFrame`: Testing features.
- yTrain `DataFrame` or `DataSeries`: Training target variable.
- yTest `DataFrame` or `DataSeries`: Testing target variable.
        
This class is designed to provide a structured representation of the result obtained from splitting a dataset into training and testing sets, making it convenient to manage and access the different subsets of data during machine learning workflows.

"
Class {
	#name : 'AIPartitionedDataSet',
	#superclass : 'Object',
	#instVars : [
		'xTrain',
		'xTest',
		'yTrain',
		'yTest'
	],
	#category : 'AI-DataPartitioners',
	#package : 'AI-DataPartitioners'
}

{ #category : 'comparing' }
AIPartitionedDataSet >> = aPartitionedDataSet [

	self == aPartitionedDataSet 
		ifTrue: [ ^ true ].
	self class = aPartitionedDataSet class
		ifFalse: [ ^ false ].
	self xTest = aPartitionedDataSet xTest
		ifFalse: [ ^ false ].
	self yTest = aPartitionedDataSet yTest
		ifFalse: [ ^ false ].
	self xTrain = aPartitionedDataSet xTrain
		ifFalse: [ ^ false ].
	self yTrain = aPartitionedDataSet yTrain
		ifFalse: [ ^ false ].
	^ true
]

{ #category : 'comparing' }
AIPartitionedDataSet >> hash [
	"hash is implemented because #= is implemented"

	^ self species hash 
		bitXor: (self xTest hash 
			bitXor: (self xTrain hash bitXor: (self yTest hash 
				bitXor: self yTrain hash)))
]

{ #category : 'accessing' }
AIPartitionedDataSet >> xTest [

	^ xTest
]

{ #category : 'accessing' }
AIPartitionedDataSet >> xTest: anObject [

	xTest := anObject
]

{ #category : 'accessing' }
AIPartitionedDataSet >> xTrain [

	^ xTrain
]

{ #category : 'accessing' }
AIPartitionedDataSet >> xTrain: anObject [

	xTrain := anObject
]

{ #category : 'accessing' }
AIPartitionedDataSet >> yTest [

	^ yTest
]

{ #category : 'accessing' }
AIPartitionedDataSet >> yTest: anObject [

	yTest := anObject
]

{ #category : 'accessing' }
AIPartitionedDataSet >> yTrain [

	^ yTrain
]

{ #category : 'accessing' }
AIPartitionedDataSet >> yTrain: anObject [

	yTrain := anObject
]
