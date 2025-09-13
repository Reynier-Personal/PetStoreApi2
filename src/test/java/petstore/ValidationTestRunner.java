package petstore;

import com.intuit.karate.junit5.Karate;

/**
 * Test Runner especializado en validaciones
 * Ejecuta tests de schema validation, data integrity y edge cases
 */
public class ValidationTestRunner {
    
    /**
     * Test de validación de schemas
     */
    @org.junit.jupiter.api.Test
    public void testSchemaValidation() {
        Karate.run("classpath:petstore/features")
                .tags("@exercise")
                .parallel(1);
    }
    
    /**
     * Test de casos edge y borde values
     */
    @org.junit.jupiter.api.Test
    public void testEdgeCases() {
        Karate.run("classpath:petstore/features")
                .tags("@data-coverage")
                .parallel(1);
    }
    
    /**
     * Test de manejo de errores
     */
    @org.junit.jupiter.api.Test
    public void testErrorHandling() {
        Karate.run("classpath:petstore/features")
                .tags("@negative")
                .parallel(1);
    }
}
