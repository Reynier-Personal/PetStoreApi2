package petstore;

import com.intuit.karate.junit5.Karate;

/**
 * Test Runner para ejecutar el test E2E completo
 * Ejecuta el flujo completo de 4 pasos secuenciales como un solo scenario
 */
public class E2ETestRunner {
    
    /**
     * Test E2E completo: Añadir → Consultar → Actualizar → Buscar
     */
    @org.junit.jupiter.api.Test
    public void testE2ECompleteFlow() {
        Karate.run("classpath:petstore/petstore-e2e.feature")
                .tags("@e2e")
                .parallel(1);
    }
    
    /**
     * Test E2E con validaciones extendidas
     */
    @org.junit.jupiter.api.Test
    public void testE2EWithValidations() {
        Karate.run("classpath:petstore/petstore-e2e.feature")
                .tags("@e2e and @exercise")
                .parallel(1);
    }
}
