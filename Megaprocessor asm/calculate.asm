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
DW -1, 1, -10, 10;                   // rook move directions (& king, queen)
calculate_bishop_move_directions:
DW -11, -9, 9, 11;                   // bishop move directions (& king, queen)
calculate_blackpawn_move_directions:
DW 9, 11, 10, 20;
calculate_whitepawn_move_directions:
DW -11, -9, -10, -20;
calculate_knight_move_directions:
DW -21, -19, -12, -8, 8, 12, 19, 21;

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
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 0-9
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 10-19
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 20-29  rank 8
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 30-39  rank 7
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 40-49  rank 6
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 50-59  rank 5
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 60-69  rank 4
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 70-79  rank 3
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 80-89  rank 2
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 90-99  rank 1
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 100-109
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 110-119

calculate_newEnPassantPawnIndex: DB;
calculate_clickedBoardIndex: DB;
calculate_returnValue: DW;
calculate_randomValue: DW;

calculate__reset:

LD.W R1, #0;
ST.B calculate_newEnPassantPawnIndex, R1;
ST.B calculate_clickedBoardIndex, R1;
ST.W calculate_returnValue, R1;
ST.W calculate_randomValue, R1;

LD.W R2, #boardState;

LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 0
ST.B (R2++), R1; // 1
ST.B (R2++), R1; // 2
ST.B (R2++), R1; // 3
ST.B (R2++), R1; // 4
ST.B (R2++), R1; // 5
ST.B (R2++), R1; // 6
ST.B (R2++), R1; // 7
ST.B (R2++), R1; // 8
ST.B (R2++), R1; // 9

ST.B (R2++), R1; // 10
ST.B (R2++), R1; // 11
ST.B (R2++), R1; // 12
ST.B (R2++), R1; // 13
ST.B (R2++), R1; // 14
ST.B (R2++), R1; // 15
ST.B (R2++), R1; // 16
ST.B (R2++), R1; // 17
ST.B (R2++), R1; // 18
ST.B (R2++), R1; // 19

ST.B (R2++), R1; // 20
LD.B R1, #UNMOVED_BLACK_ROOK;
ST.B (R2++), R1; // 21
LD.B R1, #UNMOVED_BLACK_KNIGHT;
ST.B (R2++), R1; // 22
LD.B R1, #UNMOVED_BLACK_BISHOP;
ST.B (R2++), R1; // 23
LD.B R1, #UNMOVED_BLACK_QUEEN;
ST.B (R2++), R1; // 24
LD.B R1, #UNMOVED_BLACK_KING;
ST.B (R2++), R1; // 25
LD.B R1, #UNMOVED_BLACK_BISHOP;
ST.B (R2++), R1; // 26
LD.B R1, #UNMOVED_BLACK_KNIGHT;
ST.B (R2++), R1; // 27
LD.B R1, #UNMOVED_BLACK_ROOK;
ST.B (R2++), R1; // 28
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 29

ST.B (R2++), R1; // 30
LD.B R1, #UNMOVED_BLACK_PAWN;
ST.B (R2++), R1; // 31
ST.B (R2++), R1; // 32
ST.B (R2++), R1; // 33
ST.B (R2++), R1; // 34
ST.B (R2++), R1; // 35
ST.B (R2++), R1; // 36
ST.B (R2++), R1; // 37
ST.B (R2++), R1; // 38
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 39

ST.B (R2++), R1; // 40
LD.B R1, #PIECE_ENUM_EMPTY;
ST.B (R2++), R1; // 41
ST.B (R2++), R1; // 42
ST.B (R2++), R1; // 43
ST.B (R2++), R1; // 44
ST.B (R2++), R1; // 45
ST.B (R2++), R1; // 46
ST.B (R2++), R1; // 47
ST.B (R2++), R1; // 48
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 49

ST.B (R2++), R1; // 50
LD.B R1, #PIECE_ENUM_EMPTY;
ST.B (R2++), R1; // 51
ST.B (R2++), R1; // 52
ST.B (R2++), R1; // 53
ST.B (R2++), R1; // 54
ST.B (R2++), R1; // 55
ST.B (R2++), R1; // 56
ST.B (R2++), R1; // 57
ST.B (R2++), R1; // 58
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 59

ST.B (R2++), R1; // 60
LD.B R1, #PIECE_ENUM_EMPTY;
ST.B (R2++), R1; // 61
ST.B (R2++), R1; // 62
ST.B (R2++), R1; // 63
ST.B (R2++), R1; // 64
ST.B (R2++), R1; // 65
ST.B (R2++), R1; // 66
ST.B (R2++), R1; // 67
ST.B (R2++), R1; // 68
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 69

ST.B (R2++), R1; // 70
LD.B R1, #PIECE_ENUM_EMPTY;
ST.B (R2++), R1; // 71
ST.B (R2++), R1; // 72
ST.B (R2++), R1; // 73
ST.B (R2++), R1; // 74
ST.B (R2++), R1; // 75
ST.B (R2++), R1; // 76
ST.B (R2++), R1; // 77
ST.B (R2++), R1; // 78
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 79

ST.B (R2++), R1; // 80
LD.B R1, #UNMOVED_WHITE_PAWN;
ST.B (R2++), R1; // 81
ST.B (R2++), R1; // 82
ST.B (R2++), R1; // 83
ST.B (R2++), R1; // 84
ST.B (R2++), R1; // 85
ST.B (R2++), R1; // 86
ST.B (R2++), R1; // 87
ST.B (R2++), R1; // 88
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 89

