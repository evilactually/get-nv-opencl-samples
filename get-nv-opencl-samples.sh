############################### Nvidia OpenCL Samples Installer ############################
##                                                                                        ## 
## Description:                                                                           ##
##  Download OpenCL samples from Nvidia, add missing files, simplify and fix Makefiles.   ##
##                                                                                        ##
## Usage:                                                                                 ##
## ./get-nv-samples.sh  [DESTINATION]   -   installs to ./opencl-samples by default       ##
##                                                                                        ##
## Compiling:                                                                             ##
## cd ./opencl-samples                                                                    ##
## make                                                                                   ##
##                                                                                        ##
############################################################################################

# Turn non-matched glob patterns into null strings
shopt -s nullglob

URLS='http://developer.download.nvidia.com/compute/cuda/1.1-Beta/Projects/deviceQuery.tar.gz 
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

# This is a common template used to generate Makefiles for each sample. 
PROJECT_MAKEFILE='
dbg ?= 1

EXECUTABLE	     := ###NAME###

# C/C++ source files (compiled with gcc / c++)
CCFILES          = $(wildcard ../common/*.cpp)
###EXTRACCFILES###
###EXTRACFILES###

# Includes
INCLUDES  = -I../common
###EXTRAINCLUDES###

# Libraries
LIB = -lOpenCL
###EXTRALIBS###

# Compilers
CXX        := g++
CC         := gcc
LINK       := g++ -fPIC

# Common flags
COMMONFLAGS += $(INCLUDES) -DUNIX

# Compiler-specific flags
CXXFLAGS  := $(CXXWARN_FLAGS) $(CXX_ARCH_FLAGS)
CFLAGS    := $(CWARN_FLAGS) $(CXX_ARCH_FLAGS)
LINK      += $(CXX_ARCH_FLAGS)

# Warning flags
CXXWARN_FLAGS := \
	-W -Wall \
	-Wimplicit \
	-Wswitch \
	-Wformat \
	-Wchar-subscripts \
	-Wparentheses \
	-Wmultichar \
	-Wtrigraphs \
	-Wpointer-arith \
	-Wcast-align \
	-Wreturn-type \
	-Wno-unused-function \
	$(SPACE)

CWARN_FLAGS := $(CXXWARN_FLAGS) \
	-Wstrict-prototypes \
	-Wmissing-prototypes \
	-Wmissing-declarations \
	-Wnested-externs \
	-Wmain \

# Debug/release configuration
ifeq ($(dbg),1)
	COMMONFLAGS += -g
	BINSUBDIR   := debug
else 
	COMMONFLAGS += -O3 
	BINSUBDIR   := release
	CXXFLAGS    += -fno-strict-aliasing
	CFLAGS      += -fno-strict-aliasing
endif

# check if verbose 
ifeq ($(verbose), 1)
	VERBOSE :=
else
	VERBOSE := @
endif

# Add common flags
CXXFLAGS  += $(COMMONFLAGS)
CFLAGS    += $(COMMONFLAGS)

################################################################################
# Set up object files
################################################################################

ROOTOBJ = obj
OBJDIR := $(ROOTOBJ)/$(BINSUBDIR)
OBJS +=  $(patsubst %.cpp,$(OBJDIR)/%.cpp.o,$(notdir $(CCFILES)))
OBJS +=  $(patsubst %.c,$(OBJDIR)/%.c.o,$(notdir $(CFILES)))

################################################################################
# Target
################################################################################

ROOTBINDIR := bin
TARGETDIR := $(ROOTBINDIR)/$(BINSUBDIR)
TARGET    := $(TARGETDIR)/$(EXECUTABLE)
LINKLINE  = $(LINK) -o $(TARGET) $(OBJS) $(LIB)

################################################################################
# Rules
################################################################################

$(OBJDIR)/%.c.o : %.c $(C_DEPS)
	$(VERBOSE)$(CC) $(CFLAGS) -o $@ -c $<

$(OBJDIR)/%.cpp.o : ../common/%.cpp $(C_DEPS)
	$(VERBOSE)$(CXX) $(CXXFLAGS) -o $@ -c $<

$(OBJDIR)/%.cpp.o : %.cpp $(C_DEPS)
	$(VERBOSE)$(CXX) $(CXXFLAGS) -o $@ -c $<

$(TARGET): makedirectories $(OBJS) Makefile
	$(VERBOSE)$(LINKLINE)

makedirectories:
	$(VERBOSE)mkdir -p $(OBJDIR)
	$(VERBOSE)mkdir -p $(TARGETDIR)

tidy :
	$(VERBOSE)find . | egrep "#" | xargs rm -f
	$(VERBOSE)find . | egrep "\~" | xargs rm -f

clean : tidy
	$(VERBOSE)rm -rf $(ROOTOBJ)/*
	$(VERBOSE)rm -rf $(ROOTBINDIR)/*
'

MAIN_MAKEFILE='
PROJECTS := $(shell find ./ -mindepth 2 -name Makefile)

%.ph_build : 
	+@$(MAKE) -C $(dir $*) $(MAKECMDGOALS)

%.ph_clean : 
	+@$(MAKE) -C $(dir $*) clean $(USE_DEVICE)

all:  $(addsuffix .ph_build,$(PROJECTS))
	@echo "Finished building all"

tidy:
	@find * | egrep "#" | xargs rm -f
	@find * | egrep "\~" | xargs rm -f

clean: tidy $(addsuffix .ph_clean,$(PROJECTS))
	+@$(MAKE) -C common clean'

SCRIPTNAME=$(basename $0)

DESTDIR=$1                            # Install to location specified by first argument
: ${DESTDIR:=$(pwd)/opencl-samples}   # or to ./opencl-samples if no argument supplied

prepare() {
	mkdir -p $DESTDIR &> /dev/null

	if [[ ! -d $DESTDIR ]]; then 
	echo "Couldn't create destination directory!" >&2
		exit 1
	fi
	echo "Installing into: $DESTDIR"
}

# Get a tmp directory for sources
SRCDIR=$(mktemp -d)
echo "Temporary directory is: $SRCDIR"

cleanup() {
  rm -r $SRCDIR &> /dev/null
  exit
}

# Setup clean-up trap for tmp directory
trap "cleanup" SIGTERM SIGINT

fetch() {
	echo "Fetching archives into $SRCDIR"
	pushd $SRCDIR
	for t in $URLS; do
		wget $t
		tar -xf "$SRCDIR/`basename $t`"
	done

	popd
}

# Convert line endings from windows to unix style
fix_line_endings() {
	echo "Fixing line endings in $1"
	pushd "$1"; # (descend into sample directory, xargs doesn't like spaces in paths)
	find ./ -type f -name '*.h' -o -name '*.cpp' -o -name 'Makefile' -o -name '*.txt' -o -name '*.cl' | xargs dos2unix
	popd
}

get_makefile_var() {
	cat $2 | sed ':a;N;$!ba;s/[\]\n[\t\ ]*/ /g' | \
    sed -n 's/^[\ \t]*'"$1"'[\ \t]*:=[\ \t]*\(.*\)$/\1/p'
}

