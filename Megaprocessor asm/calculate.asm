BOOL_FALSE   EQU 0x00;
BOOL_TRUE    EQU 0xFF;

PIECE_COLOUR_MASK   EQU 0b00001000;
PIECE_COLOUR_WHITE  EQU 0b00001000;
PIECE_COLOUR_BLACK  EQU 0b00000000;

UNMOVED_PIECE       EQU 0b00110000;
PIECE_VALUE_MASK    EQU 0b00001111;

PIECE_ENUM_MASK     EQU 0b00000111;
PIECE_ENUM_EMPTY    EQU 0b00000000;
PIECE_ENUM_PAWN     EQU 0b00000001;
PIECE_ENUM_KING     EQU 0b00000010;
PIECE_ENUM_KNIGHT   EQU 0b00000011;
PIECE_ENUM_BISHOP   EQU 0b00000100;
PIECE_ENUM_ROOK     EQU 0b00000101;
PIECE_ENUM_QUEEN    EQU 0b00000110;
PIECE_ENUM_OFFBOARD EQU 0b00000111;

PIECE_ENUM_WHITE_PAWN EQU PIECE_COLOUR_WHITE + PIECE_ENUM_PAWN;

PIECE_GAMEVALUE_EMPTY           EQU 0;
PIECE_GAMEVALUE_PAWN            EQU 14;
PIECE_GAMEVALUE_KING            EQU 0;
PIECE_GAMEVALUE_KNIGHT          EQU 40;
PIECE_GAMEVALUE_BISHOP          EQU 38;
PIECE_GAMEVALUE_ROOK            EQU 68;
PIECE_GAMEVALUE_QUEEN           EQU 124;
PIECE_GAMEVALUE_QUEEN_PAWN_DIFF EQU PIECE_GAMEVALUE_QUEEN - PIECE_GAMEVALUE_PAWN;

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
CALCULATE_LOCAL_castlingIsProhibited EQU CALCULATE_LOCAL;
CALCULATE_LOCAL_moveGameValue EQU CALCULATE_LOCAL_castlingIsProhibited + 2;
CALCULATE_LOCAL_targetSquareValueAfterMoving EQU CALCULATE_LOCAL_moveGameValue + 2;
CALCULATE_LOCAL_otherSquareTargetIndex EQU CALCULATE_LOCAL_targetSquareValueAfterMoving + 2;
CALCULATE_LOCAL_otherSquareOriginIndex EQU CALCULATE_LOCAL_otherSquareTargetIndex + 2;
CALCULATE_LOCAL_targetSquareValue EQU CALCULATE_LOCAL_otherSquareOriginIndex + 2;
CALCULATE_LOCAL_targetSquareIndex EQU CALCULATE_LOCAL_targetSquareValue + 2;
CALCULATE_LOCAL_moveDirectionIndex EQU CALCULATE_LOCAL_targetSquareIndex + 2;
CALCULATE_LOCAL_moveDirectionNumber EQU CALCULATE_LOCAL_moveDirectionIndex + 2;
CALCULATE_LOCAL_originPieceIsSlidey EQU CALCULATE_LOCAL_moveDirectionNumber + 2;
CALCULATE_LOCAL_originPieceIsAKing EQU CALCULATE_LOCAL_originPieceIsSlidey + 2;
CALCULATE_LOCAL_originPieceIsAPawn EQU CALCULATE_LOCAL_originPieceIsAKing + 2;
CALCULATE_LOCAL_originPieceIsOnOriginalSquare EQU CALCULATE_LOCAL_originPieceIsAPawn + 2;
CALCULATE_LOCAL_colorlessOriginPieceValue EQU CALCULATE_LOCAL_originPieceIsOnOriginalSquare + 2;
CALCULATE_LOCAL_movedOriginPieceValue EQU CALCULATE_LOCAL_colorlessOriginPieceValue + 2;
CALCULATE_LOCAL_originSquareValue EQU CALCULATE_LOCAL_movedOriginPieceValue + 2;
CALCULATE_LOCAL_originSquareIndex EQU CALCULATE_LOCAL_originSquareValue + 2;
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
calculate:                                                       // const calculate = (opponentPieceColor, depth, enPassantPawnIndex, modeMaxDepth, maxGameValueThatAvoidsPruning) => {
LD.B R0, #0;
PUSH R0;                                                         //     dim originPieceColor;
PUSH R0;                                                         //     dim bestGameValue;
PUSH R0;                                                         //     dim originPlayerIsInCheck;
PUSH R0;                                                         //     dim winGameValue;
PUSH R0;                                                         //     dim singlePawnJump;
PUSH R0;                                                         //     dim originSquareIndex;
PUSH R0;                                                         //     dim originSquareValue;
PUSH R0;                                                         //     dim movedOriginPieceValue;
PUSH R0;                                                         //     dim colorlessOriginPieceValue;
PUSH R0;                                                         //     dim originPieceIsOnOriginalSquare;
PUSH R0;                                                         //     dim originPieceIsAPawn;
PUSH R0;                                                         //     dim originPieceIsAKing;
PUSH R0;                                                         //     dim originPieceIsSlidey;
PUSH R0;                                                         //     dim moveDirectionNumber;
PUSH R0;                                                         //     dim moveDirectionIndex;
PUSH R0;                                                         //     dim targetSquareIndex;
PUSH R0;                                                         //     dim targetSquareValue;
PUSH R0;                                                         //     dim otherSquareOriginIndex;
PUSH R0;                                                         //     dim otherSquareTargetIndex;
PUSH R0;                                                         //     dim targetSquareValueAfterMoving;
PUSH R0;                                                         //     dim moveGameValue;
PUSH R0;                                                         //     dim castlingIsProhibited;

