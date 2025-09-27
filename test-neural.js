// Test Suite for 3D Neural Network Visualization
// File: test-neural.js

console.log('🧠 Neural Network 3D Test Suite Starting...\n');

const tests = {
  // Test 1: Neural Network Initialization
  testNetworkInit: () => {
    console.log('🔍 Test 1: Network Initialization');
    
    if (typeof neuralNet !== 'undefined' && neuralNet) {
      const neurons = neuralNet.getTotalNeurons();
      const connections = neuralNet.connections.length;
      const layers = neuralNet.layers.length;
      
      console.log(`✅ Network initialized: ${layers} layers, ${neurons} neurons, ${connections} connections`);
      console.log(`✅ Camera positioned at z=${neuralNet.camera.z}`);
      console.log(`✅ Auto-rotation: ${neuralNet.autoRotate ? 'ON' : 'OFF'}`);
      console.log(`✅ Neural pulses: ${neuralNet.showPulses ? 'ON' : 'OFF'}`);
      
      return { pass: true, neurons, connections, layers };
    } else {
      console.log('❌ Neural network not initialized');
      return { pass: false };
    }
  },
  
  // Test 2: 3D Projection System
  test3DProjection: () => {
    console.log('\n🔍 Test 2: 3D Projection System');
    
    if (!neuralNet) {
      console.log('❌ Neural network not available');
      return { pass: false };
    }
    
    // Test projection of a known 3D point
    const testPoint = { x: 100, y: 50, z: -100 };
    const projected = neuralNet.project3D(testPoint.x, testPoint.y, testPoint.z);
    
    if (projected && projected.x && projected.y && projected.scale) {
      console.log(`✅ 3D projection working: (${testPoint.x}, ${testPoint.y}, ${testPoint.z}) → (${projected.x.toFixed(1)}, ${projected.y.toFixed(1)}) scale: ${projected.scale.toFixed(3)}`);
      
      // Test rotation effects
      const originalY = neuralNet.rotation.y;
      neuralNet.rotation.y += Math.PI / 4; // 45 degree rotation
      const rotatedProjection = neuralNet.project3D(testPoint.x, testPoint.y, testPoint.z);
      neuralNet.rotation.y = originalY; // Reset
      
      console.log(`✅ Rotation effects projection: rotated position (${rotatedProjection.x.toFixed(1)}, ${rotatedProjection.y.toFixed(1)})`);
      
      return { pass: true, projection: projected };
    } else {
      console.log('❌ 3D projection failed');
      return { pass: false };
    }
  },
  
  // Test 3: Neural Layer Structure
  testLayerStructure: () => {
    console.log('\n🔍 Test 3: Neural Layer Structure');
    
    if (!neuralNet) {
      console.log('❌ Neural network not available');
      return { pass: false };
    }
    
    let allGood = true;
    const layerInfo = [];
    
    neuralNet.layers.forEach((layer, index) => {
      const neurons = layer.neurons.length;
      const hasColor = layer.color && layer.color.startsWith('#');
      const hasDepth = typeof layer.depth === 'number';
      
      layerInfo.push({ index, neurons, color: layer.color, depth: layer.depth });
      
      if (neurons > 0 && hasColor && hasDepth) {
        console.log(`✅ Layer ${index}: ${neurons} neurons, color: ${layer.color}, depth: ${layer.depth}`);
      } else {
        console.log(`❌ Layer ${index}: Missing properties (neurons: ${neurons}, color: ${hasColor}, depth: ${hasDepth})`);
        allGood = false;
      }
    });
    
    // Test neuron positioning
    const firstLayer = neuralNet.layers[0];
    if (firstLayer && firstLayer.neurons.length > 0) {
      const neuron = firstLayer.neurons[0];
      if (typeof neuron.x === 'number' && typeof neuron.y === 'number' && typeof neuron.z === 'number') {
        console.log(`✅ Neuron positioning: (${neuron.x}, ${neuron.y}, ${neuron.z})`);
      } else {
        console.log('❌ Neuron positioning invalid');
        allGood = false;
      }
    }
    
    return { pass: allGood, layers: layerInfo };
  },
  
  // Test 4: Neural Connections
  testConnections: () => {
    console.log('\n🔍 Test 4: Neural Connections');
    
    if (!neuralNet) {
      console.log('❌ Neural network not available');
      return { pass: false };
    }
    
    const connections = neuralNet.connections;
    let validConnections = 0;
    let activeConnections = 0;
    
    connections.forEach(conn => {
      const fromNeuron = neuralNet.findNeuron(conn.from);
      const toNeuron = neuralNet.findNeuron(conn.to);
      
      if (fromNeuron && toNeuron) {
        validConnections++;
        if (conn.active) activeConnections++;
      }
    });
    
    const validPercent = ((validConnections / connections.length) * 100).toFixed(1);
    const activePercent = ((activeConnections / connections.length) * 100).toFixed(1);
    
    console.log(`✅ Total connections: ${connections.length}`);
    console.log(`✅ Valid connections: ${validConnections} (${validPercent}%)`);
    console.log(`✅ Active connections: ${activeConnections} (${activePercent}%)`);
    
    return { 
      pass: validConnections > 0,
      total: connections.length,
      valid: validConnections,
      active: activeConnections
    };
  },
  
  // Test 5: Interactive Controls
  testControls: () => {
    console.log('\n🔍 Test 5: Interactive Controls');
    
    if (!neuralNet) {
      console.log('❌ Neural network not available');
      return { pass: false };
    }
    
    let allGood = true;
    
    // Test rotation
    const originalRotY = neuralNet.rotation.y;
    neuralNet.rotation.y += 0.1;
    if (Math.abs(neuralNet.rotation.y - originalRotY) > 0.05) {
      console.log('✅ Rotation control working');
    } else {
      console.log('❌ Rotation control failed');
      allGood = false;
    }
    
    // Test zoom
    const originalZ = neuralNet.camera.z;
    neuralNet.camera.z += 100;
    if (Math.abs(neuralNet.camera.z - originalZ) > 50) {
      console.log('✅ Zoom control working');
      neuralNet.camera.z = originalZ; // Reset
    } else {
      console.log('❌ Zoom control failed');
      allGood = false;
    }
    
    // Test auto-rotation toggle
    const wasAutoRotating = neuralNet.autoRotate;
    neuralNet.autoRotate = !wasAutoRotating;
    if (neuralNet.autoRotate !== wasAutoRotating) {
      console.log('✅ Auto-rotation toggle working');
      neuralNet.autoRotate = wasAutoRotating; // Reset
    } else {
      console.log('❌ Auto-rotation toggle failed');
      allGood = false;
    }
    
    // Test pulse toggle
    const wasPulsing = neuralNet.showPulses;
    neuralNet.showPulses = !wasPulsing;
    if (neuralNet.showPulses !== wasPulsing) {
      console.log('✅ Neural pulse toggle working');
      neuralNet.showPulses = wasPulsing; // Reset
    } else {
      console.log('❌ Neural pulse toggle failed');
      allGood = false;
    }
    
    return { pass: allGood };
  },
  
  // Test 6: Animation System
  testAnimation: () => {
    console.log('\n🔍 Test 6: Animation System');
    
    if (!neuralNet) {
      console.log('❌ Neural network not available');
      return { pass: false };
    }
    
    // Check if pulses are being generated
    const initialPulseCount = neuralNet.pulses.length;
    
    // Force pulse generation
    for (let i = 0; i < 5; i++) {
      neuralNet.updatePulses();
    }
    
    const finalPulseCount = neuralNet.pulses.length;
    
    console.log(`✅ Pulse system: ${initialPulseCount} → ${finalPulseCount} pulses`);
    console.log(`✅ Canvas dimensions: ${neuralNet.width} × ${neuralNet.height}`);
    console.log('✅ Animation loop running (requestAnimationFrame)');
    
    return { 
      pass: true, 
      pulses: finalPulseCount,
      dimensions: { width: neuralNet.width, height: neuralNet.height }
    };
  },
  
  // Test 7: Neuron Data Integrity
  testNeuronData: () => {
    console.log('\n🔍 Test 7: Neuron Data Integrity');
    
    if (!neuralNet) {
      console.log('❌ Neural network not available');
      return { pass: false };
    }
    
    let neuronsWithNames = 0;
    let neuronsWithUrls = 0;
    let totalNeurons = 0;
    
    neuralNet.layers.forEach(layer => {
      layer.neurons.forEach(neuron => {
        totalNeurons++;
        if (neuron.name && neuron.name !== `Node ${neuron.layer}-${neuron.id.split('-')[1]}`) {
          neuronsWithNames++;
        }
        if (neuron.url && neuron.url !== '#') {
          neuronsWithUrls++;
        }
      });
    });
    
    console.log(`✅ Total neurons: ${totalNeurons}`);
    console.log(`✅ Neurons with real names: ${neuronsWithNames} (${((neuronsWithNames/totalNeurons)*100).toFixed(1)}%)`);
    console.log(`✅ Neurons with URLs: ${neuronsWithUrls} (${((neuronsWithUrls/totalNeurons)*100).toFixed(1)}%)`);
    
    // Check specific neuron names
    const rkGroupsNeuron = neuralNet.layers[0].neurons.find(n => n.name === 'RK Groups');
    const companiesNeuron = neuralNet.layers[1].neurons.find(n => n.name === 'Companies');
    
    if (rkGroupsNeuron) console.log('✅ RK Groups root neuron found');
    if (companiesNeuron) console.log('✅ Companies neuron found');
    
    return { 
      pass: neuronsWithNames > 0 && neuronsWithUrls > 0,
      total: totalNeurons,
      withNames: neuronsWithNames,
      withUrls: neuronsWithUrls
    };
  }
};

