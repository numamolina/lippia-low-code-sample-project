@ProjectsAll
Feature: Trabajar con proyectos dentro de Workspaces

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)

  @CrearProyecto
  Scenario Outline: Crear un proyecto dentro de un workspace exitosamente
    And endpoint v1/workspaces/$(env.workSpaceID)/projects
    And set value <nameProject> of key name in body jsons/bodies/TP8_AddProject.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameProject   |
      | "Proyecto-01" |
      | "Proyecto-02" |

  @GetAllProjects
  Scenario: Consultar todos los proyectos de un workspace
    And endpoint v1/workspaces/$(env.workSpaceID)/projects
    When execute method GET
    * define projectID = [0].id
    And response should be [0].id = 664e488cca96041c2c4e4aa7
    Then the status code should be 200


  @ConsultarProyectoID
  Scenario: Consultar Proyecto por ID
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/664e488cca96041c2c4e4aa7
    When execute method GET
    Then the status code should be 200

  @updateProjectUserCost
    #Ejercicio de eleccion libre de campo a editar
  Scenario Outline: Editar el monto de algun proyecto existente
    #  664e488cca96041c2c4e4aa7
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/664e488cca96041c2c4e4aa7/users/662696c75d9896471187566c/cost-rate
#    And endpoint v1/workspaces/{workspaceId}/projects/664e488cca96041c2c4e4aa7/users/{userId}/cost-rate
    And set value <amountUser> of key amount in body jsons/bodies/TP8_UpdateAmountProject.json
    And set value <sinceUser> of key since in body jsons/bodies/TP8_UpdateAmountProject.json
    When execute method PUT
    Then the status code should be 200

    Examples
      | amountUser | sinceUser            |
      | 900        | 2024-05-23T00:00:00Z |





