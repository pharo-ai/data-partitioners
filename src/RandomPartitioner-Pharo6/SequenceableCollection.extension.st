Extension { #name : #SequenceableCollection }

{ #category : #'*RandomPartitioner-Pharo6' }
SequenceableCollection >> withIndexSelect: elementAndIndexBlock [
	"select elements from the receiver that the block evaluates true with the element and its index."

	"(#('We' 'love' 'pharo!') withIndexSelect: [:value :index | value size - 1 <= index]) >>> #('We')"

	^ self class
		new: self size
		streamContents: [ :stream | 
			1 to: self size do: [ :index | 
				| each |
				(elementAndIndexBlock value: (each := self at: index) value: index)
					ifTrue: [ stream nextPut: each ] ] ]
]
