Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

    | oneStep diagonalLeft diagonalRight targets |

    targets := OrderedCollection new.

    "Déplacement de base d'une case"
    oneStep := self isWhite 
		ifTrue: [ square up ] 
		ifFalse: [ square down ].
    (oneStep notNil and: [ oneStep hasPiece not ]) 
		ifTrue: [ targets add: oneStep ].


    "Captures diagonales"
    diagonalLeft := self isWhite ifTrue: [ square up left ] ifFalse: [ square down left ].
    diagonalRight := self isWhite ifTrue: [ square up right ] ifFalse: [ square down right ].

    (diagonalLeft notNil and: [ diagonalLeft hasPiece and: [ diagonalLeft contents color ~= color ] ]) 
        ifTrue: [ targets add: diagonalLeft ].
    (diagonalRight notNil and: [ diagonalRight hasPiece and: [ diagonalRight contents color ~= color ] ]) 
        ifTrue: [ targets add: diagonalRight ].

    ^ targets
]
