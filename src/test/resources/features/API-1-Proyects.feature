@ProjectsAll
Feature: Trabajar con proyectos dentro de Workspaces

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)


  @CrearProyecto @punto1 @punto4
    #Punto 1 y punto 4
  Scenario Outline: Crear un proyecto dentro de un workspace exitosamente
    And endpoint v1/workspaces/$(env.workSpaceID)/projects
    And set value <nameProject> of key name in body jsons/bodies/TP8_AddProject.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameProject    |
      | "Proyecto-01c" |
      | "Proyecto-02c" |

  @GetAllProjects
  Scenario: Consultar todos los proyectos de un workspace
    And endpoint v1/workspaces/$(env.workSpaceID)/projects
    When execute method GET
    * define projectID = [0].id
    And response should be [0].id = 664e488cca96041c2c4e4aa7
    Then the status code should be 200


  @ConsultarProyectoID @punto2 @punto4
        #Punto 2 y punto 4
  Scenario Outline: Consultar Proyecto por ID
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    When execute method GET
    Then the status code should be 200

    Examples:
      | IdProyecto               |
      | 664e488cca96041c2c4e4aa7 |


  @updateProjectUserCost
    #Ejercicio de eleccion libre de campo a editar
    #Update project user cost rate
#NO SE PUDO POR SER UNA CARACTERISTICA PREMIUM
  Scenario Outline: Editar el monto de algun proyecto existente
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<projectId>/users/<userId>/cost-rate
    And set value <amountUser> of key amount in body jsons/bodies/TP8_UpdateAmountProject.json
    And set value <sinceUser> of key since in body jsons/bodies/TP8_UpdateAmountProject.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | amountUser | sinceUser            | projectId                | userId                   |
      | 901        | 2024-05-25T14:30:45Z | 664e488cca96041c2c4e4aa7 | 662696c75d9896471187566c |
      |            |                      |                          |                          |



#  Punto 4 consigna: Endpoint /projects, camino feliz. Analizar si tiene parámetros obligatorios y no obligatorios, y definir pruebas para todos los casos.


  @archivarProyectoID @punto4
    #metodo PUT (update project)
  Scenario Outline: Archivar Proyecto por ID
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    And set value <boolean> of key archived in body jsons/bodies/TP8_ArchivarProjects.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | IdProyecto               | boolean |
      | 664e4723ca96041c2c4e45e0 | true    |
      | 664e47aa90dd872da4c3a7f7 | true    |
      | 664e47abdc66f75ba3ca4212 | true    |


  @borrarProyectoID @punto4
        #Punto 4
  Scenario Outline: Borrar Proyecto por ID
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    When execute method DELETE
    Then the status code should be 200
#El borrado de un proyecto exige que el proyecto antes sea archivado
    Examples:
      | IdProyecto               |  |
      | 664e44e5c785857280bfe5b5 |  |
    #Se pueden borrar para probar
#  IdProyecto:
#664e44e5ca96041c2c4e3b13
#664c3e823b9ad93ad35feb51





  @updateProjectEstimate @punto4
        #Punto 4 - metodo PATCH
  Scenario Outline: Modificar presupuesto (budget) de proyecto
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>/estimate
    And set value <resetOp> of key active in body jsons/bodies/TP8_UpdateProjectEstimated.json
    When execute method PATCH
    Then the status code should be 200

    Examples:
      | IdProyecto               | resetOp |
      | 664eb549ca96041c2c5044c2 | true    |
      | 664eb5d0dc66f75ba3cc3ad3 | true    |


  @updateProjectMemberships @punto4
#Punto 4 - metodo PATCH
  Scenario Outline: Modificar membresia de proyecto
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>/memberships
    And set value <idUsuario> of key memberships[0].userId in body jsons/bodies/TP8_UpdateProjectMembership.json
    And set value <monto> of key memberships[0].hourlyRate.amount in body jsons/bodies/TP8_UpdateProjectMembership.json
    When execute method PATCH
    Then the status code should be 200

    Examples:
      | IdProyecto               | idUsuario                | monto |
      | 6652622d21704c74384a40b5 | 662696c75d9896471187566c | 100   |
