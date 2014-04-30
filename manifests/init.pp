#== Class: wildfly

class wildfly inherits wildfly::params {

  class{'wildfly::install': } ->
  class{'wildfly::config': } ~>
  class{'wildfly::service': } ->
  Class["wildfly"]

}
