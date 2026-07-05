import wollok.game.*
import enemigos.*
import comidas.*
import obstaculos.*
import elementos.*

object juego {
  const listaDeEnemigos = []
  const sonidoAmbiente = game.sound("kikeSound.mp3")
  
  method musica() = sonidoAmbiente
  
  method iniciar() {
    game.title("Kike Game")
    game.width(10)
    game.height(10)
    game.cellSize(50)
    game.ground("pasto.png")
    game.start()
    game.schedule(
      500,
      { 
        sonidoAmbiente.play()
        return sonidoAmbiente.volume(0.025)
      }
    )
    
    kike.aparecer()
    marcador.aparecer()
    marcadorFinal.aparecer()
    self.generarElementos()
    
    game.onTick(
      1000,
      "moverse",
      { listaDeEnemigos.forEach({ enemigo => enemigo.movete() }) }
    )
    
    game.onCollideDo(
      kike,
      { elemento => elemento.teCruzasteCon(kike, elemento) }
    )
    
    self.configs()
  }
  
  method configs() {
    keyboard.up().onPressDo({ kike.perderEnergia(1) })
    keyboard.down().onPressDo({ kike.perderEnergia(1) })
    keyboard.left().onPressDo({ kike.perderEnergia(1) })
    keyboard.right().onPressDo({ kike.perderEnergia(1) })
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
    game.clear()
    game.addVisual(gameOver)
  }
  
  method cargarPantallaDeVictoria() {
    game.clear()
    game.addVisual(victoria)
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