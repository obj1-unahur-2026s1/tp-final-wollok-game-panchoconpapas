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
    personaje.aumentarPuntosPorToparseCon(comida)
    // game.say(self, "Ummm que rico, mis puntos son: " + kike.puntos().toString())
    game.say(self, "Estaba rico")
    self.desaparecer()
  }
  
  method desaparecer() {
    game.schedule(1000, { game.removeVisual(self) })
  }
  
  method animarse() {
    
  }
  
  method aparecer() {
    position = self.posicionAleatoriaVacia()
    game.addVisual(self)
  }
  
  method image()
  
  method puntosQueOtorga()
}

class HuesoConCarne inherits Comida {
  override method image() = "comidita.png"
  
  override method puntosQueOtorga() {
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

class Locrazo inherits Comida {
  override method image() = "locro.png"
  
  override method puntosQueOtorga() {
    if (nivel == 1) {
      return 2
    } else {
      if (nivel == 2) {
        return 6
      } else {
        return 10
      }
    }
  }
}

class Pizza inherits Comida {
  override method image() = "pizza.png"
  
  override method puntosQueOtorga() {
    if (nivel == 1) {
      return 3
    } else {
      if (nivel == 2) {
        return 6
      } else {
        return 12
      }
    }
  }
}