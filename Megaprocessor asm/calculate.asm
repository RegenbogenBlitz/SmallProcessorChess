PIECE_COLOUR_MASK   EQU 0b00001000;
PIECE_COLOUR_WHITE  EQU 0b00001000;
PIECE_COLOUR_BLACK  EQU 0b00000000;

UNMOVED_PIECE       EQU 0b00110000;

PIECE_ENUM_EMPTY    EQU 0b00000000;
PIECE_ENUM_PAWN     EQU 0b00000001;
PIECE_ENUM_KING     EQU 0b00000010;
PIECE_ENUM_KNIGHT   EQU 0b00000011;
PIECE_ENUM_BISHOP   EQU 0b00000100;
PIECE_ENUM_ROOK     EQU 0b00000101;
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

UNMOVED_BLACK_PAWN   EQU UNMOVED_PIECE + PIECE_COLOUR_BLACK + PIECE_ENUM_PAWN;
UNMOVED_BLACK_KING   EQU UNMOVED_PIECE + PIECE_COLOUR_BLACK + PIECE_ENUM_KING;
UNMOVED_BLACK_KNIGHT EQU UNMOVED_PIECE + PIECE_COLOUR_BLACK + PIECE_ENUM_KNIGHT;
UNMOVED_BLACK_BISHOP EQU UNMOVED_PIECE + PIECE_COLOUR_BLACK + PIECE_ENUM_BISHOP;
UNMOVED_BLACK_ROOK   EQU UNMOVED_PIECE + PIECE_COLOUR_BLACK + PIECE_ENUM_ROOK;
UNMOVED_BLACK_QUEEN  EQU UNMOVED_PIECE + PIECE_COLOUR_BLACK + PIECE_ENUM_QUEEN;

UNMOVED_WHITE_PAWN   EQU UNMOVED_PIECE + PIECE_COLOUR_WHITE + PIECE_ENUM_PAWN;
UNMOVED_WHITE_KING   EQU UNMOVED_PIECE + PIECE_COLOUR_WHITE + PIECE_ENUM_KING;
UNMOVED_WHITE_KNIGHT EQU UNMOVED_PIECE + PIECE_COLOUR_WHITE + PIECE_ENUM_KNIGHT;
UNMOVED_WHITE_BISHOP EQU UNMOVED_PIECE + PIECE_COLOUR_WHITE + PIECE_ENUM_BISHOP;
UNMOVED_WHITE_ROOK   EQU UNMOVED_PIECE + PIECE_COLOUR_WHITE + PIECE_ENUM_ROOK;
UNMOVED_WHITE_QUEEN  EQU UNMOVED_PIECE + PIECE_COLOUR_WHITE + PIECE_ENUM_QUEEN;

boardState:
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD; // 0-9
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD; // 10-19
DB PIECE_ENUM_OFFBOARD, UNMOVED_BLACK_ROOK,  UNMOVED_BLACK_KNIGHT, UNMOVED_BLACK_BISHOP, UNMOVED_BLACK_QUEEN, UNMOVED_BLACK_KING,  UNMOVED_BLACK_BISHOP, UNMOVED_BLACK_KNIGHT, UNMOVED_BLACK_ROOK,  PIECE_ENUM_OFFBOARD; // 20-29  rank 8
DB PIECE_ENUM_OFFBOARD, UNMOVED_BLACK_PAWN,  UNMOVED_BLACK_PAWN,   UNMOVED_BLACK_PAWN,   UNMOVED_BLACK_PAWN,  UNMOVED_BLACK_PAWN,  UNMOVED_BLACK_PAWN,   UNMOVED_BLACK_PAWN,   UNMOVED_BLACK_PAWN,  PIECE_ENUM_OFFBOARD; // 30-39  rank 7
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_OFFBOARD; // 40-49  rank 6
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_OFFBOARD; // 50-59  rank 5
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_OFFBOARD; // 60-69  rank 4
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,    PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,     PIECE_ENUM_EMPTY,    PIECE_ENUM_OFFBOARD; // 70-79  rank 3
DB PIECE_ENUM_OFFBOARD, UNMOVED_WHITE_PAWN,  UNMOVED_WHITE_PAWN,   UNMOVED_WHITE_PAWN,   UNMOVED_WHITE_PAWN,  UNMOVED_WHITE_PAWN,  UNMOVED_WHITE_PAWN,   UNMOVED_WHITE_PAWN,   UNMOVED_WHITE_PAWN,  PIECE_ENUM_OFFBOARD; // 80-89  rank 2
DB PIECE_ENUM_OFFBOARD, UNMOVED_WHITE_ROOK,  UNMOVED_WHITE_KNIGHT, UNMOVED_WHITE_BISHOP, UNMOVED_WHITE_QUEEN, UNMOVED_WHITE_KING,  UNMOVED_WHITE_BISHOP, UNMOVED_WHITE_KNIGHT, UNMOVED_WHITE_ROOK,  PIECE_ENUM_OFFBOARD; // 90-99  rank 1
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD; // 100-109
DB PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD,  PIECE_ENUM_OFFBOARD, PIECE_ENUM_OFFBOARD; // 110-119

