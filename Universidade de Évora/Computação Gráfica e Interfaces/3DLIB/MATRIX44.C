#include <math.h>
#include "matrix44.h"

/*
      name: matrixIdentity()
   purpose: sets a matrix to identy
*/
void matrixIdentity(matrix44 m) {
    m[0][0]=1; m[0][1]=0; m[0][2]=0; m[0][3]=0;
    m[1][0]=0; m[1][1]=1; m[1][2]=0; m[1][3]=0;
    m[2][0]=0; m[2][1]=0; m[2][2]=1; m[2][3]=0;
    m[3][0]=0; m[3][1]=0; m[3][2]=0; m[3][3]=1;
}

/*
      name: matrixMultiply()
   purpose: multiply two matrices together, use this function to create a
            general matrix for a sets of transformations.
*/
void matrixMultiply(matrix44 m1, matrix44 m2) {
    int row,col,k;
    matrix44 r;

    for(row=0;row<4;row++)
        for(col=0;col<4;col++)
            for(k=0,r[row][col]=0.0;k<4;k++)
                r[row][col]+=(m1[row][k])*(m2[k][col]);
    matrixCopy(r,m1);
}

/*
      name: matrixPrint()
   purpose: print a matrix
*/
void matrixPrint(matrix44 m) {
    printf("%8.3f %8.3f %8.3f %8.3f\n",m[0][0],m[0][1],m[0][2],m[0][3]);
    printf("%8.3f %8.3f %8.3f %8.3f\n",m[1][0],m[1][1],m[1][2],m[1][3]);
    printf("%8.3f %8.3f %8.3f %8.3f\n",m[2][0],m[2][1],m[2][2],m[2][3]);
    printf("%8.3f %8.3f %8.3f %8.3f\n",m[3][0],m[3][1],m[3][2],m[3][3]);
}

/*
      name: matrixXRotation()
   purpose: create a matrix for rotation about the X axis
*/
void matrixXRotation(matrix44 m, real angle) {
    real sintheta,costheta;

    sintheta=sin(angle*pi/180);
    costheta=cos(angle*pi/180);
    matrixIdentity(m);
    m[1][1]=costheta;
    m[1][2]=-sintheta;
    m[2][1]=sintheta;
    m[2][2]=costheta;
}

/*
      name: matrixYRotation()
   purpose: create a matrix for rotation about the Y axis
*/
void matrixYRotation(matrix44 m, real angle) {
    real sintheta,costheta;

    sintheta=sin(angle*pi/180);
    costheta=cos(angle*pi/180);
    matrixIdentity(m);
    m[0][0]=costheta;
    m[0][2]=sintheta;
    m[2][0]=-sintheta;
    m[2][2]=costheta;
}

/*
      name: matrixZRotation()
   purpose: create a matrix for rotation about the Z axis
*/
void matrixZRotation(matrix44 m, real angle) {
    real sintheta,costheta;

    sintheta=sin(angle*pi/180);
    costheta=cos(angle*pi/180);
    matrixIdentity(m);
    m[0][0]=costheta;
    m[0][1]=-sintheta;
    m[1][0]=sintheta;
    m[1][1]=costheta;
}

/*
      name: matrixXYZRotation()
   purpose: create a matrix for rotation about the X,Y and Z axis
*/
void matrixXYZRotation(matrix44 m, real xangle, real yangle, real zangle) {
    real sin1,cos1;
    real sin2,cos2;
    real sin3,cos3;

    sin1=sin(yangle*pi/180);
    cos1=cos(yangle*pi/180);
    sin2=sin(xangle*pi/180);
    cos2=cos(xangle*pi/180);
    sin3=sin(zangle*pi/180);
    cos3=cos(zangle*pi/180);
    matrixIdentity(m);
    m[0][0]=cos1*cos3+sin1*sin2*sin3;
    m[0][1]=-cos1*sin3+cos3*sin1*sin2;
    m[0][2]=cos2*sin1;
    m[1][0]=cos2*sin3;
    m[1][1]=cos2*cos3;
    m[1][2]=-sin2;
    m[2][0]=-cos3*sin1+cos1*sin2*sin3;
    m[2][1]=sin1*sin3+cos1*cos3*sin2;
    m[2][2]=cos1*cos2;
}

/*
      name: matrixTranslation()
   purpose: create a translation matrix
*/
void matrixTranslation(matrix44 m, real dx, real dy, real dz) {
    matrixIdentity(m);
    m[0][3]=dx;
    m[1][3]=dy;
    m[2][3]=dz;
}

/*
      name: matrixScale()
   purpose: create a scale matrix
*/
void matrixScale(matrix44 m, real sx, real sy, real sz) {
    matrixIdentity(m);
    m[0][0]=sx;
    m[1][1]=sy;
    m[2][2]=sz;
}

/*
      name: matrixTranspose()
   purpose: inverse a matrix (must be orthonormalized!) useful for object-space
            back-face culling or lightning
*/
void matrixTranspose(matrix44 m) {
    dword row,col;
    matrix44 r;

    for (row=0;row<4;row++)
       for (col=0;col<4;col++)
          r[row][col]=m[col][row];
    matrixCopy(r,m);
}