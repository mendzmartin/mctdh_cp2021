## Notes

#### OMP_STACKSIZE
+ [link1](https://www.openmp.org/spec-html/5.0/openmpse54.html)
+ [link2](https://www.bgu.ac.il/intel_fortran_docs/compiler_f/main_for/mergedProjects/optaps_for/common/optaps_par_var.htm)
> Recommended size is 16M.

#### OMP_SCHEDULE
+ [link1](https://www.openmp.org/spec-html/5.0/openmpse49.html)

#### configurations
> Para todos los casos se fijo el valor de lambda=0.5 y se llevo a cabo tratamiento de partículas idénticas.
> La configuración de MCTDH para obtener energías de estados excitados con método de relajación se utilizó `relaxation=follow,full,ortho`.

### Threads configurations

#### conf01
```bash
    #$ -pe smp 1
    export OMP_NUM_THREADS=1
    export OMP_SCHEDULE="dynamic,128"
    export OMP_STACKSIZE="512M"
```

#### conf02
```bash
    #$ -pe smp 2
    export OMP_NUM_THREADS=2
    export OMP_SCHEDULE="dynamic,128"
    export OMP_STACKSIZE="512M"
```

#### conf03
```bash
    #$ -pe smp 3
    export OMP_NUM_THREADS=3
    export OMP_SCHEDULE="dynamic,128"
    export OMP_STACKSIZE="512M"
```

#### conf04
```bash
    #$ -pe smp 4
    export OMP_NUM_THREADS=4
    export OMP_SCHEDULE="dynamic,128"
    export OMP_STACKSIZE="512M"
```

### Schedule configurations

#### conf04_v2
```bash
    #$ -pe smp 4
    export OMP_NUM_THREADS=4
    export OMP_SCHEDULE="static,default"
    export OMP_STACKSIZE="512M"
```

#### conf04_v3
```bash
    #$ -pe smp 4
    export OMP_NUM_THREADS=4
    export OMP_SCHEDULE="static,128"
    export OMP_STACKSIZE="512M"
```

#### conf04_v4
```bash
    #$ -pe smp 4
    export OMP_NUM_THREADS=4
    export OMP_SCHEDULE="guided"
    export OMP_STACKSIZE="512M"
```

#### conf04_v5
```bash
    #$ -pe smp 4
    export OMP_NUM_THREADS=4
    export OMP_SCHEDULE="auto"
    export OMP_STACKSIZE="512M"
```