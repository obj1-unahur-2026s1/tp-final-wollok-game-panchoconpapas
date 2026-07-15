import juego.*

class Comida {
  const property nivel
  var property position = game.origin()
  
  method positionAleatoria() = game.at(
    0.randomUpTo(game.width()),
    0.randomUpTo(game.height())
  )
  
  method posicionAleatoriaVacia() {
    const posiblePosicion = self.positionAleatoria()
    
    if (game.getObjectsIn(posiblePosicion).isEmpty()) {
      return posiblePosicion
    } else {
      return self.posicionAleatoriaVacia()
    }
  }
  
  method teCruzasteCon(personaje, comida) {
    game.sound("perroComiendo.mp3").play()
    personaje.aumentarPuntosPorToparseCon(comida)
    game.say(self, "Estaba rico")
    self.desaparecer()
  }
  
  method desaparecer() {
    game.schedule(1000, { game.removeVisual(self) })
  }
  
  method aparecer() {
    position = self.posicionAleatoriaVacia()
    game.addVisual(self)
  }
  
  method image()
  
  method puntosQueOtorga() {
    if (nivel == 1) {
      return 1
    } else {
      if (nivel == 2) {
        return 3
      } else {
        return 6
      }
    }
  }
}

class HuesoConCarne inherits Comida {
  override method image() = "comidita.png"
  
  override method puntosQueOtorga() = super() + 2
}

class Locrazo inherits Comida {
  override method image() = "locro.png"
  
  override method puntosQueOtorga() = super() + 3
}

class Pizza inherits Comida {
  override method image() = "pizza.png"
  
  override method puntosQueOtorga() = super() + 4
}