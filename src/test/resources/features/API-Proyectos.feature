@ProjectsAll
Feature: Trabajar con proyectos dentro de Workspaces

  @CrearProyecto
  Scenario Outline: Crear un proyecto dentro de un workspace exitosamente
    Given base url $(env.base_url)
    And endpoint v1/workspaces/$(env.workSpaceID)/projects
    And header x-api-key = $(env.x_api_key)
    And header Content-Type = application/json
    And set value <nameProject> of key name in body jsons/bodies/TP8_AddProject.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameProject  |
      | "Proyecto-1" |
      | "Proyecto-2" |

