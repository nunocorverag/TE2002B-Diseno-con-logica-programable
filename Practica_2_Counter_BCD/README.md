<div align="center">
  <img src="../assets/images/tecnologico_de_monterrey_logo.png" alt="Tecnológico de Monterrey" width="750">
</div>

<br>

<div align="center">

## Campus Guadalajara

# Práctica 2 - BCD Counter

### Gustavo Alexander Nuño Corvera

### A01644775

### Ingeniería en Robótica y Sistemas Digitales

#### TE2002B - Diseño con lógica programable

</div>

# 📌 Tabla de Contenido

1. [📜 Resumen](#-resumen)
2. [📖 Introducción](#-introducción)
3. [🔧 Requisitos](#-requisitos)
4. [📂 Estructura del Proyecto](#-estructura-del-proyecto)
5. [📄 Contenido](#-contenido)
6. [📈 Resultados](#-resultados)
7. [✅ Conclusiones](#-conclusiones)
8. [📚 Bibliografía](#-bibliografía)

---

# 📜 Resumen

La práctica consiste en diseñar e implementar un contador ascendente-descendente en Verilog para la FPGA DE10-Lite. El sistema debe ser capaz de:

- Ralentizar el conteo mediante un divisor de reloj.
- Iniciar o detener el conteo con una señal de habilitación.
- Cargar un valor específico de manera síncrona.
- Controlar la dirección del conteo (ascendente o descendente).
- Mostrar el conteo en los displays de 7 segmentos.

---

# 📖 Introducción

## Contadores Digitales

Los contadores digitales son circuitos secuenciales que almacenan y muestran la cantidad de veces que ha ocurrido un evento en un sistema digital. Son ampliamente utilizados en electrónica para tareas como medición de tiempo, conteo de eventos y división de frecuencia (GeeksforGeeks, 2023). Dependiendo de su configuración, pueden operar en modo ascendente, descendente o en combinaciones de ambos.

## Importancia del Reloj en Circuitos Digitales

El reloj (CLK) es un elemento crucial en los circuitos digitales, ya que sincroniza la transferencia de datos entre los componentes. Funciona como un metrónomo, asegurando que los dispositivos dentro del sistema operen al mismo ritmo y evitando errores en la transmisión de datos (Ornate Pixels, n.d.). En este proyecto, el uso de un divisor de reloj es fundamental para hacer visible el conteo en los displays.

---

# 🔧 Requisitos

- Tarjeta FPGA DE10-Lite
- Cable USB Blaster
- Software Intel Quartus Prime Lite

---

# 📂 Estructura del Proyecto

**Estructura local**

    /practica_2_counter
    │── assets/
    │ ├── images/ # Imágenes utilizadas en el README
    │── simulation/
    │ ├── questa/ # Archivos de simulación en Questa Sim
    │── .gitignore # Archivos y carpetas ignoradas por Git
    │── Practica_2_Counter.qpf # Archivo del proyecto en Quartus
    │── Practica_2_Counter.qsf # Archivo de configuración del FPGA
    │── README.md # Documentación del proyecto
    │── counter.v # Módulo principal del contador
    │── up_down_counter_parallel_load.v # Contador ascendente-descendente con carga síncrona

**Archivos incluidos desde utils**

    /utils
    │── counter_tb.sv # Testbench para validación
    │── decoder_7_seg.v # Decodificador de 7 segmentos
    │── display_module.v # Módulo de visualización
    │── clock_divider.v # Divisor de reloj

---

# 📄 Contenido

## 1. Código en Verilog

Archivos .v utilizados en la implementación:

- `counter.v`
- `up_down_counter_parallel_load.v`
- `display_module.v`
- `decoder_7_seg.v`
- `clock_divider.v`
- `counter_tb.sv` (Testbench)

### 1.1 Módulos del sistema

- **counter.v**
  - Módulo principal que conecta todos los componentes.
  
- **up_down_counter_parallel_load.v**
  - Contador que permite carga síncrona y cambio de dirección.

- **clock_divider.v**
  - Reduce la frecuencia del reloj para una mejor visualización.

- **display_module.v**
  - Convierte el número binario en unidades, decenas y centenas para su visualización en los displays.

- **decoder_7_seg.v**
  - Decodifica valores binarios para los displays de 7 segmentos.

- **counter_tb.sv (Testbench)**
  - Se encarga de probar el correcto funcionamiento del sistema.


## 2. Diagrama RTL

<img src="assets/images/diagrama_rtl.png" alt="Diagrama RTL" style="width: 100%; display: block; margin: auto;">

## 3. Formas de onda

<img src="assets/images/formas_de_onda_1.png" alt="Formas de onda 1" style="width: 100%; display: block; margin: auto;">
<img src="assets/images/formas_de_onda_2.png" alt="Formas de onda 2" style="width: 100%; display: block; margin: auto;">
<img src="assets/images/formas_de_onda_3.png" alt="Formas de onda 3" style="width: 100%; display: block; margin: auto;">

---

# 📈 Resultados

En la simulación, se generaron las siguientes formas de onda:

La primera imagen muestra cómo el contador incrementa los valores, reflejando correctamente los cambios en los displays.
La segunda imagen ilustra el proceso de conteo descendente, donde el sistema responde correctamente a la señal `up_down`.
Finalmente, la tercera imagen demuestra el efecto de la señal `clear_btn`, reiniciando el contador a 0.

# ✅ Conclusiones

Se comprendió la importancia de dividir los ciclos de reloj para permitir la visualización del resultado de manera comprensible. Sin esta división, la velocidad del `clk` haría que el conteo fuera imperceptible para un humano. Gracias al divisor de reloj, fue posible observar los cambios en el conteo de manera clara.

# 📚 Bibliografía

GeeksforGeeks. (2023, March 6). _Counters in Digital Logic._ Recuperado de: [https://www.geeksforgeeks.org/counters-in-digital-logic/](https://www.geeksforgeeks.org/counters-in-digital-logic/)

Ornate Pixels. (s.f.). _What is the Clock Signal and Data Signal in a Digital Circuit?_ Recuperado de: [https://www.ornatepixels.com/2023/11/what-is-sda-or-serial-data-and-clk-or.html](https://www.ornatepixels.com/2023/11/what-is-sda-or-serial-data-and-clk-or.html)