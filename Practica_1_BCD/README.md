<div align="center">
  <img src="../assets/images/tecnologico_de_monterrey_logo.png" alt="Tecnológico de Monterrey" width="750">
</div>

<br>

<div align="center">

## Campus Guadalajara

# Práctica 1 - BCD

### Gustavo Alexander Nuño Corvera

### A01644775

### Ingeniería en Robótica y Sistemas Digitales

#### TE2002B - Diseño con lógica programable

</div>

---

# Resumen

La práctica consiste en diseñar e implementar un sistema en Verilog para la FPGA DE10-Lite que lea el valor ingresado en sus 10 switches, lo interprete como un número binario y lo convierta a su equivalente decimal. Este valor se mostrará en los displays de 7 segmentos mediante un decodificador. Para ello, se desarrollaron múltiples módulos en Verilog, incluyendo un decodificador de 7 segmentos, un manejador de displays y un módulo de pruebas (testbench) para verificar su funcionamiento.

---

# Introducción

## Verilog y Quartus

Verilog HDL es un lenguaje de descripción de hardware utilizado para programar circuitos y sistemas electrónicos. Se emplea en el diseño digital para simulación, análisis de tiempos, pruebas de testabilidad y síntesis lógica. (_Doulos, s. f._).

Quartus es un entorno de diseño de Intel para la programación y simulación de FPGAs, SoCs y CPLDs. Permite la integración de Verilog y VHDL, ofreciendo herramientas para síntesis, verificación y optimización de sistemas digitales (_Intel, s. f._).

## FPGA y su funcionalidad

Un FPGA (Field Programmable Gate Array) es un conjunto de circuitos integrados configurables que permiten al usuario personalizar su funcionamiento según la tarea requerida. A diferencia de los procesadores tradicionales, que ejecutan instrucciones de software, los FPGA pueden ser reprogramados para modificar la estructura de sus puertas lógicas y las conexiones entre ellas.

Estos dispositivos tienen una amplia variedad de aplicaciones en distintos campos, como la exploración espacial, los automóviles inteligentes y los servidores de telecomunicaciones. Su principal ventaja radica en la capacidad de optimización para tareas específicas, lo que los hace más eficientes y con un mayor rendimiento en comparación con procesadores genéricos.

Una diferencia clave entre los FPGA y plataformas programables como Arduino o Raspberry Pi es que estas últimas dependen de un microprocesador para ejecutar instrucciones, mientras que los FPGA requieren ser configurados previamente para realizar una tarea específica (_Romero, 2021_).

## Interruptores DIP

Los interruptores DIP (Dual In-line Package switch) son dispositivos electrónicos manuales compuestos por una serie de pequeños interruptores que permiten representar señales digitales mediante estados lógicos, donde 0 indica un estado apagado y 1 un estado encendido (_TE Connectivity_).

## Displays de 7 segmentos

Para la visualización de información en sistemas digitales, se emplean los displays de 7 segmentos, dispositivos alfanuméricos formados por diodos emisores de luz (LEDs) dispuestos de manera que permiten representar los números del 0 al 9 y algunas letras del sistema hexadecimal (A, B, C, D, E, F). Cada segmento individual del display corresponde a un LED, el cual puede encenderse o apagarse para formar los diferentes caracteres.

Existen dos tipos principales de displays de 7 segmentos: ánodo común y cátodo común. En el primero, los ánodos de los LEDs están conectados entre sí y se activan con un voltaje positivo, mientras que en el segundo, los cátodos están unidos y requieren una señal de baja tensión para encenderse. En nuestro caso, la FPGA DE10-Lite utiliza un display de cátodo común, lo que significa que debemos enviar un nivel lógico bajo (0) para activar los segmentos y mostrar la información en pantalla.

## Decodificadores

Para controlar el display de 7 segmentos, se emplea un decodificador, un circuito digital basado en compuertas lógicas. Su función es recibir un número en binario y convertirlo en la combinación adecuada de estados lógicos para iluminar los segmentos correctos y representar su equivalente en decimal. Como se menciona en _Electrónica Digital Circuitos_ (s. f.), un decodificador funciona "a base de estados lógicos, con los cuales indica una salida determinada basándose en un dato de entrada característico. Su función operacional se basa en la introducción a sus entradas de un número en código binario correspondiente a su equivalente en decimal para mostrar en los siete pines de salida establecidos para el integrado" (_Electrónica Digital Circuitos_).

