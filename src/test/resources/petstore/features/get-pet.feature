Feature: CASO 2 - Get Pet by ID

  Background:
    * url baseUrl
    * def petFactory = read('classpath:petstore/pet-data-factory.js')
    * def petId = java.lang.System.currentTimeMillis()
    * def petName = 'TestPet_' + petId

  @exercise @get-pet
  Scenario: CASO 2 - Consultar mascota por ID
    # Setup: Create pet first
    * print '=== CASO 2: Consultar mascota por ID ==='
    * def petData = petFactory.createPet({id: petId, name: petName, status: 'available'})
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    * def createdPetId = response.id
    
    # Test: Obtener pet por ID
    Given path 'pet', createdPetId
    When method get
    Then status 200
    And match response == petFactory.getPetSchema()
    And match response.id == createdPetId
    And match response.name == petName
    And match response.photoUrls == '#[]'
    And match response.photoUrls[0] == '#string'
    * print 'RESULTADO CASO 2 - Mascota encontrada por ID:'
    * print 'Pet ID consultado:', createdPetId
    * print 'Pet encontrada:', response.name
    * print 'Status actual:', response.status
    * print 'Pet Photos:', response.photoUrls

  @exercise @get-pet @negative
  Scenario: CASO 2 NEGATIVO - Consultar mascota con ID inexistente
    * print '=== CASO 2 NEGATIVO: Consultar mascota con ID inexistente ==='
    * def nonExistentId = 999999999
    Given path 'pet', nonExistentId
    When method get
    Then status 404
    * print 'RESULTADO CASO 2 NEGATIVO - Error esperado con ID inexistente:'
    * print 'Pet ID consultado:', nonExistentId
    * print 'Status Code:', responseStatus

  @exercise @get-pet @negative
  Scenario: CASO 2 NEGATIVO - Consultar mascota con ID inválido
    * print '=== CASO 2 NEGATIVO: Consultar mascota con ID inválido ==='
    Given path 'pet', '11invalid-id'
    When method get
    Then status 400
    * print 'RESULTADO CASO 2 NEGATIVO - Error esperado con ID inválido:'
    * print 'Pet ID consultado: invalid-id'
    * print 'Status Code:', responseStatus