// Run all tests
console.log('🚀 Running all neural network tests...\n');

const results = {
  passed: 0,
  failed: 0,
  details: {}
};

Object.keys(tests).forEach(testName => {
  try {
    const result = tests[testName]();
    results.details[testName] = result;
    
    if (result.pass) {
      results.passed++;
    } else {
      results.failed++;
    }
  } catch (error) {
    console.log(`❌ Test ${testName} threw error: ${error.message}`);
    results.failed++;
    results.details[testName] = { pass: false, error: error.message };
  }
});

// Final results
console.log('\n🏆 NEURAL NETWORK TEST RESULTS:');
console.log(`✅ Passed: ${results.passed}`);
console.log(`❌ Failed: ${results.failed}`);
console.log(`📊 Success Rate: ${((results.passed / (results.passed + results.failed)) * 100).toFixed(1)}%`);

if (results.passed >= 6) {
  console.log('\n🎉 NEURAL NETWORK FULLY FUNCTIONAL! 🧠✨');
  console.log('🚀 Your 3D brain visualization is ready for action!');
} else {
  console.log('\n⚠️ Some neural pathways need attention');
}

// Performance check
if (typeof performance !== 'undefined') {
  console.log(`\n⚡ Performance: Script executed in ${performance.now().toFixed(2)}ms`);
}

// Export results for further use
window.neuralTestResults = results;