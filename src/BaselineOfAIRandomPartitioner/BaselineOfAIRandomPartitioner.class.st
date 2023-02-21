Class {
	#name : #BaselineOfAIRandomPartitioner,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIRandomPartitioner
}

{ #category : #testing }
BaselineOfAIRandomPartitioner class >> isDeprecated [

	^ true
]

{ #category : #baselines }
BaselineOfAIRandomPartitioner >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Packages"
		spec
			package: 'AI-DataPartitioners';
			package: 'AI-DataPartitioners-Tests' with: [ spec requires: #( 'AI-DataPartitioners' ) ].

		"Groups"
		spec
			group: 'Core' with: #( 'AI-DataPartitioners' );
			group: 'Tests' with: #( 'AI-DataPartitioners' 'AI-DataPartitioners-Tests' ) ]
]
