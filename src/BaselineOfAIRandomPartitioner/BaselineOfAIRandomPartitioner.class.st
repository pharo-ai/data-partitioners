Class {
	#name : #BaselineOfAIRandomPartitioner,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIRandomPartitioner
}

{ #category : #baselines }
BaselineOfAIRandomPartitioner >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec
			baseline: 'DataFrame'
			with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
		"Note: DataFrame will only be loaded for group 'withDataFrameTests'. The default RandomPartitioner is independent of DataFrame"
		
		"Packages"
		spec 
			package: 'AI-RandomPartitioner';
			package: 'AI-RandomPartitioner-Tests' with: [ spec requires: #('AI-RandomPartitioner') ];
			package: 'AI-RandomPartitioner-DataFrameTests' with: [ spec requires: #('AI-RandomPartitioner-Tests' 'DataFrame') ].
			
		"Groups"
		spec
			group: 'default' with: #('AI-RandomPartitioner-Tests');
			group: 'withDataFrameTests' with: #('AI-RandomPartitioner-DataFrameTests') ].
]
