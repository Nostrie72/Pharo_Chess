Class {
	#name : 'MyFirstPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'path commands' }
MyFirstPawn >> moveTo: aSquare [

	super moveTo: aSquare.

	self replacePawn: MyPawn new.
]

{ #category : 'rendering' }
MyFirstPawn >> targetSquaresLegal: aBoolean [

	| twoSteps targets firstSquare |
	firstSquare := super targetSquaresLegal: aBoolean.
	targets := firstSquare.

	twoSteps := self isWhite
		            ifTrue: [ square up up ]
		            ifFalse: [ square down down ].
	(twoSteps notNil and: [ twoSteps hasPiece not ]) ifTrue: [
		"Vérifier que la première case (un déplacement) est aussi vide"
		((self isWhite
			ifTrue: [ square up ] 
			ifFalse: [ square down ]) notNil and: [ 
				(self isWhite 
					ifTrue: [ square up ] 
					ifFalse: [ square down ]) hasPiece not ]) ifTrue: [
			targets add: twoSteps].].

	^ targets
	
]
