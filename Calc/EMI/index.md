---
layout: default
title: EMI Calculator
---

<div class="jumbotron text-center">
  <h2>EMI Calculator</h2>
  <p>Calculate your monthly loan EMI, total interest, and total payment.</p>
</div>
<div class="container" style="max-width:600px;">
  <form oninput="calculateEMI()">
    <div class="form-group row">
      <label class="col-sm-5 col-form-label">Principal (Loan Amount)</label>
      <div class="col-sm-7">
        <input type="number" class="form-control" id="principal" placeholder="e.g. 500000" min="0" step="any">
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-5 col-form-label">Annual Interest Rate (%)</label>
      <div class="col-sm-7">
        <input type="number" class="form-control" id="rate" placeholder="e.g. 8.5" min="0" step="any">
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-5 col-form-label">Tenure (Months)</label>
      <div class="col-sm-7">
        <input type="number" class="form-control" id="months" placeholder="e.g. 60" min="1" step="1">
      </div>
    </div>
  </form>
  <hr>
  <div class="text-center">
    <h4>Results</h4>
    <div>EMI: <span id="emi">—</span></div>
    <div>Total Interest: <span id="interest">—</span></div>
    <div>Total Payment: <span id="total">—</span></div>
  </div>
</div>
<script>
function calculateEMI() {
  var P = parseFloat(document.getElementById('principal').value) || 0;
  var annualRate = parseFloat(document.getElementById('rate').value) || 0;
  var n = parseInt(document.getElementById('months').value) || 0;
  var r = annualRate / 12 / 100;
  var emi = 0, total = 0, interest = 0;
  if (P > 0 && r > 0 && n > 0) {
    emi = P * r * Math.pow(1 + r, n) / (Math.pow(1 + r, n) - 1);
    total = emi * n;
    interest = total - P;
  }
  document.getElementById('emi').textContent = emi > 0 ? emi.toLocaleString('en-IN', {maximumFractionDigits:2}) : '—';
  document.getElementById('interest').textContent = interest > 0 ? interest.toLocaleString('en-IN', {maximumFractionDigits:2}) : '—';
  document.getElementById('total').textContent = total > 0 ? total.toLocaleString('en-IN', {maximumFractionDigits:2}) : '—';
}
</script>
