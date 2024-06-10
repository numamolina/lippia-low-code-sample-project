@CasosDeError @Punto5
Feature: Trabajar con proyectos dentro de Workspaces

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)

  @ErrorAlCrearProyecto @Punto5 @400BadRequest
  Scenario Outline: Crear un proyecto dentro de un workspace -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects
    And set value <nameProject> of key name in body jsons/bodies/TP8_Projects.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameProject |
      | "P"         |
      | A           |
    #400 Bad Request: "{"message":"Project name has to be between 2 and 250 characters long","code":501}"


  @ErrorborrarProyectoID @Punto5 @400BadRequest
  Scenario Outline: Borrar Proyecto por ID -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    When execute method DELETE
    Then the status code should be 200

    Examples:
      | IdProyecto               |  |
      | 664eb71bca96041c2c504dde |  |
      #El borrado de un proyecto exige que el proyecto antes sea archivado
  #400 Bad Request: "{"message":"Cannot delete an active project","code":501}"


  @ErrorConsultarProyectoID @Punto5 @400BadRequest
  Scenario Outline: Consultar Proyecto por ID -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    When execute method GET
    Then the status code should be 200

    Examples:
      | IdProyecto               |
      | 664e488cca96041c2c4e4aa8 |
  # 400 Bad Request: "{"message":"Project doesn't belong to Workspace","code":501}"


  @ErrorUpdateProject @Punto5 @400BadRequest
  Scenario Outline: Modificar Proyecto -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    And set value <color> of key color in body jsons/bodies/TP8_UpdateProject.json
    And set value <name> of key name in body jsons/bodies/TP8_UpdateProject.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | IdProyecto               | color   | name |
      | 664e488cca96041c2c4e4aa7 | #010101 | ""   |
#  400 Bad Request: "{"message":"Project name has to be between 2 and 250 characters long","code":501}

  @ErrorUpdateProjectEstimate @Punto5 @400BadRequest
  Scenario Outline: Modificar presupuesto (budget) de proyecto -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>/estimate
    And set value <resetOption> of key resetOption in body jsons/bodies/TP8_UpdateProjectEstimatedError.json
    When execute method PATCH
    Then the status code should be 200

    Examples:
      | IdProyecto               | resetOption |
      | 664eb549ca96041c2c5044c2 | "MENSUAL"   |
#  400 Bad Request: "{"message":"You entered invalid value for field: [resetOption].


  @ErrorUpdateProjectMemberships @Punto5 @400BadRequest
  Scenario Outline: Modificar membresia de proyecto -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>/memberships
    And set value <idUsuario> of key memberships[0].userId in body jsons/bodies/TP8_UpdateProjectMembership.json
    And set value <monto> of key memberships[0].hourlyRate.amount in body jsons/bodies/TP8_UpdateProjectMembership.json
    When execute method PATCH
    Then the status code should be 200

    Examples:
      | IdProyecto               | idUsuario                | monto  |
      | 6652622d21704c74384a40b5 | 662696c75d9896471187566c | "-100" |
    #400 Bad Request: "{"message":"Amount has to be a positive value.","code":501}"


  @ErrorAssignUserToProject @Punto5 @400BadRequest
  Scenario Outline: Asignar/remover usuario al proyecto -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>/memberships
    And set value <idUsuario> of key userIds[0] in body jsons/bodies/TP8_UpdateUserProject.json
    And set value <remove> of key remove in body jsons/bodies/TP8_UpdateUserProject.json
    When execute method POST
    Then the status code should be 200

    Examples:
      | IdProyecto               | idUsuario                | remove  |
      | 664e488cca96041c2c4e4aa7 | 662696c75d9896471187566c | Remover |
    #400 Bad Request: "{"message":"JSON parse error: Cannot deserialize value of type `java.lang.Boolean` from String \"Remover\": only \"true\" or \"false\" recognized","code":3002}"

  @ErrorUpdateBillableRate @Punto5 @400BadRequest
  Scenario Outline: Actualizar la tarifa facturable del usuario del proyecto -Error-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<projectId>/users/<userId>/hourly-rate
    And set value <amountUser> of key amount in body jsons/bodies/TP8_BillableRate.json
    And set value <sinceUser> of key since in body jsons/bodies/TP8_BillableRate.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | projectId                | userId                   | amountUser | sinceUser            |
      | 664e48b0c785857280bff63a | 662696c75d9896471187566c | "-1000"    | 2022-05-25T14:30:45Z |
    #400 Bad Request: "{"message":"Amount has to be a positive value.","code":501}"