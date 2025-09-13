Feature: PETSTORE E2E - Test Completo de 4 Casos Secuenciales

  Background:
    * url baseUrl
    * def petFactory = read('classpath:petstore/pet-data-factory.js')
    * def petId = java.lang.System.currentTimeMillis()
    * def petName = 'E2EPet_' + petId
    * def updatedPetName = 'E2EUpdatedPet_' + petId

  @e2e @exercise
  Scenario: E2E COMPLETO - Flujo completo de mascota (Añadir → Consultar → Actualizar → Buscar)
    * print '========================================='
    * print 'INICIANDO TEST E2E PETSTORE API'
    * print 'Pet ID único:', petId
    * print '========================================='

    # PASO 1: Añadir una mascota a la tienda
    * print '=== PASO 1: Añadir una mascota a la tienda ==='
    * def petData = petFactory.createPet({id: petId, name: petName, status: 'available'})
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.id == petId
    And match response.name == petName
    And match response.status == 'available'
    * print 'RESULTADO PASO 1 - Mascota añadida exitosamente:'
    * print 'Pet ID:', response.id
    * print 'Pet Name:', response.name
    * print 'Pet Status:', response.status
    * print 'Response from POST /pet:', response
    * def createdPetId = response.id

    # PASO 2: Consultar la mascota ingresada previamente (Búsqueda por ID)
    * print '=== PASO 2: Consultar la mascota por ID ==='
    Given path 'pet', createdPetId
    When method get
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.id == createdPetId
    And match response.name == petName
    And match response.status == 'available'
    * print 'RESULTADO PASO 2 - Mascota consultada exitosamente:'
    * print 'Pet ID:', response.id
    * print 'Pet Name:', response.name
    * print 'Pet Status:', response.status
    * print 'Verificación: Mascota existe y datos coinciden'

    # PASO 3: Actualizar el nombre de la mascota y el estatus a "sold"
    * print '=== PASO 3: Actualizar nombre y estatus a sold ==='
    * def updatedPetData = petFactory.createPet({id: createdPetId, name: updatedPetName, status: 'sold'})
    Given path 'pet'
    And request updatedPetData
    When method put
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.id == createdPetId
    And match response.name == updatedPetName
    And match response.status == 'sold'
    * print 'RESULTADO PASO 3 - Mascota actualizada exitosamente:'
    * print 'Pet ID:', response.id
    * print 'Pet Name (NUEVO):', response.name
    * print 'Pet Status (NUEVO):', response.status
    * def soldPetId = response.id

    # PASO 4: Consultar la mascota modificada por estatus (Búsqueda por estatus)
    * print '=== PASO 4: Consultar mascota modificada por estatus sold ==='
    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    And match response == '#[]'
    * def foundPet = null
    * eval for (var i = 0; i < response.length; i++) if (response[i].id == soldPetId) foundPet = response[i]
    * assert foundPet != null
    * match foundPet == petFactory.getDetailedPetSchema()
    * match foundPet.id == soldPetId
    * match foundPet.name == updatedPetName
    * match foundPet.status == 'sold'
    * print 'RESULTADO PASO 4 - Mascota encontrada por estatus:'
    * print 'Pet ID:', foundPet.id
    * print 'Pet Name:', foundPet.name
    * print 'Pet Status:', foundPet.status
    * print 'Total mascotas sold encontradas:', response.length

    * print '========================================='
    * print 'TEST E2E COMPLETADO EXITOSAMENTE'
    * print 'FLUJO COMPLETO VERIFICADO:'
    * print '✅ 1. Mascota añadida con status available'
    * print '✅ 2. Mascota consultada por ID correctamente'
    * print '✅ 3. Mascota actualizada a status sold'
    * print '✅ 4. Mascota encontrada en búsqueda por status'
    * print '========================================='
