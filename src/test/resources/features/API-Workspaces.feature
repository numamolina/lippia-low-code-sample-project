@WorkspacesAll
Feature: clockify low code - Trabajando con Workspaces

  Background:
    Given base url $(env.base_url)
    And endpoint v1/workspaces
    And header x-api-key = $(env.x_api_key)

  @ObtenerWorkspaces
  Scenario: Obtener Workspaces
    When execute method GET
    * define workSpaceID = response[6].id
    Then the status code should be 200

  @CrearWorkspace
  Scenario Outline: Agregar workspace
    And header Content-Type = application/json
    And set value <nameWorkspace> of key name in body jsons/bodies/TP8_CreateWorkspace.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameWorkspace                      |
      | "basic automation academy"         |
      | "Workspace TP8 Lippia Api LowCode" |

  @ObtenerTP8Workspace
  Scenario: Obtener Workspace especifico para el TP8
    When execute method GET
    And response should be [6].id = 664c36dc7d59624baae8dd8e
    And response should be [6].name = Workspace TP8 Lippia Api LowCode
    * define workSpaceID = response[6].id
    Then the status code should be 200