@Buscando404 @Punto7
Feature: Buscando error "404 No encontrado"

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)


@Buscando-Error-404 @Punto7
  Scenario: Buscar Workspace -inexistente-
    And endpoint api/v1/workspaces/664c36dc7d59624baae8dd8e
    When execute method GET
    Then the status code should be 200
#404 Not Found: "{"message":"No static resource api/v1/workspaces/664c36dc7d59624baae8dd8e.","code":3000}"
#En este caso la url del endpoint esta erronea


  @Buscando-Error-404-b @Punto7 @400BadRequest
  Scenario Outline: Buscar proyecto por ID -inexistente-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    When execute method GET
    Then the status code should be 200
    Examples:
      | IdProyecto               |
      | 664e4723ca96041c2c4e45e1 |
#Original 664e4723ca96041c2c4e45e0

#400 Bad Request: "{"message":"Project doesn't belong to Workspace","code":501}"
# En este caso el ID del proyecto está erroneo
# Si el proyecto fue borrado anteriormente solo aparece: 400 Bad Request: "{"message":"Project doesn't belong to Workspace","code":501}"


  @Buscando-Error-404-c @Punto7
  Scenario: Buscar Workspace -inexistente-
    And endpoint api/v1/workspaces/664c36dc7d59624baae8dd8e
    When execute method GET
    Then the status code should be 404