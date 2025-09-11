// site-links.js
// Centralized link references for navigation and footer

const RKOGKP = "rkoxygengkp"

const siteLinks = {
  home: "index.html",
  terms: `${RKOGKP}/terms.html`,
  refund: `${RKOGKP}/refund-policy.html`,
  gst: "Calc/GST/index.html",
  liq: "Calc/LIQ/index.html"
};

function setSiteLinks() {
  const linkMap = [
    { selector: '.nav-home', href: siteLinks.home },
    { selector: '.nav-terms', href: siteLinks.terms },
    { selector: '.nav-refund', href: siteLinks.refund },
    { selector: '.nav-gst', href: siteLinks.gst },
    { selector: '.nav-liq', href: siteLinks.liq }
  ];
  linkMap.forEach(link => {
    document.querySelectorAll(link.selector).forEach(el => {
      el.setAttribute('href', link.href);
    });
  });
}

document.addEventListener('DOMContentLoaded', setSiteLinks);
