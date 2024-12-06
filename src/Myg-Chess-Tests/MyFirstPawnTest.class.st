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
	pawn := MyPawn black.
	board at: 'e1' put: pawn
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
	oldPiece := MyPawn black.
	newPiece := MyFirstPawn black.
	square := board at: 'e4'.
	board at: 'e4' put: oldPiece.
	oldPiece replacePawn: newPiece.
	self assert: square contents equals: newPiece 
]
