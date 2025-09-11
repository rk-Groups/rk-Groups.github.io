---
layout: default
title: RK Oxygen - Gorakhpur Branch
---

{% assign details = site.data.companies.rk-oxygen.gorakhpur %}

# RK Oxygen — Gorakhpur Branch

<div class="panel panel-default">
	<div class="panel-heading"><strong>Switch Branch</strong></div>
	<div class="panel-body">
		<a class="btn btn-primary btn-sm" href="/companies/rk-oxygen/gorakhpur/">Gorakhpur</a>
		<a class="btn btn-default btn-sm" href="/companies/rk-oxygen/lucknow/">Lucknow</a>
	</div>
</div>

<table class="table table-bordered" style="max-width:600px;">
	<tr><th>GSTIN</th><td>{{ details.gstin }}</td></tr>
	<tr><th>Constitution</th><td>{{ details.constitution }}</td></tr>
	<tr><th>Principal Place</th><td>{{ details.principal_place }}</td></tr>
	{% if details.branch_address %}
		<tr><th>Branch Address</th><td>{{ details.branch_address }}</td></tr>
	{% endif %}
	{% if details.proprietor %}
		<tr><th>Proprietor</th><td>{{ details.proprietor }}</td></tr>
	{% endif %}
	{% if details.partners and details.partners.size > 0 %}
		<tr><th>Partners</th><td>{{ details.partners | join: ', ' }}</td></tr>
	{% endif %}
	<tr><th>Contact Email</th><td><a href="mailto:{{ details.contact.email }}">{{ details.contact.email }}</a></td></tr>
	{% if details.contact.phone %}
		<tr><th>Contact Phone</th><td><a href="tel:{{ details.contact.phone }}">{{ details.contact.phone }}</a></td></tr>
	{% endif %}
</table>
