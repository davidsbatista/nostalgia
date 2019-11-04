#include <math.h>
#include "vector.h"

/*
       name: vectorSet()
    purpose: set a vector value
*/
void vectorSet(vector v, real x, real y, real z, real w) {
    v[0]=x;
    v[1]=y;
    v[2]=z;
    v[3]=w;
}

/*
       name: vectorAdd()
    purpose: add two vectors
*/
void vectorAdd(vector v1, vector v2) {
    v1[0] += v2[0];
    v1[1] += v2[1];
    v1[2] += v2[2];
}

/*
       name: vectorSub()
    purpose: sub two vectors
*/
void vectorSub(vector v1, vector v2) {
    v1[0] -= v2[0];
    v1[1] -= v2[1];
    v1[2] -= v2[2];
}

/*
       name: vectorDivide()
    purpose: divide a vector by a scalar
*/
void vectorDivide(vector v, real s) {
    v[0] /= s;
    v[1] /= s;
    v[2] /= s;
}

/*
       name: vectorLength()
    purpose: return the length of a vector (ie it's magnitude)
*/
real vectorLength(vector v){
    return sqrt((v[0] * v[0]) + (v[1] * v[1]) + (v[2] * v[2]));
}

/*
       name: vectorNormalize()
    purpose: normalise a vector, ie make it a unit vector (length 1.0)
*/
void vectorNormalize(vector v) {
    real l;
    
    l=sqrt((v[0] * v[0]) + (v[1] * v[1]) + (v[2] * v[2]));
    if (l!=0) {
        v[0] /= l;
        v[1] /= l;
        v[2] /= l;
    } else {
        v[0] = 1;
        v[1] = 1;
        v[2] = 1;
    }
}

/*
       name: vectorPrint()
    purpose: don't know
*/
void vectorPrint(vector v) {
    printf("(%8.3f,%8.3f,%8.3f,%8.3f)\n",v[0],v[1],v[2],v[3]);
}

/*
       name: vectorMultiply()
    purpose: multiply a vector by a scalar
*/
void vectorMutiply(vector v, real s) {
    v[0] *= s;
    v[1] *= s;
    v[2] *= s;
}

/*
       name: vectorDot()
    purpose: return the dot product of two vectors (ie the angle between them),
             usefull for HSR or lightning.
*/
real vectorDot(vector v1, vector v2) {
    return (v1[0] * v2[0]) + (v1[1] * v2[1]) + (v1[2] * v2[2]);
}

/*
       name: vectorCross()
    purpose: return the cross product of two vectors (ie a perpendicular vector)
             usefull to find faces normals, etc.
*/
void vectorCross(vector v1,vector v2) {
   v1[0]=(v1[1] * v2[2]) - (v1[2] * v2[1]);
   v1[1]=(v1[2] * v2[0]) - (v1[0] * v2[2]);
   v1[2]=(v1[0] * v2[1]) - (v1[1] * v2[0]);
}

/*
       name: vectorMultiplyByMatrix()
    purpose: multiply a vector by a matrix, usefull to transform a vector
*/
void vectorMultiplyByMatrix(vector v, matrix44 m) {
    vector r;
    
    r[0] = v[0] * m[0][0] + v[1] * m[0][1] + v[2] * m[0][2] + m[0][3];
    r[1] = v[0] * m[1][0] + v[1] * m[1][1] + v[2] * m[1][2] + m[1][3];
    r[2] = v[0] * m[2][0] + v[1] * m[2][1] + v[2] * m[2][2] + m[2][3];
    r[3] = m[3][3];
    vectorCopy(r,v);
}
