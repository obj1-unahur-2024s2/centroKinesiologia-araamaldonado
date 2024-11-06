class Paciente {
  var edad
  var dolor
  var fortalezaMuscular
  const rutina = []

  method edad() = edad

  method dolor() = dolor

  method fortalezaMuscular() = fortalezaMuscular

  method cumplirAnios() {
    edad += 1
  }

  method cargarRutina(unaLista) {
    rutina.clear()
    rutina.addAll(unaLista)
  }

  method disminuirDolor(unValor) {
    dolor = 0.max(dolor - unValor)
  }

  method aumentarFortaleza(unValor){
    fortalezaMuscular += unValor
  }

  method puedeUsar(unAparato) = unAparato.puedeSerUsadoPor(self)

  method usarAparato(unAparato) {
    if(self.puedeUsar(unAparato)){
      unAparato.consecuencia(self)
    }
  }

  method puedeHacerRutina() = rutina.all({ a => self.puedeUsar(a) })

  method realizarRutina() {
    rutina.forEach({ a => self.usarAparato(a) })
  }

}

class Aparato {
  var property color = "blanco"

  method consecuenciaDeUso(unPaciente)

  method puedeSerUsadoPor(unPaciente)
  method recibirMantenimiento()
  method necesitaMantenimiento() = false
}

class Magneto inherits Aparato {
  var imantacion = 800

  override method consecuenciaDeUso(unPaciente){
    unPaciente.disminuirDolor(unPaciente.dolor() * 0.1)
    imantacion = 0.max(imantacion - 1)
  }

  override method puedeSerUsadoPor(unPaciente) = true

  override method necesitaMantenimiento() = imantacion < 100

  override method recibirMantenimiento() {
    imantacion = (imantacion + 500).min(800)
  }

}

class Bici inherits Aparato {
  var tornillos = 0
  var aceite = 0

    override method consecuenciaDeUso(unPaciente){
      if (unPaciente.dolor() >= 30)
        tornillos += 1
        if (unPaciente.edad().between(30, 50))
        aceite+=1

    unPaciente.disminuirDolor(4)
    unPaciente.aumentarFortaleza(3)
  }

  override method puedeSerUsadoPor(unPaciente) = unPaciente.edad() > 8

  override method necesitaMantenimiento() = tornillos >= 10 || aceite >= 5

  override method recibirMantenimiento() {
    tornillos = 0
    aceite = 0
  }

}

class MiniTramp inherits Aparato {
  override method consecuenciaDeUso(unPaciente) {
    unPaciente.aumentarFortaleza(unPaciente.edad()*0.1)
  }

  override method puedeSerUsadoPor(unPaciente) = unPaciente.nivelDeDolor() < 20

  override method recibirMantenimiento() {}
}

class Resistente inherits Paciente {
  override method realizarRutina() {
    const cantidad = rutina.count{a => self.puedeUsar(a)}
    super()
    self.aumentarFortaleza(cantidad)
  }
}

class Caprichoso inherits Paciente {
  override method puedeHacerRutina() {
    return self.hayAlgunAparatoRojo() && super()
  }

  method hayAlgunAparatoRojo() {
    return rutina.any({a => a.color() == "rojo"})
  }
}

class RecuperacionRapida inherits Paciente {
  override method realizarRutina () {
    super()
    self.disminuirDolor(disminucionDolor.valor())
  }
}

object disminucionDolor {
  var property valor = 3
}