#include "polinom.hpp"

using namespace std;

Polinom::Polinom(int degree) {
	
	_coeffs.resize(degree);
	for (auto it = _coeffs.begin(); it != _coeffs.end(); it++)
		*it = 0;
}

Polinom::Polinom(const Polinom& p) {
	
	_coeffs = p._coeffs;
}

Polinom::Polinom(const vector<double>& elements) {
	
	_coeffs = elements;
}

void Polinom::insert(double x) {
	
	_coeffs.push_back(x);
}

void Polinom::normalize(void) {
	
	for (auto it = _coeffs.rbegin(); it != _coeffs.rend() && *it == 0; it++)
		_coeffs.pop_back();
}

Polinom* Polinom::operator +(Polinom& p) const {
	Polinom* newPoly = new Polinom();
	
	auto it1 = _coeffs.begin();
	auto it2 = p._coeffs.begin();
	
	for (;it1 != _coeffs.end() && it2 != p._coeffs.end(); it1++, it2++)
		newPoly->insert(*it1 + *it2);
		
	for (;it1 != _coeffs.end(); it1++)
		newPoly->insert(*it1);
	
	for (;it2 != p._coeffs.end(); it2++)
		newPoly->insert(*it2);	
	
	newPoly->normalize();
	
	return newPoly;
}

Polinom* Polinom::operator -(Polinom& p) const {
	Polinom* newPoly = new Polinom();
	
	auto it1 = _coeffs.begin();
	auto it2 = p._coeffs.begin();
	
	for (;it1 != _coeffs.end() && it2 != p._coeffs.end(); it1++, it2++)
		newPoly->insert(*it1 - *it2);
		
	for (;it1 != _coeffs.end(); it1++)
		newPoly->insert(*it1);
	
	for (;it2 != p._coeffs.end(); it2++)
		newPoly->insert(-*it2);	
	
	newPoly->normalize();
	
	return newPoly;
}

Polinom* Polinom::operator *(Polinom& p) const {
	
	int deg1 = _coeffs.size();
	int deg2 = p._coeffs.size();
	Polinom* newPoly = new Polinom(deg1+deg2);
	
	for (int i = 0; i < deg1; i++) {
		for (int j = 0; j < deg2; j++) {
			newPoly->_coeffs[i+j] += _coeffs[i]*p._coeffs[j];
		}
	}	
	
	newPoly->normalize();
	
	return newPoly;
}

Polinom* Polinom::operator -() const {
	Polinom* newPoly = new Polinom();
	
	for (auto it = _coeffs.begin(); it != _coeffs.end(); it++)
		newPoly->insert(-*it);
	
	return newPoly;
}

bool Polinom::operator ==(Polinom& p) const {
	
	return _coeffs == p._coeffs;
}

bool Polinom::operator !=(Polinom& p) const {
	
	return !(_coeffs == p._coeffs);
}

void Polinom::show(ostream& s) const {
	
	int degree = _coeffs.size();
	for (int i = 0; i< degree; i++) {
		
		if (_coeffs[i] != 0) {
			if (_coeffs[i] > 0)
				s<<"+";
			if (i != 0)
				s<<_coeffs[i]<<"x^"<<i;
			else 
				s<<_coeffs[i];
		}
	}
}

double Polinom::valueAt(double x) const {
	
	auto it = _coeffs.rbegin();
	double result = *it;
	
	for (it++; it != _coeffs.rend(); it++) {
		result = result*x + *it;
	}
	
	return result;
}

Polinom* Polinom::izvod() const {
	
	Polinom* newPoly = new Polinom(_coeffs);
	int degree = newPoly->_coeffs.size();
	
	for (int i = 0; i < degree; i++){
		
		newPoly->_coeffs[i]*=i;
	}
	
	newPoly->_coeffs.erase(newPoly->_coeffs.begin());
	
	return newPoly;
}

Polinom* Polinom::integral(double c) const {
	Polinom* newPoly = new Polinom(_coeffs);
	
	newPoly->_coeffs.insert(newPoly->_coeffs.begin(), c);
	
	int degree = newPoly->_coeffs.size();
	
	for (int i = 0; i < degree; i++){
		if (i > 0)
			newPoly->_coeffs[i]/=i;
	}
	
	return newPoly;
}

ostream& operator <<(ostream& s, const Polinom& p) {
	
	p.show(s);
	return s;
}
