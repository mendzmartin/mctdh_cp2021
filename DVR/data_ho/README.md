# Configuración de corridas

## CORRIDA N°1

```

mendez@mendez-famaf:~/MCTDH/DVR/sine_DVR$ ./sinedvr_ho_v3 
	Total grid size			= 50 prop L=100
	Number of grid points	= 250 
	Frequency value			= 1
	Initial beta value		= 0.01
	Final beta value		= 0.1
	DeltaX					= 0.80321285140562249 
	L						= 201.60642570281124 (MAL)
	N						= 250

```

## CORRIDA N°2 (variando N para grid size fijo)

```

mendez@mendez-famaf:~/MCTDH/DVR/sine_DVR$ ./sinedvr_ho_v3 
	Total grid size 		= 50
	Number of grid points	= 500
	Frequency value			= 1
	Initial beta value		= 0.01
	Final beta value		= 0.1
	DeltaX					= 0.40080160320641284     
	L						= 200.80160320641284     
	N						= 500

```

## CORRIDA N°3 (variando N para L fijo aprox (corrida N°2) )

```

mendez@mendez-famaf:~/MCTDH/DVR/sine_DVR$ ./sinedvr_ho_v3 
	Total grid size			= 50
	Number of grid points	= 1000
	Frequency value			= 1
	Initial beta value		= 0.01
	Final beta value		= 0.1
	DeltaX					= 0.20020020020020021     
	L						= 200.40040040040040     
	N						= 1000

```

	Nota: aumento mucho más el tiempo de corrida

## CORRIDA N°4 (variando L para N fijo (corrida N°2) )

```

mendez@mendez-famaf:~/MCTDH/DVR/sine_DVR$ ./sinedvr_ho_v3 
	Total grid size			= 100
	Number of grid points	= 500
	Frequency value			= 1
	Initial beta value		= 0.01
	Final beta value		= 0.1
	DeltaX					= 0.80160320641282568     
	L						= 401.60320641282567     
	N						= 500

```

## CORRIDA N°5 (variando frecuencia para L y N fijo (corrida N°2) )

```

mendez@mendez-famaf:~/MCTDH/DVR/sine_DVR$ ./sinedvr_ho_v3 
	Total grid size			= 50
	Number of grid points	= 500
	Frequency value			= 50
	Initial beta value		= 0.01
	Final beta value		= 0.1
	DeltaX					= 0.40080160320641284     
	L						= 200.80160320641284     
	N						= 500

```
