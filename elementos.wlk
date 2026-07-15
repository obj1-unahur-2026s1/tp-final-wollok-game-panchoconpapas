import juego.*

object kike {
  var property energia = 100
  var property vida = 10
  var property position = game.origin()
  var positionAnterior = position
  
  method aparecer() {
    game.addVisualCharacter(self)
  }
  
  method aumentarPuntosPorToparseCon(unaComida) {
    energia += unaComida.puntosQueOtorga()
  }
  
  method perderVidasPorToparseConEnemigo(unEnemigo) {
    vida -= 0.max(unEnemigo.vidasQueArrebata())
    if (vida <= 0) {
      //juego.musica().pause()
      game.sound("gameOverSound.mp3").play()
      juego.terminarJuegoMal()
    }
  }
  
  method morir() {
    vida = 0
  }
  
  method recargarVida() {
    vida = 10
  }
  
  method recargarEnergia() {
    energia = 100
  }
  
  method perderEnergia() {
    energia = 0.max(energia - 1)
    if (energia <= 0) {
      // juego.musica().pause()
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
  
  method image() = "marcador.png"
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
  
  method teCruzasteCon(personaje, elemento) {
    
  }
  
  method image() = "gameOver.png"
}

object victoria {
  method position() = game.origin()
  
  method teCruzasteCon(personaje, elemento) {
    
  }
  
  method image() = "victoria.png"
}

object pantallaPrincipal {
  method image() = "pantallaPrincipal.png"
  
  method position() = game.origin()
  
  method mostrar() = game.addVisual(self)
  
  method teCruzasteCon(personaje, elemento) {
    
  }
}

object instrucciones {
  method image() = "instrucciones.png"
  
  method position() = game.origin()
  
  method mostrar() = game.addVisual(self)
  
  method teCruzasteCon(personaje, elemento) {
    
  }
}

object controles {
  method image() = "controles.png"
  
  method position() = game.origin()
  
  method mostrar() = game.addVisual(self)
  
  method teCruzasteCon(personaje, elemento) {
    
  }
}

object dificultades {
  method image() = "dificultades.png"
  
  method position() = game.origin()
  
  method mostrar() = game.addVisual(self)
  
  method teCruzasteCon(personaje, elemento) {
    
  }
}