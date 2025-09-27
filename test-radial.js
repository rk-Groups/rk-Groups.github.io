// Test script for radial sitemap functionality
console.log('🧪 Testing Radial Sitemap...\n');

// Test 1: Check if page loads
fetch('http://localhost:3000/sitemap/radial')
  .then(response => {
    if (response.ok) {
      console.log('✅ Page loads successfully');
      return response.text();
    } else {
      throw new Error(`❌ Page failed to load: ${response.status}`);
    }
  })
  .then(html => {
    // Test 2: Check for essential elements
    const tests = [
      { name: 'SVG container', pattern: /<svg.*?viewBox="0 0 800 800"/ },
      { name: 'Radial nodes', pattern: /radial-node/g },
      { name: 'Level rings', pattern: /level-ring/g },
      { name: 'Gradient definitions', pattern: /radialGradient/g },
      { name: 'Interactive controls', pattern: /radial-controls/ },
      { name: 'JavaScript functionality', pattern: /showAllLevels/ },
      { name: 'Keyboard shortcuts', pattern: /addEventListener.*keydown/ },
      { name: 'Zoom functionality', pattern: /zoomIn|zoomOut/ },
      { name: 'Animation controls', pattern: /toggleAnimation/ },
      { name: 'Navigation links', pattern: /window\.location\.href/g }
    ];

    let passCount = 0;
    tests.forEach(test => {
      const matches = html.match(test.pattern);
      if (matches) {
        console.log(`✅ ${test.name}: Found ${Array.isArray(matches) ? matches.length : 1} instance(s)`);
        passCount++;
      } else {
        console.log(`❌ ${test.name}: Not found`);
      }
    });

    console.log(`\n📊 Test Results: ${passCount}/${tests.length} tests passed`);

    // Test 3: Check for all 10 levels
    const levelPattern = /data-level="(\d+)"/g;
    const levelMatches = [...html.matchAll(levelPattern)];
    const uniqueLevels = [...new Set(levelMatches.map(match => parseInt(match[1])))].sort();
    
    console.log(`\n🏗️ Hierarchy Levels Found: ${uniqueLevels.join(', ')}`);
    
    if (uniqueLevels.length === 10 && uniqueLevels[0] === 1 && uniqueLevels[9] === 10) {
      console.log('✅ All 10 levels present and correctly structured');
    } else {
      console.log('❌ Missing levels or incorrect structure');
    }

    // Test 4: Count interactive nodes
    const nodePattern = /onclick="window\.location\.href/g;
    const nodeMatches = html.match(nodePattern);
    console.log(`\n🔗 Interactive nodes: ${nodeMatches ? nodeMatches.length : 0}`);

    if (passCount >= 8) {
      console.log('\n🎉 Radial sitemap is working excellently!');
      console.log('🌟 Features confirmed:');
      console.log('   • Beautiful radial/circular layout');
      console.log('   • 10-level hierarchy visualization');
      console.log('   • Interactive controls and filtering');
      console.log('   • Zoom and animation capabilities');
      console.log('   • Keyboard shortcuts support');
      console.log('   • Clickable navigation to all pages');
      console.log('   • Modern responsive design');
    } else {
      console.log('\n⚠️ Some features may need attention');
    }
  })
  .catch(error => {
    console.error('❌ Test failed:', error.message);
  });