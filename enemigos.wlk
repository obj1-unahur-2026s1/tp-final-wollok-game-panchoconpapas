import juego.*

class Enemigo {
  const nivel
  var property vida = self.vidaPorNivel(nivel)
  var property position = self.posicionAleatoria()
  
  method posicionAleatoria() = game.at(
    0.randomUpTo(game.width()),
    0.randomUpTo(game.height())
  )
  
  method teCruzasteConKike(enemigo) {
    kike.perderVidasPorToparseConEnemigo(enemigo)
    game.say(self, ("Auch, me quedan: " + kike.vida().toString()) + " vidas.")
  }
  
  method vidasQueArrebata()
  
  method aparecer() {
    game.addVisual(self)
  }
  
  method vidaPorNivel(unNivel) {
    if (unNivel == 1) {
      vida = 100
    } else {
      if (unNivel == 2) {
        vida = 150
      } else {
        vida = 200
      }
    }
  }
  
  method image()
  
  method ataque()
}

class Perrito inherits Enemigo {
  override method image() = "perrito.png"
  
  override method ataque() {
    
  }
  
  override method vidasQueArrebata() = 1
}

class Perro inherits Enemigo {
  override method image() = "perro.png"
  
  override method ataque() {
    
  }
  
  override method vidasQueArrebata() = 2
}

class Perrote inherits Enemigo {
  override method image() = "perrote.png"
  
  override method ataque() {
    
  }
  
  override method vidasQueArrebata() = 3
}