ST.B (R2++), R1; // 90
LD.B R1, #UNMOVED_WHITE_ROOK;
ST.B (R2++), R1; // 91
LD.B R1, #UNMOVED_WHITE_KNIGHT;
ST.B (R2++), R1; // 92
LD.B R1, #UNMOVED_WHITE_BISHOP;
ST.B (R2++), R1; // 93
LD.B R1, #UNMOVED_WHITE_QUEEN;
ST.B (R2++), R1; // 94
LD.B R1, #UNMOVED_WHITE_KING;
ST.B (R2++), R1; // 95
LD.B R1, #UNMOVED_WHITE_BISHOP;
ST.B (R2++), R1; // 96
LD.B R1, #UNMOVED_WHITE_KNIGHT;
ST.B (R2++), R1; // 97
LD.B R1, #UNMOVED_WHITE_ROOK;
ST.B (R2++), R1; // 98
LD.B R1, #PIECE_ENUM_OFFBOARD;
ST.B (R2++), R1; // 99

ST.B (R2++), R1; // 100
ST.B (R2++), R1; // 101
ST.B (R2++), R1; // 102
ST.B (R2++), R1; // 103
ST.B (R2++), R1; // 104
ST.B (R2++), R1; // 105
ST.B (R2++), R1; // 106
ST.B (R2++), R1; // 107
ST.B (R2++), R1; // 108
ST.B (R2++), R1; // 109

ST.B (R2++), R1; // 110
ST.B (R2++), R1; // 111
ST.B (R2++), R1; // 112
ST.B (R2++), R1; // 113
ST.B (R2++), R1; // 114
ST.B (R2++), R1; // 115
ST.B (R2++), R1; // 116
ST.B (R2++), R1; // 117
ST.B (R2++), R1; // 118
ST.B (R2++), R1; // 119

RET;

MODE0_CHECK_FOR_CHECK EQU 0;
MODE1_CHECK_CAN_MOVE  EQU 1;
MODE2_CALCULATE_MOVE  EQU 2;

CALCULATE_LOCAL EQU 0;
CALCULATE_LOCAL_justMovedEnPassantPawnIndex         EQU CALCULATE_LOCAL;
CALCULATE_LOCAL_castlingIsProhibited                EQU CALCULATE_LOCAL_justMovedEnPassantPawnIndex + 2;
CALCULATE_LOCAL_moveGameValue                       EQU CALCULATE_LOCAL_castlingIsProhibited + 2;
CALCULATE_LOCAL_targetSquareValueAfterMoving        EQU CALCULATE_LOCAL_moveGameValue + 2;
CALCULATE_LOCAL_otherSquareTargetIndex              EQU CALCULATE_LOCAL_targetSquareValueAfterMoving + 2;
CALCULATE_LOCAL_otherSquareOriginIndex              EQU CALCULATE_LOCAL_otherSquareTargetIndex + 2;
CALCULATE_LOCAL_targetSquareValue                   EQU CALCULATE_LOCAL_otherSquareOriginIndex + 2;
CALCULATE_LOCAL_targetSquareIndex                   EQU CALCULATE_LOCAL_targetSquareValue + 2;
CALCULATE_LOCAL_moveDirectionIndex                  EQU CALCULATE_LOCAL_targetSquareIndex + 2;
CALCULATE_LOCAL_moveDirectionNumber                 EQU CALCULATE_LOCAL_moveDirectionIndex + 2;
CALCULATE_LOCAL_originPieceIsSlidey                 EQU CALCULATE_LOCAL_moveDirectionNumber + 2;
CALCULATE_LOCAL_originPieceIsAKing                  EQU CALCULATE_LOCAL_originPieceIsSlidey + 2;
CALCULATE_LOCAL_originPieceIsAPawn                  EQU CALCULATE_LOCAL_originPieceIsAKing + 2;
CALCULATE_LOCAL_originPieceIsOnOriginalSquare       EQU CALCULATE_LOCAL_originPieceIsAPawn + 2;
CALCULATE_LOCAL_colorlessOriginPieceValue           EQU CALCULATE_LOCAL_originPieceIsOnOriginalSquare + 2;
CALCULATE_LOCAL_movedOriginPieceValue               EQU CALCULATE_LOCAL_colorlessOriginPieceValue + 2;
CALCULATE_LOCAL_originSquareValue                   EQU CALCULATE_LOCAL_movedOriginPieceValue + 2;
CALCULATE_LOCAL_originSquareIndex                   EQU CALCULATE_LOCAL_originSquareValue + 2;
CALCULATE_LOCAL_singlePawnJump                      EQU CALCULATE_LOCAL_originSquareIndex + 2;
CALCULATE_LOCAL_winGameValue                        EQU CALCULATE_LOCAL_singlePawnJump + 2;
CALCULATE_LOCAL_originPlayerIsInCheck               EQU CALCULATE_LOCAL_winGameValue + 2;
CALCULATE_LOCAL_bestGameValue                       EQU CALCULATE_LOCAL_originPlayerIsInCheck + 2;
CALCULATE_LOCAL_originPieceColor                    EQU CALCULATE_LOCAL_bestGameValue + 2;

CALCULATE_LengthOf_Locals                           EQU CALCULATE_LOCAL_originPieceColor + 2 - CALCULATE_LOCAL;

CALCULATE_returnAddress                             EQU CALCULATE_LOCAL_originPieceColor + 2;

CALCULATE_ARG                                       EQU CALCULATE_returnAddress + 2;

CALCULATE_ARG_maxGameValueThatAvoidsPruning         EQU CALCULATE_ARG;
CALCULATE_ARG_modeMaxDepth                          EQU CALCULATE_ARG_maxGameValueThatAvoidsPruning + 2;
CALCULATE_ARG_enPassantPawnIndex                    EQU CALCULATE_ARG_modeMaxDepth + 2;
CALCULATE_ARG_depth                                 EQU CALCULATE_ARG_enPassantPawnIndex + 2;
CALCULATE_ARG_opponentPieceColor                    EQU CALCULATE_ARG_depth + 2;
CALCULATE_LengthOf_Args                             EQU CALCULATE_ARG_opponentPieceColor + 2 - CALCULATE_ARG;

