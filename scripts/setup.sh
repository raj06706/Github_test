#!/bin/bash

# GitHub-Jira Integration Setup Script
# This script helps set up the integration locally

echo "🚀 GitHub-Jira Integration Setup"
echo "=================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 14 or higher."
    exit 1
fi

echo "✓ Node.js $(node --version) detected"
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✓ .env file created"
    echo "⚠️  Please update .env with your Jira credentials"
else
    echo "✓ .env file already exists"
fi

echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✓ Dependencies installed"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo ""

# Run tests
echo "🧪 Running tests..."
npm test

if [ $? -eq 0 ]; then
    echo "✓ All tests passed"
else
    echo "⚠️  Some tests failed. Please check the output above."
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Update .env with your Jira credentials"
echo "2. Create custom fields in Jira"
echo "3. Update config/jira-config.json with custom field IDs"
echo "4. Add GitHub Secrets to your repository"
echo ""
echo "For detailed instructions, see docs/JIRA_INTEGRATION_SETUP.md"
