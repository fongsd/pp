#ifndef matrix_hpp
#define matrix_hpp

#include <iostream>
#include <cstdlib>
#include <vector>

using namespace std;

class Matrix{
	private:
		vector<vector<double>> _m;
	public:
		Matrix() {};
		Matrix(int m, int n);
		Matrix(Matrix& m);
		
		vector<double> operator [](int i) const;
		vector<double>& operator [](int i);
		
		Matrix* operator +(Matrix& m) const;
		Matrix* operator -(Matrix& m) const;
		Matrix* operator *(Matrix& m) const;
		Matrix* operator -() const;
		
		Matrix* transpose() const;
		Matrix* scalarMultiply(Matrix& m) const;
		
		void show(ostream& s) const;
		
		void addRow(vector<double>& v);
};

ostream& operator <<(ostream& s, const Matrix& m); 

#endif

