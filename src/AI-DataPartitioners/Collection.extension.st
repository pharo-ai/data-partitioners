Extension { #name : 'Collection' }

{ #category : '*AI-DataPartitioners' }
Collection >> cumulativeSum [
	| sum |
	sum := 0.
	^ self collect: [ :each |
		sum := sum + each.
		sum ].
]