CALCULATE_NEXT_ARG_opponentPieceColor               EQU CALCULATE_LOCAL - 2;
CALCULATE_NEXT_ARG_depth                            EQU CALCULATE_NEXT_ARG_opponentPieceColor - 2;
CALCULATE_NEXT_ARG_enPassantPawnIndex               EQU CALCULATE_NEXT_ARG_depth - 2;
CALCULATE_NEXT_ARG_modeMaxDepth                     EQU CALCULATE_NEXT_ARG_enPassantPawnIndex - 2;
CALCULATE_NEXT_ARG_maxGameValueThatAvoidsPruning    EQU CALCULATE_NEXT_ARG_modeMaxDepth - 2;

// MUST BE CALLED USING JSR and the stack
calculate:                                                       // const calculate = (opponentPieceColor, depth, enPassantPawnIndex, modeMaxDepth, maxGameValueThatAvoidsPruning) => {

LD.B R1, #CALCULATE_LengthOf_Locals;
MOVE R0, SP;
SUB R0,R1;
MOVE SP, R0;
                                                                 //     dim originPieceColor;
                                                                 //     dim bestGameValue;
                                                                 //     dim originPlayerIsInCheck;
                                                                 //     dim winGameValue;
                                                                 //     dim singlePawnJump;
                                                                 //     dim originSquareIndex;
                                                                 //     dim originSquareValue;
                                                                 //     dim movedOriginPieceValue;
                                                                 //     dim colorlessOriginPieceValue;
                                                                 //     dim originPieceIsOnOriginalSquare;
                                                                 //     dim originPieceIsAPawn;
                                                                 //     dim originPieceIsAKing;
                                                                 //     dim originPieceIsSlidey;
                                                                 //     dim moveDirectionNumber;
                                                                 //     dim moveDirectionIndex;
                                                                 //     dim targetSquareIndex;
                                                                 //     dim targetSquareValue;
                                                                 //     dim otherSquareOriginIndex;
                                                                 //     dim otherSquareTargetIndex;
                                                                 //     dim targetSquareValueAfterMoving;
                                                                 //     dim moveGameValue;
                                                                 //     dim castlingIsProhibited;
                                                                 //     dim justMovedEnPassantPawnIndex;

LD.B R0, (SP + CALCULATE_ARG_opponentPieceColor);
LD.B R1, #PIECE_COLOUR_MASK;
XOR R1, R0;
ST.B (SP + CALCULATE_LOCAL_originPieceColor), R1;                //     originPieceColor = opponentPieceColor ^ PIECE_COLOUR_MASK;

LD.W R0, #-32768;
ST.W (SP + CALCULATE_LOCAL_bestGameValue), R0;                   //     bestGameValue = -32768;

LD.B R0, #BOOL_FALSE;
ST.B (SP + CALCULATE_LOCAL_originPlayerIsInCheck), R0;
LD.B R0, (SP + CALCULATE_ARG_modeMaxDepth);
BEQ calculate_originPlayerIsInCheck_notModeIsZero;               //     if(modeMaxDepth != MODE0_CHECK_FOR_CHECK) {

MOVE R0,SP;
MOVE R3,R0;
LD.W R2, #CALCULATE_NEXT_ARG_opponentPieceColor;
ADD R2,R3;
ST.W (R2), R1;

LD.B R0, #0;

LD.W R2, #CALCULATE_NEXT_ARG_depth;
ADD R2,R3;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_enPassantPawnIndex;
ADD R2,R3;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_modeMaxDepth;
ADD R2,R3;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_maxGameValueThatAvoidsPruning;
ADD R2,R3;
//LD.B R0, #MODE0_CHECK_FOR_CHECK;
ST.W (R2), R0;
include "calculate_call.asm";                                    //         const calculateResult = calculate(originPieceColor, 0, undefined, MODE0_CHECK_FOR_CHECK, 0);

LD.B R2, #BOOL_FALSE;
LD.W R1, #10000;
CMP R0,R1;
BLE calculate__was_not_in_check;
LD.B R2, #BOOL_TRUE;
calculate__was_not_in_check:
ST.B (SP + CALCULATE_LOCAL_originPlayerIsInCheck), R2;           //         originPlayerIsInCheck = calculateResult > 10000;

calculate_originPlayerIsInCheck_notModeIsZero:                   //     } else {
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
ST.W (SP + CALCULATE_LOCAL_singlePawnJump), R1;

LD.B R2, (SP + CALCULATE_ARG_depth);
BNE calculate__notDepth0AndMode1;                                //     if (depth === 0 &&

LD.B R2, #MODE1_CHECK_CAN_MOVE;
LD.B R1, (SP + CALCULATE_ARG_modeMaxDepth);
CMP R1,R2;
BNE calculate__notDepth0AndMode1;                                //          modeMaxDepth == MODE1_CHECK_CAN_MOVE) {

LD.B R0, global_selected_square_index;                           //         originSquareIndex = global_selected_square_index;
JMP calculate__checkDepthAndModeForInitialOriginSquareIndex;

calculate__notDepth0AndMode1:                                    //     } else {
LD.B R0, #21;                                                    //         originSquareIndex = 21;

calculate__checkDepthAndModeForInitialOriginSquareIndex:         //     }
ST.B (SP + CALCULATE_LOCAL_originSquareIndex), R0;

LD.B R2, (SP + CALCULATE_ARG_modeMaxDepth);
BEQ calculate__clearprogress_mode0;                              //     if (modeMaxDepth != MODE0_CHECK_FOR_CHECK) {

LD.B R2, (SP + CALCULATE_ARG_depth);
BNE calculate__clearprogress_notDepth0;                          //         if (depth == 0) {

