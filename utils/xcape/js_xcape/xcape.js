/**
 * <>---< XC4P3 SCR1PT >---<>
 *
 * version: v0.0.1 (node)
 * author: N0M4D
 *
 * You must install nircmd and update the script path for run this.
 * Obviously, you need node as well.
 *
 * `node xcape.js` for script execution!
 *
 * HHKK
 * N0M4D
 */

const { exec } = require("child_process");

// Path to the NirCmd executable (change if necessary)
const nircmdPath = "C:\\nircmd\\nircmd.exe";
const time_interval = 60000;

// Function to press the Escape key using NirCmd
function pressEscapeKey() {
  console.info("<!> Pressing the Escape key...");
  exec(`${nircmdPath} sendkey esc press`, (error, stdout, stderr) => {
    if (error) {
      console.error(`<!> Error: ${error.message}`);
      console.log('');
      return;
    }
    if (stderr) {
      console.error(`<!> Stderr: ${stderr}`);
      console.log('');
      return;
    }
    console.info("<!> Escape key pressed successfully.");
    console.info('');
  });
}

// Set an interval to press the Escape key every 1 minute (60000 ms)
setInterval(pressEscapeKey, time_interval);

// Initial message
console.warn("<>---< XC4P3 SCR1PT >---<>");
console.warn("  .... v0.0.1 node  ....");
console.warn("");

console.info('<!> Script is running. Pressing "Escape" key every 1 minute.');
