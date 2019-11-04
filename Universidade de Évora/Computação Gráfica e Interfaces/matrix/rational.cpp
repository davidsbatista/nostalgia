#include <conio.h>
#include <iostream.h>
#include <assert.h>
#include "rational.h"

rational::rational()
	{
   my_numerator = 1;
   my_denominator = 1;
   }

//******************************************************************************

rational::rational(long int numerator, long int denominator)
	{
   assert(denominator != 0);
   my_numerator = numerator;
   my_denominator = denominator;
   reduce();
   }

//******************************************************************************

rational::rational(const rational &r)
	{
   my_numerator = r.my_numerator;
   my_denominator = r.my_denominator;
   }

//******************************************************************************

void rational::reduce()
	{
   long int common_div;
   if((my_numerator < 0) && (my_denominator > 0))
   	my_denominator = my_denominator * -1;
   if((my_denominator < 0) && (my_numerator > 0))
   	my_numerator = my_numerator * -1;
   if(my_numerator == 0)
   	{
      my_numerator = 0;
      my_denominator = 1;
      }
   if(my_numerator > 0)
   	{
	   if(my_numerator >= my_denominator)
   		common_div = my_denominator;
	   else
   	   common_div = my_numerator;
	   while(((my_numerator % common_div) != 0) || ((my_denominator % common_div) != 0))
   	   --common_div;
      my_numerator = (my_numerator / common_div);
   	my_denominator = (my_denominator / common_div);
      }
   else
   	{
   	if(my_numerator >= my_denominator)
      	common_div = my_numerator;
      else
      	common_div = my_denominator;
      while(((my_numerator % common_div) != 0) || ((my_denominator % common_div) != 0))
   	   ++common_div;
      my_numerator = (my_numerator / common_div) * -1;
	   my_denominator = (my_denominator / common_div);
      }
   }

//******************************************************************************

long int rational::numerator() const
	{
   return my_numerator;
   }

//******************************************************************************

long int rational::denominator() const
	{
   return my_denominator;
   }

//******************************************************************************

void rational::change_numerator(long int new_numerator)
	{
   my_numerator = new_numerator;
   }

//******************************************************************************

void rational::change_denominator(long int new_denominator)
	{
   my_denominator = new_denominator;
   }

//******************************************************************************

const rational& rational::operator = (const rational &rhs)
	{
   if(this != &rhs)
   	{
      my_numerator = rhs.my_numerator;
      my_denominator = rhs.my_denominator;
      }
   return *this;
   }

//******************************************************************************

rational operator + (const rational &lhs, const rational &rhs)
	{
   long int lnum, ldenom, rnum, rdenom;
   lnum = lhs.numerator();
   ldenom = lhs.denominator();
   rnum = rhs.numerator();
   rdenom = rhs.denominator();
   long int numerator = (lnum * rdenom) + (rnum * ldenom);
   long int denominator = (ldenom * rdenom);
   rational sum(numerator, denominator);
   return sum;
   }

//******************************************************************************

rational operator - (const rational &lhs, const rational &rhs)
	{
   long int lnum, ldenom, rnum, rdenom;
   lnum = lhs.numerator();
   ldenom = lhs.denominator();
   rnum = rhs.numerator();
   rdenom = rhs.denominator();
   long int numerator = (lnum * rdenom) - (rnum * ldenom);
   long int denominator = ldenom * rdenom;
   rational diff(numerator, denominator);
   return diff;
   }

//******************************************************************************

rational operator * (const rational &lhs, const rational &rhs)
	{
   long int lnum, ldenom, rnum, rdenom;
   lnum = lhs.numerator();
   ldenom = lhs.denominator();
   rnum = rhs.numerator();
   rdenom = rhs.denominator();
	long int numerator = (lnum * rnum);
   long int denominator = (ldenom * rdenom);
   rational product(numerator, denominator);
   return product;
   }

//******************************************************************************

rational operator / (const rational &lhs, const rational &rhs)
	{
   long int lnum, ldenom, rnum, rdenom;
   lnum = lhs.numerator();
   ldenom = lhs.denominator();
   rnum = rhs.numerator();
   rdenom = rhs.denominator();
   long int numerator = (lnum * rdenom);
   long int denominator = (ldenom * rnum);
   rational quotient(numerator, denominator);
   return quotient;
   }

//******************************************************************************

bool operator == (const rational &lhs, const rational &rhs)
	{
   if((lhs.numerator() == rhs.numerator()) && (lhs.denominator() == rhs.denominator()))
	   return 1;
   return 0;
   }

//******************************************************************************

istream& operator >> (istream &is, rational &r)
	{
   char division_symbol;
   long int numerator = 0, denominator =0;
   is>>numerator>>division_symbol>>denominator;
   rational temp(numerator, denominator);
   r = temp;
   return is;
   }

//******************************************************************************

ostream& operator << (ostream &os, const rational &r)
	{
   if(r.denominator() == 1)
   	os<<r.numerator();
   else if(r.numerator() == 0)
   	os<<'0';
   else
   	{
      if((r.numerator() < 0) && (r.denominator() > 0))
      	os<<'-'<<(r.numerator() * -1)<<'/'<<r.denominator();
      else if((r.numerator() > 0) && (r.denominator() < 0))
      	os<<'-'<<r.numerator()<<'/'<<(r.denominator() * -1);
      else if((r.numerator() < 0) && (r.denominator() < 0))
      	os<<(r.numerator() * -1)<<'/'<<(r.denominator() * -1);
      else
		   os<<r.numerator()<<'/'<<r.denominator();
      }
   return os;
   }
