#!/bin/bash

echo "========================================"
echo "PETSTORE API TESTING - SCRIPT DE EJECUCION"
echo "========================================"
echo

# Verificar Java
echo "[1/5] Verificando Java..."
if ! command -v java &> /dev/null; then
    echo "ERROR: Java no encontrado. Instalar Java 11 o superior."
    exit 1
fi
java -version
echo "Java OK"
echo

# Verificar Maven
echo "[2/5] Verificando Maven..."
if ! command -v mvn &> /dev/null; then
    echo "ERROR: Maven no encontrado. Instalar Maven 3.6 o superior."
    exit 1
fi
mvn -version
echo "Maven OK"
echo

# Limpiar proyecto
echo "[3/5] Limpiando proyecto..."
mvn clean
echo

# Compilar proyecto
echo "[4/5] Compilando proyecto..."
mvn compile test-compile
if [ $? -ne 0 ]; then
    echo "ERROR: Fallo en compilacion"
    exit 1
fi
echo "Compilacion OK"
echo

# Ejecutar tests
echo "[5/5] Ejecutando tests..."
echo
echo "Seleccione el tipo de test a ejecutar:"
echo "1. CRUD Completo (casos basicos + negativos + cobertura)"
echo "2. Features Individuales (cada feature por separado)"
echo "3. Solo Validaciones (casos negativos y edge cases)"
echo "4. Todos los tests"
echo
read -p "Ingrese su opcion (1-4): " choice

case $choice in
    1)
        echo "Ejecutando CRUD Completo..."
        mvn test -Dtest=CrudTestRunner
        ;;
    2)
        echo "Ejecutando Features Individuales..."
        mvn test -Dtest=IndividualTestRunner
        ;;
    3)
        echo "Ejecutando Solo Validaciones..."
        mvn test -Dtest=ValidationTestRunner
        ;;
    4)
        echo "Ejecutando Todos los Tests..."
        mvn test
        ;;
    *)
        echo "Opcion invalida. Ejecutando CRUD Completo por defecto..."
        mvn test -Dtest=CrudTestRunner
        ;;
esac

echo
echo "========================================"
echo "EJECUCION COMPLETADA"
echo "========================================"
echo
echo "Reportes generados en: target/karate-reports/"
echo "Abrir: target/karate-reports/karate-summary.html"
echo