LD.B R0, (SP + CALCULATE_ARG_opponentPieceColor);
LD.B R1, #PIECE_COLOUR_MASK;
XOR R1, R0;
ST.B (SP + CALCULATE_LOCAL_originPieceColor), R1;                //     originPieceColor = opponentPieceColor ^ PIECE_COLOUR_MASK;

LD.W R0, #-32768;
ST.W (SP + CALCULATE_LOCAL_bestGameValue), R1;                   //     bestGameValue = -32768;

LD.B R0, #BOOL_FALSE;
ST.B (SP + CALCULATE_LOCAL_originPlayerIsInCheck), R0;
LD.B R0, (SP + CALCULATE_ARG_modeMaxDepth);
BNE calculate_originPlayerIsInCheck_notModeZero;                 //     if(modeMaxDepth == 0) {
// TODO TODO TODO TODO TODO                                      //         originPlayerIsInCheck = calculate(originPieceColor, 0, undefined, 0) > 10000;
calculate_originPlayerIsInCheck_notModeZero:                     //     } else {
                                                                 //         originPlayerIsInCheck = false;
                                                                 //     }

LD.W R1, #32767;                                                 //     winGameValue = 32767;
LD.B R0, (SP + CALCULATE_ARG_depth);
BEQ calculate_winGameValue_depthZero;                            //     if(depth != 0) {
LD.W R3, #-512;
LD.B R2, #1;
CMP R0, R2;
BEQ calculate_winGameValue_depthOne;                             //         if(depth != 1) {

ADD R1, R3;                                                      //             winGameValue -= 512 * 2;  // depth=2 => winGameValue = 31743
calculate_winGameValue_depthOne:                                 //         } else {
ADD R1, R3;                                                      //             winGameValue -= 512;      // depth=1 => winGameValue = 32255
                                                                 //         }
calculate_winGameValue_depthZero:                                //     } else {
                                                                 //         winGameValue -= 0;            // depth=0 => winGameValue = 32767
                                                                 //     }
ST.W (SP + CALCULATE_LOCAL_winGameValue), R1;

