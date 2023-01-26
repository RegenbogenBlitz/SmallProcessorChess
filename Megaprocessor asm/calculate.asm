PIECE_COLOUR_MASK   EQU 0b00001000;
PIECE_COLOUR_WHITE  EQU 0b00001000;
PIECE_COLOUR_BLACK  EQU 0b00000000;

// 0b11xxxx not moved 0b00xxxx already moved

EMPTY_SQUARE_VALUE EQU 0b00000000;
OFFBOARD_SQUARE_VALUE EQU 0b000111;

PIECE_ENUM_EMPTY    EQU 0b00000000;
PIECE_ENUM_PAWN     EQU 0b00000001;
PIECE_ENUM_KING     EQU 0b00000010;
// 0bxxx011 knight
// 0bxxx100 bishop
// 0bxxx101 rook
PIECE_ENUM_QUEEN    EQU 0b00000110;
PIECE_ENUM_OFFBOARD EQU 0b00000111;

PIECE_ENUM_WHITE_PAWN EQU PIECE_COLOUR_WHITE + PIECE_ENUM_PAWN;

PIECE_GAMEVALUE_EMPTY EQU 0;
PIECE_GAMEVALUE_PAWN EQU 14;
PIECE_GAMEVALUE_KING EQU 0;
PIECE_GAMEVALUE_KNIGHT EQU 40;
PIECE_GAMEVALUE_BISHOP EQU 38;
PIECE_GAMEVALUE_ROOK EQU 68;
PIECE_GAMEVALUE_QUEEN EQU 124;

calculate_piece_game_values:
DB PIECE_GAMEVALUE_EMPTY;
DB PIECE_GAMEVALUE_PAWN;
DB PIECE_GAMEVALUE_KING;
DB PIECE_GAMEVALUE_KNIGHT;
DB PIECE_GAMEVALUE_BISHOP;
DB PIECE_GAMEVALUE_ROOK;
DB PIECE_GAMEVALUE_QUEEN;

calculate_rook_move_directions:
DB -1, 1, -10, 10;                   // rook move directions (& king, queen)
calculate_bishop_move_directions:
DB -11, -9, 9, 11;                   // bishop move directions (& king, queen)
calculate_blackpawn_move_directions:
DB 9, 11, 10, 20;
calculate_whitepawn_move_directions:
DB -11, -9, -10, -20;
calculate_knight_move_directions:
DB -21, -19, -12, -8, 8, 12, 19, 21;

calculate_initial_move_direction_indexes:
DW 0;
DW calculate_blackpawn_move_directions;
DW calculate_rook_move_directions; // start of kings moves
DW calculate_knight_move_directions;
DW calculate_bishop_move_directions;
DW calculate_rook_move_directions;
DW calculate_rook_move_directions; // start of queen moves
DW 0; // 7

DW 0; // 8
DW calculate_whitepawn_move_directions;
DW calculate_rook_move_directions; // start of kings moves
DW calculate_knight_move_directions;
DW calculate_bishop_move_directions;
DW calculate_rook_move_directions;
DW calculate_rook_move_directions; // start of queen moves

// Board representation

//  xxxxxxxxxx
//  xxxxxxxxxx
//  xRHBQKBHRx
//  xPPPPPPPPx
//  x........x
//  x........x
//  xppppppppx
//  xrhbqkbhrx
//  xxxxxxxxxx
//  xxxxxxxxxx

// Coordinates
//  x  x  x  x  x  x  x  x  x  x
//  x  x  x  x  x  x  x  x  x  x
//  x 21 22 23 24 25 26 27 28  x
//  x 31 32 33 34 35 36 37 38  x
//  x 41 42 43 44 45 46 47 48  x
//  x 51 52 53 54 55 56 57 58  x
//  x 61 62 63 64 65 66 67 68  x
//  x 71 72 73 74 75 76 77 78  x
//  x 81 82 83 84 85 86 87 88  x
//  x 91 92 93 94 95 96 97 98  x
//  x  x  x  x  x  x  x  x  x  x
//  x  x  x  x  x  x  x  x  x  x

// Main Representation
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7
//  7  5  3  4  6  2  4  3  5  7
//  7  1  1  1  1  1  1  1  1  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  9  9  9  9  9  9  9  9  7
//  7 13 11 12 14 10 12 11 13  7
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7

// Initial Representation
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7
//  7 53 51 52 54 50 52 51 53  7
//  7 49 49 49 49 49 49 49 49  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7 57 57 57 57 57 57 57 57  7
//  7 61 59 60 62 58 60 59 61  7
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7

board:
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 0-9
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 10-19
DB 0b000111, 0b110101, 0b110011, 0b110100, 0b110110, 0b110010, 0b110100, 0b110011, 0b110101, 0b000111; // 20-29  rank 8
DB 0b000111, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b000111; // 30-39  rank 7
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 40-49  rank 6
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 50-59  rank 5
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 60-69  rank 4
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 70-79  rank 3
DB 0b000111, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b000111; // 80-89  rank 2
DB 0b000111, 0b111101, 0b111011, 0b111100, 0b111110, 0b111010, 0b111100, 0b111011, 0b111101, 0b000111; // 90-99  rank 1
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 100-109
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 110-119

// let highlightedSquareIndex = 0;
// let newEnPassantPawnIndex = 0;
// let clickedBoardIndex = 0;

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
//                             castlingIsProhibited = 
//                                 !originPieceIsAKing || moveDirectionNumber < 7 || otherSquareOriginIndex > 0 ||
//                                 modeMaxDepth === 0 || !targetIsEmpty || !originPieceIsOnOriginalSquare || calculate(originPieceColor, 0, undefined, 0) > 10000;
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