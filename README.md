**FIFO Design in Verilog**

This repository contains a Verilog implementation of a **First In First Out (FIFO)** memory buffer and a corresponding testbench for simulation. The FIFO module is parameterized for flexibility in data width and depth. This README provides detailed instructions on how to set up and run the simulation, as well as an explanation of the FIFO design and its components.

**Table of Contents**

- [File Structure](#file-structure)
- [Getting Started](#getting-started)
  - [Cloning the Repository](#cloning-the-repository)
  - [Simulation Tools](#simulation-tools)
  - [Running the Simulation](#running-the-simulation)
- [Detailed Explanation](#detailed-explanation)
  - [FIFO Module](#fifo-module)
  - [Testbench](#testbench)
  - [Parameters](#parameters)
- [Simulation Waveform](#simulation-waveform)
- [Contributing](#contributing)
- [License](#license)

**File Structure**

bash

Copy code

├── fifo.v         # Verilog code for the FIFO module

├── tb\_fifo.v      # Verilog code for the testbench

└── README.md      # Project documentation

**Getting Started**

**Cloning the Repository**

To clone the repository, use the following command:

bash

Copy code

git clone https://github.com/your-username/fifo-verilog.git

cd fifo-verilog

**Simulation Tools**

You will need a Verilog simulation tool to run the project. Recommended tools include:

- ModelSim
- Vivado
- Quartus

Ensure the tool you choose supports Verilog HDL and is properly installed.

**Running the Simulation**

To run the simulation, follow these steps:

1. Open your simulation tool (ModelSim, Vivado, Quartus, etc.).
1. Add the Verilog files (fifo.v and tb\_fifo.v) to your project.
1. Compile the Verilog files.
1. Run the simulation on the testbench (tb\_fifo.v).
1. View the results in the simulation console and waveform viewer.

**Detailed Explanation**

**FIFO Module**

The FIFO module (fifo.v) is implemented with the following features:

- **Parameterized Design**: Supports configurable data width and memory depth.

**Signals:**

- clk: Clock signal
- rst: Reset signal
- wr\_en: Write enable signal
- rd\_en: Read enable signal
- din: Data input
- dout: Data output
- full: High when FIFO is full
- empty: High when FIFO is empty

**Functionality:**

- **Write Operation**: Data is written to the FIFO when wr\_en is high, and the FIFO is not full.
- **Read Operation**: Data is read from the FIFO when rd\_en is high, and the FIFO is not empty.
- **Status Flags**: full and empty flags indicate the FIFO's status.

**Testbench**

The testbench (tb\_fifo.v) is designed to:

- Write multiple values into the FIFO.
- Read values from the FIFO and print them.
- Test edge cases, such as writing when full and reading when empty.

**Parameters**

The FIFO's behavior is controlled by the following parameters:

- DATA\_WIDTH: Defines the width of the data bus (e.g., 8 bits).
- ADDR\_WIDTH: Defines the depth of the FIFO as a power of 2 (e.g., 2^4 = 16 locations).

**Example parameters:**

verilog

Copy code

parameter DATA\_WIDTH = 8;  // Data width in bits

parameter ADDR\_WIDTH = 4;  // Address width (depth = 2^ADDR\_WIDTH)

**Simulation Waveform**

After running the simulation, you can view the waveform for signals like clk, rst, wr\_en, rd\_en, din, dout, full, and empty. This helps verify the FIFO's functionality.

**Exporting the Waveform**

1. **Adjust the View**: Zoom and pan to the desired section of the waveform.
1. **Export the Image**:
   1. In ModelSim: Go to File > Export > Image.
   1. In Vivado: Right-click in the waveform window and select Export.
   1. In Quartus: Use the screenshot tool or external tools if necessary.

**Contributing**

Contributions are welcome! If you have suggestions or improvements, please submit a pull request. For significant changes, please open an issue first to discuss your ideas.

**License**

This project is licensed under the MIT License. See the LICENSE file for details.