LD.B R1, #10;                                                    //     singlePawnJump = 10; // pawn direction for origin piece
LD.B R0, (SP + CALCULATE_LOCAL_originPieceColor);
LD.B R2, #PIECE_COLOUR_WHITE;
CMP R0, R2;
BNE calculate_singlePawnJump_black;                              //     if(originPieceColor == whiteColor) {
NEG R1;                                                          //         singlePawnJump = -singlePawnJump;
calculate_singlePawnJump_black:                                  //     }
ST.B (SP + CALCULATE_LOCAL_singlePawnJump), R1;

LD.B R0, #21;
ST.B (SP + CALCULATE_LOCAL_originSquareIndex), R0;               //     originSquareIndex = 21;
calculate_forloop_start:                                         //     do {

LD.W R2, #boardState;
ADD R2, R0;
LD.B R0, (R2);
ST.B (SP + CALCULATE_LOCAL_originSquareValue), R0;               //         originSquareValue = boardState[originSquareIndex];

BNE calculate_originSquareValue_notEmpty;                        //         if(     originSquareValue !== PIECE_ENUM_EMPTY && 
JMP calculate_handleOriginPiece_blockEnd;
calculate_originSquareValue_notEmpty:

LD.B R1,#PIECE_ENUM_OFFBOARD;
CMP R0,R1;
BNE calculate_originSquareValue_notOffBoard;                     //                 originSquareValue !== PIECE_ENUM_OFFBOARD &&
JMP calculate_handleOriginPiece_blockEnd;
calculate_originSquareValue_notOffBoard:

LD.B R1, #PIECE_COLOUR_MASK;
AND R1,R0;
LD.B R2, (SP + CALCULATE_LOCAL_originPieceColor);
CMP R1,R2;
BEQ calculate_originSquareValue_notOriginColor;                  //                 (originSquareValue & PIECE_COLOUR_MASK) === originPieceColor) {
JMP calculate_handleOriginPiece_blockEnd;
calculate_originSquareValue_notOriginColor:

LD.B R1, #PIECE_VALUE_MASK;
AND R1,R0;
ST.B (SP + CALCULATE_LOCAL_movedOriginPieceValue), R1;           //             movedOriginPieceValue = originSquareValue & PIECE_VALUE_MASK;

XOR R2,R1;
ST.B (SP + CALCULATE_LOCAL_colorlessOriginPieceValue), R2;       //             colorlessOriginPieceValue = movedOriginPieceValue ^ originPieceColor; // pawn 1, king 2, knight 3, bishop 4, rook 5, queen 6

LD.B R3, #BOOL_FALSE;
CMP R0,R1;
BEQ calculate_originSquareValue_pieceHasMoved;
LD.B R3, #BOOL_TRUE;
calculate_originSquareValue_pieceHasMoved:
ST.B (SP + CALCULATE_LOCAL_originPieceIsOnOriginalSquare), R3;   //             originPieceIsOnOriginalSquare = (originSquareValue !== movedOriginPieceValue);

LD.B R3, #BOOL_FALSE;
LD.B R0, #PIECE_ENUM_PAWN;
CMP R2,R0;
BNE calculate_originSquareValue_isNotPawn;
LD.B R3, #BOOL_TRUE;
calculate_originSquareValue_isNotPawn:
ST.B (SP + CALCULATE_LOCAL_originPieceIsAPawn), R3;              //             originPieceIsAPawn = (colorlessOriginPieceValue === PIECE_ENUM_PAWN);

LD.B R3, #BOOL_FALSE;
LD.B R0, #PIECE_ENUM_KING;
CMP R2,R0;
BNE calculate_originSquareValue_isNotKing;
LD.B R3, #BOOL_TRUE;
calculate_originSquareValue_isNotKing:
ST.B (SP + CALCULATE_LOCAL_originPieceIsAKing), R3;              //             originPieceIsAKing = (colorlessOriginPieceValue === PIECE_ENUM_KING);

LD.B R3, #BOOL_FALSE;
LD.B R0, #4;
CMP R2,R0;
BLT calculate_originSquareValue_isNotSlidey;
LD.B R3, #BOOL_TRUE;
calculate_originSquareValue_isNotSlidey:
ST.B (SP + CALCULATE_LOCAL_originPieceIsSlidey), R3;             //             originPieceIsSlidey = (colorlessOriginPieceValue >= 4);

