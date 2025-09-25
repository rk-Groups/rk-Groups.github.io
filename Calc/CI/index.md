---
layout: default
title: Compound Interest Calculator
description: Calculate compound interest for investments, savings, and loans with detailed breakdown and growth visualization.
---

<div class="mui-hero mui-hero--bleed">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">trending_up</span>
    </div>
    <h1 class="mui-hero-title">Compound Interest Calculator</h1>
    <p class="mui-hero-subtitle">Calculate investment growth and loan compound interest</p>
  </div>
</div>

<div class="mui-features-grid" style="grid-template-columns: 1fr 1fr; gap: 2rem; align-items: start;">
  <!-- Calculator Input -->
  <div class="mui-card">
    <h3>Investment Details</h3>
    <div style="display: grid; gap: 1rem;">
      <div>
        <label for="principal" style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--text);">Principal Amount (₹)</label>
        <input type="number" id="principal" value="100000" min="0" step="1000" 
               style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-primary); border-radius: var(--mui-radius); background: var(--bg-elevated); color: var(--text);">
      </div>
      
      <div>
        <label for="rate" style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--text);">Annual Interest Rate (%)</label>
        <input type="number" id="rate" value="8" min="0" max="50" step="0.1" 
               style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-primary); border-radius: var(--mui-radius); background: var(--bg-elevated); color: var(--text);">
      </div>
      
      <div>
        <label for="time" style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--text);">Time Period (Years)</label>
        <input type="number" id="time" value="10" min="0" max="50" step="0.5" 
               style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-primary); border-radius: var(--mui-radius); background: var(--bg-elevated); color: var(--text);">
      </div>
      
      <div>
        <label for="compound" style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--text);">Compounding Frequency</label>
        <select id="compound" style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-primary); border-radius: var(--mui-radius); background: var(--bg-elevated); color: var(--text);">
          <option value="1">Annually</option>
          <option value="2">Semi-Annually</option>
          <option value="4" selected>Quarterly</option>
          <option value="12">Monthly</option>
          <option value="365">Daily</option>
        </select>
      </div>
      
      <div>
        <label for="addition" style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--text);">Monthly Addition (₹)</label>
        <input type="number" id="addition" value="0" min="0" step="500" 
               style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-primary); border-radius: var(--mui-radius); background: var(--bg-elevated); color: var(--text);">
        <small style="color: var(--text-secondary);">Optional: Additional monthly contributions</small>
      </div>
      
      <button onclick="calculateCompoundInterest()" class="mui-btn mui-btn--primary" style="margin-top: 1rem;">
        <span class="material-icons">calculate</span>
        Calculate Interest
      </button>
    </div>
  </div>

  <!-- Results -->
  <div class="mui-card">
    <h3>Results</h3>
    <div id="results" style="display: none;">
      <div class="mui-info-grid" style="gap: 1rem;">
        <div class="mui-info-item">
          <strong>Final Amount:</strong>
          <span id="finalAmount" style="color: var(--accent-success); font-weight: 600; font-size: 1.2rem;"></span>
        </div>
        <div class="mui-info-item">
          <strong>Total Interest:</strong>
          <span id="totalInterest" style="color: var(--accent-primary); font-weight: 600;"></span>
        </div>
        <div class="mui-info-item">
          <strong>Principal Amount:</strong>
          <span id="principalDisplay"></span>
        </div>
        <div class="mui-info-item">
          <strong>Total Contributions:</strong>
          <span id="totalContributions"></span>
        </div>
        <div class="mui-info-item">
          <strong>Effective Annual Rate:</strong>
          <span id="effectiveRate"></span>
        </div>
      </div>
      
      <div style="margin-top: 2rem; padding: 1rem; background: var(--bg-elevated); border-radius: var(--mui-radius);">
        <h4 style="margin: 0 0 1rem 0; color: var(--text);">Growth Breakdown</h4>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; font-size: 0.9rem;">
          <div>
            <strong>Interest Earned:</strong><br>
            <span id="interestPercent" style="color: var(--accent-primary);"></span>
          </div>
          <div>
            <strong>Principal + Contributions:</strong><br>
            <span id="principalPercent" style="color: var(--text-secondary);"></span>
          </div>
        </div>
      </div>
    </div>
    
    <div id="placeholder" style="text-align: center; color: var(--text-secondary); padding: 2rem 0;">
      <span class="material-icons" style="font-size: 3rem; opacity: 0.5; margin-bottom: 1rem; display: block;">analytics</span>
      Enter your investment details to see compound interest calculations
    </div>
  </div>
</div>

<!-- Year-by-Year Breakdown -->
<div class="mui-card" style="margin-top: 2rem;">
  <h3>Year-by-Year Growth</h3>
  <div id="yearlyBreakdown" style="display: none;">
    <div style="overflow-x: auto;">
      <table style="width: 100%; border-collapse: collapse; margin-top: 1rem;">
        <thead>
          <tr style="background: var(--bg-elevated);">
            <th style="padding: 0.75rem; text-align: left; border-bottom: 1px solid var(--border-primary);">Year</th>
            <th style="padding: 0.75rem; text-align: right; border-bottom: 1px solid var(--border-primary);">Principal</th>
            <th style="padding: 0.75rem; text-align: right; border-bottom: 1px solid var(--border-primary);">Interest</th>
            <th style="padding: 0.75rem; text-align: right; border-bottom: 1px solid var(--border-primary);">Total</th>
          </tr>
        </thead>
        <tbody id="yearlyTable">
          <!-- Populated by JavaScript -->
        </tbody>
      </table>
    </div>
  </div>
  
  <div id="yearlyPlaceholder" style="text-align: center; color: var(--text-secondary); padding: 2rem 0;">
    <span class="material-icons" style="font-size: 3rem; opacity: 0.5; margin-bottom: 1rem; display: block;">table_chart</span>
    Calculate to see detailed yearly breakdown
  </div>
