#!/bin/bash

# Flavor Build Script for Todo Flutter App
# Usage: ./scripts/build_flavor.sh [mock|development|production] [android|ios] [debug|release]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
FLAVOR=${1:-mock}
PLATFORM=${2:-android}
BUILD_TYPE=${3:-debug}

# Validate inputs
if [[ ! "$FLAVOR" =~ ^(mock|development|production)$ ]]; then
    echo -e "${RED}Error: Invalid flavor. Use: mock, development, or production${NC}"
    echo "Usage: $0 [mock|development|production] [android|ios] [debug|release]"
    exit 1
fi

if [[ ! "$PLATFORM" =~ ^(android|ios)$ ]]; then
    echo -e "${RED}Error: Invalid platform. Use: android or ios${NC}"
    echo "Usage: $0 [mock|development|production] [android|ios] [debug|release]"
    exit 1
fi

if [[ ! "$BUILD_TYPE" =~ ^(debug|release)$ ]]; then
    echo -e "${RED}Error: Invalid build type. Use: debug or release${NC}"
    echo "Usage: $0 [mock|development|production] [android|ios] [debug|release]"
    exit 1
fi

# Flavor configuration
case $FLAVOR in
    "mock")
        FLAVOR_NAME="Mock"
        FLAVOR_COLOR=$YELLOW
        ;;
    "development")
        FLAVOR_NAME="Development"
        FLAVOR_COLOR=$BLUE
        ;;
    "production")
        FLAVOR_NAME="Production"
        FLAVOR_COLOR=$GREEN
        ;;
esac

echo -e "${FLAVOR_COLOR}🏗️  Building Todo App for $FLAVOR_NAME ($PLATFORM - $BUILD_TYPE)${NC}"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Error: Flutter is not installed or not in PATH${NC}"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}Error: pubspec.yaml not found. Please run this script from the project root.${NC}"
    exit 1
fi

# Clean previous builds
echo -e "${BLUE}🧹 Cleaning previous builds...${NC}"
flutter clean

# Get dependencies
echo -e "${BLUE}📦 Getting dependencies...${NC}"
flutter pub get

# Build command
if [ "$PLATFORM" = "android" ]; then
    if [ "$BUILD_TYPE" = "debug" ]; then
        CMD="flutter build apk --debug --dart-define=FLAVOR=$FLAVOR"
        OUTPUT_DIR="build/app/outputs/flutter-apk"
        OUTPUT_FILE="app-debug.apk"
    else
        CMD="flutter build apk --release --dart-define=FLAVOR=$FLAVOR"
        OUTPUT_DIR="build/app/outputs/flutter-apk"
        OUTPUT_FILE="app-release.apk"
    fi
else
    if [ "$BUILD_TYPE" = "debug" ]; then
        CMD="flutter build ios --debug --dart-define=FLAVOR=$FLAVOR"
        OUTPUT_DIR="build/ios/iphoneos"
        OUTPUT_FILE="Runner.app"
    else
        CMD="flutter build ios --release --dart-define=FLAVOR=$FLAVOR"
        OUTPUT_DIR="build/ios/iphoneos"
        OUTPUT_FILE="Runner.app"
    fi
fi

echo -e "${BLUE}🔧 Building command:${NC}"
echo "$CMD"
echo ""

# Build the app
echo -e "${GREEN}▶️  Building app...${NC}"
eval $CMD

# Check if build was successful
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Build completed successfully!${NC}"
    
    if [ "$PLATFORM" = "android" ]; then
        if [ -f "$OUTPUT_DIR/$OUTPUT_FILE" ]; then
            echo -e "${GREEN}📱 APK location: $OUTPUT_DIR/$OUTPUT_FILE${NC}"
            echo -e "${BLUE}📏 APK size: $(du -h "$OUTPUT_DIR/$OUTPUT_FILE" | cut -f1)${NC}"
        fi
    else
        if [ -d "$OUTPUT_DIR/$OUTPUT_FILE" ]; then
            echo -e "${GREEN}📱 iOS app location: $OUTPUT_DIR/$OUTPUT_FILE${NC}"
            echo -e "${BLUE}📏 App size: $(du -sh "$OUTPUT_DIR/$OUTPUT_FILE" | cut -f1)${NC}"
        fi
    fi
    
    echo ""
    echo -e "${BLUE}🎯 Build Summary:${NC}"
    echo "  • Flavor: $FLAVOR_NAME"
    echo "  • Platform: $PLATFORM"
    echo "  • Build Type: $BUILD_TYPE"
    echo "  • Output: $OUTPUT_DIR/$OUTPUT_FILE"
    
else
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
fi 