LD.B R3, #4;
LD.B R0, #0b0010;
AND R0,R2;
BEQ calculate_originSquareValue_isNot8Directional;
LD.B R3, #8;
calculate_originSquareValue_isNot8Directional:
ST.B (SP + CALCULATE_LOCAL_moveDirectionNumber), R3;             //             moveDirectionNumber = (colorlessOriginPieceValue & 2) ? 8 : 4; // number of move directions: pawn 4, king 8, knight 8, bishop 4, rook 4, queen 8

LD.B R3, #-1;
ADD R3,R1;
ADD R3,R3;  // double as each value is a word
LD.W R2, #calculate_initial_move_direction_indexes;
ADD R3,R2;
LD.W R0, (R3);
ST.W (SP + CALCULATE_LOCAL_moveDirectionIndex), R0;              //             moveDirectionIndex = initialMoveDirectionIndexes[movedOriginPieceValue - 1];

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
ST.B (SP + CALCULATE_LOCAL_targetSquareIndex), R0;               //             targetSquareIndex = originSquareIndex;

calculate_more_moves_loop_start:                                 //             do {
LD.B R0, (SP + CALCULATE_LOCAL_targetSquareIndex);
LD.W R2, (SP + CALCULATE_LOCAL_moveDirectionIndex);
LD.B R1, (R2);
ADD R0,R2;
ST.B (SP + CALCULATE_LOCAL_targetSquareIndex), R0;               //                 targetSquareIndex += moveDirections[moveDirectionIndex];

LD.W R2, #boardState;
ADD R2, R1;
LD.B R1, (R2);
ST.B (SP + CALCULATE_LOCAL_targetSquareValue), R1;               //                 targetSquareValue = boardState[targetSquareIndex];

LD.B R3, #0;
ST.B (SP + CALCULATE_LOCAL_otherSquareOriginIndex), R3;          //                 otherSquareOriginIndex = 0;
ST.B (SP + CALCULATE_LOCAL_otherSquareTargetIndex), R3;          //                 otherSquareTargetIndex = 0;

                                                                 //                 let originCanMoveToTarget;
BNE calculate__target_not_empty;                                 //                 if(targetSquareValue === PIECE_ENUM_EMPTY) {

LD.B R2, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BNE calculate__empty_target_origin_pawn;                         //                     if(!originPieceIsAPawn) {

JMP calculate__origin_can_move_to_target_block_start;            //                         originCanMoveToTarget = true;

calculate__empty_target_origin_pawn:                             //                     } else {


LD.B R2, (SP + CALCULATE_LOCAL_singlePawnJump);
MOVE R3, R0;
SUB R3,R2;
LD.B R2, (SP + CALCULATE_ARG_enPassantPawnIndex);
CMP R3, R2;                                                      //                         const originPieceCouldTakeEnPassant = targetSquareIndex - singlePawnJump === enPassantPawnIndex;
BNE calculate__cannot_take_enpassant;                            //                         if(originPieceCouldTakeEnPassant) {

ST.B (SP + CALCULATE_LOCAL_otherSquareOriginIndex), R2;          //                             otherSquareOriginIndex = enPassantPawnIndex; // index of pawn to be taken en passant
ST.B (SP + CALCULATE_LOCAL_otherSquareTargetIndex), R2;          //                             otherSquareTargetIndex = otherSquareOriginIndex;
JMP calculate__origin_can_move_to_target_block_start;            //                             originCanMoveToTarget = true;

calculate__cannot_take_enpassant:                                 //                         } else {
LD.B R2, (SP + CALCULATE_LOCAL_moveDirectionNumber);
LD.B R3, #2;
CMP R2,R3;
BLE calculate__origin_can_move_to_target_block_start;            //                             originCanMoveToTarget = moveDirectionNumber <= 2;
JMP calculate__origin_can_move_to_target_block_end;
                                                                 //                         }
                                                                 //                     }
