---
layout: default
title: Our Companies Network
---


# Our Companies Network

Welcome to the RK Groups company network. Below you’ll find an overview of all companies and branches in the group.

<div class="row">
  {% for company_key in site.data.companies %}
    {% assign company = site.data.companies[company_key[0]] %}
    <div class="col-md-6">
      <div class="panel panel-default">
        <div class="panel-heading"><strong>{{ company.main.name | default: company_key[0] | replace: '-', ' ' | capitalize }}</strong></div>
        <div class="panel-body">
          {% if company.main %}
            <a href="/companies/{{ company_key[0] }}/">Main Page</a><br>
            <a href="/companies/{{ company_key[0] }}/terms.md">Terms of Service</a> | <a href="/companies/{{ company_key[0] }}/refund-policy.md">Refund Policy</a><br>
          {% endif %}
          {% for branch_key in company %}
            {% if branch_key[0] != 'main' %}
              <a href="/companies/{{ company_key[0] }}/{{ branch_key[0] }}/">{{ branch_key[0] | capitalize }} Branch</a><br>
              <a href="/companies/{{ company_key[0] }}/{{ branch_key[0] }}/terms.md">Terms of Service</a> | <a href="/companies/{{ company_key[0] }}/{{ branch_key[0] }}/refund-policy.md">Refund Policy</a><br>
            {% endif %}
          {% endfor %}
        </div>
      </div>
    </div>
  {% endfor %}
</div>
