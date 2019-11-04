// Class declaration file: rational.h

#ifndef RATIONAL_H

#include <iostream.h>
//#include "bool.h"  don't need this we have it in our default library.

class rational
{
	public:
	//Constructors
	rational();
	rational(long int numerator, long int denominator);

   //Copy constructor
	rational(const rational &r);

	//Accessors
	long int numerator() const;
	long int denominator() const;

   //Modifiers
   void change_numerator(long int new_numerator);
   void change_denominator(long int new_denominator);

	//Assignment
	const rational& operator = (const rational &rhs);

	protected:
	//Data members
	long int my_numerator, my_denominator;

	//Utility function
	void reduce();
};

// The following free (non-member) functions operate on
// rational numbers

// Arithmetic

rational operator + (const rational &lhs, const rational &rhs);
rational operator - (const rational &lhs, const rational &rhs);
rational operator * (const rational &lhs, const rational &rhs);
rational operator / (const rational &lhs, const rational &rhs);

// Comparison

bool operator == (const rational &lhs, const rational &rhs);

// Input and output
	
istream& operator >> (istream &is, rational &r);
ostream& operator << (ostream &os, const rational &r);

#define RATIONAL_H
#endif
