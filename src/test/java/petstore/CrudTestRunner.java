package petstore;

import com.intuit.karate.junit5.Karate;

/**
 * Test Runner para ejecutar CRUD completo de Pet
 * Ejecuta todos los features básicos + casos negativos + cobertura de datos
 */
public class CrudTestRunner {
    
    /**
     * Test específico para validar CRUD básico
     */
    @org.junit.jupiter.api.Test
    public void testBasicCrud() {
        Karate.run("classpath:petstore/features/add-pet.feature",
                  "classpath:petstore/features/get-pet.feature", 
                  "classpath:petstore/features/update-pet.feature",
                  "classpath:petstore/features/search-pet.feature")
                .tags("@exercise")
                .parallel(1);
    }
    
    /**
     * Test para casos negativos
     */
    @org.junit.jupiter.api.Test  
    public void testNegativeCases() {
        Karate.run("classpath:petstore/features")
                .tags("@negative")
                .parallel(1);
    }
    
    /**
     * Test para cobertura de datos
     */
    @org.junit.jupiter.api.Test
    public void testDataCoverage() {
        Karate.run("classpath:petstore/features")
                .tags("@data-coverage")
                .parallel(1);
    }
}
