//******************************************************************************
//*******************TEST DRIVER FOR THE APMATRIX CLASS*************************
//******************************************************************************
//Programmer/Engineer: Ryan Lloyd
//Main Driver Name: "matrix"
//Date Started: 2-13-00
//Date of Completion: 2-19-01
//Course: Advanced Placement Computer Science
//Teacher: Mr. Swanson
//Period: Six

//Visit Wonder Workers' C++ / C / Quick BASIC Site:
//		http://www.geocities.com/wonworkers/main.html

//Feel free to e-mail Wonder Workers, Inc. at:
//		wonderworkers@excite.com


#include <conio.h>
#include <iostream.h>
#include <iomanip.h>
#include <assert.h>
#include "apmatrix.cpp"
#include "rational.h"

void prompt_np();
void fill_matrix(apmatrix<int> &mat);
void display_matrix(apmatrix<int> mat);
int det_2x2(apmatrix<int> mat);
int det_3x3(apmatrix<int> mat);
rational det_nxn(apmatrix<int> mat);
apmatrix<int> add_mat(apmatrix<int> mat1, apmatrix<int> mat2);
apmatrix<int> multiply_mat(apmatrix<int> mat1, apmatrix<int> mat2);

struct many_mat
	{
   apmatrix<rational> submatrix;
   };
   
int main()
{
	apmatrix<int> mat1(3,3,0);
   apmatrix<int> mat2(2,2,0);
   apmatrix<int> mat3(3,3,0);
   apmatrix<int> mat4(3,3,5);
   apmatrix<int> mat5(3,2,4);
   apmatrix<int> mat6(2,3,10);
   apmatrix<int> sum1(10,10,0);
   apmatrix<int> product1(10,10,0);
   apmatrix<int> n_by_n(12,12,0);
   int n;
   mat2[0][0] = -18;
   mat2[0][1] = 4;
   mat2[1][0] = 7;
   mat2[1][1] = 9;
   mat3[0][0] = 21;
   mat3[0][1] = 8;
   mat3[0][2] = 11;
   mat3[1][0] = 35;
   mat3[1][1] = -2;
   mat3[1][2] = 52;
   mat3[2][0] = 25;
   mat3[2][1] = 0;
   mat3[2][2] = 41;
   cout<<"Point #1:\n-This segment of the program tests the apmatrix class' ability to assign\nvalues to its components from the keyboard.\n-Please input integer values into the slots of a 3 x 3 matrix below:\n\n";
   fill_matrix(mat1);
   clrscr();
   cout<<"The matrix's slots that you recently provided values for are displayed\nin the block below:\n\n\n";
   display_matrix(mat1);
   prompt_np();
   cout<<"Point #2:\n-The test driver will now discover the determinant for the\nnumbers in a 2 x 2 matrix, which is displayed below:\n\n\n";
   display_matrix(mat2);
   cout<<"\n\n\n\n\t\tDeterminant:  "<<det_2x2(mat2);
   prompt_np();
	cout<<"Point #3:\n-The application shall now find the determinant of the 3 x 3\nmatrix that is printed out below:\n\n\n";
   display_matrix(mat3);
   cout<<"\n\n\n\n\t\tDeterminant:  "<<det_3x3(mat3);
   prompt_np();
	cout<<"Point #4:\n-This sector of the demo requires you to specify the components of a n x n\nmatrix.  You must also provide the value of \'n,\' which signifies the length of\na side of the matrix.  The computer will then find the determinant for\nthe square matrix.\n\n\n";
   do
   	{
		cout<<"What is the value for \'n?\'  (\'n\' should be between 4 and 12 inclusively.)  ";
      cin>>n;
      }
	   while((n < 4) || (n > 12));
   n_by_n.resize(n,n);
   cout<<"\n\nNow, fill in the slots in the "<<n<<" x "<<n<<" matrix.\n";
   fill_matrix(n_by_n);
   clrscr();
   cout<<"The determinant for the previous "<<n<<" x "<<n<<" matrix reads as follows:  "<<det_nxn(n_by_n);
   prompt_np();
   cout<<"Point #5:\nTwo 3 x 3 matricies are displayed as follows:\n\n\n";
   display_matrix(mat3);
   cout<<"\n\n";
   display_matrix(mat4);
   prompt_np();
   cout<<"The sum of the two previous matricies is shown below:\n\n\n\n";
   sum1 = add_mat(mat3, mat4);
   display_matrix(sum1);
   prompt_np();
   cout<<"Point #6:\nPrinted below is a 3 x 2 matrix, followed by a 2 x 3 matrix:\n\n\n";
   display_matrix(mat5);
   cout<<"\n\n";
   display_matrix(mat6);
   prompt_np();
   cout<<"The product of the past two matricies reads as follows:\n\n\n";
   product1 = multiply_mat(mat5, mat6);
   display_matrix(product1);
   cout<<"\n\n\n\n\n\t\t  Strike Any Key to End the Demonstration";
   getch();
   clrscr();
   return 0;
}
//The Main Test Driver Ends


//******************************************************************************
//**********************FUNCTION PAGE BEGINS BELOW******************************
//******************************************************************************

void prompt_np()
	{
   cout<<"\n\n\n\n\t\t\tSTRIKE ANY KEY TO CONTINUE ON";
   //A "clean slate" will be processed after the user replies to the prompt by
   //pressing a key.
   getch();
   clrscr();
   }

