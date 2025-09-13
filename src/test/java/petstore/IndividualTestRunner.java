package petstore;

import com.intuit.karate.junit5.Karate;

/**
 * Test Runner para ejecutar features individuales
 * Permite ejecutar cada feature por separado para testing granular
 */
public class IndividualTestRunner {
    
    /**
     * Test individual: Añadir mascota
     */
    @org.junit.jupiter.api.Test
    public void testAddPet() {
        Karate.run("classpath:petstore/features/add-pet.feature")
                .tags("@add-pet and @exercise")
                .parallel(1);
    }
    
    /**
     * Test individual: Consultar mascota por ID
     */
    @org.junit.jupiter.api.Test
    public void testGetPet() {
        Karate.run("classpath:petstore/features/get-pet.feature")
                .tags("@get-pet and @exercise")
                .parallel(1);
    }
    
    /**
     * Test individual: Actualizar mascota
     */
    @org.junit.jupiter.api.Test
    public void testUpdatePet() {
        Karate.run("classpath:petstore/features/update-pet.feature")
                .tags("@update-pet and @exercise")
                .parallel(1);
    }
    
    /**
     * Test individual: Buscar mascota por status
     */
    @org.junit.jupiter.api.Test
    public void testSearchPet() {
        Karate.run("classpath:petstore/features/search-pet.feature")
                .tags("@search-pet and @exercise")
                .parallel(1);
    }
    
}
