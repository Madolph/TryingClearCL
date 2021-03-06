

__kernel
void ScanPlaneX (__read_only image3d_t image,
            __global    float*    arrayX,
            int planeDimY,
            int planeDimZ) 
{
  const int x       = get_global_id(0);
  const int y       = get_global_id(1);
  const int z       = get_global_id(2);
  
  float sum = 0;
  
  const int4 origin = (int4){x,y,z,0};
  
  for(int ly=0; ly<planeDimY; ly++)
  {
    for(int lz=0; lz<planeDimZ; lz++)
    {
      const int4 pos = origin + (int4){0,ly,lz,0};
     
      float value = read_imagef(image, pos).x;

      sum = sum + value;
    }
  }
  const int index = x;
  
  arrayX[index] = sum;
}

__kernel
void ScanPlaneY (__read_only image3d_t image,
            __global    float*    arrayY,
            int planeDimX,
            int planeDimZ) 
{
  const int x       = get_global_id(0);
  const int y       = get_global_id(1);
  const int z       = get_global_id(2);
  
  const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
  
  float sum = 0;
  
  const int4 origin = (int4){x,y,z,0};
  
  for(int lx=0; lx<planeDimX; lx++)
  {
    for(int lz=0; lz<planeDimZ; lz++)
    {
      const int4 pos = origin + (int4){lx,0,lz,0};
     
      float value = read_imagef(image, sampler, pos).x;

      sum = sum + value;
    }
  }
  const int index = y;
  
  arrayY[index] = sum;
}

__kernel
void ScanPlaneZ (__read_only image3d_t image,
            __global    float*    arrayZ,
            int planeDimX,
            int planeDimY) 
{
  const int x       = get_global_id(0);
  const int y       = get_global_id(1);
  const int z       = get_global_id(2);
  
  const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
  
  float sum = 0;
  
  const int4 origin = (int4){x,y,z,0};
  
  for(int lx=0; lx<planeDimX; lx++)
  {
    for(int ly=0; ly<planeDimY; ly++)
    {
      const int4 pos = origin + (int4){lx,ly,0,0};
     
      float value = read_imagef(image, sampler, pos).x;

      sum = sum + value;
    }
  }
  const int index = z;
  
  arrayZ[index] = sum;
}

