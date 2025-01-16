## Alyocha Yahi

### Kata

### Fix Pawn Move

Voici une version améliorée de votre texte, avec des corrections de style, de clarté, et de cohérence :

---

### Fonctionnalités à tester pour le refactoring

Dans cette tâche, je me suis concentré sur les mouvements des pions. Les fonctionnalités à tester sont les suivantes :

1. Un pion peut se déplacer de deux cases lors de son premier mouvement.
2. Un pion peut se déplacer d'une seule case après son premier mouvement.
3. Un pion ne peut pas se déplacer de deux cases après son premier mouvement.
4. Un pion peut capturer une pièce adverse en diagonale (en avant).
5. Un pion ne peut pas capturer une pièce en face de lui.
6. Un pion ne peut pas se déplacer de deux cases si une piéce se trouve devant lui.
7. Un pion ne peut pas reculer.

---

### Ma solution

J'ai eu l'idée d'implémenter une classe MyFirstPawn qui herite de la classe MyPawn pour gérer le premier mouvement.
MyFirstPawn pourra donc capturer en diagonale et avancé d'une case (comme MyPawn) mais pourra egalement avancer de deux cases.
Une fois que le MyFirstPawn aura fait un mouvement (manger en diagonale, avancer d'une case ou avancer de deux cases) il sera alors remplacer par un MyPawn qui n'aura pas la possibilité d'avancer de deux cases.

### Pourquoi ?

Finalement, j'ajoute un peu plus de code mais cela permet une chose que nous avons appris à prendre trés à coeur lors des séances de c3p, 
nous n'aimons pas les if.
Le fait d'avoir un MyFirstPawn remplacer directement par un MyPawn aprés n'importe quel mouvement permet de supprimer une condition par rapport à une implémentation qui utiliserait un Booleen "isFirstMove?" par exemple.
De plus on pourrait imaginer d'autres possibilités avec des pions spéciaux dans une version alternative de Chess.

### Comment ?

## les méthodes de captures en diagonales et de deplacement d'une case en avant sont corrigées dans la classe MyPawn :

```smalltalk
targetSquaresLegal: aBoolean 

	| oneStep diagonalLeft diagonalRight targets |
	targets := OrderedCollection new.

	"Déplacement de base d'une case"
	oneStep := self isWhite
		           ifTrue: [ square up ]
		           ifFalse: [ square down ].
	(oneStep notNil and: [ oneStep hasPiece not ]) ifTrue: [
		targets add: oneStep ].


	"Captures diagonales"
	diagonalLeft := self isWhite
		                ifTrue: [ square up left ]
		                ifFalse: [ square down left ].
	diagonalRight := self isWhite
		                 ifTrue: [ square up right ]
		                 ifFalse: [ square down right ].

	(diagonalLeft notNil and: [
		 diagonalLeft hasPiece and: [ diagonalLeft contents color ~= color ] ])
		ifTrue: [ targets add: diagonalLeft ].
	(diagonalRight notNil and: [
		 diagonalRight hasPiece and: [
			 diagonalRight contents color ~= color ] ]) ifTrue: [
		targets add: diagonalRight ].

	^ targets
```
La méthode est un peu grande et pourrait étre decomposée en sortant l'avancée d'une case et la capture en diagonale dans des methodes distincts.
Egalement la façon de gerer les couleurs pour savoir si la piéce descend ou monte est corrigée avec le kata white/black qui enleve donc deux conditions.

## Remplacer MyFirstPawn :

```smalltalk
replacePawn: aNewPiece

	aNewPiece color: self color.
	self board at: self square name put: aNewPiece
```

J'ai montée la méthode replacePawn dans la classe MyPiece, cela permet d'utiliser cette méthode dans toutes les classes filles et pourrait étre utilisée dans le kata promote par exemple.
La méthode est mal nommée car elle n'est pas spécifique au pion, elle devrait s'appeler "replacePiece" Mais comme je ne vise que les pions dans mon kata j'ai préféré être précis pour éviter une potentielle confusion.
 
## Utilisation de super pour MyFirstPawn :

```smalltalk
moveTo: aSquare

	super moveTo: aSquare.

	self replacePawn: MyPawn new
```

```smalltalk
targetSquaresLegal: aBoolean

	| twoSteps targets firstSquare |
	firstSquare := super targetSquaresLegal: aBoolean.
	targets := firstSquare.

	twoSteps := self isWhite
		            ifTrue: [ square up up ]
		            ifFalse: [ square down down ].
	(twoSteps notNil and: [ twoSteps hasPiece not ]) ifTrue: [ "Vérifier que la première case (un déplacement) est aussi vide"
		((self isWhite
			  ifTrue: [ square up ]
			  ifFalse: [ square down ]) notNil and: [
			 (self isWhite
				  ifTrue: [ square up ]
				  ifFalse: [ square down ]) hasPiece not ]) ifTrue: [
			targets add: twoSteps ] ].

	^ targets
```

Comme décrit plus haut, MyFirstPawn apporte 2 implémentations spécifique :
-pouvoir avancer de deux cases.
-être remplacer par un MyPawn aprés n'importe quel deplacement.

j'ajoute donc le deplacement de deux cases en utilisant un super dans "targetSquaresLegal" pour conserver l'integralité du fonctionnement de MyPawn et ajoute le deplacement de deux cases avec une verification de la case de devant pour éviter que le pion puisse chevaucher une autre piéce lors du mouvement.

Puis un autre super sur "moveTo" qui ici ajoute le fonctionnement de remplacement du MyFirstPawn aprés n'importe lequel de ses deplacements en MyPawn.


### Tests écrits et justifications

#### Test du déplacement de deux cases pour le MyFirstPawn

```smalltalk
testFirstPawnMoveTwoSquares
	| firstPawn board squares |
	board := MyChessBoard empty.
	board at: 'e2' put: (firstPawn := MyFirstPawn white).

	"Vérifier que le pion peut se déplacer de deux cases lors de son premier mouvement"
	squares := firstPawn targetSquaresLegal: true.
	self assert: (squares includes: (board at: 'e4'))
```

**Justification :** Ce test vérifie que le pion (MyFirstPawn) peut avancer de deux cases (de 'e2' à 'e4') lors de son premier mouvement. Le test a réussi.

---

#### Test du déplacement d'une seule case pour le pion après son premier mouvement

```smalltalk
testPawnMoveOneSquare
	| pawn board squares |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).

	"Vérifier que le pion peut se déplacer d'une seule case lors de son premier mouvement"
	squares := pawn targetSquaresLegal: true.
	self assert: (squares includes: (board at: 'e3'))
```

**Justification :** Ce test vérifie que le pion peut seulement avancer d'une seule case (de 'e2' à 'e3'). Ce test a été validé.

---

#### Test que le pion ne peut plus se déplacer de deux cases après son premier mouvement

```smalltalk
testPawnCannotMoveTwoSquaresAfterFirstMove
    | pawn board squares |
    board := MyChessBoard empty.
    board at: 'e2' put: (pawn := MyPawn white).

    "Simuler le premier mouvement du pion à 'e3'"
    pawn moveTo: 'e3'.

    "Vérifier que le pion ne peut plus se déplacer de deux cases après son premier mouvement"
    squares := pawn targetSquaresLegal: true.
    self deny: (squares includes: (board at: 'e5')).
```

**Justification :** Ce test vérifie que le pion ne peut plus avancer de deux cases après avoir déjà effectué un mouvement. Ce test a été validé.

---

#### Test que le pion peut capturer une pièce adverse en diagonale

```smalltalk
testFirstPawnWhiteCanCaptureOnLeftDiagonal

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
```

**Justification :** Ce test vérifie que le pion blanc peut capturer le pion noir en diagonale.

Il en existe 4 variantes : testFirstPawnWhiteCanCaptureOnLeftDiagonal, testFirstPawnWhiteCanCaptureOnRightDiagonal, testFirstPawnBlackCanCaptureOnLeftDiagonal, testFirstPawnBlackCanCaptureOnRightDiagonal ce qui permet de couvrir toutes les possibilités.

---

#### Test que le pion ne peut pas capturer une pièce en face de lui

```smalltalk
testFirstPawnWhiteBlocked

	| squares firstPawn simplePawn |
	firstPawn := MyFirstPawn white.
	simplePawn := MyFirstPawn black.
	board at: 'c4' put: firstPawn.
	board at: 'c5' put: simplePawn.

	squares := firstPawn targetSquares.
	self assert: squares isEmptyOrNil
```

**Justification :** Ce test vérifie que le pion ne peut pas capturer un pion adverse en face de lui, ce qui est conforme aux règles du jeu.

---

### Tests non écrits et justifications

- **Tests pour les mouvements latéraux** : Les pions ne peuvent pas se déplacer latéralement. Aucun test spécifique n'a été écrit pour cela, car ce comportement est implicitement couvert par les tests de capture et de mouvement.

- **Tests pour des cas extrêmes (fin de partie, promotion)** : Ces tests n'ont pas été inclus dans cette phase initiale, car ils ajouteraient une complexité supplémentaire et ne sont pas directement liés aux règles de mouvement des pions.
