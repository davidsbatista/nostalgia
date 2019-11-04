// Class declaration file: apmatrix.h

#ifndef _APMATRIX_H
#define _APMATRIX_H

#include "apvector.cpp"

template <class itemType> class apmatrix
{
	public:
	
	// Constructors

	apmatrix( );
	apmatrix(int rows, int cols);
	apmatrix(int rows, int cols,
		const itemType & fillValue);
	apmatrix(const apmatrix<itemType> &mat);

	// Destructor

	~apmatrix( );

	// assignment

	const apmatrix & operator = 
		(const apmatrix & rhs);

	// Accessors

	int numrows() const;
	int numcols() const;

	// Indexing

	const apvector<itemType> & operator [ ] 
		(int row) const;
	apvector<itemType>& operator [ ] 
		(int row);

	// Modifiers
    
	void resize(int newRows, int newCols);

	private:

	// Data members

	int myRows;
	int myCols;
	apvector<apvector<itemType> > myMatrix;
};

#endif
