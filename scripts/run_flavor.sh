#!/bin/bash

# Flavor Runner Script for Todo Flutter App
# Usage: ./scripts/run_flavor.sh [mock|development|production] [device_id]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
FLAVOR=${1:-mock}
DEVICE_ID=${2:-""}

# Validate flavor
if [[ ! "$FLAVOR" =~ ^(mock|development|production)$ ]]; then
    echo -e "${RED}Error: Invalid flavor. Use: mock, development, or production${NC}"
    echo "Usage: $0 [mock|development|production] [device_id]"
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

echo -e "${FLAVOR_COLOR}🚀 Running Todo App in $FLAVOR_NAME mode${NC}"
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

# Get available devices
echo -e "${BLUE}📱 Available devices:${NC}"
flutter devices

echo ""

# Build command
CMD="flutter run --dart-define=FLAVOR=$FLAVOR"

# Add device if specified
if [ ! -z "$DEVICE_ID" ]; then
    CMD="$CMD -d $DEVICE_ID"
fi

echo -e "${BLUE}🔧 Running command:${NC}"
echo "$CMD"
echo ""

# Run the app
echo -e "${GREEN}▶️  Starting app...${NC}"
eval $CMD 