LD.W R2,#0xA0E0;
LD.B R1,#0;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;                                                  //             clearDepth0Progress();
//fall through                                                   //             clearDepth1Progress();
//fall through                                                   //             clearDepth2Progress();
//fall through                                                   //             clearMode0Progress();

calculate__clearprogress_notDepth0:

LD.B R1,#1;
CMP R2,R1;
BNE calculate__clearprogress_notDepth1;                          //         } else if (depth == 1) {

LD.W R2,#0xA0E8;
LD.B R1,#0;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;                                                  //             clearDepth1Progress();
//fall through                                                   //             clearDepth2Progress();
//fall through                                                   //             clearMode0Progress();

calculate__clearprogress_notDepth1:                              //         } else{

LD.W R2,#0xA0F0;
LD.B R1,#0;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;                                                  //             clearDepth2Progress();
//fall through                                                   //             clearMode0Progress();

                                                                 //         }

calculate__clearprogress_mode0:                                  //     } else {

LD.W R2,#0xA0F8;
LD.B R1,#0;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;
ST.W (R2++),R1;                                                  //         clearMode0Progress();

                                                                 //     }

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

                                                                 //         let progressStartAddress;
LD.B R2, (SP + CALCULATE_ARG_modeMaxDepth);
BNE calculate__increaseprogress_notMode0;                        //         if (modeMaxDepth == MODE0_CHECK_FOR_CHECK) {

LD.W R2,#0xA0F8;                                                 //             progressStartAddress = 0xA0F8;

JMP calculate__increaseprogress;
calculate__increaseprogress_notMode0:                            //         } else {

LD.B R2, (SP + CALCULATE_ARG_depth);
BNE calculate__increaseprogress_notDepth0;                       //             if (depth == 0) {

LD.W R2,#0xA0E0;                                                 //                 progressStartAddress = 0xA0E0;

JMP calculate__increaseprogress;
calculate__increaseprogress_notDepth0:

LD.B R1,#1;
CMP R2,R1;                                                       //             } else if (depth == 1) {
BNE calculate__increaseprogress_notDepth1;

LD.W R2,#0xA0E8;                                                 //                 progressStartAddress = 0xA0E8;

JMP calculate__increaseprogress;
calculate__increaseprogress_notDepth1:                           //             } else{

LD.W R2,#0xA0F0;                                                 //                 progressStartAddress = 0xA0F0;

                                                                 //             }
                                                                 //         }

calculate__increaseprogress:
LD.W R3, #0xFFFF;
LD.W R1,(R2++);
CMP R3,R1;
BNE calculate__increaseprogress_done;                            //             if(progressStartAddress++* < FFFF) { progressAddress = progressStartAddress}
LD.W R1,(R2++);
CMP R3,R1;
BNE calculate__increaseprogress_done;                            //             else if(progressStartAddress++* < FFFF) { progressAddress = progressStartAddress}
LD.W R1,(R2++);
CMP R3,R1;
BNE calculate__increaseprogress_done;                            //             else if(progressStartAddress++* < FFFF) { progressAddress = progressStartAddress}
LD.W R1,(R2++);                                                  //             else                                    { progressAddress = progressStartAddress++}

calculate__increaseprogress_done:
ADDQ R2,#-2;                                                     //             progressAddress--;
ADD R1,R1;
ADD R1,R1;
ADD R1,R1;
ADD R1,R1;
LD.W R3, #15;
ADD R1,R3;
ST.W (R2),R1;                                                    //             progressAddress*++;

                                                                 //         } else { continue; }

LD.B R1, #PIECE_VALUE_MASK;
AND R1,R0;
ST.B (SP + CALCULATE_LOCAL_movedOriginPieceValue), R1;           //             movedOriginPieceValue = originSquareValue & PIECE_VALUE_MASK;

LD.B R2, (SP + CALCULATE_LOCAL_originPieceColor);
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

ADD R1,R1;  // double as each value is a word
LD.W R2, #calculate_initial_move_direction_indexes;
ADD R2,R1;
LD.W R0, (R2);
ST.W (SP + CALCULATE_LOCAL_moveDirectionIndex), R0;              //             moveDirectionIndex = initialMoveDirectionIndexes[movedOriginPieceValue];

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
ST.B (SP + CALCULATE_LOCAL_targetSquareIndex), R0;               //             targetSquareIndex = originSquareIndex;

calculate_more_moves_loop_start:                                 //             do {
LD.B R0, (SP + CALCULATE_LOCAL_targetSquareIndex);
LD.W R2, (SP + CALCULATE_LOCAL_moveDirectionIndex);
LD.W R1, (R2);
ADD R0,R1;
ST.B (SP + CALCULATE_LOCAL_targetSquareIndex), R0;               //                 targetSquareIndex += moveDirections[moveDirectionIndex];

LD.W R2, #boardState;
ADD R2, R0;
LD.B R1, (R2);
ST.B (SP + CALCULATE_LOCAL_targetSquareValue), R1;               //                 targetSquareValue = boardState[targetSquareIndex];

LD.B R3, #0;
ST.B (SP + CALCULATE_LOCAL_otherSquareOriginIndex), R3;          //                 otherSquareOriginIndex = 0;
ST.B (SP + CALCULATE_LOCAL_otherSquareTargetIndex), R3;          //                 otherSquareTargetIndex = 0;

                                                                 //                 let originCanMoveToTarget;
TEST R1;
BNE calculate__target_not_empty;                                 //                 if(targetSquareValue === PIECE_ENUM_EMPTY) {

LD.B R2, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BNE calculate__empty_target_origin_pawn;                         //                     if(!originPieceIsAPawn) {

JMP calculate__origin_can_move_to_target_block_start;            //                         originCanMoveToTarget = true;

calculate__empty_target_origin_pawn:                             //                     } else {


