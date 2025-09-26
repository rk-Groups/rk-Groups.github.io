---
layout: default
title: GST Calculator
breadcrumbs:
  - name: Home
    url: /
  - name: Calculators
    url: /Calc/
  - name: GST Calculator
    url: /Calc/GST/
---

<div class="mui-hero mui-hero--bleed">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">receipt_long</span>
    </div>
    <h1 class="mui-hero-title">GST Calculator</h1>
    <p class="mui-hero-subtitle">Calculate GST amounts and base rates for different tax slabs</p>
  </div>
</div>

<!-- Calculator Section -->
<div class="mui-card">
  <div class="mui-container">
    <h2 class="mui-section-title">GST Calculator</h2>
    <p class="mui-text-center">Type a value in any of the following fields to calculate GST amounts:</p>

    <div class="mui-calculator-grid">
      <div class="mui-calculator-header">
        <div>Taxable Amount</div>
        <div>Tax Rate</div>
        <div>Tax Amount</div>
        <div>Total Amount</div>
      </div>

      <!-- 5% GST -->
      <div class="mui-calculator-row">
        <input id="5_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 5)" class="gst-input">
        <div class="mui-calculator-label">5%</div>
        <input id="5_TAX" type="number" placeholder="TAX" oninput="Converter(this.value / .05, 5)" class="gst-input">
        <input id="5_TOTAL" type="number" placeholder="TOTAL" oninput="Converter(this.value / 1.05, 5)" class="gst-input">
      </div>

      <!-- 12% GST -->
      <div class="mui-calculator-row">
        <input id="12_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 12)" class="gst-input">
        <div class="mui-calculator-label">12%</div>
        <input id="12_TAX" type="number" placeholder="TAX" oninput="Converter(this.value / .12, 12)" class="gst-input">
        <input id="12_TOTAL" type="number" placeholder="TOTAL" oninput="Converter(this.value / 1.12, 12)" class="gst-input">
      </div>

      <!-- 18% GST -->
      <div class="mui-calculator-row">
        <input id="18_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 18)" class="gst-input">
        <div class="mui-calculator-label">18%</div>
        <input id="18_TAX" type="number" placeholder="TAX" oninput="Converter(this.value / .18, 18)" class="gst-input">
        <input id="18_TOTAL" type="number" placeholder="TOTAL" oninput="Converter(this.value / 1.18, 18)" class="gst-input">
      </div>

      <!-- 28% GST -->
      <div class="mui-calculator-row">
        <input id="28_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 28)" class="gst-input">
        <div class="mui-calculator-label">28%</div>
        <input id="28_TAX" type="number" placeholder="TAX" oninput="Converter(this.value / .28, 28)" class="gst-input">
        <input id="28_TOTAL" type="number" placeholder="TOTAL" oninput="Converter(this.value / 1.28, 28)" class="gst-input">
      </div>
    </div>

    <div id="gst-loading" class="gst-loading" style="display: none;">
      <div class="gst-loading-spinner"></div>
      Calculating...
    </div>
  </div>
</div>

<!-- Instructions Section -->
<div class="mui-card">
  <div class="mui-container">
    <h2 class="mui-section-title">How to Use</h2>
    <div class="mui-info-grid">
      <div class="mui-info-item">
        <strong>Taxable Amount:</strong>
        <span>Enter the base price before GST</span>
      </div>
      <div class="mui-info-item">
        <strong>Tax Amount:</strong>
        <span>Enter the GST amount to calculate base price</span>
      </div>
      <div class="mui-info-item">
        <strong>Total Amount:</strong>
        <span>Enter the final price including GST</span>
      </div>
      <div class="mui-info-item">
        <strong>Tax Rate:</strong>
        <span>Select from standard GST rates (5%, 12%, 18%, 28%)</span>
      </div>
    </div>
  </div>
</div>
    <span>Calculating...</span>
  </div>
</div>
<script>
function Converter(val, rate) {
  // Show loading state
  showLoading();

  // Small delay to show loading state for better UX
  setTimeout(() => {
    // Get all input fields for the selected rate
    var taxable = document.getElementById(rate + '_TAXABLE');
    var tax = document.getElementById(rate + '_TAX');
    var total = document.getElementById(rate + '_TOTAL');

    // Determine which field triggered the event
    var source = event.target.id;

    // Track calculator usage
    if (window.RKAnalytics && val && parseFloat(val) > 0) {
      window.RKAnalytics.trackCalculator('GST', 'calculate', {
        rate: rate,
        inputType: source.includes('TAXABLE') ? 'taxable' : source.includes('TAX') ? 'tax' : 'total',
        amount: parseFloat(val)
      });
    }

    if (source === rate + '_TAXABLE') {
      // User entered taxable amount
      var t = parseFloat(val) || 0;
      var taxAmt = +(t * (rate / 100)).toFixed(2);
      var tot = +(t + taxAmt).toFixed(2);
      tax.value = taxAmt;
      total.value = tot;
    } else if (source === rate + '_TAX') {
      // User entered tax amount
      var taxAmt = parseFloat(val) || 0;
      var t = +(taxAmt / (rate / 100)).toFixed(2);
      var tot = +(t + taxAmt).toFixed(2);
      taxable.value = t;
      total.value = tot;
    } else if (source === rate + '_TOTAL') {
      // User entered total amount
      var tot = parseFloat(val) || 0;
      var t = +(tot / (1 + rate / 100)).toFixed(2);
      var taxAmt = +(tot - t).toFixed(2);
      taxable.value = t;
      tax.value = taxAmt;
    }

    // Hide loading state
    hideLoading();
  }, 150);
}

function showLoading() {
  const loadingEl = document.getElementById('gst-loading');
  if (loadingEl) {
    loadingEl.style.display = 'flex';
  }
}

function hideLoading() {
  const loadingEl = document.getElementById('gst-loading');
  if (loadingEl) {
    loadingEl.style.display = 'none';
  }
}
</script>
