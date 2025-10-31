# Makefile for DNPay Flutter Project

.PHONY: help install generate-assets clean build run test

# Default target
help:
	@echo "Available commands:"
	@echo "  make install           - Install dependencies"
	@echo "  make generate-assets   - Generate assets (images, fonts, etc.)"
	@echo "  make clean             - Clean build files"
	@echo "  make build             - Build the project"
	@echo "  make run               - Run the project"
	@echo "  make test              - Run tests"
	@echo "  make build-runner      - Run build_runner"

# Install dependencies
install:
	@echo "Installing Flutter dependencies..."
	flutter pub get

# Generate assets using flutter_gen
generate-assets:
	@echo "Generating assets..."
	@echo "Assets are manually maintained in lib/generated/assets.gen.dart"
	@echo "To add new assets, update the file manually or use the script:"
	@echo "scripts/generate_assets.bat (Windows) or scripts/generate_assets.sh (Linux/Mac)"

# Alternative command for build_runner
build-runner:
	@echo "Running build_runner..."
	flutter packages pub run build_runner build --delete-conflicting-outputs

# Clean build files
clean:
	@echo "Cleaning build files..."
	flutter clean
	flutter pub get

# Build the project
build:
	@echo "Building project..."
	flutter build apk

# Build for release
build-release:
	@echo "Building release APK..."
	flutter build apk --release

# Run the project
run:
	@echo "Running project..."
	flutter run

# Run tests
test:
	@echo "Running tests..."
	flutter test

# Watch for changes and rebuild
watch:
	@echo "Watching for changes..."
	flutter packages pub run build_runner watch

# Format code
format:
	@echo "Formatting code..."
	dart format .

# Analyze code
analyze:
	@echo "Analyzing code..."
	dart analyze

# Get packages and generate assets
setup: install generate-assets
	@echo "Setup complete!"