template_set_name() {
	sed "s/###NAME###/$1/"
}

template_add_lib() {
	LIBS="$@"
	sed "s/###EXTRALIBS###/LIB += $LIBS\n&/"
}

template_add_cfiles() {
	CFILES=$@
	sed "s^###EXTRACFILES###^CFILES += $CFILES\n&^"
}

template_add_ccfiles() {
	CCFILES=$@
	sed "s^###EXTRACFILES###^CCFILES += $CCFILES\n&^"
}

# Strips remaining markers
template_finilize() {
	sed '/###INFO###/,/###ENDINFO###/d' | \
	sed -n '/###EXTRACCFILES###/!p'     | \
	sed -n '/###EXTRACFILES###/!p'      | \
	sed -n '/###EXTRAINCLUDES###/!p'    | \
	sed -n '/###EXTRALIBS###/!p'        | \
	sed -n '/###NAME###/!p'       
}

template_add_include() {
	INCLUDES="$@"
	sed "s@###EXTRAINCLUDES###@INCLUDES += $INCLUDES\n&@"
}

install() {
	echo "Constructing ${DESTDIR}/common"
	mkdir -p "$DESTDIR"/common
	cp "$SRCDIR/NVIDIA GPU Computing SDK/OpenCL/common/src/oclUtils.cpp" "$DESTDIR"/common
	cp "$SRCDIR/NVIDIA GPU Computing SDK/OpenCL/common/inc/oclUtils.h" "$DESTDIR"/common
	cp "$SRCDIR/NVIDIA GPU Computing SDK/shared/inc/"*.h "$DESTDIR"/common
	cp "$SRCDIR/NVIDIA GPU Computing SDK/shared/src/"*.cpp "$DESTDIR"/common
	cp "$SRCDIR/NVIDIA_CUDA_SDK/common/inc/exception.h" "$DESTDIR"/common     # Missing file. Found in CUDA SDK from some reason.

	fix_line_endings "$DESTDIR/common"

	# Iterate over every sample directory
	for d in "$SRCDIR/NVIDIA GPU Computing SDK/OpenCL/src/"*; do  
	    SAMPLEDIR="$DESTDIR"/$(basename "$d")

	    echo "Constructing $SAMPLEDIR"

	    # Copy to build direcotory
	    cp -r "$d" "$DESTDIR"

	    # Flatten src if exist
	    if [ -d "$SAMPLEDIR"/src ]; then
	      mv "$SAMPLEDIR"/src/* "$SAMPLEDIR"
	      rm -r "$SAMPLEDIR"/src/
	    fi

	    # Flatten src if exist
	    if [ -d "$SAMPLEDIR"/inc ]; then
	      mv "$SAMPLEDIR"/inc/* "$SAMPLEDIR"
	      rm -r "$SAMPLEDIR"/inc/
	    fi

	    # Convert locally included headers from angle brackets to quotes
	    for header_path in "$SAMPLEDIR"/*.h "$DESTDIR"/common/*.h; do
	      header_name=$(basename "$header_path")
	      sed 's/#include\([\ \t]\)*<.*'$header_name'>/#include\1"'$header_name'"/' -i "$SAMPLEDIR"/*.cpp "$SAMPLEDIR"/*.h
	      #sed 's/#include\([\ \t]\)*<\(.*\)>/#include\1/<\2>/' -i *.cpp *.h 
	    done

	    fix_line_endings "$SAMPLEDIR"

	    # Extract flags in old Makefile
	    USEGLLIB=$(get_makefile_var USEGLLIB "$SAMPLEDIR"/Makefile)
	    USEGLUT=$(get_makefile_var USEGLUT "$SAMPLEDIR"/Makefile)
	    EXECUTABLE=$(get_makefile_var EXECUTABLE "$SAMPLEDIR"/Makefile)
	    CCFILES=$(get_makefile_var CCFILES "$SAMPLEDIR"/Makefile)
	    CFILES=$(get_makefile_var CFILES "$SAMPLEDIR"/Makefile)
	    
	    # Don't need old Makefile
	    rm $SAMPLEDIR/Makefile

	    # Default flag values
	    USEGLLIB=${USEGLLIB:-0}
	    USEGLUT=${USEGLUT:-0}

	    # Conditional pipes to process Makefile template
	    echo "$PROJECT_MAKEFILE" | \
	    ( template_set_name $EXECUTABLE ) | \
	    ( [ "$USEGLLIB" -eq 1 ] && template_add_lib -lGL -lGLU -lX11 -lXmu -lGLEW || cat) | \
	    ( [ "$USEGLUT"  -eq 1 ] && template_add_lib -lglut || cat ) | \
	    ( [ "$EXECUTABLE"  == "oclMultiThreads" ] && template_add_lib -lpthread || cat ) | \
	    ( [ -n "$CCFILES" ] && template_add_ccfiles $CCFILES || cat ) | \
	    ( [ -n "$CFILES" ]  && template_add_cfiles  $CFILES  || cat ) | \
	    ( [ -n "$INCLUDE" ] && template_add_include $INCLUDE || cat ) | \
	    ( template_finilize ) \
	    > $SAMPLEDIR/Makefile

	    echo "$MAIN_MAKEFILE" > "$DESTDIR"/Makefile

	done
}

# Prepare destination directory
prepare

# Download sources into a temporary directory
fetch

# Apply patches and copy to destination directory
install

# Remove temporary files
cleanup