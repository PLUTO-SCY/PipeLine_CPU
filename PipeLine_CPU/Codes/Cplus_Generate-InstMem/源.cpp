#include<iostream>
#include <string>
#include <fstream>
using namespace std;

int main()
{
    ifstream myfile("IN.txt");
    ofstream outfile("out.txt");
    string temp;
    int i = -1;
    while (getline(myfile, temp))
    {
        i++;
        outfile << "data[9'd";
        outfile << i << "] <= ";
        outfile << temp;
        outfile << ";" << endl;
    }
    myfile.close();
    outfile.close();
	return 0;
}