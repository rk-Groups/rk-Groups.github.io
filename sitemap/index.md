---
layout: default
title: Site Graph - RK Groups Network
description: Interactive 10-level deep connected graph visualization showing the complete RK Groups website structure with hierarchical business relationships and clickable navigation.
---

<style>
/* Modern 7-Level Graph Site Map Styles */
.content-section {
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0a0a0a 100%);
  min-height: 100vh;
  padding: 0;
}

.mui-card {
  background: linear-gradient(145deg, rgba(26, 26, 26, 0.95) 0%, rgba(16, 16, 16, 0.95) 100%);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 24px;
  box-shadow: 
    0 20px 40px rgba(0, 0, 0, 0.4),
    0 8px 24px rgba(0, 0, 0, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
  overflow: hidden;
  position: relative;
}

.mui-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent 0%, rgba(64, 196, 255, 0.5) 50%, transparent 100%);
}

/* Modern Hero Section */
.mui-hero {
  background: linear-gradient(135deg, 
    rgba(64, 196, 255, 0.15) 0%, 
    rgba(147, 51, 234, 0.15) 50%, 
    rgba(239, 68, 68, 0.15) 100%);
  padding: 4rem 2rem;
  position: relative;
  overflow: hidden;
}

.mui-hero::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    radial-gradient(circle at 20% 50%, rgba(64, 196, 255, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 80% 50%, rgba(147, 51, 234, 0.1) 0%, transparent 50%);
  animation: pulseGlow 4s ease-in-out infinite;
}

@keyframes pulseGlow {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}

.mui-hero-content {
  position: relative;
  z-index: 2;
}

.mui-hero-icon {
  margin-bottom: 1.5rem;
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

.mui-hero-title {
  font-size: clamp(2.5rem, 5vw, 4rem);
  font-weight: 800;
  background: linear-gradient(135deg, #40c4ff, #9333ea, #ef4444);
  background-size: 200% 200%;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: gradientShift 6s ease infinite;
  margin-bottom: 1rem;
}

@keyframes gradientShift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

.mui-hero-subtitle {
  font-size: 1.5rem;
  color: rgba(255, 255, 255, 0.8);
  font-weight: 300;
  max-width: 600px;
  margin: 0 auto;
}

/* Depth Indicator */
.depth-indicator {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  margin: 2rem 0;
  flex-wrap: wrap;
}

.depth-level {
  padding: 0.5rem 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.6);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
}

.depth-level::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transition: left 0.5s ease;
}

.depth-level:hover::before {
  left: 100%;
}

.depth-level.active {
  background: linear-gradient(135deg, rgba(64, 196, 255, 0.3), rgba(147, 51, 234, 0.3));
  color: white;
  border-color: rgba(64, 196, 255, 0.5);
  transform: scale(1.05);
  box-shadow: 0 4px 12px rgba(64, 196, 255, 0.3);
}

/* Graph Container */
.graph-container {
  background: radial-gradient(ellipse at center, rgba(26, 26, 26, 0.9) 0%, rgba(10, 10, 10, 0.95) 100%);
  border-radius: 20px;
  padding: 2rem;
  margin: 2rem 0;
  border: 1px solid rgba(255, 255, 255, 0.08);
  position: relative;
  overflow: hidden;
}

.graph-container::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    radial-gradient(circle at 25% 25%, rgba(64, 196, 255, 0.05) 0%, transparent 50%),
    radial-gradient(circle at 75% 75%, rgba(147, 51, 234, 0.05) 0%, transparent 50%);
  pointer-events: none;
}

/* SVG Graph Styling */
.network-graph {
  width: 100%;
  height: 800px;
  position: relative;
  z-index: 2;
}

/* Node Styles with Modern Gradients */
.node {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
  filter: drop-shadow(0 2px 8px rgba(0, 0, 0, 0.3));
}

.node:hover {
  transform: scale(1.2);
  filter: drop-shadow(0 4px 16px rgba(0, 0, 0, 0.4));
}

