import wollok.game.*
import enemigos.*
import comidas.*
import obstaculos.*

object juego {
  method iniciar() {
    game.title("Kike Vs Zombies")
    game.width(10)
    game.height(10)
    game.cellSize(50)
    game.ground("pasto.png")
    game.start()
    
    2.times({ i => self.generarEnemigos() })
    
    25.times({ i => self.agregarObstaculo() })
    
    self.generarComidas()
    
    marcador.aparecer()
    kike.aparecer()
    marcadorFinal.aparecer()
    
    game.onCollideDo(
      kike,
      { elemento => elemento.teCruzasteCon(kike, elemento) }
    )
    game.onTick(10, "terminar juego", { self.terminarJuego() })
  }
  
  method terminarJuego() {
    if (kike.vida() < 1 or kike.position() == marcadorFinal.position()) {
      game.stop()
      game.clear()
      self.cargarPantallaDeMuerte()
    }
  }
  
  method cargarPantallaDeMuerte() {
    game.ground("invisible.png")
    game.boardGround("gameover.png")
  }
  
  method generarComidas() {
    self.aparecerComidaHuesoDeNivel(1)
    self.aparecerComidaLocroDeNivel(2)
    self.aparecerComidaPizza(3)
  }
  
  method agregarObstaculo() {
    // var posicion = self.posicionAleatoria()
    // const obstaculo = new Obstaculo(position = posicion)
    // if (obstaculo.position() == game.getObjectsIn(posicion).first().position()) {
    //   posicion = self.posicionAleatoria()
    //   game.addVisual(obstaculo)
    // } else {
    //   game.addVisual(obstaculo)
    // }
    game.addVisual(new Obstaculo(position = self.posicionAleatoria()))
  }
  
  method posicionAleatoria() = game.at(
    0.randomUpTo(game.width()),
    0.randomUpTo(game.height())
  )
  
  method aparecerComidaPizza(unNivel) {
    const pizza = new Pizza(nivel = unNivel)
    game.schedule(1000, { pizza.aparecer() })
  }
  
  method aparecerComidaHuesoDeNivel(unNivel) {
    const hueso = new HuesoConCarne(nivel = unNivel)
    game.schedule(1000, { hueso.aparecer() })
  }
  
  method aparecerComidaLocroDeNivel(unNivel) {
    const locro = new Locrazo(nivel = unNivel)
    game.schedule(1000, { locro.aparecer() })
  }
  
  method generarEnemigos() {
    self.aparecerEnemigoPerritoDeNivel(1)
    self.aparecerEnemigoPerroDeNivel(2)
    self.aparecerEnemigoPerroteDeNivel(3)
  }
  
  method aparecerEnemigoPerritoDeNivel(unNivel) {
    const perrito = new Perrito(nivel = unNivel)
    game.schedule(1000, { perrito.aparecer() })
  }
  
  method aparecerEnemigoPerroDeNivel(unNivel) {
    const perro = new Perro(nivel = unNivel)
    game.schedule(1000, { perro.aparecer() })
  }
  
  method aparecerEnemigoPerroteDeNivel(unNivel) {
    const perrote = new Perrote(nivel = unNivel)
    game.schedule(1000, { perrote.aparecer() })
  }

}

object kike {
  var property puntos = 0
  var vida = 10
  var property position = game.origin()
  var positionAnterior = position
  
  method vida() = vida
  
  // method text() = (((("Mi vida: " + vida.toString()) + ". ") + "Mis puntos: ") + puntos.toString()) + "."
  method aparecer() {
    game.addVisualCharacter(self)
  }
  
  method aumentarPuntosPorToparseCon(unaComida) {
    puntos += unaComida.puntosQueOtorga()
  }
  
  method perderVidasPorToparseConEnemigo(unEnemigo) {
    vida -= unEnemigo.vidasQueArrebata()
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
  
  method image() = "kike.png"
}

object marcador {
  method text() = ((("Vidas: " + kike.vida().toString()) + ". Puntos: ") + kike.puntos().toString()) + "."
  
  method position() = game.at(game.width() / 2, game.height() - 1)
  
  method aparecer() {
    game.addVisual(self)
  }

  method teCruzasteCon(personaje, elemento) {
  }
}

object marcadorFinal {
  method position() = game.at(9,9)
  method image() = "hijitos.png"
  method aparecer() {
    game.addVisual(self)
  }
  method posicionAleatoria() = game.at(
    0.randomUpTo(game.width()),
    0.randomUpTo(game.height())
  )
}