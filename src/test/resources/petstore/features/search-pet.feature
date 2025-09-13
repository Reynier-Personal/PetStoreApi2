Feature: CASO 4 - Search Pet by Status

  Background:
    * url baseUrl
    * def petFactory = read('classpath:petstore/pet-data-factory.js')
    * def petId = java.lang.System.currentTimeMillis()
    * def petName = 'TestPet_' + petId
    * def updatedPetName = 'UpdatedPet_' + petId

  @exercise @search-pet
  Scenario: CASO 4 - Consultar mascota por estatus sold
    # Setup: Create and update  pet status 'sold'
    * print '=== CASO 4: Consultar mascota por estatus sold ==='
    * def petData = petFactory.createPet({id: petId, name: petName, status: 'available'})
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    
    # Update status sold
    * def updatedPetData = petFactory.createPet({id: petId, name: updatedPetName, status: 'sold'})
    Given path 'pet'
    And request updatedPetData
    When method put
    Then status 200
    * def soldPetId = response.id
    
    # Test: Search por status 'sold'
    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    And match response == '#[]'
    * def foundPet = null
    * eval for (var i = 0; i < response.length; i++) if (response[i].id == soldPetId) foundPet = response[i]
    * match foundPet != null
    And match foundPet == petFactory.getPetSchema()
    And match foundPet.id == soldPetId
    And match foundPet.name == updatedPetName
    And match foundPet.status == 'sold'
    And match foundPet.photoUrls == '#[]'
    And match foundPet.photoUrls[0] == '#string'
    * print 'RESULTADO CASO 4 - Mascota encontrada por estatus:'
    * print 'Búsqueda por status: sold'
    * print 'Total mascotas con status sold:', response.length
    * print 'Nuestra mascota encontrada:'
    * print 'Pet ID:', foundPet.id
    * print 'Pet Name:', foundPet.name
    * print 'Pet Status:', foundPet.status
    * print 'Pet Photos:', foundPet.photoUrls

  @exercise @search-pet @negative
  Scenario: CASO 4 NEGATIVO - Buscar con status inválido
    * print '=== CASO 4 NEGATIVO: Buscar con status inválido ==='
    Given path 'pet/findByStatus'
    And param status = 'invalid-status'
    When method get
    Then status 400
    * print 'RESULTADO CASO 4 NEGATIVO - Array vacío con status inválido:'
    * print 'Status buscado: invalid-status'
    * print 'Mascotas encontradas:', response.length

  @exercise @search-pet @negative
  Scenario: CASO 4 NEGATIVO - Buscar sin parámetro status
    * print '=== CASO 4 NEGATIVO: Buscar sin parámetro status ==='
    Given path 'pet/findByStatus'
    When method get
    Then status 400
    * print 'RESULTADO CASO 4 NEGATIVO - Error esperado sin parámetro requerido:'
    * print 'Status Code:', responseStatus

  @exercise @search-pet @data-coverage
  Scenario: CASO 4 COBERTURA - Buscar mascotas con status pending
    * print '=== CASO 4 COBERTURA: Buscar mascotas con status pending ==='
    # Setup: Create  pet con status pendiente
    * def pendingPet = petFactory.createPet({status: 'pending'})
    Given path 'pet'
    And request pendingPet
    When method post
    Then status 200
    * def pendingPetId = response.id
    
    # Test: Search por status 'pending'
    Given path 'pet/findByStatus'
    And param status = 'pending'
    When method get
    Then status 200
    And match response == '#[]'
    * def foundPet = null
    * eval for (var i = 0; i < response.length; i++) if (response[i].id == pendingPetId) foundPet = response[i]
    * match foundPet != null
    And match foundPet.status == 'pending'
    * print 'RESULTADO CASO 4 COBERTURA - Mascotas encontradas con status pending:'
    * print 'Total mascotas pending:', response.length

  @exercise @search-pet @data-coverage
  Scenario: CASO 4 COBERTURA - Buscar múltiples status
    * print '=== CASO 4 COBERTURA: Buscar múltiples status ==='
    Given path 'pet/findByStatus'
    And param status = 'available,pending,sold'
    When method get
    Then status 200
    And match response == '#[]'
    * print 'RESULTADO CASO 4 COBERTURA - Búsqueda múltiple status:'
    * print 'Total mascotas encontradas:', response.length
