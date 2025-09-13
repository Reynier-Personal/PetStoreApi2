Feature: CASO 3 - Update Pet Name and Status to Sold

  Background:
    * url baseUrl
    * def petFactory = read('classpath:petstore/pet-data-factory.js')
    * def petId = java.lang.System.currentTimeMillis()
    * def petName = 'TestPet_' + petId
    * def updatedPetName = 'UpdatedPet_' + petId

  @exercise @update-pet
  Scenario: CASO 3 - Actualizar nombre y estatus a sold
    # Setup: Create pet first
    * print '=== CASO 3: Actualizar nombre y estatus a sold ==='
    * def petData = petFactory.createPet({id: petId, name: petName, status: 'available'})
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    * def createdPetId = response.id
    
    # Test: Update pet
    * def updatedPetData = petFactory.createPet({id: createdPetId, name: updatedPetName, status: 'sold'})
    Given path 'pet'
    And request updatedPetData
    When method put
    Then status 200
    And match response == petFactory.getPetSchema()
    And match response.id == createdPetId
    And match response.name == updatedPetName
    And match response.status == 'sold'
    And match response.photoUrls == '#[]'
    And match response.photoUrls[0] == '#string'
    * print 'RESULTADO CASO 3 - Mascota actualizada exitosamente:'
    * print 'Pet ID:', response.id
    * print 'Nombre anterior:', petName
    * print 'Nombre nuevo:', response.name
    * print 'Status anterior: available'
    * print 'Status nuevo:', response.status
    * print 'Pet Photos:', response.photoUrls

  @exercise @update-pet @negative
  Scenario: CASO 3 NEGATIVO - Actualizar mascota inexistente
    * print '=== CASO 3 NEGATIVO: Actualizar mascota inexistente ==='
    * def nonExistentPet = petFactory.createPet({id: 999999999, name: 'NonExistent', status: 'sold'})
    Given path 'pet'
    And request nonExistentPet
    When method put
    Then status 404
    * print 'RESULTADO CASO 3 NEGATIVO - Error esperado con mascota inexistente:'
    * print 'Pet ID inexistente:', 999999999
    * print 'Status Code:', responseStatus

  @exercise @update-pet @negative
  Scenario: CASO 3 NEGATIVO - Actualizar con datos inválidos
    * print '=== CASO 3 NEGATIVO: Actualizar con datos inválidos ==='
    * def invalidUpdate = petFactory.createInvalidPet()
    Given path 'pet'
    And request invalidUpdate
    When method put
    Then status 400
    * print 'RESULTADO CASO 3 NEGATIVO - Error esperado con datos inválidos:'
    * print 'Status Code:', responseStatus
