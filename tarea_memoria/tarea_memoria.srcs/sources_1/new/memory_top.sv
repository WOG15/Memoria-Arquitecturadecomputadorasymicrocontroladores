`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2026 00:52:42
// Design Name: 
// Module Name: memory_top
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


module memory_top #(
    parameter int ROW_BITS   = 2,
    parameter int COL_BITS   = 2,
    parameter int DATA_WIDTH = 8
)(
    input  logic [ROW_BITS+COL_BITS-1:0] address,
    input  logic [DATA_WIDTH-1:0] data_in,
    input  logic write_enable,
    input  logic read_enable,
    output logic [DATA_WIDTH-1:0] data_out
);

    // Dimensiones de la matriz
    localparam int ROWS = 2 ** ROW_BITS;
    localparam int COLS = 2 ** COL_BITS;

    // Separar direccion en fila y columna
    logic [ROW_BITS-1:0] row_address;
    logic [COL_BITS-1:0] col_address;

    assign row_address = address[ROW_BITS+COL_BITS-1:COL_BITS];
    assign col_address = address[COL_BITS-1:0];

    // Salidas de los decodificadores
    logic [ROWS-1:0] row_select;
    logic [COLS-1:0] col_select;

    // Instancias de decodificadores
    decoder #(
        .ADDR_WIDTH(ROW_BITS)
    ) ROW_DECODER (
        .address(row_address),
        .select(row_select)
    );

    decoder #(
        .ADDR_WIDTH(COL_BITS)
    ) COL_DECODER (
        .address(col_address),
        .select(col_select)
    );

    // Matriz de almacenamiento
    logic [DATA_WIDTH-1:0] memory [0:ROWS-1][0:COLS-1];

    // Generacion de celdas de memoria
    generate
        for (genvar r = 0; r < ROWS; r++) begin : ROW_GEN

            for (genvar c = 0; c < COLS; c++) begin : COL_GEN

                // Habilitar solo la posicion seleccionada
                wire cell_enable;

                assign cell_enable =
                    write_enable &
                    row_select[r] &
                    col_select[c];

                // Un latch por cada bit de la posicion
                for (genvar b = 0; b < DATA_WIDTH; b++) begin : BIT_GEN

                    gated_latch LATCH (
                        .d(data_in[b]),
                        .en(cell_enable),
                        .q(memory[r][c][b])
                    );

                end
            end
        end
    endgenerate

    // Lectura de la posicion seleccionada
    always_comb begin
        data_out = '0;

        if (read_enable && !write_enable) begin
            data_out = memory[row_address][col_address];
        end
    end

endmodule

