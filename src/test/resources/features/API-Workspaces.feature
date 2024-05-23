@WorkspacesAll
Feature: clockify low code - Trabajando con Workspaces

  Background:
    Given base url $(env.base_url)
    And endpoint v1/workspaces
    And header x-api-key = $(env.x_api_key)
    And header Content-Type = application/json

  @ObtenerWorkspaces
  Scenario: Obtener Workspaces
    When execute method GET
    * define workSpaceID = response[6].id
    Then the status code should be 200

  @CrearWorkspace
  Scenario Outline: Agregar workspace
    And set value <nameWorkspace> of key name in body jsons/bodies/TP8_CreateWorkspace.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameWorkspace                        |
      | "basic automation academy__"         |
      | "Workspace TP8 Lippia Api LowCode__" |

  @ObtenerTP8Workspace
  Scenario: Obtener Workspace especifico para el TP8
    When execute method GET
    And response should be [6].id = 664c36dc7d59624baae8dd8e
    And response should be [6].name = Workspace TP8 Lippia Api LowCode
    * define workSpaceID = response[6].id
    Then the status code should be 200

  @Hardcoded
  Scenario: Obtener Workspaces hardcodeados
    Given base url https://api.clockify.me/api/
    And header Content-Type = application/json
    And header x-api-key = NDA3MTFkYzAtYzNjYy00NzExLTlkZmEtZjllZjIyYjMwZWEz
    And endpoint v1/workspaces
    When execute method GET
    Then the status code should be 200