calculate_newEnPassantPawnIndex:
DB 0;
calculate_clickedBoardIndex:
DB 0;
calculate_returnValue:
DW 0;

MODE0_CHECK_FOR_CHECK EQU 0;
MODE1_CHECK_CAN_MOVE  EQU 1;
MODE2_CALCULATE_MOVE  EQU 2;

CALCULATE_LOCAL EQU 0;
CALCULATE_LOCAL_originSquareIndex EQU CALCULATE_LOCAL;
CALCULATE_LOCAL_singlePawnJump EQU CALCULATE_LOCAL_originSquareIndex + 2;
CALCULATE_LOCAL_winGameValue EQU CALCULATE_LOCAL_singlePawnJump + 2;
CALCULATE_LOCAL_originPlayerIsInCheck EQU CALCULATE_LOCAL_winGameValue + 2;
CALCULATE_LOCAL_bestGameValue EQU CALCULATE_LOCAL_originPlayerIsInCheck + 2;
CALCULATE_LOCAL_originPieceColor EQU CALCULATE_LOCAL_bestGameValue + 2;

CALCULATE_returnAddress EQU CALCULATE_LOCAL_originPieceColor + 2;

CALCULATE_ARG EQU CALCULATE_returnAddress + 2;

CALCULATE_ARG_maxGameValueThatAvoidsPruning EQU CALCULATE_ARG;
CALCULATE_ARG_modeMaxDepth EQU CALCULATE_ARG_maxGameValueThatAvoidsPruning + 2;
CALCULATE_ARG_enPassantPawnIndex EQU CALCULATE_ARG_modeMaxDepth + 2;
CALCULATE_ARG_depth EQU CALCULATE_ARG_enPassantPawnIndex + 2;
CALCULATE_ARG_opponentPieceColor EQU CALCULATE_ARG_depth + 2;

// MUST BE CALLED USING JSR and the stack
calculate:                                           // const calculate = (opponentPieceColor, depth, enPassantPawnIndex, modeMaxDepth, maxGameValueThatAvoidsPruning) => {
LD.B R0, #0;
PUSH R0;                                             //     dim originPieceColor;
PUSH R0;                                             //     dim bestGameValue;
PUSH R0;                                             //     dim originPlayerIsInCheck;
PUSH R0;                                             //     dim winGameValue;
PUSH R0;                                             //     dim singlePawnJump;
PUSH R0;                                             //     dim originSquareIndex;

LD.B R0, (SP + CALCULATE_ARG_opponentPieceColor);
LD.B R1, #PIECE_COLOUR_MASK;
XOR R1, R0;
ST.B (SP + CALCULATE_LOCAL_originPieceColor), R1;    //     originPieceColor = opponentPieceColor ^ PIECE_COLOUR_MASK;

LD.W R0, #-32768;
ST.W (SP + CALCULATE_LOCAL_bestGameValue), R1;       //     bestGameValue = -32768;

LD.B R0, #0;
ST.B (SP + CALCULATE_LOCAL_originPlayerIsInCheck), R0;
LD.B R0, (SP + CALCULATE_ARG_modeMaxDepth);
BNE calculate_originPlayerIsInCheck_notModeZero;     //     if(modeMaxDepth == 0) {
// TODO TODO TODO TODO TODO                          //         originPlayerIsInCheck = calculate(originPieceColor, 0, undefined, 0) > 10000;
calculate_originPlayerIsInCheck_notModeZero:         //     } else {
                                                     //         originPlayerIsInCheck = false;
                                                     //     }

LD.W R1, #32767;                                     //     winGameValue = 32767;
LD.B R0, (SP + CALCULATE_ARG_depth);
BEQ calculate_winGameValue_depthZero;                //     if(depth != 0) {
LD.W R3, #-512;
LD.B R2, #1;
CMP R0, R2;
BEQ calculate_winGameValue_depthOne;                 //         if(depth != 1) {

ADD R1, R3;                                          //             winGameValue -= 512 * 2;  // depth=2 => winGameValue = 31743
calculate_winGameValue_depthOne:                     //         } else {
ADD R1, R3;                                          //             winGameValue -= 512;      // depth=1 => winGameValue = 32255
                                                     //         }
calculate_winGameValue_depthZero:                    //     } else {
                                                     //         winGameValue -= 0;            // depth=0 => winGameValue = 32767
                                                     //     }
ST.W (SP + CALCULATE_LOCAL_winGameValue), R1;

