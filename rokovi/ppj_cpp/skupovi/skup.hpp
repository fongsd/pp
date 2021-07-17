#ifndef skup_h 
#define skup_h 1

#include <iostream>
#include <set>

using namespace std;

class Skup {
	private:
		set<int> _elementi;
	public:
		
		Skup() {}
		Skup(int begin, int end);
		Skup(set<int>& elementi);
		Skup(const Skup& s);
		
		void show(ostream& s) const;
		
		Skup* operator +(Skup& s) const;
		Skup* operator -(Skup& s) const;
		Skup* operator *(Skup& s) const;
		
		bool find(int x) const;
		bool subset(Skup& s) const;
		
		int card(void) const;
		
		void insert(int x);
		
		Skup* complement(Skup& s) const;
};

ostream& operator <<(ostream& s, const Skup& skup);

#endif

