Feature: CASO 1 - Add Pet to Store

  Background:
    * url baseUrl
    * def petFactory = read('classpath:petstore/pet-data-factory.js')
    * def petId = java.lang.System.currentTimeMillis()
    * def petName = 'TestPet_' + petId

  @exercise @add-pet
  Scenario: CASO 1 - Añadir una mascota a la tienda
    * print '=== CASO 1: Añadir una mascota a la tienda ==='
    * def petData = petFactory.createPet({id: petId, name: petName, status: 'available'})
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.id == petId
    And match response.name == petName
    And match response.status == 'available'
    And match response.photoUrls == '#[] #string'
    And match response.category == petFactory.getCategorySchema()
    And match response.tags == '#[] ' + JSON.stringify(petFactory.getTagSchema())
    And match response.photoUrls[0] == '#string'
    * print 'RESULTADO CASO 1 - Mascota añadida exitosamente:'
    * print 'Pet ID:', response.id
    * print 'Pet Name:', response.name
    * print 'Pet Status:', response.status
    * print 'Pet Photos:', response.photoUrls

  @exercise @add-pet @negative
  Scenario: CASO 1 NEGATIVO - Añadir mascota con datos inválidos
    * print '=== CASO 1 NEGATIVO: Añadir mascota con datos inválidos ==='
    * def invalidPetData = petFactory.createInvalidPet()
    Given path 'pet'
    And request invalidPetData
    When method post
    Then status 405
    * print 'RESULTADO CASO 1 NEGATIVO - Error esperado al enviar datos inválidos:'
    * print 'Status Code:', responseStatus

  @exercise @add-pet @negative
  Scenario: CASO 1 NEGATIVO - Añadir mascota sin campos requeridos
    * print '=== CASO 1 NEGATIVO: Añadir mascota sin campos requeridos ==='
    Given path 'pet'
    And request {}
    When method post
    Then status 405
    * print 'RESULTADO CASO 1 NEGATIVO - Error esperado sin campos requeridos:'
    * print 'Status Code:', responseStatus

  @exercise @add-pet @data-coverage
  Scenario: CASO 1 COBERTURA - Añadir mascota con status pending
    * print '=== CASO 1 COBERTURA: Añadir mascota con status pending ==='
    * def petData = petFactory.createPet({id: petId, name: petName, status: 'pending'})
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    And match response.status == 'pending'
    * print 'RESULTADO CASO 1 COBERTURA - Mascota con status pending:'
    * print 'Pet Status:', response.status

  @exercise @add-pet @data-coverage
  Scenario: CASO 1 COBERTURA - Añadir gato
    * print '=== CASO 1 COBERTURA: Añadir gato ==='
    * def catData = petFactory.createCat()
    Given path 'pet'
    And request catData
    When method post
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.category.name == 'Cats'
    * print 'RESULTADO CASO 1 COBERTURA - Gato añadido:'
    * print 'Pet Category:', response.category.name

  @exercise @add-pet @data-coverage
  Scenario: CASO 1 COBERTURA - Añadir pájaro
    * print '=== CASO 1 COBERTURA: Añadir pájaro ==='
    * def birdData = petFactory.createBird()
    Given path 'pet'
    And request birdData
    When method post
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.category.name == 'Birds'
    * print 'RESULTADO CASO 1 COBERTURA - Pájaro añadido:'
    * print 'Pet Category:', response.category.name

  @exercise @add-pet @data-coverage
  Scenario: CASO 1 COBERTURA - Añadir mascota con múltiples fotos
    * print '=== CASO 1 COBERTURA: Añadir mascota con múltiples fotos ==='
    * def multiPhotoData = petFactory.createPetWithMultiplePhotos()
    Given path 'pet'
    And request multiPhotoData
    When method post
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.photoUrls == '#[3] #string'
    * print 'RESULTADO CASO 1 COBERTURA - Mascota con múltiples fotos:'
    * print 'Total Photos:', response.photoUrls.length

  @exercise @add-pet @data-coverage
  Scenario: CASO 1 COBERTURA - Añadir mascota con múltiples tags
    * print '=== CASO 1 COBERTURA: Añadir mascota con múltiples tags ==='
    * def multiTagData = petFactory.createPetWithMultipleTags()
    Given path 'pet'
    And request multiTagData
    When method post
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.tags == '#[3] ' + JSON.stringify(petFactory.getTagSchema())
    * print 'RESULTADO CASO 1 COBERTURA - Mascota con múltiples tags:'
    * print 'Total Tags:', response.tags.length

  @exercise @add-pet @data-coverage
  Scenario: CASO 1 COBERTURA - Añadir mascota con nombre especial
    * print '=== CASO 1 COBERTURA: Añadir mascota con nombre especial ==='
    * def specialNameData = petFactory.createPetWithSpecialName('spaces')
    Given path 'pet'
    And request specialNameData
    When method post
    Then status 200
    And match response == petFactory.getDetailedPetSchema()
    And match response.name contains 'Pet with spaces'
    * print 'RESULTADO CASO 1 COBERTURA - Mascota con nombre especial:'
    * print 'Pet Name:', response.name
