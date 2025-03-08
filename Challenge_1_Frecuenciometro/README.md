<div align="center">
  <img src="../assets/images/tecnologico_de_monterrey_logo.png" alt="Tecnológico de Monterrey" width="750">
</div>

<br>

<div align="center">

## Campus Guadalajara

# Challenge 1 - Frecuencímetro en FPGA DE10-Lite

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

El objetivo del challenge es implementar en Verilog un frecuencímetro para la FPGA DE10-Lite, capaz de medir la frecuencia de una señal de entrada en un rango de 10 Hz a 100 KHz y mostrarla en los displays de 7 segmentos con un error de precisión del 1%.

Para ello, se diseñaron diversos módulos en Verilog, incluyendo un detector de flancos, un capturador de período, un calculador de frecuencia y un manejador de displays.

---

# 📖 Introducción

Un frecuencímetro es un dispositivo que mide la frecuencia de una señal periódica, es decir, el número de ciclos por segundo (Hertz, Hz). En este challenge, se implementa un frecuencímetro en una FPGA utilizando el lenguaje Verilog.

Según Electrositio, un frecuencímetro digital es un instrumento electrónico capaz de medir incluso los valores de frecuencia más pequeños con tres decimales y mostrarlos en la pantalla del medidor. Su funcionamiento se basa en la conversión de la señal analógica en una serie de pulsos digitales, los cuales se procesan para determinar la frecuencia exacta (_Javired & Javired, 2022_).

El sistema cuenta con los siguientes módulos:
- **Sincronizador de señal:** Elimina posibles problemas de metastabilidad.
- **Detector de flanco ascendente:** Detecta transiciones de bajo a alto en la señal de entrada.
- **Capturador de período:** Mide el tiempo entre transiciones de flanco ascendente.
- **Calculador de frecuencia:** Obtiene la frecuencia a partir del período medido.
- **Manejador de displays:** Convierte la frecuencia en un formato adecuado para los displays de 7 segmentos.

---

# 🔧 Requisitos

- FPGA DE10-Lite
- Intel Quartus Prime Lite
- Generador de señal (opcional) o una señal de prueba

---

# 📂 Estructura del Proyecto

**Estructura local**

    /frequency_meter
    │── assets/
    │ ├── images/ # Imágenes utilizadas en el README
    │── simulation/
    │ ├── questa/ *(Archivos de simulación en Questa Sim)*
    │── frequency_meter.v
    │── edge_detector.v
    │── period_capture.v
    │── frequency_calculator.v
    │── README.md
    │── frequency_meter.qpf # Archivo del proyecto en Quartus
    │── frequency_meter.qsf # Archivo de configuración del FPGA

**Archivos incluidos desde utils**

    /utils
    │── debouncer.v *(Módulo de eliminación de rebotes)*
    │── debouncer_one_shot.v *(Módulo combinado de debounce y pulso único)*
    │── clock_divider.v *(Módulo de división de reloj)*
    │── one_shot.v *(Módulo generador de un solo pulso)*
    │── counter_debouncer.v  *(Módulo contador para el debouncer)*
    ├── display_module.v

---

# 📄 Contenido

## 1. Código en Verilog

Archivos .v utilizados en la implementación:

- `frequency_meter.v`
- `edge_detector.v`
- `period_capture.v`
- `frequency_calculator.v`

### 1.1 Descripción de Módulos

- **frequency_meter**
  - Módulo principal que interconecta los demás módulos.

- **edge_detector**
  - Detecta flancos ascendentes en la señal de entrada.

- **period_capture**
  - Mide el período de la señal de entrada basado en los flancos detectados.

- **frequency_calculator**
  - Calcula la frecuencia a partir del período capturado.

## 2. Diagrama RTL

<img src="assets/images/diagrama_rtl.png" alt="Diagrama RTL" style="width: 100%; display: block; margin: auto;">

## 3. Formas de onda

<img src="assets/images/formas_de_onda_1.png" alt="Formas de onda 1" style="width: 100%; display: block; margin: auto;">
<img src="assets/images/formas_de_onda_2.png" alt="Formas de onda 2" style="width: 100%; display: block; margin: auto;">

---

# 📈 Resultados

Se realizó la simulación del sistema en Intel Quartus Prime Lite y se verificó su correcto funcionamiento. Gracias al cálculo preciso implementado en el módulo `frequency_calculator`, no se registró ningún error en la medición de la frecuencia.

---

# ✅ Conclusiones

La implementación de un frecuencímetro en una FPGA permite medir señales de manera precisa y rápida. Se logró cumplir con el objetivo del challenge sin errores en la medición, gracias a la verificación de señales flotantes y al uso de un cálculo preciso.

Esta práctica resultó particularmente interesante, ya que implica medir la señal de manera continua y asegurarse de evitar señales flotantes. Inicialmente, se presentaron problemas debido a la presencia de señales indefinidas (flotantes) en `signal_in`, pero estos fueron eliminados verificando si la señal tomaba valores `z` o `x`. Con este método, se garantizó una medición estable y confiable.

---

# 📚 Bibliografía

Javired, & Javired. (2022, July 25). ¿Qué es el frecuencímetro digital y cómo funciona? Electrositio. [https://electrositio.com/que-es-el-frecuencimetro-digital-y-como-funciona/](https://electrositio.com/que-es-el-frecuencimetro-digital-y-como-funciona/)