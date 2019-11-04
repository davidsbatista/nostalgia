/*
    4x4 matrix, 3d oriented functions
    5-19-97, 5:10 PM
    deks@videotron.ca
*/

#ifndef _MATRIX44_H_
#define _MATRIX44_H_

#include "shared.h"

#ifdef __cplusplus
extern "C" {
#endif

#define pi 3.14159265358
#define matrixCopy(m1,m2) repmovsd((byte *)m1,(byte *)m2,sizeof(matrix44)>>2)

typedef real matrix44[4][4];

void matrixIdentity(matrix44 m);
void matrixMultiply(matrix44 m1, matrix44 m2);
void matrixPrint(matrix44 m);
void matrixXRotation(matrix44 m, real angle);
void matrixYRotation(matrix44 m, real angle);
void matrixZRotation(matrix44 m, real angle);
void matrixXYZRotation(matrix44 m, real xangle, real yangle, real zangle);
void matrixTranslation(matrix44 m, real dx, real dy, real dz);
void matrixScale(matrix44 m, real sx, real sy, real sz);
void matrixTranspose(matrix44 m);

#ifdef __cplusplus
}
#endif

#endif