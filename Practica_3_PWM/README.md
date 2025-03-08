<div align="center">
  <img src="../assets/images/tecnologico_de_monterrey_logo.png" alt="Tecnológico de Monterrey" width="750">
</div>

<br>

<div align="center">

## Campus Guadalajara

# Práctica 3 - PWM

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

Esta práctica tiene como objetivo el diseño e implementación de un módulo en Verilog que genere una señal PWM (modulación por ancho de pulso) para el control de un servomotor utilizando la FPGA DE10-Lite. El ciclo de trabajo (duty cycle) se ajustará mediante los botones de la FPGA, permitiendo modificar la posición del servomotor en el rango de 0° a 180°.

---

# 📖 Introducción

## Modulación por Ancho de Pulso (PWM)

La modulación por ancho de pulso (PWM, por sus siglas en inglés) es una técnica utilizada para transmitir señales analógicas mediante una señal digital modulada. Consiste en modificar el ciclo de trabajo de una señal periódica para controlar la cantidad de energía entregada a una carga (_Solectroshop, 2020_).

Se expresa en porcentaje, por ejemplo, un 10% de duty cycle indica que la señal está en estado alto 10 de cada 100 unidades de tiempo. Para calcular el duty cycle se usa la siguiente fórmula:

**Duty cycle** = t / T

donde:
- **t** es el tiempo en estado alto.
- **T** es el período total de la señal.

Básicamente, consiste en activar una salida digital durante un tiempo determinado y mantenerla apagada el resto del tiempo.

Esta técnica se emplea comúnmente en aplicaciones como:

- **Control de velocidad en motores.**
- **Regulación de intensidad luminosa.**
- **Control de elementos termoeléctricos.**
- **Gestión de fuentes de alimentación conmutadas.**

## Servomotores

Un servomotor es un dispositivo que permite el control preciso de la posición, velocidad y movimiento dentro de un rango de 0° a 180° (usualmente). Estos motores son ampliamente utilizados en robótica, automatización industrial y sistemas de control debido a su alta precisión y fiabilidad.

Los servomotores están compuestos por distintos elementos:

- **Motor eléctrico:** Responsable del movimiento mecánico mediante giros del eje.
- **Sistema de control:** Regula el movimiento y la posición del motor mediante señales eléctricas.
- **Sistema de regulación:** Utiliza engranajes para ajustar el torque y fijar posiciones específicas.
- **Potenciómetro:** Permite conocer en todo momento la posición y ángulo del eje del motor.

Gracias a su capacidad de mantener una posición determinada y responder a variaciones en la señal de control, los servomotores son ideales para aplicaciones que requieren precisión extrema, como la robótica, la impresión 3D y los sistemas automatizados (_EGASEN, 2021_).

Los servomotores se controlan mediante señales PWM con valores específicos de ancho de pulso.
---

# 🔧 Requisitos

- Tarjeta FPGA DE10-Lite
- Software Intel Quartus Prime Lite
- Servomotor compatible con PWM
- Cables jumper para conexiones

---

# 📂 Estructura del Proyecto

**Estructura local**

    /practica_3_pwm
    │── assets/
    │   ├── images/ *(Imágenes utilizadas en el README)*
    │── simulation/
    │   ├── questa/ *(Archivos de simulación en Questa Sim)*
    │   pwm.v *(Módulo principal PWM)*
    │   pwm_tb.v *(Testbench PWM)*
    │── README.md *(Documentación del proyecto)*
    │── Practica_3_PWM.qpf *(Archivo del proyecto Quartus)*
    │── Practica_3_PWM.qsf *(Archivo de configuración FPGA)*

**Archivos incluidos desde utils**

    /utils
    │── debouncer.v *(Módulo de eliminación de rebotes)*
    │── debouncer_one_shot.v *(Módulo combinado de debounce y pulso único)*
    │── clock_divider.v *(Módulo de división de reloj)*
    │── one_shot.v *(Módulo generador de un solo pulso)*
    │── counter_debouncer.v  *(Módulo contador para el debouncer)*

