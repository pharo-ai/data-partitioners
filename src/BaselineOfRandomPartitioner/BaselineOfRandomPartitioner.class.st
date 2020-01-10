Class {
	#name : #BaselineOfRandomPartitioner,
	#superclass : #BaselineOf,
	#category : #BaselineOfRandomPartitioner
}

{ #category : #baselines }
BaselineOfRandomPartitioner >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec
			baseline: 'DataFrame'
			with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
		"Note: DataFrame will only be loaded for group 'withDataFrameTests'. The default RandomPartitioner is independent of DataFrame"
		
		"Packages"
		spec 
			package: 'RandomPartitioner';
			package: 'RandomPartitioner-Tests' with: [ spec requires: #('RandomPartitioner') ];
			package: 'RandomPartitioner-DataFrameTests' with: [ spec requires: #('RandomPartitioner-Tests' 'DataFrame') ].
			
		"Groups"
		spec
			group: 'default' with: #('RandomPartitioner-Tests');
			group: 'withDataFrameTests' with: #('RandomPartitioner-DataFrameTests') ].
		
	spec
			for: #'pharo6.x'
			do: [
				spec
					package: 'RandomPartitioner-Pharo6' ].
]
