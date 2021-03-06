#include "skup.hpp"

using namespace std;

Skup::Skup(int begin, int end) {
	
	for (int i = begin; i<=end; i++)
		_elementi.insert(i);
}
Skup::Skup(set<int>& elementi) {
	
	_elementi = elementi;
}
Skup::Skup(const Skup& s) {
		
	_elementi = s._elementi;
}

void Skup::show(ostream& s) const {
	
	s<<"{";
	for (auto it = _elementi.begin(); it != _elementi.end(); it++){
		if (it != _elementi.cbegin())
			s<<",";
		s<<*it;
	}
	s<<"}";
}

Skup* Skup::operator +(Skup& s) const {
	
	Skup* noviSkup = new Skup(s);
	
	for (auto it = _elementi.begin(); it != _elementi.end(); it++){
		
		noviSkup->insert(*it);
	}
	
	return noviSkup;
}
Skup* Skup::operator -(Skup& s) const {
	
	Skup* noviSkup = new Skup();
	
	for (auto it = _elementi.begin(); it != _elementi.end(); it++){
		
		if (!(s.find(*it)))
			noviSkup->insert(*it);
	}
	
	return noviSkup;
}
Skup* Skup::operator *(Skup& s) const {
	
	Skup* noviSkup = new Skup();
	
	for (auto it = _elementi.begin(); it != _elementi.end(); it++){
		
		if (s.find(*it))
			noviSkup->insert(*it);
	}
	
	return noviSkup;
}

bool Skup::find(int x) const {
	
	return _elementi.find(x) != _elementi.end();
}

bool Skup::subset(Skup& s) const {
	
	for (auto it = s._elementi.begin(); it != s._elementi.end(); it++) {
		
		if (!(this->find(*it)))
			return false;
	}
	
	return true;
}

int Skup::card(void) const {
	
	return _elementi.size();
}

void Skup::insert(int x) {
	
	_elementi.insert(x);
}

Skup* Skup::complement(Skup& s) const {
	
	Skup* noviSkup = new Skup();
	
	for (auto it = _elementi.begin(); it != _elementi.end(); it++){
		
		if (!(s.find(*it)))
			noviSkup->insert(*it);
	}
	
	return noviSkup;
}

ostream& operator <<(ostream& s, const Skup& skup) {
	
	skup.show(s);
	return s;
}

/*
int main(int argc, char** argv) {
	
	Skup* s = new Skup(5,15);
	Skup* t = new Skup(1,10);
	Skup* r = NULL;
	
	cout<<*s<<endl;
	cout<<*t<<endl;
	
	r = *s + *t;
	cout<<*r<<endl;
	delete r;
	
	r = *s - *t;
	cout<<*r<<endl;
	delete r;
	
	r = *s * *t;
	cout<<*r<<endl;
	delete r;
	
	cout<<(s->subset(*t))<<endl;
	Skup* w = new Skup(8,12);
	cout<<(s->subset(*w))<<endl;
	
	// curi memorija
	cout<<*(s->complement(*w))<<endl;
	
	delete s;
	delete t;
	delete w;
	
	exit(EXIT_SUCCESS);
}
*/
