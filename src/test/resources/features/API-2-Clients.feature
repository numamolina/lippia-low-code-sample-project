@ClientsAll
Feature: Trabajar con Clientes dentro de un Workspace

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)


  @listarClientes
  Scenario: Listar todos los clientes de un workspace
    And endpoint v1/workspaces/$(env.workSpaceID)/clients
    When  execute method GET
    * define clientID = [0].id
    Then the status code should be 200


  @listarClientePorId
  Scenario Outline: Obtener un cliente particular por ID
    And endpoint v1/workspaces/$(env.workSpaceID)/clients/<clienteID>
    When execute method GET
    Then the status code should be 200

    Examples:
      | clienteID                |
      | 66528f38c0eac57d45f9c6fe |

  @updateClient
  Scenario Outline: Modificar cliente existente
    #Punto 3 Ejercicio libre
    And endpoint v1/workspaces/$(env.workSpaceID)/clients/<clienteID>
    And set value <nombreCliente> of key name in body jsons/bodies/TP8_UpdateClient.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | clienteID                | nombreCliente |
      | 66528f38c0eac57d45f9c6fe | Senior X      |


    @readClient
    Scenario Outline: Consultar cliente por nombre
    #punto3 (validacion del ejercicio 3)
      And endpoint v1/workspaces/$(env.workSpaceID)/clients/<clienteID>
      And set value <nombreCliente> of key name in body jsons/bodies/TP8_UpdateClient.json
      When execute method GET
      Then the status code should be 200

      Examples:
        | clienteID                | nombreCliente |
        | 66528f38c0eac57d45f9c6fe | Senior X      |