calculate__target_not_empty:                                     //                 } else {

LD.B R3, #PIECE_COLOUR_MASK;
AND R3,R1;
LD.B R2, (SP + CALCULATE_ARG_opponentPieceColor);
CMP R3,R2;                                                       //                     const targetIsAPieceOfOppositeColor = (targetSquareValue & PIECE_COLOUR_MASK) === opponentPieceColor;
BNE calculate__non_empty_target_not_opponent;                    //                     if (targetIsAPieceOfOppositeColor) {

LD.B R2, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BEQ calculate__origin_can_move_to_target_block_start;            //                         originCanMoveToTarget = !originPieceIsAPawn

LD.B R2, (SP + CALCULATE_LOCAL_moveDirectionNumber);
LD.B R3, #2;
CMP R2,R3;
BGT calculate__origin_can_move_to_target_block_start;            //                             || moveDirectionNumber > 2;
// Falls through to JMP
calculate__non_empty_target_not_opponent:                        //                     } else {
JMP calculate__origin_can_move_to_target_block_end;              //                         originCanMoveToTarget = false;
                                                                 //                     }
                                                                 //                 }

                                                                 //                 if (originCanMoveToTarget) {
calculate__origin_can_move_to_target_block_start:

LD.B R2, #PIECE_ENUM_MASK;
AND R2, R1;
LD.B R3, #PIECE_ENUM_KING;
CMP R2,R3;                                                       //                     const targetIsAKing = (targetSquareValue & PIECE_ENUM_MASK) === PIECE_ENUM_KING;
BNE calculate__target_not_king;                                  //                     if (targetIsAKing) {
                                                                 //                         // previous state was in check
LD.W R3, (SP + CALCULATE_LOCAL_winGameValue);
ST.W calculate_returnValue, R3;
include "calculate_return.asm";                                  //                         return winGameValue;
calculate__target_not_king:                                      //                     }

LD.B R3, (SP + CALCULATE_LOCAL_movedOriginPieceValue);
ST.B (SP + CALCULATE_LOCAL_targetSquareValueAfterMoving), R3;    //                     targetSquareValueAfterMoving = movedOriginPieceValue;

LD.B R2, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BEQ calculate__makeMove_loop_start;                              //                     if(originPieceIsAPawn) {

LD.W R2, #boardState;
ADD R2, R0;
LD.B R3, (SP + CALCULATE_LOCAL_singlePawnJump);
ADD R2, R3;
LD.B R0, (R2);
LD.B R2, #PIECE_ENUM_OFFBOARD;
CMP R0,R2;
BNE calculate__makeMove_loop_start;                              //                         if(boardState[targetSquareIndex + singlePawnJump] === offBoardValue) {

LD.B R2, #PIECE_ENUM_QUEEN;
LD.B R3, (SP + CALCULATE_LOCAL_originPieceColor);
AND R3,R2;
ST.B (SP + CALCULATE_LOCAL_targetSquareValueAfterMoving), R3;    //                             targetSquareValueAfterMoving = queenPieceValue ^ originPieceColor;
                                                                 //                         }
                                                                 //                     }

calculate__makeMove_loop_start:                                  //                     do {

LD.B R1, #0;                                                     //                         moveGameValue = 0;
LD.B R3, (SP + CALCULATE_LOCAL_targetSquareValue);
BEQ calculate__target_is_empty;                                  //                         if(targetSquareValue === PIECE_ENUM_EMPTY) {
                                                                 //                         {
LD.B R2, #PIECE_ENUM_MASK;
AND R3,R2;                                                       //                             const colorlessTargetPieceValue = targetSquareValue & PIECE_ENUM_MASK;
LD.W R2, #calculate_piece_game_values;
ADD R2,R3;
LD.B R1,(R2);                                                    //                             const targetSquareGameValue = pieceGameValues[colorlessTargetPieceValue];
LD.B R2, (SP + CALCULATE_ARG_depth);
SUB R1,R2;
LD.B R2, (SP + CALCULATE_LOCAL_colorlessOriginPieceValue);
SUB R1,R2;                                                       //                             // prefer big capture, prefer quick capture, prefer capture by smaller valued piece, prefer capture
INC R1;                                                          //                             moveGameValue = targetSquareGameValue - depth - colorlessOriginPieceValue + 1;

