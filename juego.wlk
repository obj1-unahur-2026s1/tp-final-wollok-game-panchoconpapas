import wollok.game.*
import enemigos.*
import comidas.*
import obstaculos.*
import elementos.*

object juego {
  const listaDeEnemigos = []
  const sonidoAmbiente = game.sound("kikeSound.mp3")
  var juegoEnMarcha = false
  method musica() = sonidoAmbiente
  
  method iniciar() {
    try {
      sonidoAmbiente.volume(0.025)
      sonidoAmbiente.play()
    } catch e : Exception {}
    kike.aparecer()
    marcador.aparecer()
    marcadorFinal.aparecer()
    game.onTick(1000, "moverse", { listaDeEnemigos.forEach({ enemigo => enemigo.movete() }) })
    game.onCollideDo(kike, { elemento => elemento.teCruzasteCon(kike, elemento) })
    self.generarElementos()
  }
  
  method iniciarPantallaPrincipal() {
    game.title("Kike Game")
    game.width(10)
    game.height(10)
    game.cellSize(50)
    game.ground("pasto.png")
    self.configs()
    game.start()
    pantallaPrincipal.mostrar()
    keyboard.enter().onPressDo({
        if (!juegoEnMarcha) {
            juegoEnMarcha = true 
            game.removeVisual(pantallaPrincipal)
            self.iniciar()
            }
      }
    )
  }

  method configs() {
    keyboard.up().onPressDo({ kike.perderEnergia() })
    keyboard.down().onPressDo({ kike.perderEnergia() })
    keyboard.left().onPressDo({ kike.perderEnergia() })
    keyboard.right().onPressDo({ kike.perderEnergia() })
  }
  
  method generarElementos() {
    2.times({ i => self.generarEnemigos() })
    
    25.times({ i => self.agregarObstaculo() })
    5.times({ i => self.agregarParedDestructible() })
    
    self.generarComidas()
  }
  
  method agregarParedDestructible() {
    game.addVisual(
      new ObstaculoDestructible(position = self.posicionAleatoriaVacia())
    )
  }
  
  method terminarJuegoMal() {
    self.cargarPantallaDeMuerte()
  }
  
  method terminarJuegoBien() {
    self.cargarPantallaDeVictoria()
  }
  
  method cargarPantallaDeMuerte() {
    juegoEnMarcha = false
    game.clear()
    game.addVisual(gameOver)
    juegoEnMarcha = false
    keyboard.enter().onPressDo(
      {
        if (not juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(gameOver)
          listaDeEnemigos.clear()
          kike.recargarVida()
          kike.recargarEnergia()
          kike.position(game.origin())
          self.iniciar()
          }   
      }
    )
  }
  
  method cargarPantallaDeVictoria() {
    juegoEnMarcha = false
    game.clear()
    game.addVisual(victoria)
    keyboard.enter().onPressDo(
      { 
        if (not juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(victoria)
          listaDeEnemigos.clear()
          kike.recargarVida()
          kike.recargarEnergia()
          kike.position(game.origin())
          self.iniciar()
          }
      }
    )
  }
  
  method generarComidas() {
    self.aparecerComidaHuesoDeNivel(1)
    self.aparecerComidaLocroDeNivel(2)
    self.aparecerComidaPizza(3)
  }
  
  method agregarObstaculo() {
    game.addVisual(new Obstaculo(position = self.posicionAleatoriaVacia()))
  }
  
  method posicionAleatoria() = game.at(
    0.randomUpTo(game.width()),
    0.randomUpTo(game.height())
  )
  
  method posicionAleatoriaVacia() {
    const posiblePosicion = self.posicionAleatoria()
    
    if (game.getObjectsIn(posiblePosicion).isEmpty()) {
      return posiblePosicion
    } else {
      return self.posicionAleatoriaVacia()
    }
  }
  
  method agregarEnemigo(unEnemigo) {
    listaDeEnemigos.add(unEnemigo)
  }
  
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

object pantallaPrincipal {
  method image() = "pantallaPrincipal.png"
  
  method position() = game.origin()
  
  method mostrar() = game.addVisual(self)
}