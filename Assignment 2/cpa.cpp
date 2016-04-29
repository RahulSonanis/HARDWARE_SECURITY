#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <cmath>
#include <string.h>
#include <algorithm>
using namespace std;

int cipher_matrix[4][4];
int final_matrix[4][4];

void make_ciphertext_matrix(char *);
void add_key(int ,int ,int );
int getSBoxInvert(int );
void InvShiftRows();
void inv_subBytes();
void print_(int a[][4]);
int hamming_distance(int ,int );

int mapping[16] = {0,13,10,7,4,1,14,11,8,5,2,15,12,9,6,3};

int key[16];

int main()
{
	string input_file_name;
	
	cout<<"Give name of input file : ";
	cin>>input_file_name;

	string buffer;
	int rows;
	int columns;
	size_t n;

	// counting number of rows and columns in the input file
	ifstream input_stream(input_file_name.c_str());	
	while(!input_stream.eof())
	{
		getline(input_stream,buffer,'\n');

		if(!input_stream.eof())
		{
			rows = rows + 1;
			n = count(buffer.begin(), buffer.end(), ',');
			columns = n;
		}
	}
	input_stream.close();

	cout<<"Number of rows = "<<rows<<endl;
	cout<<"Number of columns = "<<columns<<endl;
	columns = columns-2;
	columns = 2500;

	// Real Power Matrix
	int** rPower = new int*[rows];
	for(int i = 0; i < rows; ++i)
	    rPower[i] = new int[columns];

	// Hypothetical Power Matrix
	int** hPower = new int*[rows];
	for(int i = 0; i < rows; ++i)
	    hPower[i] = new int[256];

	// Plaintext Array
	vector<string> plaintext_array;
	// Ciphertext Array
	vector<string> ciphertext_array;	

	vector<double> mean_trace;
	vector<double> meanH;

	ifstream input1_stream(input_file_name.c_str());

	int row_count = 0;
	int column_count = 0;	

	plaintext_array.clear();
	ciphertext_array.clear();

	// reading real power matrix taken sample from 19500-22000
	while(!input1_stream.eof())
	{
		char *row_;
		getline(input1_stream,buffer,'\n');

		if(!input1_stream.eof())
		{
			char * cstr = new char [buffer.length()+1];
			strcpy(cstr, buffer.c_str());

			int l=1;
			char *p = strtok (cstr,",");

			column_count = 0;
			while(p!=0)
			{
				if(l > 19500 && l < 22001)
				{
					rPower[row_count][column_count] = atoi(p);
					column_count++;
				}
				else if(l == 1)
				{
					string a(p);
					plaintext_array.push_back(a);
				}
				else if(l == 2)
				{
					string a(p);
					ciphertext_array.push_back(a);
				}

				p = strtok(NULL,",");
				l++;
			}
			delete[] cstr;
			row_count++;
		}
	}

	input1_stream.close();
	cout<<"columns used for analysis = "<<column_count<<endl;


	// /*****************************************************************/
	// // printing Real Power Matrix into file
	// ofstream outarray_file;
	// outarray_file.open("outarray.txt");
	// for(int i=0 ; i < rows ; i++)
	// {
	// 	for (int j = 0; j < columns; j++)
	// 	{
	// 		outarray_file<<rPower[i][j]<<" ";
	// 	}
	// 	outarray_file<<"\n";
	// }
	// outarray_file.close();
	// /*****************************************************************/

	// cout<<"Size of plaintext_array = "<<plaintext_array.size()<<endl;
	// /*****************************************************************/
	// // printing Plaintext array into file
	// ofstream outarray_file;
	// outarray_file.open("plaintext.txt");
	// for(int i=0 ; i < rows ; i++)
	// {
	// 	outarray_file<<plaintext_array[i]<<endl;
	// }
	// outarray_file.close();
	// /*****************************************************************/

	// cout<<"Size of ciphertext_array = "<<ciphertext_array.size()<<endl;
	// /*****************************************************************/
	// // printing Ciphertext array into file
	// ofstream outarray_file1;
	// outarray_file1.open("ciphertext.txt");
	// for(int i=0 ; i < rows ; i++)
	// {
	// 	outarray_file1<<ciphertext_array[i]<<endl;
	// }
	// outarray_file1.close();
	// /*****************************************************************/

	//////////////////////////////////////////////////////////////////////

	//////////////////////////////////////////////////////////////////////

	// creating mean_trace vector
	mean_trace.clear();
	for (int i = 0; i < columns; ++i)
	{
		double count = 0;
		for (int j = 0; j < rows; ++j)
		{
			count += rPower[j][i];
		}
		count /= rows;

		mean_trace.push_back(count);
	}


	// Creating Co-relation matrix
	double** co_relation = new double*[256];
	for(int i = 0; i < 256; ++i)
	    co_relation[i] = new double[columns];

	// CPA code
	for (int I = 0; I < 4; ++I)
	{
		for (int J = 0; J < 4; ++J)
		{
			// computing target byte
			int t = J*4 + I;
			// computing taget ciper byte
			int t1 = mapping[t];
			// mapping for array
			int tar_c_i = t1%4;
			int tar_c_j = t1/4;


			for(int i = 0; i < rows; ++i)
			{
				char * cstr = new char[ciphertext_array[i].length()+1];
				strcpy(cstr, ciphertext_array[i].c_str());
				// making ciper matrix
				make_ciphertext_matrix(cstr);

				///
				int cipher = cipher_matrix[I][J];
				int Scipher = cipher_matrix[tar_c_i][tar_c_j];
				///

				for (int j = 0; j < 256; ++j)
				{
					// make_ciphertext_matrix(cstr);
					// add_key(tar_c_i,tar_c_j,j);
					// InvShiftRows();
					// inv_subBytes();


					// adding key to taget cipher byte
					int lol1 = Scipher + j;
					// getting sbox inverse 
					int lol2 = getSBoxInvert(lol1);
					
					// hPower[i][j] = hamming_distance(cipher_matrix[I][J],final_matrix[I][J]);
					hPower[i][j] = hamming_distance(cipher,lol2);
				}
			}

			// /*****************************************************************/
			// // printing Hypothetical Power Matrix into file
			// ofstream outarray_file2;
			// outarray_file2.open("hypo_power.txt");
			// for(int i=0 ; i < rows ; i++)
			// {
			// 	for (int j = 0; j < 256; j++)
			// 	{
			// 		outarray_file2<<hPower[i][j]<<" ";
			// 	}
			// 	outarray_file2<<"\n";
			// }
			// outarray_file2.close();
			// /*****************************************************************/

			// creating meanH vector
			meanH.clear();
			for (int i = 0; i < 256; ++i)
			{
				double count = 0;
				for (int j = 0; j < rows; ++j)
				{
					count += hPower[j][i];
				}
				count /= rows;

				meanH.push_back(count);
			}

			
			double max = 0;
			double max1 = 0;
			double max2 = 0;
			int i1,j1,i2,i3;

			for (int i = 0; i < 256; ++i)
			{
				for (int j = 0; j < columns; ++j)
				{
					double temph;
					double tempt;
					double sumHT;
					double sumSqH;
					double sumSqT;

					for(int k = 0; k < rows; k++)
					{
						temph = hPower[k][i] - meanH[i];
						tempt = rPower[k][j] - mean_trace[j];
						sumHT += temph*tempt;
						sumSqH += temph*temph;
						sumSqT += tempt*tempt;

						// cout<<"sumSqT = "<<sumSqT<<" && sumHT = "<<sumHT<<" && sumSqH = "<<sumSqH<<endl;
					}
					co_relation[i][j] = sumHT/sqrt(sumSqH*sumSqT);

					if(max < fabs(co_relation[i][j]))
					{
						max = fabs(co_relation[i][j]);
						i1 = i;
						j1 = j;
					}
					else if(max1 < fabs(co_relation[i][j]))
					{
						max1 = fabs(co_relation[i][j]);
						i2 = i;
					}
					else if(max2 < fabs(co_relation[i][j]))
					{
						max2 = fabs(co_relation[i][j]);
						i3 = i;
					}
				}
			}

			// /*****************************************************************/
			// // printing Hypothetical Power Matrix into file
			// ofstream outarray_file3;
			// char tar[1024];
			// sprintf(tar,"corelation%d.txt",t);
			// outarray_file3.open(tar);
			// for(int i=0 ; i < 256 ; i++)
			// {
			// 	for (int j = 0; j < columns; j++)
			// 	{
			// 		outarray_file3<<co_relation[i][j]<<" ";
			// 	}
			// 	outarray_file3<<"\n";
			// }
			// outarray_file3.close();
			// /*****************************************************************/

			key[t1] = i1;

			cout<<"Key Value obtained is = "<<i1<<" && for co_relation0 = "<<max<<" && for t1 = "<<t1<<endl;
			cout<<"Key Value obtained is = "<<i2<<" && for co_relation1 = "<<max1<<" && for t1 = "<<t1<<endl;
			cout<<"Key Value obtained is = "<<i3<<" && for co_relation2 = "<<max2<<" && for t1 = "<<t1<<endl;
		}
	}

	string output_key;

	for (int i = 15; i >= 0; i--)
	{
        string y;
        stringstream ss;
        ss<<hex<<key[i];
        ss>>y;
        if(y.size() == 1)
        {
            output_key.append("0");
        }
        output_key.append(y);
	}

	cout<<"Key from CPA is "<<output_key<<endl;
	

	/////////////////////////////////////////////////////////////////

	for(int i = 0; i < rows; ++i) {
	    delete [] rPower[i];
	}
	delete [] rPower;

	for(int i = 0; i < rows; ++i) {
	    delete [] hPower[i];
	}
	delete [] hPower;

	for(int i = 0; i < 256; ++i) {
	    delete [] co_relation[i];
	}
	delete [] co_relation;

	cout<<"Done"<<endl;

	//////////////////////////////////////////////////////////////////////

	return 0;
}


