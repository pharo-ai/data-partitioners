"
Description
--------------------

One line summary. For example, ""I represent a paragraph of text"".

Three sentences about my main responsibilities - what I do, what I know.

State my main collaborators and one line about how I interact with them. 

Public API and Key Messages
--------------------

- #
- #
- #

Examples
--------------------

	
 
Internal Representation and Key Implementation Points.
--------------------

"
Class {
	#name : #BaselineOfAIDataPartitioners,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIDataPartitioners
}

{ #category : #baselines }
BaselineOfAIDataPartitioners >> baseline: spec [

	<baseline>
	spec for: #common do: [ "External dependencies"
		self dataFrame: spec.

		"Packages"
		spec
			package: 'AI-DataPartitioners';
			package: 'AI-DataPartitioners-Tests' with: [ spec requires: #( 'AI-DataPartitioners' ) ];
			package: 'AI-DataPartitioners-DataFrameTests' with: [ spec requires: #( 'AI-DataPartitioners-Tests' 'AIExternalDataFrame' ) ].

		"Groups"
		spec
			group: 'default' with: #( 'Core' 'Tests' );
			group: 'Core' with: #( 'AI-DataPartitioners' );
			group: 'DataFrame' with: #( 'AI-DataPartitioners-DataFrameTests' );
			group: 'Tests' with: #( 'AI-DataPartitioners' 'AI-DataPartitioners-Tests' ) ]
]

{ #category : #accessing }
BaselineOfAIDataPartitioners >> dataFrame: spec [

	spec baseline: 'AIExternalDataFrame' with: [ spec repository: 'github://pharo-ai/external-dependencies' ]
]
