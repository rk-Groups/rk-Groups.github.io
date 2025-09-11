---
layout: default
title: GST Calculator
---

<div class="jumbotron text-center">
  <h2>Calculator for taxes and base rates</h2>
</div>
<div class="text-center container">
  <p>Type a value in any of the following:</p>
  <div class="row">
    <label class="col-md-2">Taxable amount</label>
    <label class="col-md-2">Tax Rate</label>
    <label class="col-md-2">Tax Amount</label>
    <label class="col-md-2">Total</label>
  </div>
  <div class="row">
    <input class="col-md-2" id="5_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 5)">
    <label class="col-md-2">5%</label>
    <input class="col-md-2" id="5_TAX" type="number" placeholder="TAXABLE" oninput="Converter(this.value / .05, 5)">
    <input class="col-md-2" id="5_TOTAL" type="number" placeholder="TAXABLE" oninput="Converter(this.value / 1.05, 5)">
  </div>
  <div class="row">
    <input class="col-md-2" id="12_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 12)">
    <label class="col-md-2">12%</label>
    <input class="col-md-2" id="12_TAX" type="number" placeholder="TAXABLE" oninput="Converter(this.value / .12, 12)">
    <input class="col-md-2" id="12_TOTAL" type="number" placeholder="TAXABLE" oninput="Converter(this.value / 1.12, 12)">
  </div>
  <div class="row">
    <input class="col-md-2" id="18_TAXABLE" type="number" placeholder="TAXABLE" oninput="Converter(this.value, 18)">
    <label class="col-md-2">18%</label>
    <input class="col-md-2" id="18_TAX" type="number" placeholder="TAXABLE" oninput="Converter(this.value / .18, 18)">
    <input class="col-md-2" id="18_TOTAL" type="number" placeholder="TAXABLE" oninput="Converter(this.value / 1.18, 18)">
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
