Extension { #name : 'DataFrame' }

{ #category : '*AI-DataPartitioners' }
DataFrame >> splitTrainTest: aCollectionOfProportions shuffle: aBoolean [ 
	"Split the receiver's data into train and test sets.
	
	xTrain and yTrain sets are used for training and fitting the model.
	xTest and yTest sets are used for testing the model.
	"

	^ AIRandomPartitioner 
		split: self 
		withProportions: aCollectionOfProportions 
		shuffle: aBoolean.
]
