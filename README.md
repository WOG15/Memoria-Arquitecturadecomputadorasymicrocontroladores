# Memoria parametrizable en SystemVerilog

Implementación de una memoria RAM mediante una matriz de **Gated Latches**, desarrollada en SystemVerilog y utilizando Vivado para su simulación y síntesis.

## Descripción

El proyecto implementa una estructura de memoria parametrizable, organizada en filas y columnas. Cada posición de la matriz contiene una cantidad configurable de bits, almacenados mediante Gated Latches.

La memoria utiliza dos decodificadores para seleccionar la fila y columna correspondientes a una dirección.

## Explicación en video

Se puede consultar una explicación del diseño y su funcionamiento en el siguiente enlace:

**[Ver explicación en YouTube](https://youtu.be/x14evDRHArg)**

## Características

- Memoria parametrizable mediante `ROW_BITS`, `COL_BITS` y `DATA_WIDTH`.
- Matriz de Gated Latches generada mediante `generate`.
- Decodificadores de filas y columnas.
- Señales de habilitación de lectura (`read_enable`) y escritura (`write_enable`).
- Lectura y escritura asíncronas.
- Testbench para verificar el funcionamiento.

## Estructura del proyecto

| Archivo | Descripción |
|---|---|
| `gated_latch.sv` | Almacenamiento de un bit mediante un latch. |
| `decoder.sv` | Decodificador parametrizable de direcciones. |
| `memory_top.sv` | Módulo principal que integra la matriz y los decodificadores. |
| `tb_memory_top.sv` | Testbench para comprobar las operaciones de lectura y escritura. |

## Parametrización

```systemverilog
parameter int ROW_BITS   = 2;
parameter int COL_BITS   = 2;
parameter int DATA_WIDTH = 8;
```

Con estos valores se implementa una matriz de **4 filas × 4 columnas**, con 8 bits por posición, para una capacidad total de **128 bits (16 bytes)**.

## Funcionamiento

**Escritura:** La dirección se divide en fila y columna. Los decodificadores habilitan la posición seleccionada y, cuando `write_enable = 1`, los latches almacenan los bits presentes en `data_in`.

**Lectura:** Cuando `read_enable = 1` y `write_enable = 0`, el contenido de la posición seleccionada se presenta en `data_out`.

## Herramientas utilizadas

- SystemVerilog
- AMD Vivado (simulación, elaboración y síntesis)
