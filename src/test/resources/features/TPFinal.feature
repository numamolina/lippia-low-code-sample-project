@TPFinal-lowcode
Feature: Automatizacion de escenarios

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)

  @ConsultarHorasRegistradas
  Scenario Outline: Consultar las horas registradas
    And endpoint v1/workspaces/$(env.workSpaceID)/user/<userId>/time-entries
    When  execute method GET
    Then the status code should be 200

    Examples:
      | userId                   |
      | 662696c75d9896471187566c |


  @AgregarHorasProyecto
  Scenario Outline: Agregar horas a un proyecto
    And endpoint v1/workspaces/$(env.workSpaceID)/time-entries/<idTarea>
    And set value <startTime> of key start in body jsons/bodies/TPFinal_TimeEntry_Start.json
    And set value <finalTarea> of key end in body jsons/bodies/TPFinal_TimeEntry_Start.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | idTarea                  | startTime            | finalTarea           |
      | 66678c691dd7f20133c77101 | 2024-06-09T22:50:00Z | 2024-06-10T00:01:00Z |
      | 66679dafb232fb571ac4c604 | 2024-06-09T22:09:00Z | 2024-06-10T00:20:00Z |


  @EditarRegistroDeHora
  Scenario Outline: Editar campos de registro de hora
    And endpoint v1/workspaces/$(env.workSpaceID)/time-entries/<idTarea>
    And set value <descripcionTarea> of key description in body jsons/bodies/TPFinal_TimeEntry_campos.json
    And set value <startTime> of key start in body jsons/bodies/TPFinal_TimeEntry_campos.json
    And set value <finalTarea> of key end in body jsons/bodies/TPFinal_TimeEntry_campos.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | idTarea                  |  | descripcionTarea                      | startTime            | finalTarea           |
      | 66678c691dd7f20133c77101 |  | "Una simple descripcion TPFinal"      | 2024-06-09T23:00:00Z | 2024-06-10T00:01:00Z |
      | 66679dafb232fb571ac4c604 |  | "TPFinal modificando tiempo de tarea" | 2024-06-09T22:00:00Z | 2024-06-10T00:01:00Z |


  @EliminarRegistroDeHora
  Scenario Outline: Eliminar alguna hora registrada
    And endpoint v1/workspaces/$(env.workSpaceID)/time-entries/<idTarea>
    When execute method DELETE
    Then the status code should be 204

    Examples:
      | idTarea                  |
      | 6667b65f49ef284a36dbb69d |

#  idTarea Para poder eliminar luego:
#  6667b96587b54248992ee326

