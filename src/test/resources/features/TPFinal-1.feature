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
#    * define clientID = [0].id
    Then the status code should be 200

    Examples:
      | userId                   |
      | 662696c75d9896471187566c |

#
  @AgregarHorasProyecto
  Scenario Outline: Agregar horas a un proyecto
    And endpoint v1/workspaces/$(env.workSpaceID)/time-entries/<idTarea>
    And set value <startTime> of key start in body jsons/bodies/TPFinal_TimeEntry.json
    And set value <descripcionTarea> of key description in body jsons/bodies/TPFinal_TimeEntry.json
    And set value <finalTarea> of key end in body jsons/bodies/TPFinal_TimeEntry.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | idTarea                  | startTime            | descripcionTarea                      | finalTarea           |
      | 66678c691dd7f20133c77101 | 2024-06-09T23:50:00Z | "Una simple descripcion TPFinal"      | 2024-06-10T00:01:00Z |
      | 66679dafb232fb571ac4c604 | 2024-06-10T00:09:00Z | "TPFinal modificando tiempo de tarea" | 2024-06-10T00:20:00Z  |



#  @updateClient
#  Scenario Outline: Modificar cliente existente
#    #Punto 3 Ejercicio libre
#    And endpoint v1/workspaces/$(env.workSpaceID)/clients/<clienteID>
#    And set value <nombreCliente> of key name in body jsons/bodies/TP8_UpdateClient.json
#    When execute method PUT
#    Then the status code should be 200
#


#
#  Scenario: Editar un campo de registro de hora
#
#
#  Scenario: Eliminar hora registrada
