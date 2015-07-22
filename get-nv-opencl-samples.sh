TARS='http://developer.download.nvidia.com/compute/cuda/1.1-Beta/Projects/deviceQuery.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclMultiThreads.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclInlinePTX.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclMarchingCubes.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclTridiagonal.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclDeviceQuery.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclBandwidthTest.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclVectorAdd.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclDotProduct.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclMatVecMul.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclCopyComputeOverlap.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclSimpleMultiGPU.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclSimpleGL.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclScan.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclReduction.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclTranspose.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclMatrixMul.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclFDTD3d.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclDCT8x8.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclDXTCompression.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclRadixSort.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclSortingNetworks.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclBlackScholes.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclHiddenMarkovModel.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclQuasirandomGenerator.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclMersenneTwister.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclHistogram.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclPostprocessGL.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclSimpleTexture3D.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclBoxFilter.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclSobelFilter.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclMedianFilter.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclConvolutionSeparable.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclRecursiveGaussian.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclVolumeRender.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclParticles.tar.gz 
 http://developer.download.nvidia.com/compute/DevZone/OpenCL/Projects/oclNbody.tar.gz'

TMPDIR=$(mktemp -d)
DESTDIR=$(pwd) # or first argument

echo $TMPDIR

pushd $TMPDIR

for t in $TARS; do
	wget -P $TMPDIR $t
	#cp /tmp/tmp.Wsx22dUc9I/*.tar.gz  $TMPDIR
	tar -xf "$TMPDIR/`basename $t`"
	#tar -xf
done


#rm -r $TMPDIR