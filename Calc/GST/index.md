---
layout: default
title: GST Calculator
---

<div class="mui-hero mui-hero--bleed">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">receipt_long</span>
    </div>
    <h1 class="mui-hero-title">GST Calculator</h1>
    <p class="mui-hero-subtitle">Calculator for taxes and base rates</p>
  </div>
</div>

<div class="mui-card">
  <p style="text-align:center;">Type a value in any of the following:</p>
  <div class="mui-grid" style="grid-template-columns: repeat(4, 1fr); align-items:center; text-align:center;">
    <label>Taxable amount</label>
    <label>Tax Rate</label>
    <label>Tax Amount</label>
    <label>Total</label>
  </div>
  <div class="mui-grid" style="grid-template-columns: repeat(4, 1fr); gap:12px; align-items:center; text-align:center;">
    <input id="5_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 5)">
    <label>5%</label>
    <input id="5_TAX" type="number" placeholder="TAX" oninput="Converter(this.value / .05, 5)">
    <input id="5_TOTAL" type="number" placeholder="TOTAL" oninput="Converter(this.value / 1.05, 5)">
  </div>
  <div class="mui-grid" style="grid-template-columns: repeat(4, 1fr); gap:12px; align-items:center; text-align:center;">
    <input id="12_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 12)">
    <label>12%</label>
    <input id="12_TAX" type="number" placeholder="TAX" oninput="Converter(this.value / .12, 12)">
    <input id="12_TOTAL" type="number" placeholder="TOTAL" oninput="Converter(this.value / 1.12, 12)">
  </div>
  <div class="mui-grid" style="grid-template-columns: repeat(4, 1fr); gap:12px; align-items:center; text-align:center;">
    <input id="18_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 18)">
    <label>18%</label>
    <input id="18_TAX" type="number" placeholder="TAX" oninput="Converter(this.value / .18, 18)">
    <input id="18_TOTAL" type="number" placeholder="TOTAL" oninput="Converter(this.value / 1.18, 18)">
  </div>
</div>
<script>
function Converter(val, rate) {
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
}
</script>
