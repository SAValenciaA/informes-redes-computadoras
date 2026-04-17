# Como usar la plantilla

1. Clonar el repositorio
```bash
   git clone https://github.com/SAValenciaA/informes-redes-computadoras
   cd informes-redes-computadoras
```

2. Traer las ramas remotas
```bash
   git fetch
```

3. Cambiar a la rama tu rama de trabajo
```bash
   git checkout labX-nombre
```

   si eres malcom y trabajas en la laboratorio 6 haces
```bash
   git checkout lab6-malcom
```

   si eres samuel y trabajas en el laboratorio 16
```bash
   git checkout lab16-samuel
```

Si la rama no existe localmente pero sí en remoto:
```bash
git checkout -b labX-nombre origin/labX-nombre
```

4. Trabaja en tu parte del informe

4. Agregar cambios
```bash
   git add .
```

5. Hacer commit
```bash
   git commit -m "Mensaje descriptivo de los cambios"
```

6. Hacer push
```bash
   git push origin labX-nombre
```
