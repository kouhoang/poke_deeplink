#!/bin/bash

# 🚀 Quick Deploy Script for Vercel

echo "🎯 Pokemon App - Vercel Deploy Helper"
echo "======================================"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "📦 Initializing Git repository..."
    git init
    echo "✅ Git initialized"
    echo ""
fi

# Check git status
echo "📊 Checking git status..."
git status --short
echo ""

# Prompt for commit
read -p "💬 Enter commit message (or press Enter for default): " commit_msg
if [ -z "$commit_msg" ]; then
    commit_msg="Update Pokemon app"
fi

echo ""
echo "📝 Committing changes..."
git add .
git commit -m "$commit_msg"
echo "✅ Changes committed"
echo ""

# Check if remote exists
if ! git remote | grep -q origin; then
    echo "⚠️  No remote repository found!"
    echo ""
    echo "Please follow these steps:"
    echo "1. Go to https://github.com/new"
    echo "2. Create a new repository"
    echo "3. Run: git remote add origin YOUR_REPO_URL"
    echo "4. Run: git push -u origin main"
    echo ""
    echo "Then go to https://vercel.com and import your GitHub repository"
    echo ""
    exit 0
fi

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push
echo "✅ Pushed to GitHub"
echo ""

echo "🎉 Done!"
echo ""
echo "Next steps:"
echo "1. Go to https://vercel.com"
echo "2. Import your repository"
echo "3. Vercel will auto-detect vercel.json and deploy"
echo ""
echo "Or install Vercel CLI and run: vercel --prod"
