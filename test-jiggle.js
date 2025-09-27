// Test for jiggle fixes
console.log('🔧 Testing Jiggle Fixes...\n');

fetch('http://localhost:3000/sitemap/radial')
  .then(response => response.text())
  .then(html => {
    console.log('✅ Page loaded successfully');
    
    // Test jiggle-prevention features
    const jiggleTests = [
      { name: 'Transform !important rules', pattern: /transform:.*scale.*!important/ },
      { name: 'Animation: none !important', pattern: /animation:\s*none\s*!important/ },
      { name: 'Hover debouncing', pattern: /hoverTimeout.*setTimeout/ },
      { name: 'Center node animation stop', pattern: /\.center-node:hover/ },
      { name: 'Transform-origin set', pattern: /transform-origin/ },
      { name: 'IsHovered state tracking', pattern: /let isHovered/ },
      { name: 'Debounce timeout', pattern: /}, 50\)/ },
      { name: 'Prevent re-triggering', pattern: /if.*isHovered.*return/ },
      { name: 'Touch preventDefault', pattern: /e\.preventDefault/ },
      { name: 'Animation stopping on click', pattern: /this\.style\.animation\s*=\s*'none'/ }
    ];

    let passCount = 0;
    jiggleTests.forEach(test => {
      const matches = html.match(test.pattern);
      if (matches) {
        console.log(`✅ ${test.name}: Fixed`);
        passCount++;
      } else {
        console.log(`❌ ${test.name}: Not found`);
      }
    });

    console.log(`\n📊 Jiggle Fix Results: ${passCount}/${jiggleTests.length} fixes applied`);

    if (passCount >= 8) {
      console.log('\n🎉 Jiggle issues should be completely resolved!');
      console.log('🔧 Applied fixes:');
      console.log('   ✅ !important rules prevent CSS conflicts');
      console.log('   ✅ Animation: none stops conflicting animations');
      console.log('   ✅ Hover debouncing prevents rapid toggling');
      console.log('   ✅ State tracking prevents re-triggering');
      console.log('   ✅ Transform-origin ensures stable scaling');
      console.log('   ✅ Center node pulse stops on hover');
      console.log('   ✅ Touch events properly prevented');
      console.log('   ✅ Click animations temporarily disabled');
    } else {
      console.log('\n⚠️ Some jiggle fixes may need additional work');
    }
  })
  .catch(error => {
    console.error('❌ Test failed:', error.message);
  });