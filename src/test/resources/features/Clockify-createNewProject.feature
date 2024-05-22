Feature: Trabajar con proyectos dentro de Workspaces

  @CrearProyecto
  Scenario: Crear un proyecto dentro de un workspace exitosamente
    Given call Clockify-createWorkspace.feature@ObtenerWorkspaces
    And base url $(env.base_url)
    And endpoint v1/workspaces/{{espacioDeTrabajo}}/projects
    And header x-api-key = $(env.x_api_key)
    And header Content-Type = application/json
    And body jsons/bodies/AddProject.json
    When execute method POST
    Then the status code should be 201

