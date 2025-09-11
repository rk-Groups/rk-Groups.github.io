---
layout: default
title: RK Electrodes
---

{% assign details = site.data.companies.rk-electrodes.main %}

**Branch:** {{ details.branch }}
**GSTIN:** {{ details.gstin }}
**Constitution:** {{ details.constitution }}
**Principal Place of Business:**
{{ details.principal_place }}
{% if details.branch_address %}
**Branch Address:** {{ details.branch_address }}
{% endif %}
{% if details.proprietor %}
**Proprietor:** {{ details.proprietor }}
{% endif %}
{% if details.partners and details.partners.size > 0 %}
**Partners:** {{ details.partners | join: ', ' }}
{% endif %}
**Contact Email:** [{{ details.contact.email }}](mailto:{{ details.contact.email }})
**Contact Phone:**
[{{ details.contact.phone }}](tel:
{{ details.contact.phone }})