LD.B R1, #10;                                        //     singlePawnJump = 10; // pawn direction for origin piece
LD.B R0, (SP + CALCULATE_LOCAL_originPieceColor);
LD.B R2, #PIECE_COLOUR_WHITE;
CMP R0, R2;
BNE calculate_singlePawnJump_black;                  //     if(originPieceColor == whiteColor) {
NEG R1;                                              //         singlePawnJump = -singlePawnJump;
calculate_singlePawnJump_black:                      //     }
ST.B (SP + CALCULATE_LOCAL_singlePawnJump), R1;

LD.B R0, #21;
ST.B (SP + CALCULATE_LOCAL_originSquareIndex), R0;   //     originSquareIndex = 21;
calculate_forloop_start:                             //     do {

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
//                             if (depth === 0 && modeMaxDepth === 1 && global_selected_square_index === originSquareIndex && targetSquareIndex === calculate_clickedBoardIndex && moveGameValue >= -10000) {
//                                 calculate_newEnPassantPawnIndex = justMovedEnPassantPawnIndex;
//                                 global_selected_square_index = calculate_clickedBoardIndex;
//                                 renderHtml();
//                                 if (originPieceColor == whiteColor) {
//                                     setTimeout(() => {
//                                         calculate(whiteColor, 0, calculate_newEnPassantPawnIndex, 2);
//                                         calculate(whiteColor, 0, calculate_newEnPassantPawnIndex, 1);
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
//                                     global_selected_square_index = originSquareIndex;
//                                     calculate_clickedBoardIndex = targetSquareIndex;
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

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
INC R0;                                              //         originSquareIndex++;
ST.B (SP + CALCULATE_LOCAL_originSquareIndex), R0;
LD.B R1, #98;
CMP R0, R1;
BGT calculate_forloop_end;
JMP calculate_forloop_start;
calculate_forloop_end:                               //     } while (originSquareIndex <= 98)

// TODO TODO TODO TODO TODO                          //     const returnValueCondition = (bestGameValue > 768 - winGameValue) || originPlayerIsInCheck;
// TODO TODO TODO TODO TODO                          //     const positionGameValue = returnValueCondition ? bestGameValue : 0;
// TODO TODO TODO TODO TODO                          //     return positionGameValue;

LD.W R0, #0;
ST.W calculate_returnValue, R0;
include "calculate_return.asm";                      //
                                                     // }

on_click_return_address: DW;

on_click:                                    // const on_click = () => {
ST.W on_click_return_address, R0;            //
                                             //
LD.B R0, global_cursor_square_index;         //
ST.B calculate_clickedBoardIndex, R0;        //     calculate_clickedBoardIndex = global_cursor_square_index;
                                             //
LD.B R2, #boardState;                        //
ADD R2,R0;                                   //
LD.B R1, (R2);                               //     const clickedBoardState = boardState[calculate_clickedBoardIndex];
LD.B R3, #PIECE_COLOUR_WHITE;                //
AND R3,R1;                                   //     const clickedIsWhitePiece = (clickedBoardState & whiteColor) !== 0;
BNE on_click__clickedIsWhitePiece;           //     if (boardValueIsWhitePiece) {
JMP on_click__clickedIsOtherValue;           //
on_click__clickedIsWhitePiece:               //
ST.B global_selected_square_index, R0;       //         global_selected_square_index = calculate_clickedBoardIndex;
                                             //
LD.W R0, #on_click__return;                  //         // TODO improve performance by refreshing just the relevant squares
JMP draw_board;                              //         draw_board();
                                             //
on_click__clickedIsOtherValue:               //     } else {
                                             //
LD.W R0, #0x8000;                            //
MOVE SP, R0;                                 //         // reset SP
LD.B R0, #PIECE_COLOUR_BLACK;                //
PUSH R0;                                     //         // push CALCULATE_ARG_opponentPieceColor
LD.B R0, #0;                                 //
PUSH R0;                                     //         // push CALCULATE_ARG_depth
LD.B R0, calculate_newEnPassantPawnIndex;    //
PUSH R0;                                     //         // push CALCULATE_ARG_enPassantPawnIndex
LD.B R0, #MODE1_CHECK_CAN_MOVE;              //
PUSH R0;                                     //         // push CALCULATE_ARG_modeMaxDepth
LD.W R0, #0;                                 //
PUSH R0;                                     //         // push CALCULATE_ARG_maxGameValueThatAvoidsPruning
                                             //
include "calculate_call.asm";                //         calculate(PIECE_COLOUR_BLACK, 0, calculate_newEnPassantPawnIndex, MODE1_CHECK_CAN_MOVE, 0);
                                             //     }
on_click__return:                            //
LD.W R0, on_click_return_address;            //
JMP (R0);                                    //     return;
                                             // };