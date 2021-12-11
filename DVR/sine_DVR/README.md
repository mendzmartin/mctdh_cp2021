# IDENTIFICACIÓN DE PROGRAMAS

## Programas
* mmlib.f: Library module containing linear algebra routines that involve the multiplication of matrices.

* sinedvr_1e1N_vs_beta.f: Sine DVR TO APPROXIMATE NeHe+ NANO-THREAD POTENTIAL. Programa de de partida para tomar como modelo en el desarrollo de los programas subsecuentes.

* sinedvr_ho.f90: Sine DVR TO APPROXIMATE HARMONIC OSCILLATOR (HO)
  * sinedvr_ho_study_01.f90: primer analisis partiendo del programa base sinedvr_ho.f90 donde se busca graficar los resultados en funcion de un parámetro físico (frecuencia), discretizando este parámetro en el programa.
  * sinedvr_ho_study_02.f90: segundo analisis partiendo del programa base sinedvr_ho.f90
    * sinedvr_ho_study_02_v1.f90: versión 1, alocación variable de memoria
    * sinedvr_ho_study_02_v2.f90: versión 2, alocación fija de memoria
  * sinedvr_ho_study_03.f90: segundo analisis partiendo del programa base sinedvr_ho.f90 discretizando la longitud de la caja de potencial (variable L).
