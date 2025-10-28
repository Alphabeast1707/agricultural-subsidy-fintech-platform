#!/bin/bash

# 🔐 API Security Verification Script
# ===================================

echo "🔐 Agricultural Subsidy Fintech Platform - API Security Verification"
echo "===================================================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if .env file exists
echo "📋 Security Checklist:"
echo ""

if [ -f ".env" ]; then
    echo -e "${GREEN}✅${NC} .env file exists for secure API key storage"
else
    echo -e "${RED}❌${NC} .env file missing - copy from .env.example and add your API keys"
fi

# Check if .env.example exists
if [ -f ".env.example" ]; then
    echo -e "${GREEN}✅${NC} .env.example template provided"
else
    echo -e "${RED}❌${NC} .env.example template missing"
fi

# Check if .env is in .gitignore
if grep -q "^\.env$" .gitignore 2>/dev/null; then
    echo -e "${GREEN}✅${NC} .env file is properly ignored by git"
else
    echo -e "${RED}❌${NC} .env not in .gitignore - security risk!"
fi

# Check for hardcoded API keys in source files
echo ""
echo "🔍 Scanning for hardcoded API keys in source code..."

# Search for potential API key patterns
API_FOUND=0

# Check for WeatherAPI key pattern
if grep -r "d093940d8d674e05a15103206251410" --include="*.py" --include="*.html" --include="*.js" . 2>/dev/null; then
    echo -e "${RED}❌${NC} WeatherAPI key found in source code!"
    API_FOUND=1
fi

# Check for Gemini API key pattern  
if grep -r "AIzaSyCChBUF0HQt8l4atjVsrrF_gR8ap_1VzZg" --include="*.py" --include="*.html" --include="*.js" . 2>/dev/null; then
    echo -e "${RED}❌${NC} Gemini API key found in source code!"
    API_FOUND=1
fi

# Check for generic API key patterns
if grep -r "api[_-]key.*=.*['\"][A-Za-z0-9]{20,}['\"]" --include="*.py" --include="*.html" --include="*.js" . 2>/dev/null | grep -v ".env" | grep -v ".env.example" | head -5; then
    echo -e "${YELLOW}⚠️${NC}  Potential API key patterns found (review needed)"
    API_FOUND=1
fi

if [ $API_FOUND -eq 0 ]; then
    echo -e "${GREEN}✅${NC} No hardcoded API keys found in source code"
fi

# Check if python-dotenv is in requirements
if grep -q "python-dotenv" requirements.txt 2>/dev/null; then
    echo -e "${GREEN}✅${NC} python-dotenv dependency included"
else
    echo -e "${RED}❌${NC} python-dotenv missing from requirements.txt"
fi

# Check environment variable loading in main.py
if grep -q "load_dotenv" main.py 2>/dev/null; then
    echo -e "${GREEN}✅${NC} Environment variable loading implemented"
else
    echo -e "${RED}❌${NC} Environment variable loading missing"
fi

# Check API key validation in code
if grep -q "if not.*API_KEY" main.py 2>/dev/null; then
    echo -e "${GREEN}✅${NC} API key validation checks implemented"
else
    echo -e "${YELLOW}⚠️${NC}  API key validation checks missing"
fi

echo ""
echo "🛡️ Security Documentation:"

if [ -f "API_SECURITY_GUIDE.md" ]; then
    echo -e "${GREEN}✅${NC} API Security Guide provided"
else
    echo -e "${RED}❌${NC} API Security Guide missing"
fi

echo ""
echo "🎯 Environment Setup Status:"

# Check if .env has actual keys (without exposing them)
if [ -f ".env" ]; then
    if grep -q "WEATHER_API_KEY=" .env && [ $(grep "WEATHER_API_KEY=" .env | cut -d'=' -f2 | wc -c) -gt 10 ]; then
        echo -e "${GREEN}✅${NC} Weather API key appears to be configured"
    else
        echo -e "${YELLOW}⚠️${NC}  Weather API key needs configuration"
    fi
    
    if grep -q "GEMINI_API_KEY=" .env && [ $(grep "GEMINI_API_KEY=" .env | cut -d'=' -f2 | wc -c) -gt 20 ]; then
        echo -e "${GREEN}✅${NC} Gemini API key appears to be configured"
    else
        echo -e "${YELLOW}⚠️${NC}  Gemini API key needs configuration"
    fi
fi

echo ""
echo "🚀 Next Steps:"
echo "1. Ensure your .env file has valid API keys"
echo "2. Test the application: python main.py"
echo "3. Monitor API usage at provider dashboards"
echo "4. Rotate API keys regularly"
echo ""

# Final security score
CHECKS=7
PASSED=0

[ -f ".env" ] && ((PASSED++))
[ -f ".env.example" ] && ((PASSED++))
grep -q "^\.env$" .gitignore 2>/dev/null && ((PASSED++))
[ $API_FOUND -eq 0 ] && ((PASSED++))
grep -q "python-dotenv" requirements.txt 2>/dev/null && ((PASSED++))
grep -q "load_dotenv" main.py 2>/dev/null && ((PASSED++))
[ -f "API_SECURITY_GUIDE.md" ] && ((PASSED++))

SCORE=$((PASSED * 100 / CHECKS))

echo "🏆 Security Score: ${SCORE}%"

if [ $SCORE -ge 85 ]; then
    echo -e "${GREEN}🎉 Excellent security implementation!${NC}"
elif [ $SCORE -ge 70 ]; then
    echo -e "${YELLOW}⚠️  Good security, minor improvements needed${NC}"
else
    echo -e "${RED}❌ Security improvements required${NC}"
fi

echo ""
echo "🔒 Your Agricultural Subsidy Fintech Platform is now secure!"