En este proyecto, se diseñó un decodificador en Verilog que recibe una entrada binaria y la traduce a su representación decimal en el display de 7 segmentos.

## Representación de múltiples cifras

Además, para representar correctamente números de varias cifras, el sistema utiliza un método basado en la operación módulo. Este proceso permite extraer los diferentes dígitos de un número binario, separándolos en unidades, decenas, centenas, etc., para distribuirlos en los distintos displays de 7 segmentos y facilitar su correcta visualización.

---

# Contenido

## 1. Código en Verilog

Archivos .v utilizados en la implementación:

- `bcd.v`
- `display_module.v`
- `decoder_7_seg.v`
- `bcd_tb.v` (Testbench)

Para lograrlo, se desarrollaron los siguientes módulos:

### 1.1 Módulos del sistema

- **decoder_7_seg**

  - Recibe una entrada de 4 bits y la convierte en un número hexadecimal representado en un display de 7 segmentos.

- **display_module**

  - Gestiona múltiples instancias del módulo decoder_7_seg para manejar la visualización de diferentes unidades (unidades, decenas, centenas, millares, decenas de millar y centenas de millar).
  - Se encarga de recibir un número binario de n bits y distribuir cada dígito en los distintos displays mediante operaciones de módulo y división que permitan la visualización en el sistema decimal.

- **bcd**

  - Recibe la entrada directamente desde los switches y la envía al display_module para su conversión y visualización.
  - Gestiona las salidas para controlar los diferentes displays.

- **bcd_tb (Testbench)**

  - Se encarga de probar el correcto funcionamiento del módulo bcd generando valores aleatorios de entrada mediante la función set_input, que asigna un número aleatorio sin signo (unsigned random) en el rango de 0 a 2^"BIT_SIZE"-1.
  - Realiza i iteraciones, donde se asigna el número aleatorio a bcd_in_sw, simulando el comportamiento de los switches.
  - Permite la observación de las señales de salida para verificar el correcto funcionamiento del sistema.

## 2. Diagrama RTL

<img src="assets/images/diagrama_rtl.png" alt="Diagrama RTL" style="width: 100%; display: block; margin: auto;">

## 3. Formas de onda

<img src="assets/images/formas_de_onda.png" alt="Formas de onda" style="width: 100%; display: block; margin: auto;">

---

# Resultados

Para la verificación del funcionamiento del sistema, se utilizó Questa Sim de Intel para realizar la simulación y observar las formas de onda generadas. Se realizaron 10 casos de prueba para verificar el correcto funcionamiento del sistema. En la imagen de las formas de onda, se puede ver cómo los valores ingresados a través de los switches se interpretan correctamente y se descomponen en sus respectivas unidades, decenas, centenas y millares.

# Conclusiones

Inicialmente, se consideró implementar la lógica del convertidor a decimal en un solo archivo con múltiples módulos de display. Sin embargo, se descubrió que no era necesario modificar el archivo del decoder, ya que su única tarea es decodificar un número específico. En cambio, la transformación a decimal se implementó en el módulo superior display_module, lo que permitió una estructura modular más flexible y reutilizable.

Gracias a esta organización, el sistema ahora puede representar números de hasta 999,999 sin necesidad de modificar el decoder original, lo que optimiza el desarrollo y facilita la reutilización de código.

# Bibliografía

Romero, J. (2021, 21 diciembre). ¿Qué es un FPGA y para qué sirve? _GEEKNETIC._  
[https://www.geeknetic.es/FPGA/que-es-y-para-que-sirve](https://www.geeknetic.es/FPGA/que-es-y-para-que-sirve)

TE Connectivity. (s. f.). _Optimizar configuraciones en placas de circuitos._  
[https://www.te.com/es/products/switches/dip-switches.html?tab=pgp-story](https://www.te.com/es/products/switches/dip-switches.html?tab=pgp-story)

Electrónica Digital Circuitos. (s. f.). _Decodificador BCD a 7 segmentos._  
[https://sites.google.com/site/electronicadigitalmegatec/introducción-a-sistemas-digitales/decodificador-bcd-a-7-segmentos](https://sites.google.com/site/electronicadigitalmegatec/introducción-a-sistemas-digitales/decodificador-bcd-a-7-segmentos)

Doulos. (s. f.). _What is Verilog?_  
[https://www.doulos.com/knowhow/verilog/what-is-verilog/](https://www.doulos.com/knowhow/verilog/what-is-verilog/)

Intel. (s. f.). _Software de diseño Quartus® Prime._  
[https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html)
