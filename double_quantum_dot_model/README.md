# Final proyect repository
  
## Goal

> Estudio y análisis (con las herramientas aprendidas hasta ahora) de un hamiltoniano para modelar un punto cuántico con dos electrones.
> Este problema, en principio, sería el utilizado para hacer estudio de performance con lo visto en el curso de Computación Paralela.
> El modelo cuenta con un potencial armónico bidimensional.

## Repository contents

* 01_effcou_interaction folder
  * Carpeta que contiene aquellas modificaciones que se deben agregar al paquete mctdh (install and source folders) para poder compilar qdot_02.
* qdot_01 folder
  * Se analiza el hamiltoniano efectivo para dos electrones en dos pozos de potencial (puntos cuánticos derecho e izquierdo) sin considerar un potencial de interacción.
  * Análisis mediante el paquete de MCTDH y representación en Sine-DVR. Se intenta reproducir el espectro de energías y funciones de onda  tanto con el paquete MCTDH como con la representación Sine-DVR (programa hecho en FORTRAN).
* qdot_02 folder
  * Se agrega al hamiltoniano considerado en *qdot_01 folder* el potencial de interacción.
  * Se realiza una relajación para calcular el estado fundamental y se comparan los resultados con aquellos previos asociados a los hamiltonianos sin interacción.
  
## Math expressions
  
* The longitudinal open potentials from the embedded QD

![Potencial](https://cfn-live-content-bucket-iop-org.s3.amazonaws.com/journals/0953-8984/32/6/065302/2/cmab41a9eqn005.gif?AWSAccessKeyId=AKIAYDKQL6LTV7YY2HIK&Expires=1640460383&Signature=lr8WBFfyBcoLPkxcioY8JW5%2BC7g%3D)

* The individual effective Hamiltonian

![Hamiltoniano](https://cfn-live-content-bucket-iop-org.s3.amazonaws.com/journals/0953-8984/32/6/065302/2/cmab41a9eqn009.gif?AWSAccessKeyId=AKIAYDKQL6LTV7YY2HIK&Expires=1640460383&Signature=MiK4Ku0a9rfWnt%2BQLArQOyr9n9A%3D)


## Useful links

* [Pont, F.M., Molle, A., Berikaa, E.R., Bubeck, S. and Bande, A., 2019. Predicting the performance of the inter-Coulombic electron capture from single-electron quantities. Journal of Physics: Condensed Matter, 32(6), p.065302.](https://iopscience.iop.org/article/10.1088/1361-648X/ab41a9)