LD.W R2, (SP + CALCULATE_LOCAL_singlePawnJump);
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

LD.B R3, #PIECE_ENUM_OFFBOARD;
CMP R3,R1;
BEQ calculate__non_empty_target_not_opponent;                    //                     const targetIsAPieceOfOppositeColor = targetSquareValue != PIECE_ENUM_OFFBOARD &&

LD.B R3, #PIECE_COLOUR_MASK;
AND R3,R1;
LD.B R2, (SP + CALCULATE_ARG_opponentPieceColor);
CMP R3,R2;                                                       //                         (targetSquareValue & PIECE_COLOUR_MASK) === opponentPieceColor;
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
LD.W R3, (SP + CALCULATE_LOCAL_singlePawnJump);
ADD R2, R3;
LD.B R0, (R2);
LD.B R2, #PIECE_ENUM_OFFBOARD;
CMP R0,R2;
BNE calculate__makeMove_loop_start;                              //                         if(boardState[targetSquareIndex + singlePawnJump] === PIECE_ENUM_OFFBOARD) {

LD.B R2, #PIECE_ENUM_QUEEN;
LD.B R3, (SP + CALCULATE_LOCAL_originPieceColor);
AND R3,R2;
ST.B (SP + CALCULATE_LOCAL_targetSquareValueAfterMoving), R3;    //                             targetSquareValueAfterMoving = queenPieceValue ^ originPieceColor;
                                                                 //                         }
                                                                 //                     }

calculate__makeMove_loop_start:                                  //                     do {

LD.B R1, #0;                                                     //                         moveGameValue = 0;
LD.B R3, (SP + CALCULATE_LOCAL_targetSquareValue);
BEQ calculate__target_is_empty;                                  //                         if(targetSquareValue !== PIECE_ENUM_EMPTY) {
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
ST.B (SP + CALCULATE_LOCAL_castlingIsProhibited), R0;            //                         castlingIsProhibited = true;

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

LD.W R1, #PIECE_ENUM_EMPTY;

TEST R3;
BEQ calculate__otherSquareOriginIndexNotSet;                     //                             if (otherSquareOriginIndex != 0) {

LD.W R2, #boardState;
ADD R3,R2;
ST.B (R3), R1;                                                   //                                 boardState[otherSquareOriginIndex] = PIECE_ENUM_EMPTY;
calculate__otherSquareOriginIndexNotSet:                         //                             }

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
ADD R2,R0;
ST.B (R2), R1;                                                   //                             boardState[originSquareIndex] = PIECE_ENUM_EMPTY;

LD.B R0, #0;                                                     //                             justMovedEnPassantPawnIndex = 0;

LD.B R1, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BEQ calculate__pawnDidNotJustMoveTwoSpaces;                      //                             if(originPieceIsAPawn && 

LD.B R1, (SP + CALCULATE_LOCAL_moveDirectionNumber);
LD.B R2, #1;
CMP R1,R2;
BGT calculate__pawnDidNotJustMoveTwoSpaces;                      //                                 moveDirectionNumber <= 1) {

LD.B R0, (SP + CALCULATE_LOCAL_targetSquareIndex);               //                                 justMovedEnPassantPawnIndex = targetSquareIndex;
calculate__pawnDidNotJustMoveTwoSpaces:                          //                             }

ST.B (SP + CALCULATE_LOCAL_justMovedEnPassantPawnIndex), R0;

LD.W R1, (SP + CALCULATE_LOCAL_moveGameValue);
LD.W R2, (SP + CALCULATE_LOCAL_bestGameValue);
SUB R1,R2;                                                       //                             const maxOpponentGameValueThatAvoidsPruning = moveGameValue - bestGameValue;

MOVE R2,R0;
MOVE R0,SP;
MOVE R3,R0;
MOVE R0,R2;
LD.W R2, #CALCULATE_NEXT_ARG_opponentPieceColor;
ADD R2,R3;
LD.B R0, (SP + CALCULATE_LOCAL_originPieceColor);
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_depth;
ADD R2,R3;
LD.B R0, (SP + CALCULATE_ARG_depth);
INC R0;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_enPassantPawnIndex;
ADD R2,R3;
LD.B R0, (SP + CALCULATE_LOCAL_justMovedEnPassantPawnIndex);
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_modeMaxDepth;
ADD R2,R3;
LD.B R0, (SP + CALCULATE_ARG_modeMaxDepth);
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_maxGameValueThatAvoidsPruning;
ADD R2,R3;
ST.W (R2), R1;

include "calculate_call.asm";                                    //                             const opponentMoveGameValue = calculate(originPieceColor, depth + 1, justMovedEnPassantPawnIndex, modeMaxDepth, maxOpponentGameValueThatAvoidsPruning);

LD.W R1, (SP + CALCULATE_LOCAL_moveGameValue);
SUB R1,R0;                                                       //                             const correctedMoveGameValue = moveGameValue - opponentMoveGameValue;
ST.W (SP + CALCULATE_LOCAL_moveGameValue), R1;                   //                             moveGameValue = correctedMoveGameValue;


LD.B R3, (SP + CALCULATE_ARG_depth);
BNE calculate__notFoundMoveToPlay;                               //                             if (depth === 0 &&

LD.B R2, #1;
LD.B R3, (SP + CALCULATE_ARG_modeMaxDepth);
CMP R3,R2;
BNE calculate__notFoundMoveToPlay;                               //                                 modeMaxDepth === 1 &&

LD.B R2, (SP + CALCULATE_LOCAL_originSquareIndex);
LD.B R3, global_selected_square_index;
CMP R3,R2;
BNE calculate__notFoundMoveToPlay;                               //                                 global_selected_square_index === originSquareIndex &&

