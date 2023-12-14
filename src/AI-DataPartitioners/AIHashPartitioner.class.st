"
# Description
I am a portitioner to which you give a collection and proportions and that returns sub sets of the collection following the proportions.

To do the splitting I'll apply a hash function to the elements, or to the rowNames in DataFrame. The advantage of this splitting is that if you add new datas later and split again the collection, the previous elements will still be in the same partitions. 

This is useful to build tests sets on datas that can be filled with new data overtime.

#How to use

The partitionner can be used like this:

```st
| numbers subsets |
numbers := (1 to: 10000) asArray.

subsets := AIHashPartitioner split: numbers withProportions: #(0.5 0.3 0.2).
```

How to use with a DataFrame:

```st
| dataFrame subsets |
dataFrame := DataFrame
	withColumns: #( #( Monday Tuesday Wednesday Thursday Friday Saturday Sunday ) #( Lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche ) )
	rowNames: #( Mon Tue Wed Thu Fri Sat Sun )
	columnNames: #( English French ).

subsets := AIHashPartitioner split: dataFrame withProportions: #(0.8 0.2).
```
"
Class {
	#name : 'AIHashPartitioner',
	#superclass : 'Object',
	#category : 'AI-DataPartitioners',
	#package : 'AI-DataPartitioners'
}

{ #category : 'api' }
AIHashPartitioner class >> split: aCollection withProportions: aCollectionOfProportions [

	^ self new split: aCollection withProportions: aCollectionOfProportions
]

{ #category : 'api' }
AIHashPartitioner >> split: aCollection withProportions: aCollectionOfProportions [

	| cumulativeProportionsMap indexesMap |
	(aCollectionOfProportions sum closeTo: 1) ifFalse: [ Error signal: 'The proportions must sum up to 1' ].

	"Get the cumulative sum to define up to what ratio each step should go."
	cumulativeProportionsMap := (aCollectionOfProportions cumulativeSum collect: [ :e | e -> OrderedCollection new ]) asOrderedDictionary.

	aCollection rowNames do: [ :id |
		| hash matchingRatio |
		hash := (((CRC crc32FromCollection: id) bitAnd: 16rFFFFFFFF) / (2 raisedTo: 32)) asFloat.

		"We check in which ration the id should go and add it there."
		matchingRatio := cumulativeProportionsMap keys detect: [ :ratio | hash < ratio ].

		(cumulativeProportionsMap at: matchingRatio) add: id ].

	"Now that we have all ids grouped by ratio, we collect the index of the id in the original collection.
	This is used for DataFrame compatibility."
	indexesMap := cumulativeProportionsMap values collect: [ :ids | ids collect: [ :id | aCollection indexOfRowNamed: id ] ].

	^ indexesMap collect: [ :indexes | aCollection atAll: indexes ]
]
