`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2026 00:51:48
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module decoder #(
    parameter int ADDR_WIDTH = 2
)(
    input  logic [ADDR_WIDTH-1:0] address,
    output logic [(2**ADDR_WIDTH)-1:0] select
);

    always_comb begin
        select = '0;
        select[address] = 1'b1;
    end

endmodule
