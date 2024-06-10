@NoAuthGeneral
Feature: Buscando error por "401 No Autorizado"

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)



  @NoAutorizado @Punto6
Scenario: Consultar todos los proyectos de un workspace -Error 401-
Given base url $(env.base_url)
And header Content-Type = application/json
And header x-api-key = NDA3MTFkYzAtYzNjYy00NzExLTlkZmEtZjllZjIyYjMwZWea
And endpoint v1/workspaces/$(env.workSpaceID)/projects
When execute method GET
Then the status code should be 200
    #401 Unauthorized: "{"message":"Api key does not exist","code":4003}"



  @Auth-UpdateProjectMemberships @Punto6 @400BadRequest
  Scenario Outline: Modificar membresia de proyecto
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>/memberships
    And set value <idUsuario> of key memberships[0].userId in body jsons/bodies/TP8_UpdateProjectMembership.json
    And set value <monto> of key memberships[0].hourlyRate.amount in body jsons/bodies/TP8_UpdateProjectMembership.json
    When execute method PATCH
    Then the status code should be 200

    Examples:
      | IdProyecto               | idUsuario                | monto |
      | 6652622d21704c74384a40b5 | 662696c75d9896471187333c | 100   |
#400 Bad Request: "{"message":"User or group not a member of workspace","code":501}"



  @Auth-AssignUserToProject @Punto6 @400BadRequest
  Scenario Outline: Asignar/remover usuario al proyecto
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>/memberships
    And set value <idUsuario> of key userIds[0] in body jsons/bodies/TP8_UpdateUserProject.json
    And set value <remove> of key remove in body jsons/bodies/TP8_UpdateUserProject.json
    When execute method POST
    Then the status code should be 200
    Examples:
      | IdProyecto               | idUsuario                | remove |
      | 664e488cca96041c2c4e4aa7 | 662696c75d9896471187333c | false  |
#400 Bad Request: "{"message":"User doesn't belong to Workspace","code":501}"




