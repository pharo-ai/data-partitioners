Extension { #name : #SequenceableCollection }

{ #category : #'*AI-RandomPartitioner' }
SequenceableCollection >> shuffleWithSeed: aNumber [
	" Fix the random seed with aNumber to ensure reproducibility "

	^ self shuffleBy: (Random new seed: aNumber)
]