calculate__target_is_empty:                                      //                         }

LD.B R2, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BEQ calculate__set_moveGameValue;                                //                         if (originPieceIsAPawn) {

LD.B R2, (SP + CALCULATE_LOCAL_moveDirectionNumber);
DEC R2;                                                          //                             const pawnMovedForwardTwo = moveDirectionNumber <= 1
BGT calculate__not_pawn_double_move;                             //                             if(pawnMovedForwardTwo) {

ADDQ R1, #2;                                                     //                                  moveGameValue += 2;
JMP calculate__set_moveGameValue;
calculate__not_pawn_double_move:                                 //                             } else {

LD.B R2, (SP + CALCULATE_LOCAL_targetSquareValueAfterMoving);
LD.B R3, (SP + CALCULATE_LOCAL_movedOriginPieceValue);
CMP R2,R3;                                                       //                                 const pawnPromoted = targetSquareValueAfterMoving > movedOriginPieceValue;
BLE calculate__not_pawn_promoted;                                //                                 if (pawnPromoted) {

LD.B R3, #PIECE_GAMEVALUE_QUEEN_PAWN_DIFF;
ADD R1,R3;                                                       //                                     moveGameValue += PIECE_GAMEVALUE_QUEEN - PIECE_GAMEVALUE_PAWN;
JMP calculate__set_moveGameValue;
calculate__not_pawn_promoted:                                    //                                 } else {

LD.B R2, (SP + CALCULATE_LOCAL_otherSquareOriginIndex);          //                                     const pawnTookEnPassant = otherSquareOriginIndex !== 0;
BEQ calculate__not_pawn_took_enpassant;                          //                                     if (pawnTookEnPassant) {

LD.B R2, #PIECE_GAMEVALUE_PAWN;
ADD R1,R2;                                                       //                                         moveGameValue += pawnGameValue + 1;
// Falls through to also INC

calculate__not_pawn_took_enpassant:                              //                                     } else {
INC R1;                                                          //                                         moveGameValue += 1;
                                                                 //                                     }
                                                                 //                                 }
                                                                 //                             }

calculate__set_moveGameValue:                                    //                         }
ST.W (SP + CALCULATE_LOCAL_moveGameValue), R1;

LD.B R0, #BOOL_TRUE;
ST.W (SP + CALCULATE_LOCAL_castlingIsProhibited), R0;            //                         castlingIsProhibited = true;

LD.B R2, (SP + CALCULATE_ARG_modeMaxDepth);
LD.B R3, (SP + CALCULATE_ARG_depth);
CMP R2,R3;
BGT calculate__can_go_deeper;                                    //                         if (modeMaxDepth > depth ||

LD.B R0, #2;
CMP R2,R0;
BNE calculate__cannot_go_deeper;                                 //                             (modeMaxDepth === 2 &&

CMP R2,R3;
BNE calculate__cannot_go_deeper;                                 //                             modeMaxDepth === depth &&

CMP R1,R0;
BGT calculate__can_go_deeper;                                    //                             (moveGameValue > 2 ||

LD.B R2, (SP + CALCULATE_LOCAL_originPlayerIsInCheck);
BNE calculate__can_go_deeper;                                    //                             originPlayerIsInCheck))) {

calculate__cannot_go_deeper:
JMP calculate__can_go_deeper_blockend;

calculate__can_go_deeper:

LD.W R2, #boardState;
LD.B R3, (SP + CALCULATE_LOCAL_targetSquareIndex);
ADD R2,R3;
LD.B R1, (SP + CALCULATE_LOCAL_targetSquareValueAfterMoving);
ST.B (R2), R1;                                                   //                             boardState[targetSquareIndex] = targetSquareValueAfterMoving;

