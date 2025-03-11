<div align="center">
  <img src="../assets/images/tecnologico_de_monterrey_logo.png" alt="Tecnológico de Monterrey" width="750">
</div>

<br>

<div align="center">

## Campus Guadalajara

# Práctica 4 - Password FSM

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

La práctica consiste en diseñar e implementar un sistema de contraseña en Verilog para la FPGA DE10-Lite utilizando Máquinas de Estados Finitos (FSM). El sistema debe ser capaz de:

- Ingresar la contraseña un switch a la vez.
- Evaluar una secuencia de 4 switches secuenciados.
- Mostrar "Done" en los displays si la secuencia es correcta.
- Mostrar "Error" si hay un error en cualquier punto de la secuencia.

---

# 📖 Introducción

## Máquina de Estado Finito (FSM)

Una Máquina de Estado Finito (FSM) es un modelo de computación que solo puede estar en uno de un número finito de estados en un momento dado. Se define por un conjunto de reglas que describen las transiciones de estado y las entradas que provocan dichos cambios. Este concepto es ampliamente utilizado en el diseño de sistemas digitales y software, ya que permite estructurar la lógica en bloques discretos, facilitando su comprensión y depuración (Isaac, 2022).

Las FSM presentan varias ventajas, como la reducción de la complejidad del código al dividirlo en subrutinas específicas, la mejora de la legibilidad al organizar la ejecución en secuencias bien definidas y la posibilidad de realizar pruebas unitarias en cada estado para garantizar su correcto funcionamiento (Isaac, 2022).

---

# 🔧 Requisitos

- Tarjeta FPGA DE10-Lite (Intel Cyclone V)
- Cable USB Blaster
- Software Intel Quartus Prime Lite
- Código en Verilog

---

# 📂 Estructura del Proyecto

**Estructura local**

    /practica_4_password
    │── assets/
    │ ├── images/ # Imágenes utilizadas en el README
    │── simulation/
    │ ├── questa/ # Archivos de simulación en Questa Sim
    │── .gitignore # Archivos y carpetas ignoradas por Git
    │── Practica_4_Password.qpf # Archivo del proyecto en Quartus
    │── Practica_4_Password.qsf # Archivo de configuración del FPGA
    │── README.md # Documentación del proyecto
    │── password_fsm.v # Módulo principal de la FSM
    │── password_top.v # Integración de módulos
    │── password_tb.sv # Testbench para validación

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
    │   ├── status_display.v

---

# 📄 Contenido

## 1. Código en Verilog

Archivos .v utilizados en la implementación:

- `password_fsm.v`
- `password_top.v`
- `debouncer_one_shot.v`
- `status_display.v`
- `password_tb.sv` (Testbench)

### 1.1 Módulos del sistema

- **password_fsm.v**
  - Implementación de la Máquina de Estados Finitos (FSM) para la evaluación de la contraseña.

- **password_top.v**
  - Integración de la FSM con los debouncers y el sistema de visualización.

- **debouncer_one_shot.v**
  - Estabilización de entradas de los switches mediante un mecanismo de un solo pulso.

- **status_display.v**
  - Conversión de los estados "Done" y "Error" en salidas de displays de 7 segmentos.

- **password_tb.sv (Testbench)**
  - Simulación para verificar el funcionamiento correcto del sistema.

## 2. Diagrama FSM

<img src="assets/images/diagrama_fsm.png" alt="Diagrama FSM" style="width: 100%; display: block; margin: auto;">

## 3. Diagrama RTL

<img src="assets/images/diagrama_rtl.png" alt="Diagrama RTL" style="width: 100%; display: block; margin: auto;">

## 4. Formas de onda

<img src="assets/images/formas_de_onda.png" alt="Formas de onda" style="width: 100%; display: block; margin: auto;">

---

# 📈 Resultados

En la simulación, se generaron las siguientes formas de onda:

- En la primera pasada de contraseña, podemos comprobar que el sistema pasa al estado `Done` cuando los dígitos ingresados son correctos.
- En los demás casos, la FSM se salta del estado `3`, `2`, `1` o `0` al estado `5` cuando un dígito es incorrecto, indicando un error.
- Posteriormente, la FSM regresa al estado `0`, listo para una nueva entrada de contraseña.

# ✅ Conclusiones

La implementación de una FSM nos permitió estructurar de manera organizada la secuencia de estados que debe seguir el sistema. Este enfoque es clave para programar sistemas que requieren transiciones lógicas predefinidas y la gestión adecuada de entradas y salidas acorde a dichas secuencias y estados.

# 📚 Bibliografía

Isaac. (2022, October 3). _Máquinas de estado finito ¿Qué son? ¿Para qué sirven?_ Profesional Review. Recuperado de: [https://www.profesionalreview.com/2022/11/26/maquinas-de-estado-finito-que-son-para-que-sirven/](https://www.profesionalreview.com/2022/11/26/maquinas-de-estado-finito-que-son-para-que-sirven/)