---

# 📄 Contenido

## 1. Archivos Utilizados

- `debouncer.v`: Filtra el ruido de señales mecánicas.
- `debouncer_one_shot.v`: Combina un debouncer con un generador de pulso único.
- `clock_divider.v`: Reduce la frecuencia del reloj.
- `one_shot.v`: Genera un pulso único al detectar una transición.
- `counter_debouncer.v`: Contador que mide la estabilidad de una señal para eliminar rebotes.

Estos archivos son fundamentales para el correcto funcionamiento del módulo PWM y garantizan estabilidad en la detección de señales de entrada.

---

### 1.1 Descripción del Módulo PWM

El módulo `pwm.v` genera la señal PWM en base a una frecuencia de 50 Hz, permitiendo modificar el ciclo de trabajo mediante los botones de la FPGA.

- **Incrementa el duty cycle** con `pb_inc`
- **Disminuye el duty cycle** con `pb_dec`
- **Reinicia a 90°** con `rst`

### 1.2 Simulación y Pruebas

El testbench `pwm_tb.v` valida el comportamiento del sistema simulando pulsaciones en los botones y verificando la señal PWM generada.

---


## 2. Diagrama RTL

<img src="assets/images/diagrama_rtl_1.png" alt="Diagrama RTL 1" style="width: 100%; display: block; margin: auto;">
<img src="assets/images/diagrama_rtl_2.png" alt="Diagrama RTL 2" style="width: 100%; display: block; margin: auto;">
<img src="assets/images/diagrama_rtl_3.png" alt="Diagrama RTL 3" style="width: 100%; display: block; margin: auto;">

## 3. Formas de onda

<img src="assets/images/formas_de_onda.png" alt="Formas de onda" style="width: 100%; display: block; margin: auto;">

---

# 📈 Resultados

---

Para la verificación del funcionamiento del sistema, se utilizó Questa Sim de Intel para realizar la simulación y observar las formas de onda generadas. Se realizaron múltiples incrementos y decrementos del duty cycle y, como se muestra en las imágenes de las ondas, se pudo observar cómo el ancho del pulso se ajustaba correctamente.

En la implementación física, logramos*controlar el servomotor en incrementos de 5° por cada pulsación de los botones en la FPGA. Esto nos permitió mover el servomotor de manera precisa y predecible dentro de su rango de 0° a 180°.

---

# ✅ Conclusiones

El diseño e implementación del módulo PWM en Verilog permitieron controlar la posición de un servomotor mediante la FPGA DE10-Lite. Se comprobó que el sistema responde correctamente a los cambios en el ciclo de trabajo a través de los botones de la tarjeta, logrando un control preciso del servomotor.

Durante la práctica, se evidenció que un PWM es una herramienta sumamente útil para controlar con alta precisión un servomotor, lo que permite aplicaciones interesantes en diversas áreas de automatización y robótica.

Además, se observó que el período de la señal PWM es un factor crítico en su funcionamiento. Es fundamental calcularlo correctamente, ya que determina la relación entre el contador y el duty cycle, afectando directamente la precisión del control del servomotor. Un error en este cálculo puede resultar en un comportamiento errático del sistema.

El uso de Verilog y Quartus Prime facilitó la generación, simulación y validación del diseño, lo que permitió identificar y corregir errores antes de la implementación en hardware.

---

# 📚 Bibliografía

- Solectroshop. (2020, 26 agosto). _¿Qué es PWM y cómo usarlo?_  
  [https://solectroshop.com/es/blog/que-es-pwm-y-como-usarlo--n38](https://solectroshop.com/es/blog/que-es-pwm-y-como-usarlo--n38)

- EGASEN. (2021, 13 octubre). _Qué es un servomotor y para qué se utiliza._  
  [https://www.egasen.com/es/blog/noticias/que-es-servomotor-para-que-se-utiliza](https://www.egasen.com/es/blog/noticias/que-es-servomotor-para-que-se-utiliza)
