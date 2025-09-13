# GUÍA DE INSTALACIÓN Y EJECUCIÓN - PETSTORE API TESTING

## REQUISITOS PREVIOS

### Software Necesario:
- **Java 11 o superior** - [Descargar OpenJDK](https://adoptium.net/)
- **Maven 3.6 o superior** - [Descargar Maven](https://maven.apache.org/download.cgi)
- **Git** (opcional) - Para clonar el repositorio

### Verificación de Requisitos:
```bash
# Verificar Java
java -version
# Debe mostrar: openjdk version "11.x.x" o superior

# Verificar Maven  
mvn -version
# Debe mostrar: Apache Maven 3.6.x o superior
```

## INSTALACIÓN PASO A PASO

### Opción 1: Clonar desde Git
```bash
git clone [URL_DEL_REPOSITORIO]
cd PetStoreApi2
```

### Opción 2: Descargar ZIP
1. Descargar el archivo ZIP del proyecto
2. Extraer en directorio deseado
3. Abrir terminal en la carpeta extraída

## ▶EJECUCIÓN DE TESTS

### Método 1: Scripts Automatizados (RECOMENDADO)

**Windows:**
```cmd
run-tests.bat
```

**Linux/Mac:**
```bash
chmod +x run-tests.sh
./run-tests.sh
```

### Método 2: Comandos Maven Directos

**CRUD Completo:**
```bash
mvn test -Dtest=CrudTestRunner
```

**Features Individuales:**
```bash
mvn test -Dtest=IndividualTestRunner
```

**Solo Validaciones:**
```bash
mvn test -Dtest=ValidationTestRunner
```

**Todos los Tests:**
```bash
mvn test
```

### Método 3: Tests Específicos

**Solo Añadir Mascota:**
```bash
mvn test -Dtest=IndividualTestRunner#testAddPet
```

**Solo Casos Negativos:**
```bash
mvn test -Dtest=CrudTestRunner#testNegativeCases
```

**Solo Cobertura de Datos:**
```bash
mvn test -Dtest=CrudTestRunner#testDataCoverage
```

## VISUALIZACIÓN DE REPORTES

### Ubicación de Reportes:
```
target/
├── karate-reports/
│   ├── karate-summary.html    # Reporte principal
│   ├── karate-timeline.html   # Timeline de ejecución
│   └── [feature-name].html    # Reportes por feature
├── surefire-reports/          # Reportes JUnit
└── karate.log                 # Log detallado
```

### Abrir Reportes:
**Windows:**
```cmd
start target\karate-reports\karate-summary.html
```

**Linux/Mac:**
```bash
open target/karate-reports/karate-summary.html
```

## 🔧 SOLUCIÓN DE PROBLEMAS

### Error: "Java no encontrado"
```bash
# Verificar instalación
java -version

# Si no está instalado, descargar de:
# https://adoptium.net/
```

### Error: "Maven no encontrado"
```bash
# Verificar instalación
mvn -version

# Si no está instalado, descargar de:
# https://maven.apache.org/download.cgi
```

### Error: "baseUrl not defined"
- Verificar que existe: `src/test/resources/karate-config.js`
- El archivo debe contener: `baseUrl: 'https://petstore.swagger.io/v2'`

### Error: "Connection refused"
- Verificar conexión a internet
- Probar acceso manual: `curl https://petstore.swagger.io/v2/pet/1`

### Tests Fallan Inesperadamente
- Revisar `target/karate.log` para detalles
- La API real puede diferir de la documentación (ver conclusiones.txt)

## ESTRUCTURA DEL PROYECTO

```
PetStoreApi2/
├── src/test/java/petstore/           # Test Runners
│   ├── CrudTestRunner.java           # CRUD completo
│   ├── IndividualTestRunner.java     # Features individuales
│   └── ValidationTestRunner.java     # Validaciones
├── src/test/resources/
│   ├── karate-config.js              # Configuración global
│   └── petstore/
│       ├── pet-data-factory.js       # Factory de datos
│       └── features/                 # Features de prueba
│           ├── add-pet.feature       # Añadir mascota
│           ├── get-pet.feature       # Consultar por ID
│           ├── update-pet.feature    # Actualizar mascota
│           └── search-pet.feature    # Buscar por status
├── run-tests.bat                     # Script Windows
├── run-tests.sh                      # Script Linux/Mac
├── README.txt                        # Documentación técnica
├── conclusiones.txt                  # Hallazgos y análisis
└── pom.xml                          # Configuración Maven
```