LD.B R2, calculate_clickedBoardIndex;
LD.B R3, (SP + CALCULATE_LOCAL_targetSquareIndex);
CMP R3,R2;
BNE calculate__notFoundMoveToPlay;                               //                                 targetSquareIndex === calculate_clickedBoardIndex && 

LD.W R3, #-10000;
CMP R1,R3;
BLT calculate__notFoundMoveToPlay;                               //                                 moveGameValue >= -10000) {

JMP calculate__foundMoveToPlay;

calculate__notFoundMoveToPlay:
JMP calculate__foundMoveToPlay_blockEnd;

calculate__foundMoveToPlay:
LD.B R0, (SP + CALCULATE_LOCAL_justMovedEnPassantPawnIndex);
ST.B calculate_newEnPassantPawnIndex, R0;                        //                                 calculate_newEnPassantPawnIndex = justMovedEnPassantPawnIndex;

ST.B global_selected_square_index, R2;                           //                                 global_selected_square_index = calculate_clickedBoardIndex;

LD.W R0, #calculate__draw_board_return_after_found_move;         //                                 // TODO improve performance by refreshing just the relevant squares
JMP draw_board;                                                  //                                 draw_board();
calculate__draw_board_return_after_found_move:

LD.B R0, (SP + CALCULATE_LOCAL_originPieceColor);
LD.B R1, #PIECE_COLOUR_WHITE;
CMP R0,R1;
BEQ calculate__whiteFoundMove;                                   //                                 if (originPieceColor == whiteColor) {
JMP calculate__notWhiteFoundMove;

calculate__whiteFoundMove:
NOP;

include "draw_thinking.asm";

MOVE R0,SP;
MOVE R3,R0;
LD.W R2, #CALCULATE_NEXT_ARG_opponentPieceColor;
ADD R2,R3;
ST.W (R2), R1;

LD.W R2, #CALCULATE_NEXT_ARG_depth;
ADD R2,R3;
LD.B R0, #0;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_enPassantPawnIndex;
ADD R2,R3;
LD.B R1, calculate_newEnPassantPawnIndex;
ST.W (R2), R1;

LD.W R2, #CALCULATE_NEXT_ARG_modeMaxDepth;
ADD R2,R3;
LD.B R1, #MODE2_CALCULATE_MOVE;
ST.W (R2), R1;

LD.W R2, #CALCULATE_NEXT_ARG_maxGameValueThatAvoidsPruning;
ADD R2,R3;
ST.W (R2), R0;

include "calculate_call.asm";                                    //                                     calculate(whiteColor, 0, calculate_newEnPassantPawnIndex, MODE2_CALCULATE_MOVE, 0);

MOVE R0,SP;
MOVE R3,R0;
LD.W R2, #CALCULATE_NEXT_ARG_opponentPieceColor;
ADD R2,R3;
LD.B R1, #PIECE_COLOUR_WHITE;
ST.W (R2), R1;

LD.W R2, #CALCULATE_NEXT_ARG_depth;
ADD R2,R3;
LD.B R0, #0;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_enPassantPawnIndex;
ADD R2,R3;
LD.B R1, calculate_newEnPassantPawnIndex;
ST.W (R2), R1;

LD.W R2, #CALCULATE_NEXT_ARG_modeMaxDepth;
ADD R2,R3;
LD.B R1, #MODE1_CHECK_CAN_MOVE;
ST.W (R2), R1;

LD.W R2, #CALCULATE_NEXT_ARG_maxGameValueThatAvoidsPruning;
ADD R2,R3;
ST.W (R2), R0;

include "calculate_call.asm";                                    //                                     calculate(whiteColor, 0, calculate_newEnPassantPawnIndex, MODE1_CHECK_CAN_MOVE, 0);

calculate__notWhiteFoundMove:                                    //                                 }

LD.B R0, #0;
ST.W calculate_returnValue, R0;
include "calculate_return.asm";                                  //                                 return;

calculate__foundMoveToPlay_blockEnd:                             //                             }
NOP;


LD.B R0, (SP + CALCULATE_LOCAL_originPieceIsAKing);
BEQ calculate__castlingIsProhibited;                             //                             if(originPieceIsAKing &&

LD.B R0, (SP + CALCULATE_LOCAL_moveDirectionNumber);
LD.B R1, #7;
CMP R0,R1;
BLT calculate__castlingIsProhibited;                             //                                 moveDirectionNumber >= 7 &&

LD.B R0, (SP + CALCULATE_LOCAL_otherSquareOriginIndex);
BNE calculate__castlingIsProhibited;                             //                                 otherSquareOriginIndex == 0 &&

LD.B R0, (SP + CALCULATE_ARG_modeMaxDepth);
BEQ calculate__castlingIsProhibited;                             //                                 modeMaxDepth !== 0 &&

LD.B R0, (SP + CALCULATE_LOCAL_targetSquareValue);
BNE calculate__castlingIsProhibited;                             //                                 targetSquareValue === PIECE_ENUM_EMPTY &&

LD.B R0, (SP + CALCULATE_LOCAL_originPieceIsOnOriginalSquare);
BEQ calculate__castlingIsProhibited;                             //                                 originPieceIsOnOriginalSquare &&

MOVE R0,SP;
MOVE R3,R0;
LD.W R2, #CALCULATE_NEXT_ARG_opponentPieceColor;
ADD R2,R3;
LD.B R0, (SP + CALCULATE_LOCAL_originPieceColor);
ST.W (R2), R0;

LD.B R0, #0;

LD.W R2, #CALCULATE_NEXT_ARG_depth;
ADD R2,R3;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_enPassantPawnIndex;
ADD R2,R3;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_modeMaxDepth;
ADD R2,R3;
//LD.B R0, #MODE0_CHECK_FOR_CHECK;
ST.W (R2), R0;