LD.W R2, #boardState;
LD.B R3, (SP + CALCULATE_LOCAL_otherSquareOriginIndex);
ADD R2,R3;
LD.B R1, (R2);
LD.W R2, #boardState;
LD.B R0, (SP + CALCULATE_LOCAL_otherSquareTargetIndex);
ADD R2,R0;
ST.B (R2), R1;                                                   //                             boardState[otherSquareTargetIndex] = boardState[otherSquareOriginIndex];

TEST R3;
BNE calculate__otherSquareOriginIndexNotSet;                     //                             if (otherSquareOriginIndex) {

LD.W R2, #boardState;
ADD R3,R2;
LD.W R1, #PIECE_ENUM_EMPTY;
ST.B (R3), R1;                                                   //                                 boardState[otherSquareOriginIndex] = PIECE_ENUM_EMPTY;
calculate__otherSquareOriginIndexNotSet:                         //                             }

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
ADD R2,R0;
ST.B (R2), R1;                                                   //                             boardState[originSquareIndex] = PIECE_ENUM_EMPTY;

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
//                                 modeMaxDepth === 0 || !(targetSquareValue === PIECE_ENUM_EMPTY) || !originPieceIsOnOriginalSquare || calculate(originPieceColor, 0, undefined, 0) > 10000;
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
calculate__can_go_deeper_blockend:                               //                         }
NOP;
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
//                         let canAlsoCastle;
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

calculate__origin_can_move_to_target_block_end:                  //                 }

LD.B R0, (SP + CALCULATE_LOCAL_targetSquareValue);
BNE calculate__pieceCannotSlide;                                 //                 let pieceCanSlide = (targetSquareValue === PIECE_ENUM_EMPTY)

LD.B R0, (SP + CALCULATE_LOCAL_originPieceIsSlidey);
BEQ calculate__pieceCannotSlide;                                 //                     && originPieceIsSlidey;

                                                                 //                 let thereAreMoreMoves;
                                                                 //                 if (pieceCanSlide) {
JMP calculate_more_moves_loop_start;                             //                     thereAreMoreMoves = true;

calculate__pieceCannotSlide:                                     //                 } else {
                                                                 //                     thereAreMoreMoves = false;

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
ST.B (SP + CALCULATE_LOCAL_targetSquareIndex), R0;               //                     targetSquareIndex = originSquareIndex;

                                                                 //                     const remainingMovesAreValidForPiece = 
LD.B R0, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BEQ calculate__remainingMovesAreValidForPiece;                   //                         !originPieceIsAPawn

LD.B R2, (SP + CALCULATE_LOCAL_moveDirectionNumber);
LD.B R3, #2;
CMP R2,R3;
BGT calculate__remainingMovesAreValidForPiece;                   //                         || moveDirectionNumber > 2

LD.B R0, (SP + CALCULATE_LOCAL_originPieceIsOnOriginalSquare);
BEQ calculate_handleOriginPiece_blockEnd;                        //                         || (originPieceIsOnOriginalSquare

LD.B R0, (SP + CALCULATE_LOCAL_targetSquareValue);
BNE calculate_handleOriginPiece_blockEnd;                        //                             && (targetSquareValue === PIECE_ENUM_EMPTY));
// Falls through to calculate__remainingMovesAreValidForPiece

calculate__remainingMovesAreValidForPiece:                       //                     if (remainingMovesAreValidForPiece) {
LD.B R0, (SP + CALCULATE_LOCAL_moveDirectionIndex);
INC R0;
ST.B (SP + CALCULATE_LOCAL_moveDirectionIndex), R0;              //                         moveDirectionIndex++;

LD.B R0, (SP + CALCULATE_LOCAL_moveDirectionNumber);
DEC R0;
ST.B (SP + CALCULATE_LOCAL_moveDirectionNumber), R0;             //                         moveDirectionNumber--;

