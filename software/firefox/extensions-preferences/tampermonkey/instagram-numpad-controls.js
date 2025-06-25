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

  function simulateKeyPress(e, key, code) {
    e.preventDefault();

    const event = new KeyboardEvent("keydown", {
      key: key,
      code: code,
      bubbles: true,
      composed: true,
    });

    document.activeElement.dispatchEvent(event);
  }

  function clickLikeButton() {
    // Step 1: Find the post <section>
    const postSection = document.querySelector(
      'section.x78zum5.x1q0g3np.xwib8y2.x1yrsyyn.x1xp8e9x.x13fuv20.x178xt8z.xdj266r.x14z9mp.xat24cr.x1lziwak.xo1ph6p.xv54qhq.xf7dkkf'
    );

    if (!postSection) {
      console.warn("Post section not found");
      return;
    }

    // Step 2: Inside that section, find all role="button" elements
    const buttons = postSection.querySelectorAll('div[role="button"][tabindex="0"]');

    // Step 3: Search for the button that contains a <svg> with title "Like"
    for (const btn of buttons) {
      const svg = btn.querySelector('svg[aria-label="Like"]');
      if (svg) {
        btn.click();
        console.log("Like button clicked!");
        return;
      }
    }

    console.warn("Like button not found in section");
  }

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
      clickLikeButton();

      // Unsave if needed
      findButtonByAriaLabel(
        ".x1i10hfl.x972fbf.xcfux6l.x1qhh985.xm0m39n.x9f619.xe8uvvx.xdj266r.x11i5rnm.xat24cr.x1mh8g0r.x16tdsg8.x1hl2dhg.xggy1nq.x1a2a7pz.x6s0dn4.xjbqb8w.x1ejq31n.xd10rxx.x1sy0etr.x17r0tee.x1ypdohk.x78zum5.xl56j7k.x1y1aw1k.x1sxyh0.xwib8y2.xurb0ha.xcdnw81",
        "Remove"
      );
    }

    // Give like
    if (e.code === "Numpad2") {
      clickLikeButton();
    }

    // Previous page
    else if (e.code === "Numpad4") {
      simulateKeyPress(e, "ArrowLeft", "ArrowLeft");
    }

    // Next page
    else if (e.code === "Numpad6") {
      simulateKeyPress(e, "ArrowRight", "ArrowRight");
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
