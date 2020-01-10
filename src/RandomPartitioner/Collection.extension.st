Extension { #name : #Collection }

{ #category : #'*RandomPartitioner' }
Collection >> cumulativeSum [
	| sum |
	sum := 0.
	^ self collect: [ :each |
		sum := sum + each.
		sum ].
]