.node.root {
  fill: url(#rootGradient);
  stroke: #40c4ff;
  stroke-width: 3;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.node.level2 {
  fill: url(#level2Gradient);
  stroke: #9333ea;
  stroke-width: 2.5;
}

.node.level3 {
  fill: url(#level3Gradient);
  stroke: #10b981;
  stroke-width: 2;
}

.node.level4 {
  fill: url(#level4Gradient);
  stroke: #f59e0b;
  stroke-width: 2;
}

.node.level5 {
  fill: url(#level5Gradient);
  stroke: #ef4444;
  stroke-width: 1.5;
}

.node.level6 {
  fill: url(#level6Gradient);
  stroke: #8b5cf6;
  stroke-width: 1.5;
}

.node.level7 {
  fill: url(#level7Gradient);
  stroke: #06b6d4;
  stroke-width: 1;
}

.node.level8 {
  fill: url(#level8Gradient);
  stroke: #4CAF50;
  stroke-width: 1;
}

.node.level9 {
  fill: url(#level9Gradient);
  stroke: #FFC107;
  stroke-width: 1;
}

.node.level10 {
  fill: url(#level10Gradient);
  stroke: #E91E63;
  stroke-width: 1;
}

/* Connection Lines with Modern Styling */
.connection {
  stroke-width: 2;
  stroke-linecap: round;
  opacity: 0.6;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  filter: drop-shadow(0 1px 3px rgba(0, 0, 0, 0.3));
}

.connection:hover {
  opacity: 1;
  stroke-width: 3;
}

.connection.level1-2 { stroke: #40c4ff; }
.connection.level2-3 { stroke: #9333ea; }
.connection.level3-4 { stroke: #10b981; }
.connection.level4-5 { stroke: #f59e0b; }
.connection.level5-6 { stroke: #ef4444; }
.connection.level6-7 { stroke: #8b5cf6; }

/* Text Labels */
.node-label {
  fill: white;
  font-size: 11px;
  font-weight: 600;
  text-anchor: middle;
  pointer-events: none;
  font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
  text-shadow: 0 1px 3px rgba(0, 0, 0, 0.8);
}

.site-graph {
  width: 100%;
  height: 1000px;
  background: var(--bg-primary);
  border-radius: var(--mui-radius);
  border: 1px solid var(--border-primary);
  position: relative;
  overflow: hidden;
}

.graph-svg {
  width: 100%;
  height: 100%;
  background: transparent;
}

.graph-node {
  cursor: pointer;
  transition: all 0.3s ease;
}

.graph-node:hover {
  transform: scale(1.1);
}

.graph-node circle {
  fill: var(--bg-elevated);
  stroke: var(--accent-primary);
  stroke-width: 3;
  transition: all 0.3s ease;
}

.graph-node:hover circle {
  fill: var(--accent-primary);
  stroke: var(--accent-secondary);
  stroke-width: 4;
}

.graph-node.root circle {
  r: 60;
  fill: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
  stroke: var(--accent-primary);
  stroke-width: 5;
}

.graph-node.level2 circle {
  r: 50;
  fill: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
  stroke: var(--accent-primary);
  stroke-width: 4;
}

.graph-node.level3 circle {
  r: 45;
  stroke: var(--text-secondary);
  stroke-width: 3;
}

.graph-node.level4 circle {
  r: 40;
  stroke: var(--border-primary);
  stroke-width: 3;
}

.graph-node.level5 circle {
  r: 35;
  stroke: var(--accent-secondary);
  stroke-width: 2.5;
}

.graph-node.level6 circle {
  r: 30;
  stroke: var(--text-tertiary);
  stroke-width: 2;
}

.graph-node.level7 circle {
  r: 25;
  stroke: var(--border-primary);
  stroke-width: 1.5;
}

.graph-edge {
  stroke: var(--accent-primary);
  stroke-width: 2;
  fill: none;
  opacity: 0.6;
  transition: all 0.3s ease;
}

.graph-edge.level1 { stroke: var(--accent-primary); }
.graph-edge.level2 { stroke: var(--text-secondary); }
.graph-edge.level3 { stroke: var(--border-primary); }
.graph-edge.level4 { stroke: var(--accent-secondary); }
.graph-edge.level5 { stroke: var(--text-tertiary); }
.graph-edge.level6 { stroke: var(--border-primary); }

.node-label {
  text-anchor: middle;
  dominant-baseline: middle;
  font-size: 11px;
  font-weight: 500;
  fill: var(--text-primary);
  pointer-events: none;
  user-select: none;
}

.graph-node.root .node-label {
  font-size: 16px;
  font-weight: 700;
}

.graph-node.level2 .node-label {
  font-size: 14px;
  font-weight: 600;
}

.graph-node.level3 .node-label {
  font-size: 13px;
  font-weight: 600;
}

.graph-node:hover .node-label {
  fill: white;
}

.node-icon {
  text-anchor: middle;
  dominant-baseline: middle;
  font-size: 18px;
  fill: var(--text-primary);
  pointer-events: none;
}

.graph-node.root .node-icon {
  font-size: 28px;
}

.graph-node.level2 .node-icon {
  font-size: 22px;
}

.graph-node.level3 .node-icon {
  font-size: 20px;
}

.graph-node:hover .node-icon {
  fill: white;
}

/* Legend */
.graph-legend {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  margin: 2rem 0;
  flex-wrap: wrap;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.85rem;
  color: var(--text-secondary);
}

.legend-node {
  width: 14px;
  height: 14px;
  border-radius: 50%;
  display: inline-block;
}

.legend-node.root { background: var(--accent-primary); }
.legend-node.level2 { background: var(--accent-primary); }
.legend-node.level3 { background: var(--text-secondary); border: 2px solid var(--text-secondary); }
.legend-node.level4 { background: var(--border-primary); border: 2px solid var(--border-primary); }
.legend-node.level5 { background: var(--accent-secondary); border: 2px solid var(--accent-secondary); }
.legend-node.level6 { background: var(--text-tertiary); border: 2px solid var(--text-tertiary); }
.legend-node.level7 { background: var(--border-primary); border: 1px solid var(--border-primary); }
.legend-node.level8 { background: #4CAF50; border: 1px solid #4CAF50; }
.legend-node.level9 { background: #FFC107; border: 1px solid #FFC107; }
.legend-node.level10 { background: #E91E63; border: 1px solid #E91E63; }

/* Controls */
.graph-controls {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin: 1rem 0;
  flex-wrap: wrap;
}

.graph-btn {
  padding: 0.5rem 1rem;
  background: var(--bg-elevated);
  border: 1px solid var(--border-primary);
  border-radius: var(--mui-radius);
  color: var(--text-primary);
  cursor: pointer;
  transition: all 0.2s ease;
  font-size: 0.9rem;
}

.graph-btn:hover {
  background: var(--accent-primary);
  color: white;
}

.graph-btn.active {
  background: var(--accent-primary);
  color: white;
}

/* Depth indicator */
.depth-indicator {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  margin: 1rem 0;
  flex-wrap: wrap;
}

.depth-level {
  padding: 0.25rem 0.75rem;
  background: var(--bg-elevated);
  border: 1px solid var(--border-primary);
  border-radius: var(--mui-radius);
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.depth-level.active {
  background: var(--accent-primary);
  color: white;
}

/* Responsive */
@media (max-width: 768px) {
  .site-graph {
    height: 700px;
  }

  .graph-node circle {
    r: 20;
  }

  .graph-node.root circle {
    r: 35;
  }

  .graph-node.level2 circle {
    r: 30;
  }

  .graph-node.level3 circle,
  .graph-node.level4 circle,
  .graph-node.level5 circle,
  .graph-node.level6 circle,
  .graph-node.level7 circle {
    r: 20;
  }

  .node-label {
    font-size: 8px;
  }

  .graph-node.root .node-label {
    font-size: 10px;
  }

  .graph-node.level2 .node-label {
    font-size: 9px;
  }

  .node-icon {
    font-size: 12px;
  }

  .graph-node.root .node-icon {
    font-size: 16px;
  }

  .graph-node.level2 .node-icon {
    font-size: 14px;
  }
}

/* Modern Legend */
.graph-legend {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 1rem;
  margin: 2rem 0;
  padding: 2rem;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.02) 100%);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem;
  border-radius: 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.legend-item:hover {
  transform: translateY(-2px);
  background: rgba(255, 255, 255, 0.05);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.legend-node {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: inline-block;
  position: relative;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
  flex-shrink: 0;
}

.legend-node.root { 
  background: linear-gradient(135deg, #40c4ff, #1976d2);
  border: 2px solid #40c4ff;
}
.legend-node.level2 { 
  background: linear-gradient(135deg, #9333ea, #6b21a8);
  border: 2px solid #9333ea;
}
.legend-node.level3 { 
  background: linear-gradient(135deg, #10b981, #047857);
  border: 2px solid #10b981;
}
.legend-node.level4 { 
  background: linear-gradient(135deg, #f59e0b, #d97706);
  border: 2px solid #f59e0b;
}
.legend-node.level5 { 
  background: linear-gradient(135deg, #ef4444, #dc2626);
  border: 2px solid #ef4444;
}
.legend-node.level6 { 
  background: linear-gradient(135deg, #8b5cf6, #7c3aed);
  border: 2px solid #8b5cf6;
}
.legend-node.level7 { 
  background: linear-gradient(135deg, #06b6d4, #0891b2);
  border: 2px solid #06b6d4;
}

.legend-item span:last-child {
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.9);
  font-weight: 500;
}

/* Modern Controls */
.graph-controls {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin: 2rem 0;
  flex-wrap: wrap;
}

.graph-btn {
  padding: 0.75rem 1.5rem;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
  color: rgba(255, 255, 255, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  font-size: 0.9rem;
  font-weight: 500;
  position: relative;
  overflow: hidden;
  backdrop-filter: blur(10px);
}

.graph-btn:hover {
  transform: translateY(-2px);
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.15) 0%, rgba(255, 255, 255, 0.1) 100%);
  border-color: rgba(255, 255, 255, 0.3);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
}

.graph-btn.active {
  background: linear-gradient(135deg, #40c4ff 0%, #1976d2 100%);
  color: white;
  border-color: #40c4ff;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(64, 196, 255, 0.4);
}
</style>

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">account_tree</span>
    </div>
    <h1 class="mui-hero-title">RK Groups Deep Network</h1>
    <p class="mui-hero-subtitle">10-level deep interactive graph with clickable navigation to all business areas</p>
  </div>
</div>

<div class="content-section">
  <div class="mui-card">
    <div class="depth-indicator">
      <div class="depth-level active">Level 1: Root</div>
      <div class="depth-level">Level 2: Ecosystem</div>
      <div class="depth-level">Level 3: Divisions</div>
      <div class="depth-level">Level 4: Categories</div>
      <div class="depth-level">Level 5: Companies</div>
      <div class="depth-level">Level 6: Branches</div>
      <div class="depth-level">Level 7: Services</div>
      <div class="depth-level">Level 8: Pages</div>
      <div class="depth-level">Level 9: Features</div>
      <div class="depth-level">Level 10: Details</div>
    </div>

    <div class="graph-legend">
      <div class="legend-item">
        <span class="legend-node root"></span>
        <span>Root</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level2"></span>
        <span>Ecosystem</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level3"></span>
        <span>Divisions</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level4"></span>
        <span>Categories</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level5"></span>
        <span>Companies</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level6"></span>
        <span>Branches</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level7"></span>
        <span>Services</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level8"></span>
        <span>Pages</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level9"></span>
        <span>Features</span>
      </div>
      <div class="legend-item">
        <span class="legend-node level10"></span>
        <span>Details</span>
      </div>
    </div>

    <div class="graph-controls">
      <button class="graph-btn active" onclick="showAllConnections()">Show All</button>
      <button class="graph-btn" onclick="highlightLevel(1)">Level 1-3</button>
      <button class="graph-btn" onclick="highlightLevel(4)">Level 4-6</button>
      <button class="graph-btn" onclick="highlightLevel(7)">Level 7-10</button>
      <button class="graph-btn" onclick="highlightCompanies()">Companies</button>
      <button class="graph-btn" onclick="highlightCalculators()">Calculators</button>
    </div>

    <div class="graph-container">
      <svg viewBox="0 0 1200 800" class="network-graph">
        <!-- Define Gradients -->
        <defs>
          <linearGradient id="rootGradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#40c4ff"/>
            <stop offset="100%" style="stop-color:#1976d2"/>
          </linearGradient>
          <linearGradient id="level2Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#9333ea"/>
            <stop offset="100%" style="stop-color:#6b21a8"/>
          </linearGradient>
          <linearGradient id="level3Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#10b981"/>
            <stop offset="100%" style="stop-color:#047857"/>
          </linearGradient>
          <linearGradient id="level4Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#f59e0b"/>
            <stop offset="100%" style="stop-color:#d97706"/>
          </linearGradient>
          <linearGradient id="level5Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#ef4444"/>
            <stop offset="100%" style="stop-color:#dc2626"/>
          </linearGradient>
          <linearGradient id="level6Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#8b5cf6"/>
            <stop offset="100%" style="stop-color:#7c3aed"/>
          </linearGradient>
          <linearGradient id="level7Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#06b6d4"/>
            <stop offset="100%" style="stop-color:#0891b2"/>
          </linearGradient>
          <linearGradient id="level8Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#ec4899"/>
            <stop offset="100%" style="stop-color:#be185d"/>
          </linearGradient>
          <linearGradient id="level9Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#84cc16"/>
            <stop offset="100%" style="stop-color:#65a30d"/>
          </linearGradient>
          <linearGradient id="level10Gradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#f97316"/>
            <stop offset="100%" style="stop-color:#ea580c"/>
          </linearGradient>
        </defs>
        <!-- Level 1: Root -->
        <g class="level-group level1">
          <circle cx="600" cy="40" r="28" class="node root" data-level="1" onclick="window.location.href='/'">
            <title>RK Groups - Home</title>
          </circle>
          <text x="600" y="46" text-anchor="middle" class="node-label">RK Groups</text>
        </g>

        <!-- Level 2: Main Ecosystems -->
        <g class="level-group level2">
          <circle cx="300" cy="120" r="24" class="node level2" data-level="2" onclick="window.location.href='/companies/'">
            <title>Companies Hub</title>
          </circle>
          <text x="300" y="126" text-anchor="middle" class="node-label">Companies</text>

          <circle cx="600" cy="120" r="24" class="node level2" data-level="2" onclick="window.location.href='/Calc/'">
            <title>Calculators Hub</title>
          </circle>
          <text x="600" y="126" text-anchor="middle" class="node-label">Calculators</text>

          <circle cx="900" cy="120" r="24" class="node level2" data-level="2" onclick="window.location.href='/sitemap/'">
            <title>Site Navigation</title>
          </circle>
          <text x="900" y="126" text-anchor="middle" class="node-label">Navigation</text>
        </g>

        <!-- Level 3: Business Divisions -->
        <g class="level-group level3">
          <circle cx="150" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/companies/rk-oxygen/'">
            <title>Oxygen Division</title>
          </circle>
          <text x="150" y="206" text-anchor="middle" class="node-label">Oxygen</text>

          <circle cx="250" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/companies/rk-electrodes/'">
            <title>Electrodes Division</title>
          </circle>
          <text x="250" y="206" text-anchor="middle" class="node-label">Electrodes</text>

          <circle cx="350" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/companies/rk-palace/'">
            <title>Palace Division</title>
          </circle>
          <text x="350" y="206" text-anchor="middle" class="node-label">Palace</text>

          <circle cx="450" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/companies/sand-creations/'">
            <title>Sand Creations</title>
          </circle>
          <text x="450" y="206" text-anchor="middle" class="node-label">Sand</text>

          <circle cx="550" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/Calc/GST/'">
            <title>GST Calculator</title>
          </circle>
          <text x="550" y="206" text-anchor="middle" class="node-label">GST</text>

          <circle cx="650" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/Calc/EMI/'">
            <title>EMI Calculator</title>
          </circle>
          <text x="650" y="206" text-anchor="middle" class="node-label">EMI</text>

          <circle cx="750" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/Calc/LIQ/'">
            <title>LIQ Calculator</title>
          </circle>
          <text x="750" y="206" text-anchor="middle" class="node-label">LIQ</text>

          <circle cx="850" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/search/'">
            <title>Search</title>
          </circle>
          <text x="850" y="206" text-anchor="middle" class="node-label">Search</text>

          <circle cx="950" cy="200" r="20" class="node level3" data-level="3" onclick="window.location.href='/contact/'">
            <title>Contact</title>
          </circle>
          <text x="950" y="206" text-anchor="middle" class="node-label">Contact</text>
        </g>

        <!-- Level 4: Categories -->
        <g class="level-group level4">
          <circle cx="100" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/companies/rk-oxygen/'">
            <title>Industrial Gases</title>
          </circle>
          <text x="100" y="286" text-anchor="middle" class="node-label">Gases</text>

          <circle cx="200" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/companies/rk-electrodes/'">
            <title>Welding Materials</title>
          </circle>
          <text x="200" y="286" text-anchor="middle" class="node-label">Welding</text>

          <circle cx="300" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/companies/rk-palace/'">
            <title>Real Estate</title>
          </circle>
          <text x="300" y="286" text-anchor="middle" class="node-label">Estate</text>

          <circle cx="400" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/companies/sand-creations/'">
            <title>Construction</title>
          </circle>
          <text x="400" y="286" text-anchor="middle" class="node-label">Build</text>

          <circle cx="500" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/Calc/GST/'">
            <title>Tax Calculations</title>
          </circle>
          <text x="500" y="286" text-anchor="middle" class="node-label">Tax</text>

          <circle cx="600" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/Calc/EMI/'">
            <title>Loan Calculations</title>
          </circle>
          <text x="600" y="286" text-anchor="middle" class="node-label">Loan</text>

          <circle cx="700" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/Calc/LIQ/'">
            <title>Liquid Calculations</title>
          </circle>
          <text x="700" y="286" text-anchor="middle" class="node-label">Liquid</text>

          <circle cx="800" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/search/'">
            <title>Site Search</title>
          </circle>
          <text x="800" y="286" text-anchor="middle" class="node-label">Find</text>

          <circle cx="900" cy="280" r="18" class="node level4" data-level="4" onclick="window.location.href='/contact/'">
            <title>Get in Touch</title>
          </circle>
          <text x="900" y="286" text-anchor="middle" class="node-label">Touch</text>
        </g>

        <!-- Level 5: Company Pages -->
        <g class="level-group level5">
          <circle cx="75" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/companies/rk-oxygen/'">
            <title>RK Oxygen Main</title>
          </circle>
          <text x="75" y="366" text-anchor="middle" class="node-label">RK O2</text>

          <circle cx="125" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/'">
            <title>Gorakhpur Branch</title>
          </circle>
          <text x="125" y="366" text-anchor="middle" class="node-label">GKP</text>

          <circle cx="175" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/companies/rk-electrodes/'">
            <title>RK Electrodes</title>
          </circle>
          <text x="175" y="366" text-anchor="middle" class="node-label">Elec</text>

          <circle cx="225" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/companies/rk-electrodes/terms/'">
            <title>Terms</title>
          </circle>
          <text x="225" y="366" text-anchor="middle" class="node-label">Terms</text>

          <circle cx="275" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/companies/rk-palace/'">
            <title>RK Palace</title>
          </circle>
          <text x="275" y="366" text-anchor="middle" class="node-label">Palace</text>

          <circle cx="325" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/companies/sand-creations/'">
            <title>Sand Creations</title>
          </circle>
          <text x="325" y="366" text-anchor="middle" class="node-label">Sand</text>

          <circle cx="375" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/companies/sand-creations/terms/'">
            <title>Sand Terms</title>
          </circle>
          <text x="375" y="366" text-anchor="middle" class="node-label">S-Terms</text>

          <circle cx="475" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/Calc/GST/'">
            <title>GST Tool</title>
          </circle>
          <text x="475" y="366" text-anchor="middle" class="node-label">GST</text>

          <circle cx="525" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/Calc/EMI/'">
            <title>EMI Tool</title>
          </circle>
          <text x="525" y="366" text-anchor="middle" class="node-label">EMI</text>

          <circle cx="575" cy="360" r="16" class="node level5" data-level="5" onclick="window.location.href='/Calc/LIQ/'">
            <title>LIQ Tool</title>
          </circle>
          <text x="575" y="366" text-anchor="middle" class="node-label">LIQ</text>
        </g>

        <!-- Level 6: Branch Services -->
        <g class="level-group level6">
          <circle cx="50" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/'">
            <title>Gorakhpur Services</title>
          </circle>
          <text x="50" y="446" text-anchor="middle" class="node-label">GKP-S</text>

          <circle cx="100" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/companies/rk-oxygen/lucknow/'">
            <title>Lucknow Branch</title>
          </circle>
          <text x="100" y="446" text-anchor="middle" class="node-label">LKO</text>

          <circle cx="150" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/companies/rk-electrodes/'">
            <title>Electrode Services</title>
          </circle>
          <text x="150" y="446" text-anchor="middle" class="node-label">E-Serv</text>

          <circle cx="200" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/companies/rk-electrodes/refund-policy/'">
            <title>Refund Policy</title>
          </circle>
          <text x="200" y="446" text-anchor="middle" class="node-label">Refund</text>

          <circle cx="250" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/companies/rk-palace/'">
            <title>Palace Services</title>
          </circle>
          <text x="250" y="446" text-anchor="middle" class="node-label">P-Serv</text>

          <circle cx="300" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/companies/sand-creations/'">
            <title>Construction Services</title>
          </circle>
          <text x="300" y="446" text-anchor="middle" class="node-label">C-Serv</text>

          <circle cx="350" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/companies/sand-creations/refund-policy/'">
            <title>Construction Refund</title>
          </circle>
          <text x="350" y="446" text-anchor="middle" class="node-label">C-Ref</text>

          <circle cx="450" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/Calc/GST/'">
            <title>GST Service</title>
          </circle>
          <text x="450" y="446" text-anchor="middle" class="node-label">G-Calc</text>

          <circle cx="500" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/Calc/EMI/'">
            <title>EMI Service</title>
          </circle>
          <text x="500" y="446" text-anchor="middle" class="node-label">E-Calc</text>

          <circle cx="550" cy="440" r="14" class="node level6" data-level="6" onclick="window.location.href='/Calc/LIQ/'">
            <title>LIQ Service</title>
          </circle>
          <text x="550" y="446" text-anchor="middle" class="node-label">L-Calc</text>
        </g>

        <!-- Level 7: Detailed Services -->
        <g class="level-group level7">
          <circle cx="30" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/contact/'">
            <title>Contact Gorakhpur</title>
          </circle>
          <text x="30" y="526" text-anchor="middle" class="node-label">Contact</text>

          <circle cx="70" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/shipping/'">
            <title>Shipping Info</title>
          </circle>
          <text x="70" y="526" text-anchor="middle" class="node-label">Ship</text>

          <circle cx="110" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/privacy/'">
            <title>Privacy Policy</title>
          </circle>
          <text x="110" y="526" text-anchor="middle" class="node-label">Privacy</text>

          <circle cx="150" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/rk-oxygen/lucknow/'">
            <title>Lucknow Services</title>
          </circle>
          <text x="150" y="526" text-anchor="middle" class="node-label">L-Serv</text>

          <circle cx="190" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/rk-electrodes/terms/'">
            <title>Electrode Terms</title>
          </circle>
          <text x="190" y="526" text-anchor="middle" class="node-label">E-Terms</text>

          <circle cx="230" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/rk-electrodes/refund-policy/'">
            <title>Electrode Refund</title>
          </circle>
          <text x="230" y="526" text-anchor="middle" class="node-label">E-Ref</text>

          <circle cx="270" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/rk-palace/'">
            <title>Property Services</title>
          </circle>
          <text x="270" y="526" text-anchor="middle" class="node-label">Prop</text>

          <circle cx="310" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/sand-creations/terms/'">
            <title>Sand Terms</title>
          </circle>
          <text x="310" y="526" text-anchor="middle" class="node-label">S-Terms</text>

          <circle cx="350" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/companies/sand-creations/refund-policy/'">
            <title>Sand Refund</title>
          </circle>
          <text x="350" y="526" text-anchor="middle" class="node-label">S-Ref</text>

          <circle cx="430" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/Calc/GST/'">
            <title>GST Calculator</title>
          </circle>
          <text x="430" y="526" text-anchor="middle" class="node-label">GST-C</text>

          <circle cx="470" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/Calc/EMI/'">
            <title>EMI Calculator</title>
          </circle>
          <text x="470" y="526" text-anchor="middle" class="node-label">EMI-C</text>

          <circle cx="510" cy="520" r="12" class="node level7" data-level="7" onclick="window.location.href='/Calc/LIQ/'">
            <title>LIQ Calculator</title>
          </circle>
          <text x="510" y="526" text-anchor="middle" class="node-label">LIQ-C</text>
        </g>

        <!-- Level 8: Specific Pages -->
        <g class="level-group level8">
          <circle cx="20" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/contact/'">
            <title>Contact Form</title>
          </circle>
          <text x="20" y="606" text-anchor="middle" class="node-label">Form</text>

          <circle cx="50" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/shipping/'">
            <title>Shipping Details</title>
          </circle>
          <text x="50" y="606" text-anchor="middle" class="node-label">Detail</text>

          <circle cx="80" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/privacy/'">
            <title>Privacy Terms</title>
          </circle>
          <text x="80" y="606" text-anchor="middle" class="node-label">P-Term</text>

          <circle cx="110" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/companies/rk-oxygen/lucknow/'">
            <title>Lucknow Info</title>
          </circle>
          <text x="110" y="606" text-anchor="middle" class="node-label">Info</text>

          <circle cx="140" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/companies/rk-electrodes/'">
            <title>Products</title>
          </circle>
          <text x="140" y="606" text-anchor="middle" class="node-label">Prod</text>

          <circle cx="170" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/companies/rk-palace/'">
            <title>Properties</title>
          </circle>
          <text x="170" y="606" text-anchor="middle" class="node-label">Props</text>

          <circle cx="200" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/companies/sand-creations/'">
            <title>Projects</title>
          </circle>
          <text x="200" y="606" text-anchor="middle" class="node-label">Proj</text>

          <circle cx="280" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/search/'">
            <title>Search Results</title>
          </circle>
          <text x="280" y="606" text-anchor="middle" class="node-label">Results</text>

          <circle cx="310" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/contact/'">
            <title>Contact Info</title>
          </circle>
          <text x="310" y="606" text-anchor="middle" class="node-label">Info</text>

          <circle cx="410" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/Calc/GST/'">
            <title>GST Features</title>
          </circle>
          <text x="410" y="606" text-anchor="middle" class="node-label">G-Feat</text>

          <circle cx="440" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/Calc/EMI/'">
            <title>EMI Features</title>
          </circle>
          <text x="440" y="606" text-anchor="middle" class="node-label">E-Feat</text>

          <circle cx="470" cy="600" r="10" class="node level8" data-level="8" onclick="window.location.href='/Calc/LIQ/'">
            <title>LIQ Features</title>
          </circle>
          <text x="470" y="606" text-anchor="middle" class="node-label">L-Feat</text>
        </g>

        <!-- Level 9: Interactive Features -->
        <g class="level-group level9">
          <circle cx="15" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/contact/'">
            <title>Contact Features</title>
          </circle>
          <text x="15" y="686" text-anchor="middle" class="node-label">C-F</text>

          <circle cx="35" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/shipping/'">
            <title>Shipping Options</title>
          </circle>
          <text x="35" y="686" text-anchor="middle" class="node-label">Ship</text>

          <circle cx="55" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/privacy/'">
            <title>Privacy Options</title>
          </circle>
          <text x="55" y="686" text-anchor="middle" class="node-label">Priv</text>

          <circle cx="75" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/companies/rk-electrodes/'">
            <title>Product Catalog</title>
          </circle>
          <text x="75" y="686" text-anchor="middle" class="node-label">Cat</text>

          <circle cx="95" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/companies/rk-palace/'">
            <title>Property Listings</title>
          </circle>
          <text x="95" y="686" text-anchor="middle" class="node-label">List</text>

          <circle cx="115" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/companies/sand-creations/'">
            <title>Project Gallery</title>
          </circle>
          <text x="115" y="686" text-anchor="middle" class="node-label">Gal</text>

          <circle cx="195" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/search/'">
            <title>Advanced Search</title>
          </circle>
          <text x="195" y="686" text-anchor="middle" class="node-label">Adv</text>

          <circle cx="215" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/contact/'">
            <title>Contact Form</title>
          </circle>
          <text x="215" y="686" text-anchor="middle" class="node-label">Form</text>

          <circle cx="395" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/Calc/GST/'">
            <title>GST Calculator Interface</title>
          </circle>
          <text x="395" y="686" text-anchor="middle" class="node-label">G-UI</text>

          <circle cx="415" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/Calc/EMI/'">
            <title>EMI Calculator Interface</title>
          </circle>
          <text x="415" y="686" text-anchor="middle" class="node-label">E-UI</text>

          <circle cx="435" cy="680" r="8" class="node level9" data-level="9" onclick="window.location.href='/Calc/LIQ/'">
            <title>LIQ Calculator Interface</title>
          </circle>
          <text x="435" y="686" text-anchor="middle" class="node-label">L-UI</text>
        </g>

        <!-- Level 10: Detailed Components -->
        <g class="level-group level10">
          <circle cx="10" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/sitemap.xml'">
            <title>XML Sitemap</title>
          </circle>
          <text x="10" y="766" text-anchor="middle" class="node-label">XML</text>

          <circle cx="25" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/robots.txt'">
            <title>Robots.txt</title>
          </circle>
          <text x="25" y="766" text-anchor="middle" class="node-label">Bot</text>

          <circle cx="40" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/manifest.json'">
            <title>Web Manifest</title>
          </circle>
          <text x="40" y="766" text-anchor="middle" class="node-label">Man</text>

          <circle cx="55" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/feed.xml'">
            <title>RSS Feed</title>
          </circle>
          <text x="55" y="766" text-anchor="middle" class="node-label">RSS</text>

          <circle cx="70" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/sw.js'">
            <title>Service Worker</title>
          </circle>
          <text x="70" y="766" text-anchor="middle" class="node-label">SW</text>

          <circle cx="85" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/offline/'">
            <title>Offline Page</title>
          </circle>
          <text x="85" y="766" text-anchor="middle" class="node-label">Off</text>

          <circle cx="100" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/404.html'">
            <title>404 Error Page</title>
          </circle>
          <text x="100" y="766" text-anchor="middle" class="node-label">404</text>

          <circle cx="380" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/Calc/GST/'">
            <title>GST Calculator Inputs</title>
          </circle>
          <text x="380" y="766" text-anchor="middle" class="node-label">G-In</text>

          <circle cx="395" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/Calc/EMI/'">
            <title>EMI Calculator Inputs</title>
          </circle>
          <text x="395" y="766" text-anchor="middle" class="node-label">E-In</text>

          <circle cx="410" cy="760" r="6" class="node level10" data-level="10" onclick="window.location.href='/Calc/LIQ/'">
            <title>LIQ Calculator Inputs</title>
          </circle>
          <text x="410" y="766" text-anchor="middle" class="node-label">L-In</text>
        </g>

        <!-- Connection Lines -->
        <g class="connections">
          <!-- Level 1 to Level 2 -->
          <line x1="600" y1="68" x2="300" y2="96" class="connection level1-2" />
          <line x1="600" y1="68" x2="600" y2="96" class="connection level1-2" />
          <line x1="600" y1="68" x2="900" y2="96" class="connection level1-2" />

          <!-- Level 2 to Level 3 -->
          <line x1="300" y1="144" x2="150" y2="180" class="connection level2-3" />
          <line x1="300" y1="144" x2="250" y2="180" class="connection level2-3" />
          <line x1="300" y1="144" x2="350" y2="180" class="connection level2-3" />
          <line x1="300" y1="144" x2="450" y2="180" class="connection level2-3" />

          <line x1="600" y1="144" x2="550" y2="180" class="connection level2-3" />
          <line x1="600" y1="144" x2="650" y2="180" class="connection level2-3" />
          <line x1="600" y1="144" x2="750" y2="180" class="connection level2-3" />

          <line x1="900" y1="144" x2="850" y2="180" class="connection level2-3" />
          <line x1="900" y1="144" x2="950" y2="180" class="connection level2-3" />

          <!-- Level 3 to Level 4 -->
          <line x1="150" y1="220" x2="100" y2="262" class="connection level3-4" />
          <line x1="250" y1="220" x2="200" y2="262" class="connection level3-4" />
          <line x1="350" y1="220" x2="300" y2="262" class="connection level3-4" />
          <line x1="450" y1="220" x2="400" y2="262" class="connection level3-4" />
          <line x1="550" y1="220" x2="500" y2="262" class="connection level3-4" />
          <line x1="650" y1="220" x2="600" y2="262" class="connection level3-4" />
          <line x1="750" y1="220" x2="700" y2="262" class="connection level3-4" />
          <line x1="850" y1="220" x2="800" y2="262" class="connection level3-4" />
          <line x1="950" y1="220" x2="900" y2="262" class="connection level3-4" />

          <!-- Level 4 to Level 5 -->
          <line x1="100" y1="298" x2="75" y2="344" class="connection level4-5" />
          <line x1="100" y1="298" x2="125" y2="344" class="connection level4-5" />
          <line x1="200" y1="298" x2="175" y2="344" class="connection level4-5" />
          <line x1="200" y1="298" x2="225" y2="344" class="connection level4-5" />
          <line x1="300" y1="298" x2="275" y2="344" class="connection level4-5" />
          <line x1="400" y1="298" x2="325" y2="344" class="connection level4-5" />
          <line x1="400" y1="298" x2="375" y2="344" class="connection level4-5" />
          <line x1="500" y1="298" x2="475" y2="344" class="connection level4-5" />
          <line x1="600" y1="298" x2="525" y2="344" class="connection level4-5" />
          <line x1="700" y1="298" x2="575" y2="344" class="connection level4-5" />

          <!-- Level 5 to Level 6 -->
          <line x1="75" y1="376" x2="50" y2="426" class="connection level5-6" />
          <line x1="125" y1="376" x2="100" y2="426" class="connection level5-6" />
          <line x1="175" y1="376" x2="150" y2="426" class="connection level5-6" />
          <line x1="225" y1="376" x2="200" y2="426" class="connection level5-6" />
          <line x1="275" y1="376" x2="250" y2="426" class="connection level5-6" />
          <line x1="325" y1="376" x2="300" y2="426" class="connection level5-6" />
          <line x1="375" y1="376" x2="350" y2="426" class="connection level5-6" />
          <line x1="475" y1="376" x2="450" y2="426" class="connection level5-6" />
          <line x1="525" y1="376" x2="500" y2="426" class="connection level5-6" />
          <line x1="575" y1="376" x2="550" y2="426" class="connection level5-6" />

          <!-- Level 6 to Level 7 -->
          <line x1="50" y1="454" x2="30" y2="508" class="connection level6-7" />
          <line x1="50" y1="454" x2="70" y2="508" class="connection level6-7" />
          <line x1="100" y1="454" x2="110" y2="508" class="connection level6-7" />
          <line x1="100" y1="454" x2="150" y2="508" class="connection level6-7" />
          <line x1="150" y1="454" x2="190" y2="508" class="connection level6-7" />
          <line x1="200" y1="454" x2="230" y2="508" class="connection level6-7" />
          <line x1="250" y1="454" x2="270" y2="508" class="connection level6-7" />
          <line x1="300" y1="454" x2="310" y2="508" class="connection level6-7" />
          <line x1="350" y1="454" x2="350" y2="508" class="connection level6-7" />
          <line x1="450" y1="454" x2="430" y2="508" class="connection level6-7" />
          <line x1="500" y1="454" x2="470" y2="508" class="connection level6-7" />
          <line x1="550" y1="454" x2="510" y2="508" class="connection level6-7" />

          <!-- Level 7 to Level 8 -->
          <line x1="30" y1="532" x2="20" y2="590" class="connection level7-8" />
          <line x1="70" y1="532" x2="50" y2="590" class="connection level7-8" />
          <line x1="110" y1="532" x2="80" y2="590" class="connection level7-8" />
          <line x1="150" y1="532" x2="110" y2="590" class="connection level7-8" />
          <line x1="190" y1="532" x2="140" y2="590" class="connection level7-8" />
          <line x1="230" y1="532" x2="170" y2="590" class="connection level7-8" />
          <line x1="270" y1="532" x2="200" y2="590" class="connection level7-8" />
          <line x1="310" y1="532" x2="280" y2="590" class="connection level7-8" />
          <line x1="350" y1="532" x2="310" y2="590" class="connection level7-8" />
          <line x1="430" y1="532" x2="410" y2="590" class="connection level7-8" />
          <line x1="470" y1="532" x2="440" y2="590" class="connection level7-8" />
          <line x1="510" y1="532" x2="470" y2="590" class="connection level7-8" />

          <!-- Level 8 to Level 9 -->
          <line x1="20" y1="610" x2="15" y2="672" class="connection level8-9" />
          <line x1="50" y1="610" x2="35" y2="672" class="connection level8-9" />
          <line x1="80" y1="610" x2="55" y2="672" class="connection level8-9" />
          <line x1="110" y1="610" x2="75" y2="672" class="connection level8-9" />
          <line x1="140" y1="610" x2="95" y2="672" class="connection level8-9" />
          <line x1="170" y1="610" x2="115" y2="672" class="connection level8-9" />
          <line x1="280" y1="610" x2="195" y2="672" class="connection level8-9" />
          <line x1="310" y1="610" x2="215" y2="672" class="connection level8-9" />
          <line x1="410" y1="610" x2="395" y2="672" class="connection level8-9" />
          <line x1="440" y1="610" x2="415" y2="672" class="connection level8-9" />
          <line x1="470" y1="610" x2="435" y2="672" class="connection level8-9" />

          <!-- Level 9 to Level 10 -->
          <line x1="15" y1="688" x2="10" y2="754" class="connection level9-10" />
          <line x1="35" y1="688" x2="25" y2="754" class="connection level9-10" />
          <line x1="55" y1="688" x2="40" y2="754" class="connection level9-10" />
          <line x1="75" y1="688" x2="55" y2="754" class="connection level9-10" />
          <line x1="95" y1="688" x2="70" y2="754" class="connection level9-10" />
          <line x1="115" y1="688" x2="85" y2="754" class="connection level9-10" />
          <line x1="195" y1="688" x2="100" y2="754" class="connection level9-10" />
          <line x1="395" y1="688" x2="380" y2="754" class="connection level9-10" />
          <line x1="415" y1="688" x2="395" y2="754" class="connection level9-10" />
          <line x1="435" y1="688" x2="410" y2="754" class="connection level9-10" />
        </g>
      </svg>
    </div>

    <div style="text-align: center; margin-top: 2rem; padding: 1rem; background: var(--bg-elevated); border-radius: var(--mui-radius);">
      <h3 style="margin-bottom: 1rem; color: var(--text-primary);">10-Level Network Statistics</h3>
      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 1rem; margin-bottom: 1rem;">
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">10</div>
          <div style="color: var(--text-secondary);">Hierarchy Levels</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">4</div>
          <div style="color: var(--text-secondary);">Companies</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">2</div>
          <div style="color: var(--text-secondary);">Branches</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">3</div>
          <div style="color: var(--text-secondary);">Calculators</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">50+</div>
          <div style="color: var(--text-secondary);">Network Nodes</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">65+</div>
          <div style="color: var(--text-secondary);">Connections</div>
        </div>
      </div>
      <p style="color: var(--text-secondary); font-size: 0.9rem;">
        Click any node to navigate • Use controls to filter by level • Explore our complete 10-level business hierarchy
      </p>
    </div>
  </div>
</div>

<script>
function showAllConnections() {
  document.querySelectorAll('.connection').forEach(connection => {
    connection.style.opacity = '0.7';
    connection.style.strokeWidth = '2';
  });
  updateActiveButton('showAllConnections');
}

function highlightLevel(level) {
  // Reset all connections
  document.querySelectorAll('.connection').forEach(connection => {
    connection.style.opacity = '0.2';
    connection.style.strokeWidth = '1';
  });

  // Highlight specific level connections
  if (level === 1) {
    document.querySelectorAll('.connection.level1-2').forEach(connection => {
      connection.style.opacity = '1';
      connection.style.strokeWidth = '3';
    });
  } else if (level === 3) {
    document.querySelectorAll('.connection.level2-3, .connection.level3-4').forEach(connection => {
      connection.style.opacity = '1';
      connection.style.strokeWidth = '3';
    });
  } else if (level === 5) {
    document.querySelectorAll('.connection.level4-5, .connection.level5-6').forEach(connection => {
      connection.style.opacity = '1';
      connection.style.strokeWidth = '3';
    });
  } else if (level === 7) {
    document.querySelectorAll('.connection.level6-7, .connection.level7-8').forEach(connection => {
      connection.style.opacity = '1';
      connection.style.strokeWidth = '3';
    });
  } else if (level === 9) {
    document.querySelectorAll('.connection.level8-9, .connection.level9-10').forEach(connection => {
      connection.style.opacity = '1';
      connection.style.strokeWidth = '3';
    });
  }
  updateActiveButton('highlightLevel');
}

function highlightCompanies() {
  document.querySelectorAll('.connection').forEach(connection => {
    connection.style.opacity = '0.2';
    connection.style.strokeWidth = '1';
  });
  // Highlight company-related connections (levels 3-8 for companies)
  document.querySelectorAll('.connection.level2-3, .connection.level3-4, .connection.level4-5, .connection.level5-6, .connection.level6-7, .connection.level7-8').forEach(connection => {
    connection.style.opacity = '1';
    connection.style.strokeWidth = '3';
  });
  updateActiveButton('highlightCompanies');
}

function highlightCalculators() {
  document.querySelectorAll('.connection').forEach(connection => {
    connection.style.opacity = '0.2';
    connection.style.strokeWidth = '1';
  });
  // Highlight calculator-related connections (includes all levels from main calculators to components)
  document.querySelectorAll('.connection.level2-3, .connection.level3-4, .connection.level4-5, .connection.level5-6, .connection.level6-7, .connection.level7-8, .connection.level8-9, .connection.level9-10').forEach(connection => {
    connection.style.opacity = '1';
    connection.style.strokeWidth = '3';
  });
  updateActiveButton('highlightCalculators');
}

function navigateTo(url) {
  window.location.href = url;
}

function updateActiveButton(activeFunction) {
  document.querySelectorAll('.graph-btn').forEach(btn => {
    btn.classList.remove('active');
  });
  if (activeFunction === 'showAllConnections') {
    document.querySelector('button[onclick="showAllConnections()"]').classList.add('active');
  } else if (activeFunction === 'highlightLevel') {
    // Find the button that called this function
    if (event && event.target) {
      event.target.classList.add('active');
    }
  } else if (activeFunction === 'highlightCompanies') {
    document.querySelector('button[onclick="highlightCompanies()"]').classList.add('active');
  } else if (activeFunction === 'highlightCalculators') {
    document.querySelector('button[onclick="highlightCalculators()"]').classList.add('active');
  }
}

// Initialize with all connections visible
document.addEventListener('DOMContentLoaded', function() {
  showAllConnections();
});
</script>