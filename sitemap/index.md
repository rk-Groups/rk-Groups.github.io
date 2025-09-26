---
layout: default
title: Site Tree - RK Groups Network
description: Interactive neural network-style site tree showing the complete RK Groups website structure and page connections.
---

<style>
/* Neural Network Site Tree Styles */
.neural-network {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  font-family: 'Roboto', sans-serif;
}

.neural-layers {
  display: flex;
  justify-content: space-between;
  align-items: center;
  min-height: 600px;
  position: relative;
  margin: 2rem 0;
}

.neural-layer {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  z-index: 2;
}

.layer-title {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 1rem;
  text-align: center;
  padding: 0.5rem 1rem;
  background: var(--bg-elevated);
  border-radius: var(--mui-radius);
  border: 1px solid var(--border-primary);
}

.neural-node {
  width: 120px;
  min-height: 60px;
  padding: 0.75rem;
  background: var(--bg-elevated);
  border: 2px solid var(--accent-primary);
  border-radius: var(--mui-radius);
  text-align: center;
  transition: all 0.3s ease;
  position: relative;
  box-shadow: var(--shadow-sm);
  cursor: pointer;
}

.neural-node:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
  border-color: var(--accent-secondary);
}

.neural-node.primary {
  background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
  color: white;
  border-color: var(--accent-primary);
}

.neural-node.secondary {
  border-color: var(--text-secondary);
}

.neural-node.leaf {
  width: 100px;
  min-height: 50px;
  padding: 0.5rem;
  font-size: 0.9rem;
  border-color: var(--border-primary);
}

.neural-node a {
  color: inherit;
  text-decoration: none;
  display: block;
  font-weight: 500;
}

.neural-node a:hover {
  text-decoration: underline;
}

.neural-connections {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.connection-line {
  position: absolute;
  background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
  border-radius: 2px;
  opacity: 0.6;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 0.4; }
  50% { opacity: 0.8; }
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .neural-layers {
    flex-direction: column;
    gap: 2rem;
    min-height: auto;
  }

  .neural-layer {
    width: 100%;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
  }

  .neural-connections {
    display: none; /* Hide connections on mobile for clarity */
  }
}

