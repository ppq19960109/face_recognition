#include <iostream>

#include "detect-image.hh"
using namespace std;

int main(int argc, char *argv[])
{
    cout << "main start!" << endl;
    if (argc != 2)
    {
        printf("Usage: %s <image_file_name>\n", argv[0]);
        return -1;
    }
    facedetectcnn_image(argv[1]);
    return 0;
}