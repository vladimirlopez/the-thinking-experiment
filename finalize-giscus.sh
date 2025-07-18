#!/bin/bash

echo "🔧 Finalizing Giscus Setup"
echo "=========================="
echo ""

# Check if we're in the right directory
if [ ! -f "_quarto.yml" ]; then
    echo "❌ Error: Not in the blog directory. Please run this from the blog root."
    exit 1
fi

# Check if comments.html has been updated
if grep -q "REPLACE_WITH_YOUR_REPO_ID" _includes/comments.html; then
    echo "⚠️  Warning: comments.html still contains placeholder values."
    echo "   Please update _includes/comments.html with your actual Giscus config first."
    echo ""
    echo "📋 Your current config:"
    cat _includes/comments.html
    echo ""
    exit 1
fi

# Check if _quarto.yml already has comments enabled
if grep -q "include-after-body.*comments.html" _quarto.yml; then
    echo "✅ Comments already enabled in _quarto.yml"
else
    echo "📝 Adding comments to _quarto.yml..."
    
    # Create backup
    cp _quarto.yml _quarto.yml.backup
    
    # Add include-after-body line
    sed -i.bak '/include-in-header:/a\
    include-after-body: _includes/comments.html' _quarto.yml
    
    # Clean up backup file on macOS
    rm -f _quarto.yml.bak
    
    echo "✅ Added comments integration to _quarto.yml"
fi

echo ""
echo "🏗️  Rebuilding site..."
quarto render

echo ""
echo "🎉 Giscus setup complete!"
echo ""
echo "🔍 To test:"
echo "   1. Run: quarto preview"
echo "   2. Navigate to a blog post"
echo "   3. Scroll to bottom to see comments section"
echo ""
echo "📝 Note: Comments will only work on the deployed site, not localhost"
