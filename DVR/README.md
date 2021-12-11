# Final proyect repository

## DVR repository

* DVR
  * The (D)iscrete (V)ariable (R)epresentation is a powerful method for representing wavefunctions and operators and numerically solve problems of quantum mechanics.
  * Here we used Sine DVR and Lapack to diagonalize different Hamiltonian operators.

## Repository contents

### data_ho; data_ho_study_01; data_ho_study_02_v1; data_ho_study_02_v2; data_ho_study_03; data_ho_study_04; sinedvr_NeHeplus

* ***En estas carpetas se guardan los resultados de las simulaciones, gráficas, autovalores, autovectores, potencial, puntos de la grilla, scripts, etc.***
* Se estudió el oscilador armónico unidimensional, el cual es un hamiltoniano muy conocido y del cual sabemos admite resolución exacta con lo cual se pueden comparar los resultados obtenidos.
* Se graficaron autovalores (o energías) y autovectores (o funciones de onda) del hamiltoniano; potencial armónico
* Dentro de *data_ho* se puede observar que se llevaron a cabo 5 corridas y dentro, en el archivo *"README.md"*, se pueden observar las diferencias entre cada una de ellas.
* La idea general fue comprobar que las autoenergía no dependen del parámetro "beta" (pues no interviene en la física del problema), la paridad de las autofunciones, los valores que esperamos para las energías y el potencial. Además, se llevaron a cabo estudios de performance dependiendo del manejo de alocación de memoria en los programas de FORTRAN, y se estudiaron los comportamientos de los resultados respecto de los parámetros que entran en juego en el métodos sine DVR (con análisis de error).
* Para mayor información ver la carpeta Sine_DVR.

### sine_DVR

* ***En esta carpeta se guardan los programas en lenguaje FORTRAN y los archivos binarios (ejecutables)***
* Se escribieron 7 programas y donde en el archivo *"README.md"* se pueden conocer las características y diferencias entre cada uno de ellos.
