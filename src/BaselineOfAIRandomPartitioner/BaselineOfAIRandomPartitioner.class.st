Class {
	#name : #BaselineOfAIRandomPartitioner,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIRandomPartitioner
}

{ #category : #baselines }
BaselineOfAIRandomPartitioner >> baseline: spec [
	<baseline>
	spec for: #common do: [
		
		"Packages"
		spec 
			package: 'AI-RandomPartitioner';
			package: 'AI-RandomPartitioner-Tests' with: [ spec requires: #('AI-RandomPartitioner') ].
			
		"Groups"
		spec
			group: 'Core' with: #('AI-RandomPartitioner');
			group: 'Tests' with: #('AI-RandomPartitioner' 'AI-RandomPartitioner-Tests');
			group: 'default' with: #('Core' 'Tests') ]
]