LD.W R2, #CALCULATE_NEXT_ARG_maxGameValueThatAvoidsPruning;
ADD R2,R3;
ST.W (R2), R0;

include "calculate_call.asm";

LD.B R1, #10000;
CMP R0,R1;
BGT calculate__castlingIsProhibited;                             //                                 calculate(originPieceColor, 0, undefined, MODE0_CHECK_FOR_CHECK, 0) <= 10000) {

LD.B R0, #BOOL_FALSE;
ST.B (SP + CALCULATE_LOCAL_castlingIsProhibited), R0;            //                                 castlingIsProhibited = false;

calculate__castlingIsProhibited:                                 //                             }

                                                                 //                             // restore board
LD.W R2, #boardState;
LD.B R3, (SP + CALCULATE_LOCAL_originSquareIndex);
ADD R2,R3;
LD.B R1, (SP + CALCULATE_LOCAL_originSquareValue);
ST.B (R2), R1;                                                   //                             boardState[originSquareIndex] = originSquareValue;

LD.W R2, #boardState;
LD.B R3, (SP + CALCULATE_LOCAL_targetSquareIndex);
ADD R2,R3;
LD.B R1, (SP + CALCULATE_LOCAL_targetSquareValue);
ST.B (R2), R1;                                                   //                             boardState[targetSquareIndex] = targetSquareValue;

LD.W R2, #boardState;
LD.B R3, (SP + CALCULATE_LOCAL_otherSquareTargetIndex);
ADD R3,R2;
LD.B R1, (R3);
LD.B R0, (SP + CALCULATE_LOCAL_otherSquareOriginIndex);
ADD R2,R0;
ST.B (R2), R1;                                                   //                             boardState[otherSquareOriginIndex] = boardState[otherSquareTargetIndex];

TEST R0;
BEQ calculate__can_go_deeper_blockend;                           //                             if (otherSquareOriginIndex) {

                                                                 //                                 let restoreOtherSquareTargetValue;
LD.B R0, (SP + CALCULATE_LOCAL_originPieceIsAPawn);
BEQ calculate__originPieceIsNotAPawn;                            //                                 if (originPieceIsAPawn) {
                                                                 //                                     // restore en passant

LD.B R0, (SP + CALCULATE_LOCAL_originPieceColor);
LD.B R1, #PIECE_ENUM_WHITE_PAWN;
XOR R1, R0;                                                      //                                     restoreOtherSquareTargetValue = PIECE_ENUM_WHITE_PAWN ^ originPieceColor;

JMP calculate__originPieceIsAPawn_blockEnd;                      //                                 }
calculate__originPieceIsNotAPawn:                                //                                 else {
                                                                 //                                     // restore castling
LD.B R1, #0;                                                     //                                     restoreOtherSquareTargetValue = 0;

calculate__originPieceIsAPawn_blockEnd:                          //                                 }
ST.B (R3), R1;                                                   //                                 boardState[otherSquareTargetIndex] = restoreOtherSquareTargetValue;
                                                                 //                             }

calculate__can_go_deeper_blockend:                               //                         }

LD.W R0, (SP + CALCULATE_LOCAL_moveGameValue);
LD.W R1, (SP + CALCULATE_LOCAL_bestGameValue);
CMP R0,R1;
BGT calculate__betterMoveFound;                                  //                         if (moveGameValue > bestGameValue ||

BNE calculate__betterMoveFound_blockEnd;                         //                             (moveGameValue == bestGameValue &&

LD.B R1, (SP + CALCULATE_ARG_depth);
BNE calculate__betterMoveFound_blockEnd;                         //                             depth === 0 &&

COUNTER_ADDRESS EQU 0x8000;
LD.W R2, COUNTER_ADDRESS;
//LD.W R2, calculate_randomValue;
//INC R2;
ST.W calculate_randomValue, R2; // Temporary "random" generator

BTST R2, #2;  // Test 3rd LSB
BEQ calculate__betterMoveFound_blockEnd;                         //                             Math.random() < .5)) {

calculate__betterMoveFound:

ST.W (SP + CALCULATE_LOCAL_bestGameValue), R0;                   //                             bestGameValue = moveGameValue;

LD.W R2, (SP + CALCULATE_ARG_modeMaxDepth);
LD.W R3, #2;
CMP R2,R3;
BNE calculate__betterMoveFound_blockEnd;                         //                             if (modeMaxDepth === 2) {

LD.B R1, (SP + CALCULATE_ARG_depth);
BLE calculate__depthEqualsZero;                                  //                                 if (depth > 0) {

LD.B R1, (SP + CALCULATE_ARG_maxGameValueThatAvoidsPruning);
CMP R0,R1;
BLE calculate__betterMoveFound_blockEnd;                         //                                     if (bestGameValue > maxGameValueThatAvoidsPruning) {

ST.W calculate_returnValue, R0;
include "calculate_return.asm";                                  //                                         return bestGameValue;
                                                                 //                                     }

                                                                 //                                 }
calculate__depthEqualsZero:                                      //                                 else {

LD.B R0, (SP + CALCULATE_LOCAL_originSquareIndex);
ST.B global_selected_square_index, R0;                           //                                     global_selected_square_index = originSquareIndex;

LD.B R0, (SP + CALCULATE_LOCAL_targetSquareIndex);
ST.B calculate_clickedBoardIndex, R0;                            //                                     calculate_clickedBoardIndex = targetSquareIndex;
                                                                 //                                 }
                                                                 //                             }

calculate__betterMoveFound_blockEnd:                             //                         }

                                                                 //                         let canAlsoCastle;

LD.B R0, (SP + CALCULATE_LOCAL_castlingIsProhibited);
BNE calculate__origin_can_move_to_target_block_end;              //                         if (castlingIsProhibited ||

