Class {
	#name : 'MyFirstPawnTest',
	#superclass : 'TestCase',
	#instVars : [
		'pawnboard',
		'board',
		'pawn'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'running' }
MyFirstPawnTest >> setUp [

	super setUp.
	"Put here a common initialization logic for tests"
	board := MyChessBoard empty.
	board initializeSquares.
	"pawn := MyPawn black.
	board at: 'e1' put: pawn"
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnBlocked [

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board at: 'c4' put: firstPawn.
	board at: 'c5' put: simplePawn.

	squares := firstPawn targetSquares.
	self assert: squares isEmptyOrNil
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnIsBlack [

	| firstBlackPawn |
	firstBlackPawn := MyFirstPawn black.
	self assert: firstBlackPawn isWhite equals: false
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnIsWhite [

	| firstWhitePawn |
	firstWhitePawn := MyFirstPawn white.
	self assert: firstWhitePawn isWhite
]

{ #category : 'tests' }
MyFirstPawnTest >> testPawnIsBlack [

	| blackPawn |
	blackPawn := MyPawn black.
	self assert: blackPawn isWhite equals: false
]

{ #category : 'tests' }
MyFirstPawnTest >> testPawnIsWhite [ 
    | whitePawn |
    
    whitePawn := MyPawn white .
	self assert: whitePawn isWhite.

]

{ #category : 'tests' }
MyFirstPawnTest >> testReplacePawn [

	| oldPiece newPiece square |
	newPiece := MyPawn black.
	oldPiece := MyFirstPawn black.
	square := board at: 'f4'.
	board at: 'f4' put: oldPiece.
	oldPiece replacePawn: newPiece.
	self assert: square contents equals: newPiece
]
