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

  document.addEventListener("keydown", (e) => {
    // Download video with button extension
    if (e.code === "Numpad5") {
      pressButton(e, ".ttdb__button_browser");

      giveLike();
    }

    // Give like to video
    else if (e.code === "Numpad2") {
      giveLike();
    }

    // Go to prev video
    else if (e.code === "Numpad4") {
      pressButton(
        e,
        ".css-1w6o9i7-ButtonBasicButtonContainer-StyledVideoSwitch.e11s2kul11"
      );
    }

    // Go to next video
    else if (e.code === "Numpad6") {
      pressButton(
        e,
        ".css-1s9jpf8-ButtonBasicButtonContainer-StyledVideoSwitch.e11s2kul11"
      );
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
