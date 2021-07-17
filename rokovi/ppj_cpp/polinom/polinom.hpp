#ifndef polinom_hpp
#define polinom_hpp 1

#include <iostream>
#include <vector>

using namespace std;

class Polinom{
	private:
		vector<double> _coeffs;
	public:
		Polinom() {};
		Polinom(int degree);
		Polinom(const vector<double>& elements);
		Polinom(const Polinom& p);
		
		void normalize(void);
		void insert(double x);
		
		Polinom* operator +(Polinom& p) const;
		Polinom* operator -(Polinom& p) const;
		Polinom* operator *(Polinom& p) const;
		
		Polinom* operator -() const;
		
		bool operator ==(Polinom& p) const;
		bool operator !=(Polinom& p) const;
		
		void show(ostream& s) const;
		
		double valueAt(double x) const;
		
		Polinom* izvod() const;
		Polinom* integral(double c) const;
};

ostream& operator <<(ostream& s, const Polinom& p); 

#endif
