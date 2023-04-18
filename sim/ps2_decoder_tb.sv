`default_nettype none
`timescale 1ns/1ps

module ps2_decoder_tb();
    logic clk;

    always begin
        #5;
        clk = !clk;
    end

    initial begin
        clk = 0;
        $dumpfile("ps2_decoder_tb.vcd");
        $dumpvars(0, ps2_decoder_tb);

        $finish();
    end
endmodule
`default_nettype wire