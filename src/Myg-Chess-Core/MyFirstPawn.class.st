Class {
	#name : 'MyFirstPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyFirstPawn >> targetSquaresLegal: aBoolean [

	| twoSteps targets firstSquare |
	firstSquare := super targetSquaresLegal: aBoolean.
	targets := firstSquare.

	"Déplacement de deux cases si sur la rangée initiale"

	twoSteps := self isWhite
		            ifTrue: [ square up up ]
		            ifFalse: [ square down down ].
	(twoSteps notNil and: [ twoSteps hasPiece not ]) ifTrue: [
		targets add: twoSteps ].

	^ targets
]
