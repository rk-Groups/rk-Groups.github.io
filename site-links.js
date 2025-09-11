// site-links.js
// Centralized link references for navigation and footer


const RK_OXYGEN_GKP = "/companies/rk-oxygen/gorakhpur";

const siteLinks = {
  home: "/index.html",
  terms: `${RK_OXYGEN_GKP}/terms.html`,
  refund: `${RK_OXYGEN_GKP}/refund-policy.html`,
  gst: "/Calc/GST/index.html",
  liq: "/Calc/LIQ/index.html"
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

// If topbar is loaded dynamically, wait for it before setting links
function setLinksWhenReady() {
  // Try to set links, and if nav is not present, retry a few times
  let tries = 0;
  function trySet() {
    setSiteLinks();
    // If nav links are present, we're done
    if (document.querySelector('.nav-home')) return;
    if (++tries < 10) setTimeout(trySet, 100);
  }
  trySet();
}

document.addEventListener('DOMContentLoaded', setLinksWhenReady);
