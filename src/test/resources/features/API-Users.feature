@getUSer
Feature: Obtener datos del usuario logueado en Clockify via API

  Background:
    Given base url $(env.base_url)
    And endpoint v1/user
    And header x-api-key = $(env.x_api_key)
    And header Content-Type = application/json

  @getUserID
  Scenario: Obtener el ID del usuario logueado
    When execute method GET
    * define usuarioID = response.id
    Then the status code should be 200