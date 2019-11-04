#ifndef __SHARED_H__
#define __SHARED_H__

typedef unsigned char   byte;
typedef unsigned short  word;
typedef unsigned long   dword;
typedef signed char     sbyte;
typedef signed short    sword;
typedef signed long     sdword;
typedef float           real;
typedef double          longreal;
typedef enum {
    true=-1,
    false=0
} bool;

#define ALL eax ebx ecx edx esi edi

dword pentium_clk(void);
#pragma aux pentium_clk="db 0xf,0x31" value [eax] modify [edx];

void repstosd(byte *dest,dword value,dword count);
#pragma aux repstosd=\
        "cld"\
        "rep stosd",\
        parm [edi] [eax] [ecx];

void repmovsd(byte *source,byte *dest,dword count);
#pragma aux repmovsd=\
        "cld"\
        "rep movsd",\
        parm [esi] [edi] [ecx];

void setmem(byte *dest,dword value,dword count);
#pragma aux setmem=\
        "cld"\
        "mov ecx,ebx"\
        "and ecx,3"\
        "rep stosb"\
        "mov ecx,ebx"\
        "shr ecx,2"\
        "rep stosd",\
        parm [edi] [eax] [ebx] modify [ecx];

void movemem(byte *source,byte *dest,dword count);
#pragma aux movemem=\
        "cld"\
        "mov ecx,ebx"\
        "and ecx,3"\
        "rep movsb"\
        "mov ecx,ebx"\
        "shr ecx,2"\
        "rep movsd",\
        parm [esi] [edi] [ebx] modify [ecx];

#endif