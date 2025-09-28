---
layout: default
title: EMI Calculator
breadcrumbs:
  - name: Home
    url: /
  - name: Calculators
    url: /Calc/
  - name: EMI Calculator
    url: /Calc/EMI/
---

<div class="jumbotron text-center">
  <h2>EMI Calculator</h2>
  <p>Calculate your monthly loan EMI, total interest, and total payment.</p>
</div>
<div class="container" style="max-width:600px;">
  <div class="row">
    <div class="col-12">
      <form oninput="calculateEMI()" class="emi-form">
        <div class="form-group">
          <label for="principal">Principal (Loan Amount)</label>
          <input type="number" class="form-control" id="principal" placeholder="e.g. 500000" min="0" step="any">
        </div>
        <div class="form-group">
          <label for="rate">Annual Interest Rate (%)</label>
          <input type="number" class="form-control" id="rate" placeholder="e.g. 8.5" min="0" step="any">
        </div>
        <div class="form-group">
          <label for="months">Tenure (Months)</label>
          <input type="number" class="form-control" id="months" placeholder="e.g. 60" min="1" step="1">
        </div>
      </form>
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="col-12">
      <div class="text-center">
        <h4>Results</h4>
        <div id="emi-loading" class="emi-loading" style="display: none;">
          <div class="emi-loading-spinner"></div>
          <span>Calculating...</span>
        </div>
        <div id="emi-results" class="emi-results">
          <div class="result-item">
            <strong>EMI:</strong> <span id="emi">—</span>
          </div>
          <div class="result-item">
            <strong>Total Interest:</strong> <span id="interest">—</span>
          </div>
          <div class="result-item">
            <strong>Total Payment:</strong> <span id="total">—</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
function calculateEMI() {
  // Show loading state
  showEMILoading();

// Small delay to show loading state for better UX setTimeout(() => { var P =
parseFloat(document.getElementById('principal').value) || 0; var annualRate =
parseFloat(document.getElementById('rate').value) || 0; var n =
parseInt(document.getElementById('months').value) || 0; var r = annualRate / 12
/ 100; var emi = 0, total = 0, interest = 0; if (P > 0 && r > 0 && n > 0) { emi
= P _ r _ Math.pow(1 + r, n) / (Math.pow(1 + r, n) - 1); total = emi \* n;
interest = total - P; }

    document.getElementById('emi').textContent = emi > 0 ? emi.toLocaleString('en-IN', {maximumFractionDigits:2}) : '—';
    document.getElementById('interest').textContent = interest > 0 ? interest.toLocaleString('en-IN', {maximumFractionDigits:2}) : '—';
    document.getElementById('total').textContent = total > 0 ? total.toLocaleString('en-IN', {maximumFractionDigits:2}) : '—';

    // Hide loading state
    hideEMILoading();

}, 200); }

function showEMILoading() { const loadingEl =
document.getElementById('emi-loading'); const resultsEl =
document.getElementById('emi-results'); if (loadingEl) loadingEl.style.display =
'flex'; if (resultsEl) resultsEl.style.opacity = '0.5'; }

function hideEMILoading() { const loadingEl =
document.getElementById('emi-loading'); const resultsEl =
document.getElementById('emi-results'); if (loadingEl) loadingEl.style.display =
'none'; if (resultsEl) resultsEl.style.opacity = '1'; } } </script>

<!-- Print Enhancement Script -->
<script src="/assets/js/print-enhancements.min.js"></script>