.legend {
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

.legend-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.legend-dot.primary { background: var(--accent-primary); }
.legend-dot.secondary { background: var(--text-secondary); }
.legend-dot.leaf { background: var(--border-primary); }
</style>

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">hub</span>
    </div>
    <h1 class="mui-hero-title">RK Groups Network</h1>
    <p class="mui-hero-subtitle">Interactive site tree showing our interconnected business ecosystem</p>
  </div>
</div>

<div class="content-section">
  <div class="mui-card">
    <div class="legend">
      <div class="legend-item">
        <div class="legend-dot primary"></div>
        <span>Main Hubs</span>
      </div>
      <div class="legend-item">
        <div class="legend-dot secondary"></div>
        <span>Company Branches</span>
      </div>
      <div class="legend-item">
        <div class="legend-dot leaf"></div>
        <span>Service Pages</span>
      </div>
    </div>

    <div class="neural-network">
      <div class="neural-layers">
        <!-- Input Layer -->
        <div class="neural-layer">
          <div class="layer-title">Entry Points</div>
          <div class="neural-node primary">
            <a href="/">
              <span class="material-icons" style="font-size: 1.5rem;">home</span><br>
              Home
            </a>
          </div>
          <div class="neural-node primary">
            <a href="/companies/">
              <span class="material-icons" style="font-size: 1.5rem;">business</span><br>
              Companies
            </a>
          </div>
          <div class="neural-node primary">
            <a href="/Calc/">
              <span class="material-icons" style="font-size: 1.5rem;">calculate</span><br>
              Calculators
            </a>
          </div>
        </div>

        <!-- Hidden Layer 1: Company Categories -->
        <div class="neural-layer">
          <div class="layer-title">Business Divisions</div>
          <div class="neural-node secondary">
            <a href="/companies/rk-electrodes/">
              <span class="material-icons" style="font-size: 1.2rem;">build</span><br>
              RK Electrodes
            </a>
          </div>
          <div class="neural-node secondary">
            <a href="/companies/rk-oxygen/">
              <span class="material-icons" style="font-size: 1.2rem;">factory</span><br>
              RK Oxygen
            </a>
          </div>
          <div class="neural-node secondary">
            <a href="/companies/rk-palace/">
              <span class="material-icons" style="font-size: 1.2rem;">apartment</span><br>
              RK Palace
            </a>
          </div>
          <div class="neural-node secondary">
            <a href="/companies/sand-creations/">
              <span class="material-icons" style="font-size: 1.2rem;">brush</span><br>
              Sand Creations
            </a>
          </div>
        </div>

        <!-- Hidden Layer 2: Branches & Calculators -->
        <div class="neural-layer">
          <div class="layer-title">Branches & Tools</div>
          <!-- RK Oxygen Branches -->
          <div class="neural-node secondary">
            <a href="/companies/rk-oxygen/gorakhpur/">
              <span class="material-icons" style="font-size: 1.2rem;">location_city</span><br>
              Gorakhpur
            </a>
          </div>
          <div class="neural-node secondary">
            <a href="/companies/rk-oxygen/lucknow/">
              <span class="material-icons" style="font-size: 1.2rem;">location_city</span><br>
              Lucknow
            </a>
          </div>
          <!-- Calculators -->
          <div class="neural-node secondary">
            <a href="/Calc/GST/">
              <span class="material-icons" style="font-size: 1.2rem;">receipt_long</span><br>
              GST Calc
            </a>
          </div>
          <div class="neural-node secondary">
            <a href="/Calc/EMI/">
              <span class="material-icons" style="font-size: 1.2rem;">payments</span><br>
              EMI Calc
            </a>
          </div>
          <div class="neural-node secondary">
            <a href="/Calc/LIQ/">
              <span class="material-icons" style="font-size: 1.2rem;">science</span><br>
              Liquid Calc
            </a>
          </div>
          <div class="neural-node secondary">
            <a href="/Calc/CI/">
              <span class="material-icons" style="font-size: 1.2rem;">trending_up</span><br>
              CI Calc
            </a>
          </div>
        </div>

        <!-- Output Layer: Service Pages -->
        <div class="neural-layer">
          <div class="layer-title">Services & Legal</div>
          <div class="neural-node leaf">
            <a href="/contact/">
              <span class="material-icons" style="font-size: 1rem;">contact_mail</span><br>
              Contact
            </a>
          </div>
          <div class="neural-node leaf">
            <a href="/search/">
              <span class="material-icons" style="font-size: 1rem;">search</span><br>
              Search
            </a>
          </div>
          <div class="neural-node leaf">
            <a href="/companies/rk-oxygen/gorakhpur/terms/">
              <span class="material-icons" style="font-size: 1rem;">gavel</span><br>
              Terms
            </a>
          </div>
          <div class="neural-node leaf">
            <a href="/companies/rk-oxygen/gorakhpur/privacy/">
              <span class="material-icons" style="font-size: 1rem;">privacy_tip</span><br>
              Privacy
            </a>
          </div>
          <div class="neural-node leaf">
            <a href="/companies/rk-oxygen/gorakhpur/refund-policy/">
              <span class="material-icons" style="font-size: 1rem;">refund</span><br>
              Refunds
            </a>
          </div>
          <div class="neural-node leaf">
            <a href="/companies/rk-oxygen/gorakhpur/shipping/">
              <span class="material-icons" style="font-size: 1rem;">local_shipping</span><br>
              Shipping
            </a>
          </div>
          <div class="neural-node leaf">
            <a href="/sitemap.xml">
              <span class="material-icons" style="font-size: 1rem;">rss_feed</span><br>
              XML Map
            </a>
          </div>
        </div>

        <!-- Neural Connections (Visual Lines) -->
        <div class="neural-connections">
          <!-- Input to Business Divisions connections -->
          <div class="connection-line" style="top: 20%; left: 16%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 35%; left: 16%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 50%; left: 16%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 65%; left: 16%; width: 18%; height: 2px; transform: rotate(0deg);"></div>

          <!-- Business Divisions to Branches/Tools connections -->
          <div class="connection-line" style="top: 25%; left: 38%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 40%; left: 38%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 55%; left: 38%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 70%; left: 38%; width: 18%; height: 2px; transform: rotate(0deg);"></div>

          <!-- Branches/Tools to Services connections -->
          <div class="connection-line" style="top: 15%; left: 60%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 30%; left: 60%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 45%; left: 60%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 60%; left: 60%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
          <div class="connection-line" style="top: 75%; left: 60%; width: 18%; height: 2px; transform: rotate(0deg);"></div>
        </div>
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
        Explore our interconnected business network - from industrial supplies to financial tools
      </p>
    </div>
  </div>
</div>