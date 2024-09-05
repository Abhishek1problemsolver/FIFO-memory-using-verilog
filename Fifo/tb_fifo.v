module tb_fifo;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;
    wire full;
    wire empty;

    // Instantiate FIFO
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 time units clock period

    // Testbench logic
    initial begin
    
        $dumpfile("tb_fifo.vcd");   // Create a dump file
        $dumpvars(0, tb_fifo);      // Dump all variables in the testbench

        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        // Reset FIFO
        #10 rst = 0;

        // Write data into FIFO
        #10 write_fifo(8'hA1);
        #10 write_fifo(8'hB2);
        #10 write_fifo(8'hC3);
        #10 write_fifo(8'hD4);

        // Read data from FIFO
        #10 read_fifo();
        #10 read_fifo();
        #10 read_fifo();
        #10 read_fifo();

        // Fill the FIFO to test full condition
        #10 fill_fifo();

        // Empty the FIFO to test empty condition
        #10 empty_fifo();

        // End simulation
        #50 $finish;
    end

    // Task to write into FIFO
    task write_fifo(input [DATA_WIDTH-1:0] data);
        begin
            if (!full) begin
                din = data;
                wr_en = 1;
                #10 wr_en = 0;
            end else begin
                $display("FIFO is full! Cannot write.");
            end
        end
    endtask

    // Task to read from FIFO
    task read_fifo();
        begin
            if (!empty) begin
                rd_en = 1;
                #10 rd_en = 0;
                $display("Data read from FIFO: %h", dout);
            end else begin
                $display("FIFO is empty! Cannot read.");
            end
        end
    endtask

    // Task to fill FIFO
    task fill_fifo();
        integer i;
        begin
            for (i = 0; i < (2**ADDR_WIDTH); i = i + 1) begin
                write_fifo(i);
            end
        end
    endtask

    // Task to empty FIFO
    task empty_fifo();
        begin
            while (!empty) begin
                read_fifo();
                #10;
            end
        end
    endtask

endmodule