BEQ calculate_handleOriginPiece_blockEnd;
JMP calculate_more_moves_loop_start;                             //                         thereAreMoreMoves = moveDirectionNumber !== 0;
                                                                 //                     }
                                                                 //                 }

                                                                 //             } while (thereAreMoreMoves)

calculate_handleOriginPiece_blockEnd:                            //         }

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
INC R0;                                                          //         originSquareIndex++;
ST.B (SP + CALCULATE_LOCAL_originSquareIndex), R0;
LD.B R1, #98;
CMP R0, R1;
BGT calculate_forloop_end;
JMP calculate_forloop_start;
calculate_forloop_end:                                           //     } while (originSquareIndex <= 98)

LD.W R2, #768;
LD.W R1, (SP + CALCULATE_LOCAL_winGameValue);
SUB R2, R1;
LD.W R0, (SP + CALCULATE_LOCAL_bestGameValue);                   //     let positionGameValue = bestGameValue;
CMP R0,R2;
BGT calculate__returnCalcValue;                                  //     if(!(bestGameValue > 768 - winGameValue) &&
LD.W R1, (SP + CALCULATE_LOCAL_originPlayerIsInCheck);
BNE calculate__returnCalcValue;                                  //         !originPlayerIsInCheck) {

LD.W R0, #0;                                                     //         positionGameValue = 0;
calculate__returnCalcValue:                                      //     }
ST.W calculate_returnValue, R0;
include "calculate_return.asm";                                  //     return positionGameValue;
                                                                 // }

on_click_return_address: DW;

on_click:                                                        // const on_click = () => {
ST.W on_click_return_address, R0;                                //
                                                                 //
LD.B R0, global_cursor_square_index;                             //
ST.B calculate_clickedBoardIndex, R0;                            //     calculate_clickedBoardIndex = global_cursor_square_index;
                                                                 //
LD.W R2, #boardState;                                            //
ADD R2,R0;                                                       //
LD.B R1, (R2);                                                   //     const clickedBoardState = boardState[calculate_clickedBoardIndex];
LD.B R3, #PIECE_COLOUR_WHITE;                                    //
AND R3,R1;                                                       //     const clickedIsWhitePiece = (clickedBoardState & whiteColor) !== 0;
BNE on_click__clickedIsWhitePiece;                               //     if (boardValueIsWhitePiece) {
JMP on_click__clickedIsOtherValue;                               //
on_click__clickedIsWhitePiece:                                   //
ST.B global_selected_square_index, R0;                           //         global_selected_square_index = calculate_clickedBoardIndex;
                                                                 //
LD.W R0, #on_click__return;                                      //         // TODO improve performance by refreshing just the relevant squares
JMP draw_board;                                                  //         draw_board();
                                                                 //
on_click__clickedIsOtherValue:                                   //     } else {
                                                                 //
LD.W R0, #0x8000;                                                //
MOVE SP, R0;                                                     //         // reset SP
LD.B R0, #PIECE_COLOUR_BLACK;                                    //
PUSH R0;                                                         //         // push CALCULATE_ARG_opponentPieceColor
LD.B R0, #0;                                                     //
PUSH R0;                                                         //         // push CALCULATE_ARG_depth
LD.B R0, calculate_newEnPassantPawnIndex;                        //
PUSH R0;                                                         //         // push CALCULATE_ARG_enPassantPawnIndex
LD.B R0, #MODE1_CHECK_CAN_MOVE;                                  //
PUSH R0;                                                         //         // push CALCULATE_ARG_modeMaxDepth
LD.W R0, #0;                                                     //
PUSH R0;                                                         //         // push CALCULATE_ARG_maxGameValueThatAvoidsPruning
                                                                 //
include "calculate_call.asm";                                    //         calculate(PIECE_COLOUR_BLACK, 0, calculate_newEnPassantPawnIndex, MODE1_CHECK_CAN_MOVE, 0);
                                                                 //     }
on_click__return:                                                //
LD.W R0, on_click_return_address;                                //
JMP (R0);                                                        //     return;
                                                                 // };