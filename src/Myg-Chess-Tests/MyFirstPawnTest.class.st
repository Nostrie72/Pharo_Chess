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
MyFirstPawnTest >> testBlackPawnCanCaptureOnLeftDiagonal [ 

	| squares firstPawn simplePawn|
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board := MyChessBoard empty.
	board at: 'd2' put: firstPawn.
	board at: 'e3' put: simplePawn.
	
	"Le pion noir devrait pouvoir capturer le pion blanc en diagonale"
	squares := simplePawn targetSquares.

	"Vérification que d3 fait partie des mouvements possibles"
	self assertCollection: squares includesAll: (#(d2) collect: [:name | board at: name]).
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnBlackBlocked [

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn black.
	simplePawn := MyFirstPawn white.
	board at: 'c5' put: firstPawn.
	board at: 'c4' put: simplePawn.

	squares := firstPawn targetSquares.
	self assert: squares isEmptyOrNil
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnBlackCanCaptureOnLeftDiagonal [

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board := MyChessBoard empty.
	board at: 'd2' put: firstPawn.
	board at: 'e3' put: simplePawn.

	"Le pion noir devrait pouvoir capturer le pion blanc en diagonale"
	squares := simplePawn targetSquares.

	"Vérification que d2 fait partie des mouvements possibles"
	self
		assertCollection: squares
		includesAll: (#( d2 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnBlackCanCaptureOnRightDiagonal [

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board := MyChessBoard empty.
	board at: 'd2' put: firstPawn.
	board at: 'c3' put: simplePawn.

	"Le pion noir devrait pouvoir capturer le pion blanc en diagonale"
	squares := simplePawn targetSquares.

	"Vérification que d2 fait partie des mouvements possibles"
	self
		assertCollection: squares
		includesAll: (#( d2 ) collect: [ :name | board at: name ])
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
MyFirstPawnTest >> testFirstPawnWhiteBlocked [

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board at: 'c4' put: firstPawn.
	board at: 'c5' put: simplePawn.

	squares := firstPawn targetSquares.
	self assert: squares isEmptyOrNil
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnWhiteCanCaptureOnLeftDiagonal [

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board := MyChessBoard empty.
	board at: 'd2' put: firstPawn.
	board at: 'e3' put: simplePawn.

	"Le pion blanc devrait pouvoir capturer le pion noir en diagonale"
	squares := simplePawn targetSquares.

	"Vérification que e3 fait partie des mouvements possibles"
	self
		assertCollection: squares
		includesAll: (#( d2 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnWhiteCanCaptureOnRightDiagonal [

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board := MyChessBoard empty.
	board at: 'd2' put: firstPawn.
	board at: 'c3' put: simplePawn.

	"Le pion blanc devrait pouvoir capturer le pion noir en diagonale"
	squares := firstPawn targetSquares.

	"Vérification que c3 fait partie des mouvements possibles"
	self
		assertCollection: squares
		includesAll: (#( c3 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyFirstPawnTest >> testFirstPawnWhiteCanMoveTwoSquaresOnFirstMove [

	| squares secondPawn|
	secondPawn := MyPawn white. 
	board at: 'e2' put: secondPawn.

	"Le pion blanc devrait pouvoir monter d'une ou deux cases"
	squares := secondPawn targetSquares.
	self
		assertCollection: squares
		includesAll: (#( e3 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyFirstPawnTest >> testPawnCannotMoveBackwards [

	| state |
	state := MyUnselectedState board: board.
	board at: 'e4' put: MyFirstPawn white.

	"Sélectionner la case e4 (pion blanc)"
	state := state clickOn: (board at: 'e4').

	"Essayer de déplacer le pion en e3 (recul)"
	self should: [ state clickOn: (board at: 'e3') ] raise: Error .
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
