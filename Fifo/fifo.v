module fifo
#(
    parameter DATA_WIDTH = 8,  // Data width
    parameter ADDR_WIDTH = 4   // Address width (depth = 2^ADDR_WIDTH)
)
(
    input clk,                 // Clock signal
    input rst,                 // Reset signal
    input wr_en,               // Write enable
    input rd_en,               // Read enable
    input [DATA_WIDTH-1:0] din, // Data input
    output reg [DATA_WIDTH-1:0] dout, // Data output
    output full,               // FIFO full flag
    output empty               // FIFO empty flag
);

    reg [DATA_WIDTH-1:0] fifo_mem [2**ADDR_WIDTH-1:0]; // FIFO memory
    reg [ADDR_WIDTH-1:0] rd_ptr, wr_ptr; // Read and write pointers
    reg fifo_full, fifo_empty; // Status flags

    assign full = fifo_full;
    assign empty = fifo_empty;

    // Write operation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (wr_en && !fifo_full) begin
            fifo_mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // Read operation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
        end else if (rd_en && !fifo_empty) begin
            dout <= fifo_mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
    end

    // Full flag logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fifo_full <= 0;
        end else if (wr_en && (wr_ptr == rd_ptr - 1)) begin
            fifo_full <= 1;
        end else if (rd_en) begin
            fifo_full <= 0;
        end
    end

    // Empty flag logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fifo_empty <= 1;
        end else if (wr_en) begin
            fifo_empty <= 0;
        end else if (rd_en && (rd_ptr == wr_ptr)) begin
            fifo_empty <= 1;
        end
    end

endmodule
