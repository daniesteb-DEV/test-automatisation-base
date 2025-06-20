@REQ_DED_001 @marvelCharactersV1
Feature:
  Background:
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daniestebdev/api/characters'
    * def body = read('classpath:../data/createCharacter.json')
    * def bodyWithoutData = read('classpath:../data/createCharacterWithoutData.json')
    * def updateBody = read('classpath:../data/updateCharacter.json')

  @id:1 @getAllCharactersV1 @casoPositivo
  Scenario: T-API-DED-001-CA1-Obtener Todos los Personajes empty Positivo
    Given url baseUrl
    When method get
    Then status 200
    * print response

  @id:2 @getCharactersByIdV1 @casoNegativo
  Scenario: T-API-DED-001-CA2-Obtener Personaje por ID Negativo
    Given url baseUrl + '/999'
    When method get
    Then status 404
    * print response
    * match response.error == 'Character not found'

  @id:3 @createCharacterV1 @casoPositivo
  Scenario: T-API-DED-001-CA2-Crear personaje Positivo
    Given url baseUrl
    And header Content-Type = 'application/json'
    And request body
    When method post
    Then status 201
    * print response

  @id:2 @getCharactersByIdV1 @casoPositivo
  Scenario: T-API-DED-001-CA2-Obtener Personaje por ID Positivo
    Given url baseUrl + '/1'
    When method get
    Then status 200
    * print response
    * match response.id == 1

  @id:1 @getAllCharactersV1 @casoPositivo
  Scenario: T-API-DED-001-CA1-Obtener Todos los Personajes Positivo
    Given url baseUrl
    When method get
    Then status 200
    * print response
    * match response[0].id == '#number'
    * match response[0].name == '#string'

  @id:3 @createCharacterV1 @casoPositivo
  Scenario: T-API-DED-001-CA2-Validar personaje duplicado
    Given url baseUrl
    And header Content-Type = 'application/json'
    And request body
    When method post
    Then status 400
    * print response
    * match response.error == 'Character name already exists'

  @id:3 @createCharacterV1 @casoPositivo
  Scenario: T-API-DED-001-CA2-Validar data de un personaje
    Given url baseUrl
    And header Content-Type = 'application/json'
    And request bodyWithoutData
    When method post
    Then status 400
    * print response
    * match response.name == 'Name is required'
    * match response.description == 'Description is required'

  @id:3 @updateCharacterV1 @casoPositivo
  Scenario: T-API-DED-001-CA2-Actualizar personaje Positivo
    Given url baseUrl + '/1'
    And header Content-Type = 'application/json'
    And request updateBody
    When method put
    Then status 200
    * print response
    * match response.id == 1

  @id:3 @updateCharacterV1 @casoNegativo
  Scenario: T-API-DED-001-CA2-Actualizar personaje Negativo
    Given url baseUrl + '/999'
    And header Content-Type = 'application/json'
    And request updateBody
    When method put
    Then status 404
    * print response
    * match response.error == 'Character not found'

  @id:3 @deleteCharacterV1 @casoPositivo
  Scenario: T-API-DED-001-CA2-Eliminar personaje Positivo
    Given url baseUrl + '/1'
    And header Content-Type = 'application/json'
    When method delete
    Then status 204
    * print response
    * match response == ''

  @id:3 @deleteCharacterV1 @casoNegativo
  Scenario: T-API-DED-001-CA2-Eliminar personaje No existente
    Given url baseUrl + '/999'
    And header Content-Type = 'application/json'
    When method delete
    Then status 404
    * print response
    * match response.error == 'Character not found'