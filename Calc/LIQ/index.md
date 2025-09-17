---
layout: default
title: Liquid Oxygen Converter
---


<div class="mui-hero mui-hero--bleed">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">science</span>
    </div>
    <h1 class="mui-hero-title">Liquid Gas Universal Converter</h1>
    <p class="mui-hero-subtitle">Convert between KGS, TON, SM3, and LTR for O₂, N₂, and CO₂</p>
  </div>
</div>
<div class="mui-card" style="text-align:center;">
  <p>
    <label for="liqType">Select Liquid Type:</label>
    <select id="liqType" onchange="resetFields();">
      <option value="o2">Liquid O₂</option>
      <option value="n2">Liquid N₂</option>
      <option value="co2">Liquid CO₂</option>
    </select>
  </p>
  <p>Type a value in any of the following:</p>
  <p>
    <label>Kilogram (KGS)</label>
    <input id="KGS" type="number" placeholder="KGS" oninput="fromKGS(this.value)">
  </p>
  <p>
    <label>Ton (TON)</label>
    <input id="TON" type="number" placeholder="TON" oninput="fromTON(this.value)">
  </p>
  <p>
    <label>Standard metric cube (sm3)</label>
    <input id="SM3" type="number" placeholder="SM3" oninput="fromSM3(this.value)">
  </p>
  <p>
    <label>Liters (ltr)</label>
    <input id="LTR" type="number" placeholder="LTR" oninput="fromLTR(this.value)">
  </p>

</div>

<script>
// Conversion factors for each liquid type
const factors = {
  o2: { sm3: 0.77, ltr: 0.89 },
  n2: { sm3: 0.808, ltr: 0.808 },
  co2: { sm3: 1.53, ltr: 0.769 },
};
function getSelected() {
  return document.getElementById('liqType').value;
}
function fromKGS(val) {
  let v = parseFloat(val);
  if (isNaN(v)) v = 0;
  document.getElementById('TON').value = round(v / 1000);
  const f = factors[getSelected()];
  document.getElementById('SM3').value = round(v * f.sm3);
  document.getElementById('LTR').value = round(v * f.ltr);
}
function fromTON(val) {
  let v = parseFloat(val);
  if (isNaN(v)) v = 0;
  fromKGS(v * 1000);
  document.getElementById('KGS').value = round(v * 1000);
}
function fromSM3(val) {
  let v = parseFloat(val);
  if (isNaN(v)) v = 0;
  const f = factors[getSelected()];
  let kgs = v / f.sm3;
  document.getElementById('KGS').value = round(kgs);
  fromKGS(kgs);
}
function fromLTR(val) {
  let v = parseFloat(val);
  if (isNaN(v)) v = 0;
  const f = factors[getSelected()];
  let kgs = v / f.ltr;
  document.getElementById('KGS').value = round(kgs);
  fromKGS(kgs);
}
function resetFields() {
  document.getElementById('KGS').value = '';
  document.getElementById('TON').value = '';
  document.getElementById('SM3').value = '';
  document.getElementById('LTR').value = '';
}
function round(x) {
  return Math.round(x * 100) / 100;
}
</script>

---

## Liquid Gas Conversion Table

Select your liquid type and use the factors below to convert between units.

### Conversion Factors

| Liquid Type | 1 KGS = X SM3 | 1 KGS = X LTR | 1 SM3 = X KGS | 1 LTR = X KGS |
|-------------|:-------------:|:-------------:|:-------------:|:-------------:|
| Liquid O₂   | 0.77          | 0.89          | 1.30          | 1.12          |
| Liquid N₂   | 0.808         | 0.808         | 1.24          | 1.24          |
| Liquid CO₂  | 1.53          | 0.769         | 0.65          | 1.30          |

### How to Use

- **To convert KGS to SM3:** Multiply KGS by the SM3 factor for your liquid.
- **To convert KGS to LTR:** Multiply KGS by the LTR factor for your liquid.
- **To convert SM3 to KGS:** Multiply SM3 by the KGS per SM3 factor (see table).
- **To convert LTR to KGS:** Multiply LTR by the KGS per LTR factor (see table).

#### Example

- 100 KGS of Liquid O₂ = 100 × 0.77 = 77 SM3
- 100 KGS of Liquid O₂ = 100 × 0.89 = 89 LTR

---

*For an interactive version, use the web calculator above this table.*
