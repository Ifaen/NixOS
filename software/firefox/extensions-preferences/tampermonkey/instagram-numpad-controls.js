// ==UserScript==
// @name         Instagram numpad controls
// @namespace    http://tampermonkey.net/
// @version      2025-02-19
// @description  Just an script to more easily navigate and download from Instagram. Instagram download buttons extension is required.
// @author       You
// @match        https://www.instagram.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=instagram.com
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  function pressButton(e, classes) {
    e.preventDefault();

    const button = document.querySelector(classes);
    if (button) {
      button.click(); // Simulate button click
    }
  }

  function findButtonByAriaLabel(classes, ariaLabel) {
    // Get all buttons with the specified classes
    const buttons = document.querySelectorAll(classes);

    // Loop through each button to find the one with the specified aria-label
    for (const button of buttons) {
      const svgTitle = button.querySelector(`svg[aria-label="${ariaLabel}"]`); // Check for the specific SVG with the given aria-label
      if (svgTitle) {
        button.click();
      }
    }
  }

  function giveLike() {
    findButtonByAriaLabel(
      ".x1i10hfl.x972fbf.xcfux6l.x1qhh985.xm0m39n.x9f619.xe8uvvx.xdj266r.x11i5rnm.xat24cr.x1mh8g0r.x16tdsg8.x1hl2dhg.xggy1nq.x1a2a7pz.x6s0dn4.xjbqb8w.x1ejq31n.xd10rxx.x1sy0etr.x17r0tee.x1ypdohk.x78zum5.xl56j7k.x1y1aw1k.x1sxyh0.xwib8y2.xurb0ha.xcdnw81",
      "Like"
    );
  }

  document.addEventListener("keydown", (e) => {
    if (e.code === "Numpad5") {
      //Find the download button
      const downloadButton = document.querySelector(".post-download-button");
      if (downloadButton) {
        downloadButton.click(); // Simulate button click
      }
      // If not found, press the download all button
      else {
        const downloadAll = document.querySelector(".post-download-all-button");
        if (downloadAll) {
          downloadAll.click(); // Simulate button click
        }
      }

      // Give like
      giveLike();

      // Unsave if needed
      findButtonByAriaLabel(
        ".x1i10hfl.x972fbf.xcfux6l.x1qhh985.xm0m39n.x9f619.xe8uvvx.xdj266r.x11i5rnm.xat24cr.x1mh8g0r.x16tdsg8.x1hl2dhg.xggy1nq.x1a2a7pz.x6s0dn4.xjbqb8w.x1ejq31n.xd10rxx.x1sy0etr.x17r0tee.x1ypdohk.x78zum5.xl56j7k.x1y1aw1k.x1sxyh0.xwib8y2.xurb0ha.xcdnw81",
        "Remove"
      );
    }

    // Give like
    if (e.code === "Numpad2") {
      giveLike();
    }

    // Previous page
    else if (e.code === "Numpad4") {
      findButtonByAriaLabel("._abl-", "Go back");
    }

    // Next page
    else if (e.code === "Numpad6") {
      findButtonByAriaLabel("._abl-", "Next");
    }

    // Previous Slide
    else if (e.code === "Numpad1") {
      pressButton(e, "._9zm0");
    }

    // Next slide
    else if (e.code === "Numpad3") {
      pressButton(e, "._9zm2");
    }
  });
})();
