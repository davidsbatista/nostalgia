/*
    4d vector defenitions homogenous coordinates system, 3d oriented
    5-19-97, 5:10 PM
    deks@videotron.ca
*/

#ifndef _VECTOR_H_
#define _VECTOR_H_

#include "shared.h"
#include "matrix44.h"

#ifdef __cplusplus
extern "C" {
#endif

#define vectorCopy(v1,v2) repmovsd((byte *)v1, (byte *)v2, sizeof(vector)>>2);

typedef real vector[4];

void vectorSet(vector v, real x, real y, real z, real w);
void vectorPrint(vector v);
void vectorAdd(vector v1, vector v2);
void vectorSub(vector v1, vector v2);
void vectorDivide(vector v, real s);
real vectorLength(vector v);
void vectorNormalize(vector v);
void vectorMutiply(vector v, real s);
void vectorMultiplyByMatrix(vector v, matrix44 m);
real vectorDot(vector v1, vector v2);
void vectorCross(vector v1, vector v2);

#ifdef __cplusplus
}
#endif

#endif
