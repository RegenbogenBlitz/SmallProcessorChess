// let highlightedSquareIndex = 0;
// let newEnPassantPawnIndex = 0;
// let clickedBoardIndex = 0;
// 
// const blackColor = 0b0000;
// const whiteColor = 0b1000;
// 
// const whitePawnPieceValue = 0b1001;
// const pawnPieceValue = 0b0001; // 1
// const kingPieceValue = 0b0010; // 2
// const queenPieceValue = 0b0110; // 6
// const offBoardValue = 0b0111; // 7
// 
// const pawnGameValue = 14;
// const queenGameValue = 124;
// 
// const pieceGameValues = [
//     0, pawnGameValue, 0, 40, 38, 68, queenGameValue  //  0- 6: piece game value: empty 0, pawn: 14, king: 0, knight: 40, bishop: 38, rook: 68, queen: 124
// ];
// 
// const moveDirections = [
//     -1, 1, -10, 10,                                  //  0- 3: rook move directions (& king, queen)
//     -11, -9, 9, 11, 10, 20,                          //  4- 7: bishop move directions (& king, queen), 6-9: black pawn move directions
//     -11, -9, -10, -20,                               // 10-13: white pawn move directions
//     -21, -19, -12, -8, 8, 12, 19, 21,                // 14-21: knight move directions
// ];
// 
// const initialMoveDirectionIndexes = [
//     6, 0, 14, 4, 0, 0                                //  0- 5: initial move index: black pawn, king, knight, bishop, rook, queen
// ];
// 
// const unicodeOffsets = [
//     15, 10, 14, 13, 12, 11, -32, -32,                //  0- 7: 9808 + value = unicode black chess piece:       pawn, king, knight, bishop, rook, queen, n/a, n/a
//     9, 4, 8, 7, 6, 5                                 //  8-13: 9808 + value = unicode white chess piece:       pawn, king, knight, bishop, rook, queen
// ];
// 
// const boardState = [
//     7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
//     7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
//     7, 53, 51, 52, 54, 50, 52, 51, 53, 7,
//     7, 49, 49, 49, 49, 49, 49, 49, 49, 7,
//     7, 0, 0, 0, 0, 0, 0, 0, 0, 7,
//     7, 0, 0, 0, 0, 0, 0, 0, 0, 7,
//     7, 0, 0, 0, 0, 0, 0, 0, 0, 7,
//     7, 0, 0, 0, 0, 0, 0, 0, 0, 7,
//     7, 57, 57, 57, 57, 57, 57, 57, 57, 7,
//     7, 61, 59, 60, 62, 58, 60, 59, 61, 7,
//     7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
//     7, 7, 7, 7, 7, 7, 7, 7, 7, 7
// ];
// 
// const calculate = (opponentPieceColor, depth, enPassantPawnIndex, modeMaxDepth, maxGameValueThatAvoidsPruning) => {
//     let originPieceColor = opponentPieceColor ^ 0b1000;
//     let bestGameValue = -100000000;
//     let originPlayerIsInCheck = modeMaxDepth > 0 && calculate(originPieceColor, 0, undefined, 0) > 10000;
//     const winGameValue = (78 - depth) * 512; // depth: 0=>39936, 1=>39424, 2=>38912
//     let singlePawnJump = originPieceColor === whiteColor ? -10 : 10; // pawn direction for origin piece
// 
//     // TODO short circuit to go straight to correct origin square when modeMaxDepth === 1 and depth === 0
//     for (let originSquareIndex = 21; originSquareIndex <= 98; originSquareIndex++) {
//         let originSquareValue = boardState[originSquareIndex];
//         const movedOriginPieceValue = originSquareValue & 0b1111;
//         const colorlessOriginPieceValue = movedOriginPieceValue ^ originPieceColor; // pawn 1, king 2, knight 3, bishop 4, rook 5, queen 6
//         const originSquareIsEmpty = originSquareValue === 0;
//         const originIsPieceOfOwnColorOrEmpty = colorlessOriginPieceValue < 7; // 0: empty, 1-6 own color piece, 7 off-board;
// 
//         if (!originSquareIsEmpty && originIsPieceOfOwnColorOrEmpty) {
//             const originPieceIsOnOriginalSquare = 0b1111 < originSquareValue;
//             const originPieceIsAPawn = colorlessOriginPieceValue === pawnPieceValue;
//             const originPieceIsAKing = colorlessOriginPieceValue === kingPieceValue;
//             const originPieceIsSlidey = colorlessOriginPieceValue >= 4;
// 
//             let moveDirectionNumber = (colorlessOriginPieceValue & 2) ? 8 : 4; // number of move directions: pawn 4, king 8, knight 8, bishop 4, rook 4, queen 8
// 
//             let initialMoveDirectionIndex = movedOriginPieceValue === whitePawnPieceValue ? 10 : initialMoveDirectionIndexes[colorlessOriginPieceValue - 1];
//             let targetSquareIndex = originSquareIndex;
//             let pieceCanSlide;
//             let thereAreMoreMoves;
//             do {
// 
//                 targetSquareIndex += moveDirections[initialMoveDirectionIndex];
//                 let targetSquareValue = boardState[targetSquareIndex];
//                 const originPieceCouldTakeEnPassant = originPieceIsAPawn && targetSquareIndex - singlePawnJump === enPassantPawnIndex;
//                 let otherSquareOriginIndex = originPieceCouldTakeEnPassant ? enPassantPawnIndex : 0; // index of pawn to be taken en passant
//                 let otherSquareTargetIndex = otherSquareOriginIndex;
// 
//                 const targetIsEmpty = targetSquareValue === 0;
//                 const targetIsAPieceOfOppositeColor = (1 + (targetSquareValue & 0b1111) ^ originPieceColor) > 9;
// 
//                 const theTargetCanBeMovedInto = targetIsEmpty && (!originPieceIsAPawn || moveDirectionNumber <= 2 || originPieceCouldTakeEnPassant);
//                 const theTargetCanBeTaken = targetIsAPieceOfOppositeColor && (!originPieceIsAPawn || moveDirectionNumber > 2);
//                 if (theTargetCanBeMovedInto || theTargetCanBeTaken) {
//                     const targetIsAKing = (targetSquareValue & 0b0111) === kingPieceValue;
//                     if (targetIsAKing) {
//                         // previous state was in check
//                         return winGameValue;
//                     }
// 
//                     const originPieceWouldBePawnOnLastRank = originPieceIsAPawn && boardState[targetSquareIndex + singlePawnJump] === offBoardValue;
// 
//                     const originColorQueenPieceValue = queenPieceValue ^ originPieceColor;
//                     let targetSquareValueAfterMoving = originPieceWouldBePawnOnLastRank ? originColorQueenPieceValue : movedOriginPieceValue;
//                     let canAlsoCastle;
//                     do {
//                         const colorlessTargetPieceValue = targetSquareValue & 0b0111
//                         const targetSquareGameValue = pieceGameValues[colorlessTargetPieceValue];
//                         const captureGameValueCorrection = targetIsEmpty
//                             ? 0
//                             : targetSquareGameValue - depth - colorlessOriginPieceValue + 1;
//                         // prefer big capture, prefer quick capture, prefer capture by smaller valued piece, prefer capture
// 
//                         let pawnMoveGameValueCorrection = 0;
//                         if (originPieceIsAPawn) {
//                             const pawnPromoted = targetSquareValueAfterMoving > originSquareValue & 0b1111;
//                             const pawnTookEnPassant = otherSquareOriginIndex !== 0;
//                             const pawnMovedForwardTwo = moveDirectionNumber <= 1
//                             if (pawnPromoted) {
//                                 pawnMoveGameValueCorrection = queenGameValue - pawnGameValue;
//                             } else if (pawnTookEnPassant) {
//                                 pawnMoveGameValueCorrection = pawnGameValue + 1;
//                             } else if (pawnMovedForwardTwo) {
//                                 pawnMoveGameValueCorrection = 2;
//                             }
//                             else {
//                                 pawnMoveGameValueCorrection = 1;
//                             }
//                         }
// 
//                         let castlingIsProhibited = true;
//                         let moveGameValue = captureGameValueCorrection + pawnMoveGameValueCorrection;
//                         if (modeMaxDepth > depth || (modeMaxDepth === 2 && modeMaxDepth === depth && (moveGameValue > 2 || originPlayerIsInCheck))) {
//                             boardState[targetSquareIndex] = targetSquareValueAfterMoving;
//                             boardState[otherSquareTargetIndex] = boardState[otherSquareOriginIndex];
//                             if (otherSquareOriginIndex) {
//                                 boardState[otherSquareOriginIndex] = 0;
//                             }
//                             boardState[originSquareIndex] = 0;
// 
//                             const pawnJustMovedTwoSpaces = originPieceIsAPawn && moveDirectionNumber <= 1;
//                             const justMovedEnPassantPawnIndex = pawnJustMovedTwoSpaces ? targetSquareIndex : 0;
// 
//                             const maxOpponentGameValueThatAvoidsPruning = moveGameValue - bestGameValue;
//                             const opponentMoveGameValue = calculate(originPieceColor, depth + 1, justMovedEnPassantPawnIndex, modeMaxDepth, maxOpponentGameValueThatAvoidsPruning);
//                             const correctedMoveGameValue = moveGameValue - opponentMoveGameValue;
//                             moveGameValue = correctedMoveGameValue;
//                             if (depth === 0 && modeMaxDepth === 1 && highlightedSquareIndex === originSquareIndex && targetSquareIndex === clickedBoardIndex && moveGameValue >= -10000) {
//                                 newEnPassantPawnIndex = justMovedEnPassantPawnIndex;
//                                 highlightedSquareIndex = clickedBoardIndex;
//                                 renderHtml();
//                                 if (originPieceColor == whiteColor) {
//                                     setTimeout(() => {
//                                         calculate(whiteColor, 0, newEnPassantPawnIndex, 2);
//                                         calculate(whiteColor, 0, newEnPassantPawnIndex, 1);
//                                     }, 75);
//                                 }
//                                 return;
//                             }
// 
//                             castlingIsProhibited = !originPieceIsAKing || moveDirectionNumber < 7 || otherSquareOriginIndex > 0 || modeMaxDepth === 0 || !targetIsEmpty || !originPieceIsOnOriginalSquare || calculate(originPieceColor, 0, undefined, 0) > 10000;
// 
//                             // restore board
//                             boardState[originSquareIndex] = originSquareValue;
//                             boardState[targetSquareIndex] = targetSquareValue;
//                             boardState[otherSquareOriginIndex] = boardState[otherSquareTargetIndex];
//                             if (otherSquareOriginIndex) {
//                                 if (originPieceIsAPawn) {
//                                     // restore en passant
//                                     const targetColorPawnPieceValue = 9 ^ originPieceColor
//                                     boardState[otherSquareTargetIndex] = targetColorPawnPieceValue;
//                                 }
//                                 else {
//                                     // restore castling
//                                     boardState[otherSquareTargetIndex] = 0;
//                                 }
// 
//                             }
//                         }
//                         if (moveGameValue > bestGameValue || (depth === 0 && moveGameValue == bestGameValue && Math.random() < .5)) {
//                             bestGameValue = moveGameValue;
//                             if (modeMaxDepth === 2) {
//                                 if (depth > 0) {
//                                     if (bestGameValue > maxGameValueThatAvoidsPruning) {
//                                         return bestGameValue;
//                                     }
//                                 }
//                                 else {
//                                     highlightedSquareIndex = originSquareIndex;
//                                     clickedBoardIndex = targetSquareIndex;
//                                 }
//                             }
//                         }
// 
//                         if (castlingIsProhibited || originPlayerIsInCheck) {
//                             canAlsoCastle = false;
//                         } else {
//                             // castling
//                             otherSquareTargetIndex = targetSquareIndex;
//                             otherSquareOriginIndex = targetSquareIndex < originSquareIndex ? otherSquareTargetIndex - 3 : otherSquareTargetIndex + 2;
//                             const kingStep = targetSquareIndex - originSquareIndex;
//                             targetSquareIndex += kingStep;
//                             const rookIsUnmoved = boardState[otherSquareOriginIndex] >= 0b1111;
//                             const rookAdjacentTargetIsEmpty = boardState[otherSquareOriginIndex - kingStep] == 0;
//                             const kingTargetIsEmpty = boardState[targetSquareIndex] == 0;
//                             canAlsoCastle = rookIsUnmoved && rookAdjacentTargetIsEmpty && kingTargetIsEmpty;
//                         }
//                     } while (canAlsoCastle)
//                 }
//                 pieceCanSlide = targetIsEmpty && originPieceIsSlidey;
//                 const remainingMovesAreValidForPiece = !originPieceIsAPawn || moveDirectionNumber > 2 || (originPieceIsOnOriginalSquare && targetIsEmpty);
// 
//                 if (!pieceCanSlide) {
//                     targetSquareIndex = originSquareIndex;
// 
//                     if (remainingMovesAreValidForPiece) {
//                         initialMoveDirectionIndex++;
//                         moveDirectionNumber--;
//                     }
//                 }
//                 thereAreMoreMoves = remainingMovesAreValidForPiece && moveDirectionNumber !== 0;
// 
//             } while (pieceCanSlide || thereAreMoreMoves)
// 
//         }
//     }
// 
//     const returnValueCondition = (bestGameValue > 768 - winGameValue) || originPlayerIsInCheck;
//     const positionGameValue = returnValueCondition ? bestGameValue : 0;
//     return positionGameValue;
// }
// 
// const onClick = (eventBoardIndex) => {
//     clickedBoardIndex = eventBoardIndex;
//     const boardValueIsWhitePiece = (boardState[clickedBoardIndex] & whiteColor) !== 0;
//     if (boardValueIsWhitePiece) {
//         highlightedSquareIndex = clickedBoardIndex;
//         renderHtml();
//     } else {
//         calculate(blackColor, 0, newEnPassantPawnIndex, 1);
//     }
// }