#define WorldCurvatureSize 256 //[-4096 -2048 -1024 -512 -256 -128 -64 -32 -16 -8 -4 -2 2 4 8 16 32 64 128 256 512 1024 2048 4096]

float worldCurvature(vec2 pos){
    return dot(pos,pos)/WorldCurvatureSize;
}