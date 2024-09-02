"use strict";

const btns = document.querySelectorAll(".btn");
const timeDisplay = document.getElementById("time");
const lapContainer = document.getElementById("lap-times");

let hour = 0;
let minute = 0;
let seconds = 0;
let count = 0;
let timer;
let isRunning = false;

btns.forEach((btn) => {
  btn.addEventListener("click", () => {
    if (btn.id === "start") {
      startTimer();
    } else if (btn.id === "pause") {
      pauseTimer();
    } else if (btn.id === "reset") {
      resetTimer();
    } else if (btn.id === "lap") {
      addLap();
    }
  });
});

function startTimer() {
  if (!isRunning) {
    isRunning = true;
    timer = setInterval(updateTime, 10);
  }
}

function pauseTimer() {
  clearInterval(timer);
  isRunning = false;
}

function resetTimer() {
  clearInterval(timer);
  isRunning = false;
  hour = 0;
  minute = 0;
  seconds = 0;
  count = 0;
  updateDisplay();
  lapContainer.innerHTML = ""; // Clear lap times
}

function updateTime() {
  count++;
  if (count === 100) {
    seconds++;
    count = 0;
  }
  if (seconds === 60) {
    minute++;
    seconds = 0;
  }
  if (minute === 60) {
    hour++;
    minute = 0;
  }

  updateDisplay();
}

function updateDisplay() {
  const hrString = hour < 10 ? `0${hour}` : hour;
  const minString = minute < 10 ? `0${minute}` : minute;
  const secString = seconds < 10 ? `0${seconds}` : seconds;
  const countString = count < 10 ? `0${count}` : count;

  timeDisplay.innerHTML = `${hrString}:${minString}:${secString}:<span>${countString}</span>`;
}

function addLap() {
  if (isRunning) {
    const lapTime = timeDisplay.textContent;
    const lapItem = document.createElement("li");
    lapItem.textContent = lapTime;
    lapContainer.appendChild(lapItem);
  }
}
