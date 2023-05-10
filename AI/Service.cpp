#include "common.h"
#include "ChessDefinition.h"
#include "ChessThink.h"
#include "ChessStd.h"
#include <iostream>

// BOOL Think(int tmap[11][12],POINT tmanposition[32],int &tside,int &resultman, POINT &resultpoint);
	//g_chessCoordinate[0].x = 5; g_chessCoordinate[0].y = 10;	// KING
	//g_chessCoordinate[1].x = 4; g_chessCoordinate[1].y = 10;	// LEFT ADVISOR
	//g_chessCoordinate[2].x = 6; g_chessCoordinate[2].y = 10;	// RIGHT ADVISOR
	//g_chessCoordinate[3].x = 3; g_chessCoordinate[3].y = 10;	// LEFT ELEPHANT
	//g_chessCoordinate[4].x = 7; g_chessCoordinate[4].y = 10;	// RIGHT ELEPHANT
	//g_chessCoordinate[5].x = 2; g_chessCoordinate[5].y = 10;	// LEFT HORSE
	//g_chessCoordinate[6].x = 8; g_chessCoordinate[6].y = 10;	// RIGHT HORSE
	//g_chessCoordinate[7].x = 1; g_chessCoordinate[7].y = 10;	// LEFT CHARIOT
	//g_chessCoordinate[8].x = 9; g_chessCoordinate[8].y = 10;	// RIGHT CHARIOT
	//g_chessCoordinate[9].x = 2; g_chessCoordinate[9].y = 8;		// LEFT CANNON
	//g_chessCoordinate[10].x = 8; g_chessCoordinate[10].y = 8;	// RIGHT CANNON
	//g_chessCoordinate[11].x = 1; g_chessCoordinate[11].y = 7;	// SOLDIER
	//g_chessCoordinate[12].x = 3; g_chessCoordinate[12].y = 7;	// SOLDIER
	//g_chessCoordinate[13].x = 5; g_chessCoordinate[13].y = 7;	// SOLDIER
	//g_chessCoordinate[14].x = 7; g_chessCoordinate[14].y = 7;	// SOLDIER
	//g_chessCoordinate[15].x = 9; g_chessCoordinate[15].y = 7;	// SOLDIER

	// BLACK
	//g_chessCoordinate[16].x = 5; g_chessCoordinate[16].y = 1;	// KING
	//g_chessCoordinate[17].x = 4; g_chessCoordinate[17].y = 1;	// LEFT ADVISOR
	//g_chessCoordinate[18].x = 6; g_chessCoordinate[18].y = 1;	// RIGHT ADVISOR
	//g_chessCoordinate[19].x = 3; g_chessCoordinate[19].y = 1;	// LEFT ELEPHANT
	//g_chessCoordinate[20].x = 7; g_chessCoordinate[20].y = 1;	// RIGHT ELEPHANT
	//g_chessCoordinate[21].x = 2; g_chessCoordinate[21].y = 1;	// LEFT HORSE
	//g_chessCoordinate[22].x = 8; g_chessCoordinate[22].y = 1;	// RIGHT HORSE
	//g_chessCoordinate[23].x = 1; g_chessCoordinate[23].y = 1;	// LEFT CHARIOT
	//g_chessCoordinate[24].x = 9; g_chessCoordinate[24].y = 1;	// RIGHT CHARIOT
	//g_chessCoordinate[25].x = 2; g_chessCoordinate[25].y = 3;	// LEFT CANNON
	//g_chessCoordinate[26].x = 8; g_chessCoordinate[26].y = 3;	// RIGHT CANNON
	//g_chessCoordinate[27].x = 1; g_chessCoordinate[27].y = 4;	// SOLDIER
	//g_chessCoordinate[28].x = 3; g_chessCoordinate[28].y = 4;	// SOLDIER
	//g_chessCoordinate[29].x = 5; g_chessCoordinate[29].y = 4;	// SOLDIER
	//g_chessCoordinate[30].x = 7; g_chessCoordinate[30].y = 4;	// SOLDIER
	//g_chessCoordinate[31].x = 9; g_chessCoordinate[31].y = 4;	// SOLDIER

void Ask(const char *data, char *rep) {
	int side = data[0] == 'R' ? RED : BLACK;
    POINT piecesCoordinate[32], newPie[32];
	int map[11][12];
    const int lut[32] = { // th to me+1
        21,20,22,19,23,18,24,17,25,27,31,26,28,29,30,32,
        5,4,6,3,7,2,8,1,9,11,15,10,12,13,14,16,
    };
    for (int i = 0; i < 32; i++) {
        const char *xy = data + lut[i] * 2;
        if (xy[-1] == '-' || xy[0] == '-') {
            newPie[i] = piecesCoordinate[i] = {0, 0};
        } else {
            newPie[i] = piecesCoordinate[i] = {(xy[-1] - '0') + 1, (xy[0] - '0') + 1};
        }
    }
    FixManMap(map, piecesCoordinate, side);
    int resultPiece = 32;
    POINT resultPoint = {0, 0};
	BOOL flag = Think(map, piecesCoordinate, side, resultPiece, resultPoint);
    if (flag) {
        if (map[resultPoint.x][resultPoint.y] != 32) {
            newPie[map[resultPoint.x][resultPoint.y]] = {0, 0};
        }
        newPie[resultPiece] = resultPoint;
        rep[0] = 'M';
    } else {
        rep[0] = 'E';
    }
    for (int i = 0; i < 32; i++) {
        POINT p = newPie[i];
        int j = lut[i] - 1;
        if (p.x != 0) {
            rep[j * 2 + 1] = '0' + p.x - 1;
            rep[j * 2 + 2] = '0' + p.y - 1;
        } else {
            rep[j * 2 + 1] = '-';
            rep[j * 2 + 2] = '-';
        }
    }
}

void Proc(std::string const &in) {
    if (in.size() < 65) {
        std::cout << "ERRORINPUT";
    } else {
        char rep[66];
        Ask(in.data(), rep);
        rep[65] = 0;
        std::cout << rep;
    }
    std::cout << std::endl;
}

int main(int argc, char *argv[]) {
    std::string in;
    if (argc > 1 && argv[1]) {
        in = argv[1];
        Proc(in);
    } else {
        while (std::cin >> in) {
            Proc(in);
        }
    }
    return 0;
}
