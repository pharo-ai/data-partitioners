Extension { #name : 'SequenceableCollection' }

{ #category : '*AI-DataPartitioners' }
SequenceableCollection >> indexOfRowNamed: aName [

	^ self indexOf: aName
]

{ #category : '*AI-DataPartitioners' }
SequenceableCollection >> rowNames [

	^ self
]

{ #category : '*AI-DataPartitioners' }
SequenceableCollection >> shuffleWithSeed: aNumber [
	" Fix the random seed with aNumber to ensure reproducibility "

	^ self shuffleBy: (Random new seed: aNumber)
]
