PETSTORE API TESTING - EJERCICIO 2
=====================================

DESCRIPCIÓN:
Este proyecto implementa pruebas automatizadas para la API de PetStore usando Karate Framework.
Cubre los 4 casos de prueba solicitados en el ejercicio.

REQUISITOS PREVIOS:
- Java 11 o superior
- Maven 3.6 o superior
- Conexión a internet (para acceder a https://petstore.swagger.io/v2)

ESTRUCTURA DEL PROYECTO:
PetStoreApi2/
├── src/test/java/petstore/
│   ├── BaseTestRunner.java          # Clase base para runners
│   ├── ExerciseTestRunner.java      # Runner específico del ejercicio
│   ├── SimpleTestRunner.java        # Runner para tests simples
│   └── CrudTestRunner.java          # Runner para tests CRUD
├── src/test/resources/
│   ├── karate-config.js             # Configuración global de Karate
│   └── petstore/
│       ├── petstore-exercise.feature    # Feature principal del ejercicio
│       ├── pet-data-factory-new.js      # Factory de datos para tests
│       ├── add-pet.feature              # Test individual: añadir mascota
│       ├── get-pet.feature              # Test individual: consultar mascota
│       ├── update-pet.feature           # Test individual: actualizar mascota
│       └── find-pet-by-status.feature   # Test individual: buscar por status
├── pom.xml                          # Configuración Maven
├── README.txt                       # Este archivo
└── conclusiones.txt                 # Hallazgos y conclusiones

INSTRUCCIONES DE EJECUCIÓN:

1. CLONAR EL REPOSITORIO:
   git clone [URL_DEL_REPOSITORIO]
   cd PetStoreApi2

2. VERIFICAR REQUISITOS:
   java -version    # Debe ser Java 11+
   mvn -version     # Debe ser Maven 3.6+

3. EJECUTAR EL EJERCICIO COMPLETO:
   mvn test -Dtest=ExerciseTestRunner

   Este comando ejecutará los 4 casos de prueba en secuencia:
   - Caso 1: Añadir una mascota a la tienda
   - Caso 2: Consultar la mascota por ID
   - Caso 3: Actualizar nombre y estatus a "sold"
   - Caso 4: Consultar mascota por estatus

4. EJECUTAR TESTS INDIVIDUALES (OPCIONAL):
   mvn test -Dtest=SimpleTestRunner     # Tests básicos
   mvn test -Dtest=CrudTestRunner       # Tests CRUD completos
   mvn test                             # Todos los tests

5. VER REPORTES:
   Los reportes se generan en: target/karate-reports/
   Abrir: target/karate-reports/karate-summary.html

CASOS DE PRUEBA IMPLEMENTADOS:

CASO 1: Añadir una mascota a la tienda
- Endpoint: POST /pet
- Entrada: JSON con datos de mascota (ID único, nombre, categoría, status "available")
- Validación: Status 200, ID correcto, nombre correcto, status "available"

CASO 2: Consultar mascota por ID
- Endpoint: GET /pet/{petId}
- Entrada: ID de la mascota creada en Caso 1
- Validación: Status 200, datos coinciden con mascota creada

CASO 3: Actualizar nombre y estatus
- Endpoint: PUT /pet
- Entrada: JSON con mismo ID, nuevo nombre, status "sold"
- Validación: Status 200, nombre actualizado, status "sold"

CASO 4: Consultar por estatus
- Endpoint: GET /pet/findByStatus?status=sold
- Entrada: Parámetro status="sold"
- Validación: Status 200, mascota actualizada aparece en resultados

VARIABLES UTILIZADAS:
- petId: Timestamp único para cada ejecución
- petName: Nombre inicial de la mascota
- updatedPetName: Nombre actualizado de la mascota
- baseUrl: https://petstore.swagger.io/v2

CONFIGURACIÓN:
- Base URL: https://petstore.swagger.io/v2
- Content-Type: application/json
- Timeout: 30 segundos por defecto

SOLUCIÓN DE PROBLEMAS:

1. Error de conexión:
   - Verificar conexión a internet
   - Verificar que https://petstore.swagger.io/ esté disponible

2. Error "baseUrl not defined":
   - Verificar que existe src/test/resources/karate-config.js
   - Verificar configuración en karate-config.js

3. Tests fallan:
   - Verificar que la API esté respondiendo: curl https://petstore.swagger.io/v2/pet/1
   - Revisar logs en target/karate.log

4. Compilación falla:
   - Verificar versión de Java: java -version
   - Limpiar proyecto: mvn clean compile

CONTACTO:
Para dudas o problemas, revisar el archivo conclusiones.txt con hallazgos detallados.
