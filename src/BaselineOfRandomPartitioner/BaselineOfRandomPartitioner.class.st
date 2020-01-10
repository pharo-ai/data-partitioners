Class {
	#name : #BaselineOfRandomPartitioner,
	#superclass : #BaselineOf,
	#category : #BaselineOfRandomPartitioner
}

{ #category : #baselines }
BaselineOfRandomPartitioner >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"Packages"
		spec 
			package: 'RandomPartitioner';
			package: 'RandomPartitioner-Tests' with: [ spec requires: #('RandomPartitioner') ] ]
]
