#!/bin/bash

echo "🚀 Giscus Setup Helper Script"
echo "================================"
echo ""

# Get repository info
REPO_OWNER="vladimirlopez"
REPO_NAME="the-thinking-experiment"
REPO_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"

echo "📋 Repository: ${REPO_URL}"
echo ""

echo "⚠️  MANUAL STEPS REQUIRED (will open in browser):"
echo ""

echo "1️⃣  Enable GitHub Discussions:"
echo "   🔗 ${REPO_URL}/settings"
echo "   ➡️  Scroll to 'Features' section"
echo "   ➡️  Check the 'Discussions' checkbox"
echo ""

echo "2️⃣  Install Giscus GitHub App:"
echo "   🔗 https://github.com/apps/giscus"
echo "   ➡️  Click 'Install'"
echo "   ➡️  Select '${REPO_OWNER}/${REPO_NAME}' repository"
echo ""

echo "3️⃣  Configure Giscus:"
echo "   🔗 https://giscus.app/"
echo "   ➡️  Enter repository: ${REPO_OWNER}/${REPO_NAME}"
echo "   ➡️  Choose 'General' category"
echo "   ➡️  Select 'dark' theme"
echo "   ➡️  Copy the generated config"
echo ""

echo "🤖 AUTOMATED STEPS:"
echo ""

# Check if we're in the right directory
if [ ! -f "_quarto.yml" ]; then
    echo "❌ Error: Not in the blog directory. Please run this from the blog root."
    exit 1
fi

# Check if comments.html exists
if [ ! -f "_includes/comments.html" ]; then
    echo "❌ Comments file not found. Creating basic structure..."
    mkdir -p _includes
    cat > _includes/comments.html << 'EOF'
<div id="comments">
  <script src="https://giscus.app/client.js"
        data-repo="vladimirlopez/the-thinking-experiment"
        data-repo-id="REPLACE_WITH_YOUR_REPO_ID"
        data-category="General"
        data-category-id="REPLACE_WITH_YOUR_CATEGORY_ID"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="dark"
        data-lang="en"
        crossorigin="anonymous"
        async>
  </script>
</div>
EOF
    echo "✅ Created _includes/comments.html template"
fi

# Function to open URLs (cross-platform)
open_url() {
    if command -v open > /dev/null; then
        open "$1"  # macOS
    elif command -v xdg-open > /dev/null; then
        xdg-open "$1"  # Linux
    elif command -v start > /dev/null; then
        start "$1"  # Windows
    else
        echo "   🔗 Please open manually: $1"
    fi
}

echo ""
read -p "🚀 Ready to open the required pages? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📖 Opening GitHub repository settings..."
    open_url "${REPO_URL}/settings"
    sleep 2
    
    echo "🔧 Opening Giscus app installation..."
    open_url "https://github.com/apps/giscus"
    sleep 2
    
    echo "⚙️  Opening Giscus configuration..."
    open_url "https://giscus.app/"
    
    echo ""
    echo "✅ All pages opened! Follow the manual steps above."
    echo ""
    echo "📝 AFTER completing the manual steps:"
    echo "   1. Copy the generated script from giscus.app"
    echo "   2. Update _includes/comments.html with the new config"
    echo "   3. Run: ./finalize-giscus.sh"
fi

echo ""
echo "🔧 Need help? Check the manual setup guide in the README"
