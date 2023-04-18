`default_nettype none
`timescale 1ns / 1ps

module top_level (
	input wire clk,
    input wire btnc,

    input wire ps2_clk,
    input wire ps2_data,

    output logic ca, cb, cc, cd, ce, cf, cg,
    output logic [7:0] an,

	input wire uart_txd_in,
	output logic uart_rxd_out
	);

    logic clk_10mhz;
    clk_gen_100_to_10_clk_wiz clk_gen(.clk_100mhz(clk), .clk_10mhz(clk_10mhz));

    manta manta_inst (
        .clk(clk_10mhz),

        .rx(uart_txd_in),
        .tx(uart_rxd_out),

        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data));

    logic [7:0] data;
    ps2_decoder decoder(
        .clk(clk_10mhz),

        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),

        .data(data));

    logic [6:0] cat;
	assign {cg,cf,ce,cd,cc,cb,ca} = cat;
    ssd ssd (
        .clk_in(clk_10mhz),
        .rst_in(btnc),
        .val_in(data),
        .cat_out(cat),
        .an_out(an));
endmodule

`default_nettype wire