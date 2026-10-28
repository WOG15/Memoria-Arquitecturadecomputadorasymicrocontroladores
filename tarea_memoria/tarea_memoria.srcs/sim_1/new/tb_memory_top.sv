`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2026 00:53:42
// Design Name: 
// Module Name: tb_memory_top
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



module tb_memory_top;

    localparam int ROW_BITS   = 2;
    localparam int COL_BITS   = 2;
    localparam int DATA_WIDTH = 8;

    logic [ROW_BITS+COL_BITS-1:0] address;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;

    logic write_enable;
    logic read_enable;

    memory_top #(
        .ROW_BITS(ROW_BITS),
        .COL_BITS(COL_BITS),
        .DATA_WIDTH(DATA_WIDTH)
    ) DUT (
        .address(address),
        .data_in(data_in),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .data_out(data_out)
    );

    // Procedimiento para escribir
    task automatic write_mem(
        input logic [3:0] addr,
        input logic [7:0] data
    );
        begin
            write_enable = 0;
            read_enable = 0;
            address = addr;
            data_in = data;
            #5;

            write_enable = 1;
            #5;
            write_enable = 0;
            #5;
        end
    endtask

    // Procedimiento para comprobar lectura
    task automatic check_mem(
        input logic [3:0] addr,
        input logic [7:0] expected
    );
        begin
            write_enable = 0;
            read_enable = 0;
            address = addr;
            #5;

            read_enable = 1;
            #5;

            if (data_out === expected)
                $display("PASS: Addr=%h Data=%h",
                         addr, data_out);
            else
                $display("FAIL: Addr=%h Expected=%h Got=%h",
                         addr, expected, data_out);

            read_enable = 0;
            #5;
        end
    endtask

    initial begin
        address = 0;
        data_in = 0;
        write_enable = 0;
        read_enable = 0;

        #10;

        // Escribir tres direcciones diferentes
        write_mem(4'h0, 8'hA5);
        write_mem(4'h5, 8'h3C);
        write_mem(4'h9, 8'hF0);

        // Comprobar las tres direcciones
        check_mem(4'h0, 8'hA5);
        check_mem(4'h5, 8'h3C);
        check_mem(4'h9, 8'hF0);

        // Sobrescribir una direccion
        write_mem(4'h5, 8'hFF);

        // Comprobar que las otras no cambiaron
        check_mem(4'h5, 8'hFF);
        check_mem(4'h0, 8'hA5);
        check_mem(4'h9, 8'hF0);

        $finish;
    end

endmodule

