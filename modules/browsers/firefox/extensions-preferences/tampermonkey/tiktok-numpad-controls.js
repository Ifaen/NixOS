// ==UserScript==
// @name         Tiktok numpad controls
// @namespace    http://tampermonkey.net/
// @version      2025-01-13
// @description  Just an script to more easily navigate and download from Tiktok. Tiktok download buttons extension is required.
// @author       You
// @match        https://www.tiktok.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=tiktok.com
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

  function simulateButton(e, key, keyCode) {
    e.preventDefault();

    // Create a new event for the key
    const keyboardEvent = new KeyboardEvent("keydown", {
      key: key, // Simulate the key
      code: key,
      keyCode: keyCode,
      which: keyCode,
      bubbles: true, // Ensure the event bubbles up the DOM
    });

    document.activeElement.dispatchEvent(keyboardEvent);
  }

  function giveLike() {
    const likebutton = document.querySelector(".css-1ncfmqs-ButtonActionItem");

    const ariaPressed = likebutton.getAttribute("aria-pressed");
    if (ariaPressed === "false") {
      likebutton.click();
    }
  }

  function saveVideo(e) {
    e.preventDefault();
    // Select all the buttons you want to check
    const buttons = document.querySelectorAll(".css-1ncfmqs-ButtonActionItem");

    buttons.forEach((button) => {
      // Select the SVG inside the button
      const svg = button.querySelector("svg");

      // Get the xlink:href value from the <use> element
      const xlinkHref = svg.querySelector("use").getAttribute("xlink:href");

      // If is uncollect, save it
      if (xlinkHref.includes("uncollect")) {
        button.click();

        // Download video with button extension
        pressButton(e, ".ttdb__button_browser");
      }
    });
  }

  document.addEventListener("keydown", (e) => {
    if (e.code === "Numpad5") {
      saveVideo(e);
    }

    // Give like to video
    else if (e.code === "Numpad2") {
      giveLike();
    }

    // Go to prev video
    else if (e.code === "Numpad4") {
      simulateButton(e, "ArrowUp", 38);
    }

    // Go to next video
    else if (e.code === "Numpad6") {
      simulateButton(e, "ArrowDown", 40);
    }

    // Return few seconds in the video
    else if (e.code === "Numpad1") {
      simulateButton(e, "ArrowLeft", 37);
    }

    // Skip few seconds in the video
    else if (e.code === "Numpad3") {
      simulateButton(e, "ArrowRight", 39);
    }

    // Close video
    else if (e.code === "Numpad8") {
      pressButton(
        e,
        ".css-yg0pvs-ButtonBasicButtonContainer-StyledCloseIconContainer.e11s2kul7"
      );
    }
  });
})();