int hamming_distance(int a,int b)
{
	int hi = a^b;
	int count = 0;

	for (int i = 0; i < 8; ++i)
	{
		if((hi>>i) & 1)		count++;
	}

	return count;
}

void make_ciphertext_matrix(char *test)
{
	char test1[3];
	int k=strlen(test)-2;
	for (int i = 0; i < 4; ++i)
	{
		for (int j = 0; j < 4; ++j)
		{
			strncpy(test1,&test[k],2);
			test1[2] = '\0';
			cipher_matrix[j][i] = (int)strtol(test1, NULL, 16);
			final_matrix[j][i] = (int)strtol(test1, NULL, 16);
			k = k - 2;
		}
	}
}

void add_key(int i,int j,int val)
{
	final_matrix[i][j] = final_matrix[i][j] ^ val;
}

void inv_subBytes()
{
	for (int i = 0; i < 4; ++i)
	{
		for (int j = 0; j < 4; ++j)
		{
			final_matrix[i][j] = getSBoxInvert(final_matrix[i][j]);
		}
	}
}

int getSBoxInvert(int num)
{
	int rsbox[256] =
	{ 0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb
	, 0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb
	, 0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e
	, 0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25
	, 0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92
	, 0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84
	, 0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06
	, 0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b
	, 0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73
	, 0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e
	, 0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b
	, 0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4
	, 0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f
	, 0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef
	, 0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61
	, 0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d };

	// int rsbox[256] = 
	// {
	// 	82,     9, 106, 213,   48,   54, 165,   56, 191,   64, 163, 158, 129, 243, 215, 251,
	// 	                           124, 227,   57, 130, 155,   47, 255, 135,   52, 142,   67,   68, 196, 222, 233, 203,
	// 	                             84, 123, 148,   50, 166, 194,   35,   61, 238,   76, 149,   11,   66, 250, 195,   78,
	// 	                               8,   46, 161, 102,   40, 217,   36, 178, 118,   91, 162,   73, 109, 139, 209,   37,
	// 	                           114, 248, 246, 100, 134, 104, 152,   22, 212, 164,   92, 204,   93, 101, 182, 146,
	// 	                           108, 112,   72,   80, 253, 237, 185, 218,   94,   21,   70,   87, 167, 141, 157, 132,
	// 	                           144, 216, 171,     0, 140, 188, 211,   10, 247, 228,   88,     5, 184, 179,   69,     6,
	// 	                           208,   44,   30, 143, 202,   63,   15,     2, 193, 175, 189,     3,     1,   19, 138, 107,
	// 	                             58, 145,   17,   65,   79, 103, 220, 234, 151, 242, 207, 206, 240, 180, 230, 115,
	// 	                           150, 172, 116,   34, 231, 173,   53, 133, 226, 249,   55, 232,   28, 117, 223, 110,
	// 	                             71, 241,   26, 113,   29,   41, 197, 137, 111, 183,   98,   14, 170,   24, 190,   27,
	// 	                           252,   86,   62,   75, 198, 210, 121,   32, 154, 219, 192, 254, 120, 205,   90, 244,
	// 	                             31, 221, 168,   51, 136,     7, 199,   49, 177,   18,   16,   89,   39, 128, 236,   95,
	// 	                             96,   81, 127, 169,   25, 181,   74,   13,   45, 229, 122, 159, 147, 201, 156, 239,
	// 	                           160, 224,   59,   77, 174,   42, 245, 176, 200, 235, 187,   60, 131,   83, 153,   97,
	// 	                             23,   43,     4, 126, 186, 119, 214,   38, 225, 105,   20,   99,   85,   33,   12, 125
	// };

	return rsbox[num];
}

void InvShiftRows()
{
	int temp;

	// Rotate first row 1 columns to right	
	temp=final_matrix[1][3];
	final_matrix[1][3]=final_matrix[1][2];
	final_matrix[1][2]=final_matrix[1][1];
	final_matrix[1][1]=final_matrix[1][0];
	final_matrix[1][0]=temp;

	// Rotate second row 2 columns to right	
	temp=final_matrix[2][0];
	final_matrix[2][0]=final_matrix[2][2];
	final_matrix[2][2]=temp;

	temp=final_matrix[2][1];
	final_matrix[2][1]=final_matrix[2][3];
	final_matrix[2][3]=temp;

	// Rotate third row 3 columns to right
	temp=final_matrix[3][0];
	final_matrix[3][0]=final_matrix[3][1];
	final_matrix[3][1]=final_matrix[3][2];
	final_matrix[3][2]=final_matrix[3][3];
	final_matrix[3][3]=temp;
}

void print_(int a[][4])
{
	for (int i = 0; i < 4; ++i)
	{
		for (int j = 0; j < 4; ++j)
		{
			cout<<a[i][j]<<" ";
		}
		cout<<endl;
	}
	cout<<endl;
}