//******************************************************************************

void fill_matrix(apmatrix<int> &mat)
	{
   int rows = mat.numrows();
   int cols = mat.numcols();
   int element;
   for(int row=0; row < rows; ++row)
   	for(int column=0; column < cols; ++column)
   		{
      	cout<<"Value of ("<<row<<", "<<column<<"):  ";
      	cin>>element;
      	mat[row][column] = element;
      	}
   }

//******************************************************************************

void display_matrix(apmatrix<int> mat)
	{
   int rows = mat.numrows();
   int cols = mat.numcols();
   cout<<setiosflags(ios::left);
   for(int row=0; row < rows; ++row)
   	{
      cout<<"     [";
   	for(int column=0; column < cols; ++column)
			cout<<setw(6)<<mat[row][column];
      cout<<']'<<endl;
      }
   }

//******************************************************************************

int det_2x2(apmatrix<int> mat)
	{
   assert((mat.numrows()) == (mat.numcols()));
	return ((mat[0][0] * mat[1][1]) - (mat[0][1] * mat[1][0]));
   }

//******************************************************************************

int det_3x3(apmatrix<int> mat)
	{
   assert((mat.numrows()) == (mat.numcols()));
   return (mat[0][0] * mat[1][1] * mat[2][2]) + (mat[0][1] * mat[1][2] * mat[2][0]) + (mat[0][2] * mat[1][0] * mat[2][1]) - (mat[0][2] * mat[1][1] * mat[2][0]) - (mat[1][2] * mat[2][1] * mat[0][0]) - (mat[2][2] * mat[0][1] * mat[1][0]);
   }

//******************************************************************************

rational det_nxn(apmatrix<int> mat)
	{
   assert((mat.numrows() == mat.numcols()) && (mat.numrows() > 3));
   int n = mat.numcols();
   many_mat mats[15];
   for(int res=0; res < 15; ++res)
   	mats[res].submatrix.resize(15, 15);
   int x, xx, yy;
   rational mult_factor;
   rational pre_final_det;
   rational neg_one(-1,1);
   rational product1, product2, product3, product4, product5, product6;
	rational sum1, sum2;
   for(int filly = 0; filly < n; ++filly)
   	for(int fillx = 0; fillx < n; ++fillx)
      	{
      	mats[n].submatrix[fillx][filly].change_numerator(mat[fillx][filly]);
         mats[n].submatrix[fillx][filly].change_denominator(1);
         }
   for(x = n; x > 3; --x)
      for(yy = 0; yy < (x-1); ++yy)
      	{
	     	mult_factor = ((mats[x].submatrix[yy][0] / mats[x].submatrix[(x-1)][0]) * neg_one);
   	   for(xx = 0; xx < (x-1); ++xx)
      		mats[(x-1)].submatrix[yy][xx] = (mult_factor * mats[x].submatrix[(x-1)][(xx+1)]) + mats[x].submatrix[yy][(xx+1)];
         }
   product1 = (mats[x].submatrix[0][0] * mats[x].submatrix[1][1] * mats[x].submatrix[2][2]);
   product2 = (mats[x].submatrix[0][1] * mats[x].submatrix[1][2] * mats[x].submatrix[2][0]);
   product3 = (mats[x].submatrix[0][2] * mats[x].submatrix[1][0] * mats[x].submatrix[2][1]);
   product4 = (mats[x].submatrix[0][2] * mats[x].submatrix[1][1] * mats[x].submatrix[2][0]);
   product5 = (mats[x].submatrix[0][0] * mats[x].submatrix[1][2] * mats[x].submatrix[2][1]);
   product6 = (mats[x].submatrix[0][1] * mats[x].submatrix[1][0] * mats[x].submatrix[2][2]);
   sum1 = product1 + product2 + product3;
   sum2 = product4 + product5 + product6;
	pre_final_det = (sum1 - sum2);
   return (pre_final_det * mats[n].submatrix[(n-1)][0] * neg_one);
	}

//******************************************************************************

apmatrix<int> add_mat(apmatrix<int> mat1, apmatrix<int> mat2)
	{
   assert((mat1.numrows() == mat2.numrows()) && (mat1.numcols() == mat2.numcols()));
   int rows = mat1.numrows();
   int cols = mat1.numcols();
   apmatrix<int> sum(rows, cols, 0);
   for(int row=0; row < rows; ++row)
   	for(int col=0; col < cols; ++col)
      	sum[row][col] = (mat1[row][col] + mat2[row][col]);
   return sum;
   }

//******************************************************************************

apmatrix<int> multiply_mat(apmatrix<int> mat1, apmatrix<int> mat2)
	{
   assert(mat1.numcols() == mat2.numrows());
   int rows = mat1.numrows();
   int cols = mat2.numcols();
   int numops = mat1.numcols();
   int sum;
   apmatrix<int> product(rows, cols, 0);
   for(int row=0; row < rows; ++row)
   	for(int col=0; col < cols; ++col)
      	{
         sum=0;
         for(int x=0; x < numops; ++x)
         	{
            sum = sum + (mat1[row][x] * mat2[x][col]);
            }
         product[row][col] = sum;
         }
   return product;
   }