LD.B R0, (SP + CALCULATE_LOCAL_originPlayerIsInCheck);
BNE calculate__origin_can_move_to_target_block_end;              //                             originPlayerIsInCheck) {

                                                                 //                             canAlsoCastle = false;
// Falls through if neither true                                 //                         } else {
                                                                 //                             // castling

LD.B R0, (SP + CALCULATE_LOCAL_targetSquareIndex);
MOVE R2,R0;
MOVE R3,R0;

ST.B (SP + CALCULATE_LOCAL_otherSquareTargetIndex), R0;          //                             otherSquareTargetIndex =  targetSquareIndex;

LD.B R1, (SP + CALCULATE_LOCAL_originSquareIndex);
CMP R0,R1;
BGE calculate__targetGreaterThanOrigin;                          //                             if(targetSquareIndex < originSquareIndex) {

LD.B R1, #3;
SUB R2,R1;                                                       //                                 otherSquareOriginIndex =  otherSquareTargetIndex - 3;

JMP calculate__targetLessThanOrigin_blockend;
calculate__targetGreaterThanOrigin:                              //                             } else {

LD.B R1, #2;
ADD R2,R1;                                                       //                                 otherSquareOriginIndex =  otherSquareTargetIndex + 2;

calculate__targetLessThanOrigin_blockend:                        //                             }
ST.B (SP + CALCULATE_LOCAL_otherSquareOriginIndex), R2;

LD.B R1, (SP + CALCULATE_LOCAL_originSquareIndex);
SUB R3,R1;                                                       //                             const kingStep = targetSquareIndex - originSquareIndex;

ADD R0,R3;
ST.B (SP + CALCULATE_LOCAL_targetSquareIndex), R0;               //                             targetSquareIndex += kingStep;


LD.B R1, #boardState;
ADD R2,R1;
LD.B R1, (R2);
LD.B R2, #UNMOVED_PIECE;
CMP R1,R2;
BLT calculate__origin_can_move_to_target_block_end;              //                             const rookIsUnmoved = boardState[otherSquareOriginIndex] >= UNMOVED_PIECE;

LD.B R1, #boardState;
LD.B R2, (SP + CALCULATE_LOCAL_otherSquareOriginIndex);
ADD R2,R1;
SUB R2,R3;
LD.B R1, (R2);
BNE calculate__origin_can_move_to_target_block_end;              //                             const rookAdjacentTargetIsEmpty = boardState[otherSquareOriginIndex - kingStep] == 0;

LD.B R1, #boardState;
LD.B R2, (SP + CALCULATE_LOCAL_targetSquareIndex);
ADD R2,R1;
LD.B R1, (R2);
BNE calculate__origin_can_move_to_target_block_end;              //                             const kingTargetIsEmpty = boardState[targetSquareIndex] == 0;

JMP calculate__makeMove_loop_start;                              //                             canAlsoCastle = rookIsUnmoved && rookAdjacentTargetIsEmpty && kingTargetIsEmpty;
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
LD.W R0, (SP + CALCULATE_LOCAL_moveDirectionIndex);
ADDQ R0, #2; // Add 2 because the values are stored as Words
ST.W (SP + CALCULATE_LOCAL_moveDirectionIndex), R0;              //                         moveDirectionIndex++;

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
                                                                 //
LD.B R1, global_selected_square_index;                           //         old_global_selected_square_index = global_selected_square_index;
LD.B R2, calculate_clickedBoardIndex;                            //
ST.B global_selected_square_index, R2;                           //         global_selected_square_index = calculate_clickedBoardIndex;
                                                                 //
LD.W R0, #on_click__return_redraw_old_selected_square;           //
JMP draw_piece;                                                  //         draw_piece(old_global_selected_square_index);
on_click__return_redraw_old_selected_square:                     //
                                                                 //
LD.B R1, global_selected_square_index;                           //
LD.W R0, #on_click__return;                                      //
JMP draw_piece;                                                  //         draw_piece(global_selected_square_index);
                                                                 //
on_click__clickedIsOtherValue:                                   //     } else {
NOP;                                                             //
                                                                 //
include "draw_checking.asm";                                     //
                                                                 //
LD.W R0, #0x8000;                                                //
MOVE SP, R0;       // reset SP                                   //
MOVE R3,R0;                                                      //
                                                                 //
LD.W R2, #CALCULATE_NEXT_ARG_opponentPieceColor;                 //
ADD R2,R3;                                                       //
LD.B R0, #PIECE_COLOUR_BLACK;                                    //
ST.W (R2), R0;                                                   //
                                                                 //
LD.W R2, #CALCULATE_NEXT_ARG_depth;                              //
ADD R2,R3;                                                       //
LD.B R0, #0;                                                     //
ST.W (R2), R0;                                                   //
                                                                 //
LD.W R2, #CALCULATE_NEXT_ARG_enPassantPawnIndex;                 //
ADD R2,R3;                                                       //
LD.B R1, calculate_newEnPassantPawnIndex;                        //
ST.W (R2), R1;                                                   //
                                                                 //
LD.W R2, #CALCULATE_NEXT_ARG_modeMaxDepth;                       //
ADD R2,R3;                                                       //
LD.B R1, #MODE1_CHECK_CAN_MOVE;                                  //
ST.W (R2), R1;                                                   //
                                                                 //
LD.W R2, #CALCULATE_NEXT_ARG_maxGameValueThatAvoidsPruning;      //
ADD R2,R3;                                                       //
ST.W (R2), R0;                                                   //
                                                                 //
include "calculate_call.asm";                                    //         calculate(PIECE_COLOUR_BLACK, 0, calculate_newEnPassantPawnIndex, MODE1_CHECK_CAN_MOVE, 0);
                                                                 //     }
on_click__return:                                                //
LD.W R0, on_click_return_address;                                //
JMP (R0);                                                        //     return;
                                                                 // };