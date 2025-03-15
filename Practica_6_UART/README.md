<div align="center">
  <img src="../assets/images/tecnologico_de_monterrey_logo.png" alt="Tecnológico de Monterrey" width="750">
</div>

<br>

<div align="center">

## Campus Guadalajara

# Práctica 6 - UART con Paridad en Verilog

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

Esta práctica tiene como objetivo desarrollar un módulo de comunicación UART en Verilog con bit de paridad, utilizando la tarjeta FPGA DE10-Lite. El sistema debe ser capaz de recibir y transmitir datos serie a una velocidad de 115200 baudios, verificando la paridad del mensaje.

---

# 📖 Introducción

UART (Universal Asynchronous Receiver/Transmitter) es un protocolo de comunicación serie asíncrono ampliamente utilizado para la transmisión y recepción de datos. Su funcionamiento se basa en la utilización de una línea de transmisión (TX) y una de recepción (RX), sin necesidad de una señal de reloj compartida, lo que simplifica su implementación en hardware.

A pesar de la creciente adopción de protocolos más avanzados como SPI e I2C, UART sigue siendo una opción viable en aplicaciones donde la simplicidad y el bajo costo son factores clave. Este protocolo permite la comunicación en modos simplex, half-duplex y full-duplex, lo que lo hace versátil para una variedad de sistemas embebidos (Rohde & Schwarz, s.f.).

---

# 🔧 Requisitos

- Tarjeta FPGA DE10-Lite (Intel Cyclone V)
- Cable USB Blaster
- Software Intel Quartus Prime Lite
- Código en Verilog

---

# 📂 Estructura del Proyecto

**Estructura local**

    /practica_6_uart
    │── assets/
    │ ├── images/ # Imágenes utilizadas en el README
    │── simulation/
    │ ├── questa/ # Archivos de simulación en Questa Sim
    │── .gitignore # Archivos y carpetas ignoradas por Git
    │── Practica_6_UART.qpf # Archivo del proyecto en Quartus
    │── Practica_6_UART.qsf # Archivo de configuración del FPGA
    │── README.md # Documentación del proyecto
    │── uart_tx.v # Módulo de transmisión
    │── uart_rx.v # Módulo de recepción
    │── uart_top.v # Integración de los módulos
    │── uart_top_tb.v # Testbench para validación del top
    │── uart_tx_tb.v # Testbench para validación del tx
    │── uart_rx_tb.v # Testbench para validación del rx

**Archivos incluidos desde utils**

    /utils
    │── debouncer_one_shot/
    │   ├── debouncer/
    │   │   ├── counter_debouncer.v
    │   │   ├── debouncer.v
    │   ├── one_shot/
    │   │   ├── one_shot.v
    │   ├── debouncer_one_shot.v
    │── display/
    │   ├── display_module.v
    │   ├── decoder_7_seg.v

---

# 📄 Contenido

## 1. Código en Verilog

Archivos .v utilizados en la implementación:

- `uart_tx.v`
- `uart_rx.v`
- `uart_top.v`
- `uart_tb.sv` (Testbench)
- `uart_tx_tb.sv` (Testbench)
- `uart_rx_tb.sv` (Testbench)

### 1.1 Módulos del sistema

- **uart_tx.v**
  - Implementación del transmisor UART con bit de paridad.

- **uart_rx.v**
  - Implementación del receptor UART con verificación de paridad.

- **uart_top.v**
  - Integración de los módulos transmisor y receptor.

- **uart_tb.sv (Testbench)**
  - Simulación para verificar el funcionamiento correcto del uart top.
  
- **uart_tx_tb.sv (Testbench)**
  - Simulación para verificar el funcionamiento correcto del uart tx.
  
- **uart_rx_tb.sv (Testbench)**
  - Simulación para verificar el funcionamiento correcto del uart rx.

## 2. Tablas FSM

### FSM Transmisor (TX)
<img src="assets/images/fsm_tx.png" alt="Tabla FSM Transmisor (TX)" style="width: 100%; display: block; margin: auto;">

### FSM Receptor (RX)
<img src="assets/images/fsm_rx.png" alt="Tabla FSM Receptor (RX)" style="width: 100%; display: block; margin: auto;">

## 3. Diagrama RTL

### RTL UART Top
<img src="assets/images/diagrama_rtl_1.png" alt="Diagrama RTL UART Top" style="width: 100%; display: block; margin: auto;">

### RTL UART TX
<img src="assets/images/diagrama_rtl_2.png" alt="Diagrama RTL UART TX" style="width: 100%; display: block; margin: auto;">

### RTL UART RX
<img src="assets/images/diagrama_rtl_3.png" alt="Diagrama RTL UART RX" style="width: 100%; display: block; margin: auto;">

## 4. Formas de onda

### Formas de onda UART Top
<img src="assets/images/formas_de_onda_1.png" alt="Formas de onda UART Top" style="width: 100%; display: block; margin: auto;">
<img src="assets/images/formas_de_onda_2.png" alt="Formas de onda UART Top" style="width: 100%; display: block; margin: auto;">

### Formas de onda UART RX
<img src="assets/images/formas_de_onda_3.png" alt="Formas de onda UART RX" style="width: 100%; display: block; margin: auto;">

## 5. Debugging Transcript Console

### Transcript UART Top
<img src="assets/images/transcript_console_1.png" alt="Transcript Console UART Top" style="width: 100%; display: block; margin: auto;">

### Transcript UART RX
<img src="assets/images/transcript_console_2.png" alt="Transcript Console UART RX" style="width: 100%; display: block; margin: auto;">

---

# 📈 Resultados

- **Pruebas de transmisión (UART Top) - Testbench**:
  - Se realizaron pruebas con los diferentes tipos de paridad: sin paridad (`0`), paridad impar (`1`) y paridad par (`2`).
  - Los datos fueron transmitidos correctamente en todos los casos, verificando la funcionalidad del transmisor UART.

- **Pruebas de recepción y verificación de paridad (UART RX) - Testbench**:
  - Se probó la funcionalidad del receptor sometiéndolo a diferentes escenarios para verificar si detectaba correctamente los errores de paridad.
  - Los casos en los que los datos no cumplían con la paridad seleccionada fueron detectados correctamente como errores.

- **Implementación en hardware**:
  - Se logró implementar correctamente un sistema UART full-duplex en hardware utilizando la FPGA DE10-Lite, permitiendo la transmisión y recepción simultánea de datos. La verificación de paridad funcionó adecuadamente en todos los escenarios de prueba, confirmando la integridad de los datos en la comunicación serie.

---

# ✅ Conclusiones

El bit de paridad es una herramienta útil para la detección de errores en la comunicación serial. Sin embargo, al profundizar en el tema, se observa que es un sistema relativamente antiguo y no es completamente confiable para detectar errores múltiples en la transmisión de datos.

---

# 📚 Bibliografía

Rohde & Schwarz. (s.f.). Understanding UART. Rohde & Schwarz. Recuperado el 14 de marzo de 2025, de https://www.rohde-schwarz.com/cz/products/test-and-measurement/essentials-test-equipment/digital-oscilloscopes/understanding-uart_254524.html