</div>

<script>
function calculateCompoundInterest() {
  // Get input values
  const P = parseFloat(document.getElementById('principal').value) || 0;
  const r = parseFloat(document.getElementById('rate').value) / 100 || 0;
  const t = parseFloat(document.getElementById('time').value) || 0;
  const n = parseFloat(document.getElementById('compound').value) || 4;
  const monthlyAddition = parseFloat(document.getElementById('addition').value) || 0;
  
  if (P <= 0 || r < 0 || t <= 0) {
    alert('Please enter valid positive values for all fields.');
    return;
  }
  
  // Calculate compound interest with monthly additions
  let yearlyData = [];
  let currentPrincipal = P;
  let totalInterest = 0;
  let totalContributions = monthlyAddition * 12 * t;
  
  for (let year = 1; year <= Math.ceil(t); year++) {
    const yearTime = year <= t ? 1 : t - Math.floor(t);
    const monthsInYear = year <= t ? 12 : (t - Math.floor(t)) * 12;
    
    // Add monthly contributions for this year
    const yearlyContribution = monthlyAddition * monthsInYear;
    currentPrincipal += yearlyContribution;
    
    // Calculate compound interest for this year
    const yearEndAmount = currentPrincipal * Math.pow(1 + r/n, n * yearTime);
    const yearInterest = yearEndAmount - currentPrincipal;
    
    yearlyData.push({
      year: year,
      principal: currentPrincipal,
      interest: yearInterest,
      total: yearEndAmount
    });
    
    totalInterest += yearInterest;
    currentPrincipal = yearEndAmount;
    
    if (year >= Math.ceil(t)) break;
  }
  
  const finalAmount = currentPrincipal;
  const effectiveRate = Math.pow(finalAmount / (P + totalContributions), 1/t) - 1;
  
  // Display results
  document.getElementById('finalAmount').textContent = '₹' + finalAmount.toLocaleString('en-IN', {maximumFractionDigits: 0});
  document.getElementById('totalInterest').textContent = '₹' + totalInterest.toLocaleString('en-IN', {maximumFractionDigits: 0});
  document.getElementById('principalDisplay').textContent = '₹' + P.toLocaleString('en-IN');
  document.getElementById('totalContributions').textContent = '₹' + (P + totalContributions).toLocaleString('en-IN');
  document.getElementById('effectiveRate').textContent = (effectiveRate * 100).toFixed(2) + '%';
  
  const interestPercentage = (totalInterest / finalAmount * 100);
  const principalPercentage = ((P + totalContributions) / finalAmount * 100);
  
  document.getElementById('interestPercent').textContent = interestPercentage.toFixed(1) + '% of final amount';
  document.getElementById('principalPercent').textContent = principalPercentage.toFixed(1) + '% of final amount';
  
  // Show results
  document.getElementById('results').style.display = 'block';
  document.getElementById('placeholder').style.display = 'none';
  
  // Generate yearly breakdown table
  const tableBody = document.getElementById('yearlyTable');
  tableBody.innerHTML = yearlyData.map(data => `
    <tr>
      <td style="padding: 0.75rem; border-bottom: 1px solid var(--border-primary);">${data.year}</td>
      <td style="padding: 0.75rem; text-align: right; border-bottom: 1px solid var(--border-primary);">₹${data.principal.toLocaleString('en-IN', {maximumFractionDigits: 0})}</td>
      <td style="padding: 0.75rem; text-align: right; border-bottom: 1px solid var(--border-primary); color: var(--accent-primary);">₹${data.interest.toLocaleString('en-IN', {maximumFractionDigits: 0})}</td>
      <td style="padding: 0.75rem; text-align: right; border-bottom: 1px solid var(--border-primary); font-weight: 600;">₹${data.total.toLocaleString('en-IN', {maximumFractionDigits: 0})}</td>
    </tr>
  `).join('');
  
  document.getElementById('yearlyBreakdown').style.display = 'block';
  document.getElementById('yearlyPlaceholder').style.display = 'none';
}

// Auto-calculate on input change
['principal', 'rate', 'time', 'compound', 'addition'].forEach(id => {
  document.getElementById(id).addEventListener('input', () => {
    if (document.getElementById('results').style.display !== 'none') {
      calculateCompoundInterest();
    }
  });
});

// Calculate on page load with default values
window.addEventListener('load', () => {
  calculateCompoundInterest();
});
</script>

<style>
.mui-info-item {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  padding: 0.75rem 0;
  border-bottom: 1px solid var(--border-primary);
}

.mui-info-item:last-child {
  border-bottom: none;
}

@media (max-width: 768px) {
  .mui-features-grid[style*="1fr 1fr"] {
    grid-template-columns: 1fr !important;
  }
  
  .mui-info-item {
    grid-template-columns: 1fr;
    gap: 0.25rem;
  }
}
</style>