import example.*

object centro {
  const pacientes = []
  const aparatos = []

  method agregarPacientes(unaLista){
    pacientes.addAll(unaLista)
  }

  method agregarAparatos(unaLista){
    aparatos.addAll(unaLista)
  }

  method colorAparatos() = aparatos.map({ a => a.color() }).asSet()

  method pacientesMenoresA(unValor) = pacientes.filter({ p => p.edad() < unValor })

  method cantPacientesNoCumplenRutina() = pacientes.count({ p => ! p.puedeHacerRutina()})

  method condicionesOptimas() = aparatos.all({ a => ! a.necesitaMantenimiento() })

  method estaComplicado() = self.cantNecesitaMantenimiento() >= aparatos.size().div(2)

  method cantNecesitaMantenimiento() = aparatos.count({ a => a.necesitaMantenimiento() })

  method visitaTecnico() {
    self.aparatosQueNecesitanMantenimiento().forEach({a=>a.realizarMantenimiento()})
  }

  method aparatosQueNecesitanMantenimiento() = aparatos.filter({ a=> a.necesitaMantenimiento()})
}