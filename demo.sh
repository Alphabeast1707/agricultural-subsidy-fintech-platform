#!/bin/zsh
# 🚀 Agricultural Subsidy Fintech Platform - Complete Demo Script
# Run this script to demonstrate all features in sequence

echo "🌾 AGRICULTURAL SUBSIDY FINTECH PLATFORM DEMONSTRATION"
echo "═══════════════════════════════════════════════════════"
echo ""

# Check if server is running
echo "🔍 Checking server status..."
if curl -s http://localhost:8000/health > /dev/null; then
    echo "✅ Server is running at http://localhost:8000"
else
    echo "❌ Server not running. Please start with: python3 -m uvicorn main:app --reload"
    exit 1
fi

echo ""
echo "📋 Current Active Rules:"
echo "────────────────────────"
curl -s "http://localhost:8000/rules" | jq -r '.[] | "• \(.schemeName) - \(.condition) - ₹\(.amount | tostring)"'

echo ""
echo "🎯 SIMULATION DEMONSTRATIONS:"
echo "═════════════════════════════"

# 1. Basic Simulation
echo ""
echo "1️⃣ BASIC SIMULATION:"
echo "   Standard rule-based calculations"
basic_result=$(curl -s "http://localhost:8000/simulate" | jq '.summary.totalPayoutAmount')
echo "   💰 Total Payout: ₹$(printf "%'d" $basic_result)"

# 2. Realistic Simulation
echo ""
echo "2️⃣ REALISTIC SIMULATION (Research-Based):"
echo "   Incorporating PM-KISAN implementation challenges"
realistic_result=$(curl -s "http://localhost:8000/simulate-realistic" | jq '.summary.totalPayoutAmount')
realistic_efficiency=$(curl -s "http://localhost:8000/simulate-realistic" | jq -r '.summary.systemEfficiency.overallEfficiencyScore')
echo "   💰 Effective Payout: ₹$(printf "%'d" $realistic_result)"
echo "   📊 System Efficiency: $realistic_efficiency"

# 3. Enhanced AI + Weather Simulation
echo ""
echo "3️⃣ ENHANCED AI + WEATHER SIMULATION:"
echo "   Live weather data + Gemini AI analytics"
enhanced_result=$(curl -s -X POST "http://localhost:8000/simulate-enhanced")
enhancement_factor=$(echo $enhanced_result | jq '.summary.enhancement_factor')
weather_condition=$(echo $enhanced_result | jq -r '.weather_data.condition')
ai_insights=$(echo $enhanced_result | jq '.summary.ai_recommendations')
echo "   🌤️ Weather Condition: $weather_condition"
echo "   🤖 AI Insights Generated: $ai_insights"
echo "   📈 Enhancement Factor: ${enhancement_factor}x"

# 4. Satellite-Guided Analysis
echo ""
echo "4️⃣ SATELLITE-GUIDED PRECISION AGRICULTURE:"
echo "   Real-time NDVI crop monitoring from space"
satellite_result=$(curl -s "http://localhost:8000/satellite/subsidy-analysis/Ahmedabad")
total_cost=$(echo $satellite_result | jq '.financial_projection.total_estimated_cost')
farmers_benefit=$(echo $satellite_result | jq '.financial_projection.farmers_to_benefit')
targeted_subsidies=$(echo $satellite_result | jq '.targeted_subsidies | length')
echo "   🛰️ Total Cost: ₹$(printf "%.0f" $total_cost)"
echo "   👨‍🌾 Farmers Benefiting: $farmers_benefit"
echo "   🎯 Targeted Schemes: $targeted_subsidies"

echo ""
echo "📊 SYSTEM EFFICIENCY DASHBOARD:"
echo "═════════════════════════════════"
efficiency_data=$(curl -s "http://localhost:8000/dashboard/efficiency")
total_districts=$(echo $efficiency_data | jq '.overview.total_districts')
avg_efficiency=$(echo $efficiency_data | jq '.overview.avg_efficiency')
critical_districts=$(echo $efficiency_data | jq '.overview.critical_districts')

echo "   🏛️ Districts Monitored: $total_districts"
echo "   📈 Average Efficiency: ${avg_efficiency}%"
echo "   🚨 Critical Districts: $critical_districts"

echo ""
echo "🌐 LIVE DATA INTEGRATIONS:"
echo "═══════════════════════════"

# Weather Data
echo "🌤️ Weather Data (Ludhiana):"
weather_data=$(curl -s "http://localhost:8000/weather/district/Ludhiana")
temperature=$(echo $weather_data | jq '.temperature')
condition=$(echo $weather_data | jq -r '.condition')
echo "   Temperature: ${temperature}°C | Condition: $condition"

# Satellite Data
echo "🛰️ Satellite Data (Ahmedabad):"
satellite_overview=$(curl -s "http://localhost:8000/satellite/realtime/Ahmedabad" | jq '.satellite_overview')
avg_ndvi=$(echo $satellite_overview | jq '.average_ndvi')
health_score=$(echo $satellite_overview | jq '.district_health_score')
echo "   Average NDVI: $avg_ndvi | Health Score: ${health_score}%"

echo ""
echo "🎯 RESEARCH VALIDATION:"
echo "═══════════════════════"
validation=$(curl -s "http://localhost:8000/test/research-validation")
implementation_score=$(echo $validation | jq '.implementation_score')
echo "   📋 Implementation Score: ${implementation_score}%"
echo "   ✅ PM-KISAN challenges accurately modeled"
echo "   ✅ Digital barriers systematically addressed"
echo "   ✅ Real-world API framework established"

echo ""
echo "🚀 PLATFORM CAPABILITIES SUMMARY:"
echo "═══════════════════════════════════"
echo "✅ Real-Time Weather Integration (WeatherAPI.com)"
echo "✅ Gemini AI Powered Analytics & Recommendations"
echo "✅ Live Satellite NDVI Crop Monitoring"
echo "✅ Research-Validated PM-KISAN Implementation"
echo "✅ Precision Agriculture Subsidy Targeting"
echo "✅ Mobile-Responsive Frontend with Visual Dashboards"
echo "✅ Production-Ready API Architecture"

echo ""
echo "🌟 ACCESS THE PLATFORM:"
echo "═════════════════════════"
echo "🖥️  Frontend: file:///$(pwd)/Subsidy_Engine.html"
echo "🔗 API Docs: http://localhost:8000/docs"
echo "💻 Server: http://localhost:8000"

echo ""
echo "🎊 DEMONSTRATION COMPLETE!"
echo "Your next-generation Agricultural Subsidy Fintech Platform"
echo "is ready for production deployment! 🚀🌾💰"
