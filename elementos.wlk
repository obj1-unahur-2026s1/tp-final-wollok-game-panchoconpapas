import juego.*

object kike {
  var property energia = 100
  var vida = 10
  var property position = game.origin()
  var positionAnterior = position
  
  method vida() = vida
  
  // method text() = (((("Mi vida: " + vida.toString()) + ". ") + "Mis puntos: ") + puntos.toString()) + "."
  method aparecer() {
    game.addVisualCharacter(self)
  }
  
  method aumentarPuntosPorToparseCon(unaComida) {
    energia += unaComida.puntosQueOtorga()
  }
  
  method perderVidasPorToparseConEnemigo(unEnemigo) {
    vida -= unEnemigo.vidasQueArrebata()
    if (vida <= 0) {
      game.sound("gameOverSound.mp3").play()
      juego.terminarJuegoMal()
    }
  }
  
  method perderEnergia(cantidad) {
    energia -= cantidad
    if(energia <= 0) {
      game.sound("gameOverSound.mp3").play()
      juego.terminarJuegoMal()
    }
  }
  
  method aumentarVidas() {
    vida += 1
  }
  
  method position(nueva) {
    positionAnterior = position
    position = nueva
  }
  
  method retroceder() {
    position = positionAnterior
  }
  
  method romperPared(pared) {
    game.removeVisual(pared)
  }
  
  method paralizar() {
    
  }
  
  method image() = "kike.png"
}

object marcador {
  method text() = ((("Vidas: " + kike.vida().toString()) + ". Energia: ") + kike.energia().toString()) + "."
  
  method position() = game.at(game.width() / 2, game.height() - 1)
  
  method aparecer() {
    game.addVisual(self)
  }
  
  method teCruzasteCon(personaje, elemento) {
    
  }
}

object marcadorFinal {
  method position() = game.at(9, 9)
  
  method image() = "hijitos.png"
  
  method aparecer() {
    game.addVisual(self)
  }
  
  method posicionAleatoria() = game.at(
    0.randomUpTo(game.width()),
    0.randomUpTo(game.height())
  )
  
  method teCruzasteCon(personaje, elemento) {
    game.sound("WinSound.mp3").play()
    juego.terminarJuegoBien()
  }
}

object gameOver {
  method position() = game.origin()
  
  method image() = "gameOver.png"
}

object victoria {
  method position() = game.origin()
  
  method image() = "victoria.png"
}