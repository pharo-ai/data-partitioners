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
	spec for: #common do: [ "Packages"
		spec
			package: 'AI-DataPartitioners';
			package: 'AI-DataPartitioners-Tests' with: [ spec requires: #( 'AI-DataPartitioners' ) ].

		"Groups"
		spec
			group: 'Core' with: #( 'AI-DataPartitioners' );
			group: 'Tests' with: #( 'AI-DataPartitioners' 'AI-DataPartitioners-Tests' ) ]
]
