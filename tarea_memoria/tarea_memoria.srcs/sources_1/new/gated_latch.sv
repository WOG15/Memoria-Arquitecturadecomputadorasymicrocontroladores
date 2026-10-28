`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2026 00:49:18
// Design Name: 
// Module Name: gated_latch
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



module gated_latch (
    input  logic d,
    input  logic en,
    output logic q
);

    always_latch begin
        if (en)
            q <= d;
    end

endmodule

