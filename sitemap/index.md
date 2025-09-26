---
layout: default
title: Site Graph - RK Groups Network
description: Interactive connected graph visualization showing the complete RK Groups website structure with nodes and edges representing page relationships.
---

<style>
/* Connected Graph Site Map Styles */
.site-graph-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 2rem;
  font-family: 'Roboto', sans-serif;
}

.site-graph {
  width: 100%;
  height: 800px;
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

.graph-node.hub circle {
  r: 50;
  fill: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
  stroke: var(--accent-primary);
  stroke-width: 4;
}

.graph-node.company circle {
  r: 40;
  stroke: var(--text-secondary);
  stroke-width: 3;
}

.graph-node.branch circle {
  r: 35;
  stroke: var(--border-primary);
  stroke-width: 2;
}

.graph-node.service circle {
  r: 30;
  stroke: var(--text-tertiary);
  stroke-width: 2;
}

.graph-node.calculator circle {
  r: 32;
  stroke: var(--accent-secondary);
  stroke-width: 2.5;
}

.graph-edge {
  stroke: var(--accent-primary);
  stroke-width: 2;
  fill: none;
  opacity: 0.7;
  transition: all 0.3s ease;
}

.graph-edge:hover {
  stroke-width: 3;
  opacity: 1;
}

.node-label {
  text-anchor: middle;
  dominant-baseline: middle;
  font-size: 12px;
  font-weight: 500;
  fill: var(--text-primary);
  pointer-events: none;
  user-select: none;
}

.graph-node.hub .node-label {
  font-size: 14px;
  font-weight: 600;
}

.graph-node:hover .node-label {
  fill: white;
}

.node-icon {
  text-anchor: middle;
  dominant-baseline: middle;
  font-size: 20px;
  fill: var(--text-primary);
  pointer-events: none;
}

.graph-node.hub .node-icon {
  font-size: 24px;
}

.graph-node:hover .node-icon {
  fill: white;
}

/* Legend */
.graph-legend {
  display: flex;
  justify-content: center;
  gap: 2rem;
  margin: 2rem 0;
  flex-wrap: wrap;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.9rem;
  color: var(--text-secondary);
}

.legend-node {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: inline-block;
}

.legend-node.hub { background: var(--accent-primary); }
.legend-node.company { background: var(--text-secondary); border: 2px solid var(--text-secondary); }
.legend-node.branch { background: var(--border-primary); border: 2px solid var(--border-primary); }
.legend-node.service { background: var(--text-tertiary); border: 2px solid var(--text-tertiary); }
.legend-node.calculator { background: var(--accent-secondary); border: 2px solid var(--accent-secondary); }

/* Controls */
.graph-controls {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin: 1rem 0;
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

/* Responsive */
@media (max-width: 768px) {
  .site-graph {
    height: 600px;
  }

  .graph-legend {
    gap: 1rem;
  }

  .legend-item {
    font-size: 0.8rem;
  }

  .graph-node circle {
    r: 25;
  }

  .graph-node.hub circle {
    r: 35;
  }

  .graph-node.company circle {
    r: 28;
  }

  .graph-node.branch circle,
  .graph-node.service circle,
  .graph-node.calculator circle {
    r: 24;
  }

  .node-label {
    font-size: 10px;
  }

  .graph-node.hub .node-label {
    font-size: 11px;
  }

  .node-icon {
    font-size: 16px;
  }

  .graph-node.hub .node-icon {
    font-size: 18px;
  }
}
</style>

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">share</span>
    </div>
    <h1 class="mui-hero-title">RK Groups Network Graph</h1>
    <p class="mui-hero-subtitle">Interactive connected graph showing our interconnected business ecosystem</p>
  </div>
</div>

<div class="content-section">
  <div class="mui-card">
    <div class="graph-legend">
      <div class="legend-item">
        <span class="legend-node hub"></span>
        <span>Main Hubs</span>
      </div>
      <div class="legend-item">
        <span class="legend-node company"></span>
        <span>Companies</span>
      </div>
      <div class="legend-item">
        <span class="legend-node branch"></span>
        <span>Branches</span>
      </div>
      <div class="legend-item">
        <span class="legend-node calculator"></span>
        <span>Calculators</span>
      </div>
      <div class="legend-item">
        <span class="legend-node service"></span>
        <span>Services</span>
      </div>
    </div>

    <div class="graph-controls">
      <button class="graph-btn active" onclick="showAllConnections()">Show All</button>
      <button class="graph-btn" onclick="highlightCompanies()">Companies</button>
      <button class="graph-btn" onclick="highlightCalculators()">Calculators</button>
      <button class="graph-btn" onclick="highlightServices()">Services</button>
    </div>

    <div class="site-graph-container">
      <div class="site-graph">
        <svg class="graph-svg" viewBox="0 0 1400 800">
          <defs>
            <marker id="arrowhead" markerWidth="10" markerHeight="7"
                    refX="9" refY="3.5" orient="auto">
              <polygon points="0 0, 10 3.5, 0 7" fill="var(--accent-primary)" opacity="0.7" />
            </marker>
          </defs>

          <!-- Edges/Lines connecting nodes -->
          <g class="graph-edges">
            <!-- Home connections -->
            <line class="graph-edge" x1="700" y1="400" x2="500" y2="300" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="400" x2="900" y2="300" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="400" x2="700" y2="200" marker-end="url(#arrowhead)" />

            <!-- Companies hub connections -->
            <line class="graph-edge" x1="500" y1="300" x2="350" y2="200" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="500" y1="300" x2="450" y2="150" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="500" y1="300" x2="550" y2="150" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="500" y1="300" x2="650" y2="200" marker-end="url(#arrowhead)" />

            <!-- RK Oxygen branches -->
            <line class="graph-edge" x1="450" y1="150" x2="300" y2="100" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="450" y1="150" x2="400" y2="50" marker-end="url(#arrowhead)" />

            <!-- Calculators hub connections -->
            <line class="graph-edge" x1="900" y1="300" x2="1050" y2="200" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="900" y1="300" x2="1150" y2="250" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="900" y1="300" x2="1000" y2="400" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="900" y1="300" x2="1100" y2="450" marker-end="url(#arrowhead)" />

            <!-- Service connections -->
            <line class="graph-edge" x1="700" y1="200" x2="850" y2="150" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="200" x2="950" y2="200" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="200" x2="800" y2="600" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="200" x2="900" y2="650" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="200" x2="1000" y2="700" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="200" x2="1100" y2="720" marker-end="url(#arrowhead)" />
            <line class="graph-edge" x1="700" y1="200" x2="1200" y2="680" marker-end="url(#arrowhead)" />
          </g>

          <!-- Nodes -->
          <g class="graph-nodes">
            <!-- Central Hub: Home -->
            <g class="graph-node hub" onclick="window.location.href='/'">
              <circle cx="700" cy="400" />
              <text class="node-icon" x="700" y="385">home</text>
              <text class="node-label" x="700" y="415">Home</text>
            </g>

            <!-- Main Hubs -->
            <g class="graph-node hub" onclick="window.location.href='/companies/'">
              <circle cx="500" cy="300" />
              <text class="node-icon" x="500" y="285">business</text>
              <text class="node-label" x="500" y="315">Companies</text>
            </g>

            <g class="graph-node hub" onclick="window.location.href='/Calc/'">
              <circle cx="900" cy="300" />
              <text class="node-icon" x="900" y="285">calculate</text>
              <text class="node-label" x="900" y="315">Calculators</text>
            </g>

            <g class="graph-node hub" onclick="window.location.href='/sitemap/'">
              <circle cx="700" cy="200" />
              <text class="node-icon" x="700" y="185">share</text>
              <text class="node-label" x="700" y="215">Site Graph</text>
            </g>

            <!-- Company Nodes -->
            <g class="graph-node company" onclick="window.location.href='/companies/rk-electrodes/'">
              <circle cx="350" cy="200" />
              <text class="node-icon" x="350" y="190">build</text>
              <text class="node-label" x="350" y="210">RK Electrodes</text>
            </g>

            <g class="graph-node company" onclick="window.location.href='/companies/rk-oxygen/'">
              <circle cx="450" cy="150" />
              <text class="node-icon" x="450" y="140">factory</text>
              <text class="node-label" x="450" y="160">RK Oxygen</text>
            </g>

            <g class="graph-node company" onclick="window.location.href='/companies/rk-palace/'">
              <circle cx="550" cy="150" />
              <text class="node-icon" x="550" y="140">apartment</text>
              <text class="node-label" x="550" y="160">RK Palace</text>
            </g>

            <g class="graph-node company" onclick="window.location.href='/companies/sand-creations/'">
              <circle cx="650" cy="200" />
              <text class="node-icon" x="650" y="190">brush</text>
              <text class="node-label" x="650" y="210">Sand Creations</text>
            </g>

            <!-- Branch Nodes -->
            <g class="graph-node branch" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/'">
              <circle cx="300" cy="100" />
              <text class="node-icon" x="300" y="95">location_city</text>
              <text class="node-label" x="300" y="110">Gorakhpur</text>
            </g>

            <g class="graph-node branch" onclick="window.location.href='/companies/rk-oxygen/lucknow/'">
              <circle cx="400" cy="50" />
              <text class="node-icon" x="400" y="45">location_city</text>
              <text class="node-label" x="400" y="60">Lucknow</text>
            </g>

            <!-- Calculator Nodes -->
            <g class="graph-node calculator" onclick="window.location.href='/Calc/GST/'">
              <circle cx="1050" cy="200" />
              <text class="node-icon" x="1050" y="190">receipt_long</text>
              <text class="node-label" x="1050" y="210">GST Calculator</text>
            </g>

            <g class="graph-node calculator" onclick="window.location.href='/Calc/EMI/'">
              <circle cx="1150" cy="250" />
              <text class="node-icon" x="1150" y="240">payments</text>
              <text class="node-label" x="1150" y="260">EMI Calculator</text>
            </g>

            <g class="graph-node calculator" onclick="window.location.href='/Calc/LIQ/'">
              <circle cx="1000" cy="400" />
              <text class="node-icon" x="1000" y="390">science</text>
              <text class="node-label" x="1000" y="410">Liquid Calculator</text>
            </g>

            <g class="graph-node calculator" onclick="window.location.href='/Calc/CI/'">
              <circle cx="1100" cy="450" />
              <text class="node-icon" x="1100" y="440">trending_up</text>
              <text class="node-label" x="1100" y="460">Compound Interest</text>
            </g>

            <!-- Service Nodes -->
            <g class="graph-node service" onclick="window.location.href='/search/'">
              <circle cx="850" cy="150" />
              <text class="node-icon" x="850" y="145">search</text>
              <text class="node-label" x="850" y="160">Search</text>
            </g>

            <g class="graph-node service" onclick="window.location.href='/contact/'">
              <circle cx="950" cy="200" />
              <text class="node-icon" x="950" y="195">contact_mail</text>
              <text class="node-label" x="950" y="210">Contact</text>
            </g>

            <g class="graph-node service" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/terms/'">
              <circle cx="800" cy="600" />
              <text class="node-icon" x="800" y="595">gavel</text>
              <text class="node-label" x="800" y="610">Terms</text>
            </g>

            <g class="graph-node service" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/privacy/'">
              <circle cx="900" cy="650" />
              <text class="node-icon" x="900" y="645">privacy_tip</text>
              <text class="node-label" x="900" y="660">Privacy</text>
            </g>

            <g class="graph-node service" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/refund-policy/'">
              <circle cx="1000" cy="700" />
              <text class="node-icon" x="1000" y="695">refund</text>
              <text class="node-label" x="1000" y="710">Refunds</text>
            </g>

            <g class="graph-node service" onclick="window.location.href='/companies/rk-oxygen/gorakhpur/shipping/'">
              <circle cx="1100" cy="720" />
              <text class="node-icon" x="1100" y="715">local_shipping</text>
              <text class="node-label" x="1100" y="730">Shipping</text>
            </g>

            <g class="graph-node service" onclick="window.location.href='/sitemap.xml'">
              <circle cx="1200" cy="680" />
              <text class="node-icon" x="1200" y="675">rss_feed</text>
              <text class="node-label" x="1200" y="690">XML Sitemap</text>
            </g>
          </g>
        </svg>
      </div>
    </div>

    <div style="text-align: center; margin-top: 2rem; padding: 1rem; background: var(--bg-elevated); border-radius: var(--mui-radius);">
      <h3 style="margin-bottom: 1rem; color: var(--text-primary);">Network Statistics</h3>
      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 1rem; margin-bottom: 1rem;">
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">4</div>
          <div style="color: var(--text-secondary);">Companies</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">6</div>
          <div style="color: var(--text-secondary);">Branches</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">4</div>
          <div style="color: var(--text-secondary);">Calculators</div>
        </div>
        <div>
          <div style="font-size: 2rem; font-weight: bold; color: var(--accent-primary);">15+</div>
          <div style="color: var(--text-secondary);">Pages</div>
        </div>
      </div>
      <p style="color: var(--text-secondary); font-size: 0.9rem;">
        Click any node to navigate • Hover for interactions • Explore our interconnected business network
      </p>
    </div>
  </div>
</div>

<script>
function showAllConnections() {
  document.querySelectorAll('.graph-edge').forEach(edge => {
    edge.style.opacity = '0.7';
    edge.style.strokeWidth = '2';
  });
  updateActiveButton('showAllConnections');
}

function highlightCompanies() {
  document.querySelectorAll('.graph-edge').forEach(edge => {
    edge.style.opacity = '0.2';
    edge.style.strokeWidth = '1';
  });
  // Highlight company-related edges
  const companyEdges = document.querySelectorAll('.graph-edge');
  companyEdges.forEach((edge, index) => {
    if (index < 8) { // First 8 edges are company-related
      edge.style.opacity = '1';
      edge.style.strokeWidth = '3';
    }
  });
  updateActiveButton('highlightCompanies');
}

function highlightCalculators() {
  document.querySelectorAll('.graph-edge').forEach(edge => {
    edge.style.opacity = '0.2';
    edge.style.strokeWidth = '1';
  });
  // Highlight calculator-related edges
  const calcEdges = document.querySelectorAll('.graph-edge');
  calcEdges.forEach((edge, index) => {
    if (index >= 8 && index < 12) { // Calculator edges
      edge.style.opacity = '1';
      edge.style.strokeWidth = '3';
    }
  });
  updateActiveButton('highlightCalculators');
}

function highlightServices() {
  document.querySelectorAll('.graph-edge').forEach(edge => {
    edge.style.opacity = '0.2';
    edge.style.strokeWidth = '1';
  });
  // Highlight service-related edges
  const serviceEdges = document.querySelectorAll('.graph-edge');
  serviceEdges.forEach((edge, index) => {
    if (index >= 12) { // Service edges
      edge.style.opacity = '1';
      edge.style.strokeWidth = '3';
    }
  });
  updateActiveButton('highlightServices');
}

function updateActiveButton(activeFunction) {
  document.querySelectorAll('.graph-btn').forEach(btn => {
    btn.classList.remove('active');
  });
  event.target.classList.add('active');
}
</script>