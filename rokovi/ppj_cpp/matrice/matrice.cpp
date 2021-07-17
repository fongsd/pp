#include <iostream>
#include <vector>

using namespace std;
#include "matrice.hpp"

Matrix::Matrix(int m, int n) {

	_m.resize(m);
	for (int i = 0; i < m; i++)
		_m[i].resize(n);
}

Matrix::Matrix(Matrix& m) {
	
	_m = m._m;
}

vector<double> Matrix::operator [](int i) const {
	
	return _m[i];
}

vector<double>& Matrix::operator [](int i) {
	
	return _m[i];
}

Matrix* Matrix::operator +(Matrix& m) const {
	
	if (_m.size() != m._m.size() || _m[0].size() != m._m[0].size())
		return NULL;
	
	Matrix* newMatrix = new Matrix(_m.size(), _m[0].size());
	
	for (int i = 0; i < _m.size(); i++) {
		for (int j = 0; j < _m[0].size(); j++) {
			(*newMatrix)[i][j] = _m[i][j]+m._m[i][j];
		}
	}
	
	return newMatrix;
}
Matrix* Matrix::operator -(Matrix& m) const {
	
	if (_m.size() != m._m.size() || _m[0].size() != m._m[0].size())
		return NULL;
	
	Matrix* newMatrix = new Matrix(_m.size(), _m[0].size());
	
	for (int i = 0; i < _m.size(); i++) {
		for (int j = 0; j < _m[0].size(); j++) {
			(*newMatrix)[i][j] = _m[i][j]-m._m[i][j];
		}
	}
	
	return newMatrix;
}
Matrix* Matrix::operator *(Matrix& m) const {
	
	if (_m[0].size() != m._m.size())
		return NULL;
	
	Matrix* newMatrix = new Matrix(_m.size(), m._m[0].size());
	
	for (int i = 0; i < _m.size(); i++) {
		for (int j = 0; j < m._m[0].size(); j++) {
			(*newMatrix)[i][j] = 0;
			for(int k = 0; k < _m[0].size(); k++) {
				(*newMatrix)[i][j] += _m[i][k]*m._m[k][j];
			}
		}
	}
	
	return newMatrix;
}

Matrix* Matrix::operator -() const {
	
	Matrix* newMatrix = new Matrix(_m.size(), _m[0].size());
	
	for (int i = 0; i < _m.size(); i++) {
		for (int j = 0; j < _m[0].size(); j++) {
			(*newMatrix)[i][j] = -_m[i][j];
		}
	}
	
	return newMatrix;
}

Matrix* Matrix::transpose() const {
	
	Matrix* newMatrix = new Matrix(_m[0].size(), _m.size());
	
	for (int i = 0; i < _m.size(); i++) {
		for (int j = 0; j < _m[0].size(); j++) {
			(*newMatrix)[j][i] = _m[i][j];
		}
	}
	
	return newMatrix;
}

Matrix* Matrix::scalarMultiply(Matrix& m) const {
	
	if (_m.size() != m._m.size() || _m[0].size() != m._m[0].size())
		return NULL;
	
	Matrix* newMatrix = new Matrix(_m.size(), _m[0].size());
	
	for (int i = 0; i < _m.size(); i++) {
		for (int j = 0; j < _m[0].size(); j++) {
			(*newMatrix)[i][j] = _m[i][j]*m._m[i][j];
		}
	}
	
	return newMatrix;
}

void Matrix::show(ostream& s) const {
	
	for (int i = 0; i < _m.size(); i++) {
		for (int j = 0; j < _m[0].size(); j++){
			s<<_m[i][j]<<" ";
		}
		s<<endl;
	}
}

void Matrix::addRow(vector<double>& v) {
	
	_m.push_back(v);
}

ostream& operator <<(ostream& s, const Matrix& m) {
	
	m.show(s);
	return s;
}
